@IsTest
private class DocuSignControllerTest {

    // -----------------------------
    // Mock for sendDocument()
    // -----------------------------
    private class SendDocumentMock implements HttpCalloutMock {

        public HttpResponse respond(HttpRequest req) {

            System.assertEquals('POST', req.getMethod());

            System.assert(
                req.getEndpoint().contains('/envelopes'),
                'Endpoint should contain /envelopes'
            );

            HttpResponse res = new HttpResponse();

            res.setStatusCode(201);
            res.setHeader('Content-Type', 'application/json');

            res.setBody(
                '{"envelopeId":"123456789","status":"sent"}'
            );

            return res;
        }
    }


    // -----------------------------
    // Mock for checkEnvelopeStatus()
    // -----------------------------
    private class CheckStatusMock implements HttpCalloutMock {

        public HttpResponse respond(HttpRequest req) {

            System.assertEquals('GET', req.getMethod());

            HttpResponse res = new HttpResponse();

            res.setStatusCode(200);
            res.setHeader('Content-Type', 'application/json');

            res.setBody(
                '{"envelopeId":"123456789","status":"completed"}'
            );

            return res;
        }
    }


    // -----------------------------
    // Mock for downloadSignedPdf()
    // -----------------------------
    private class DownloadPdfMock implements HttpCalloutMock {

        public HttpResponse respond(HttpRequest req) {

            System.assertEquals('GET', req.getMethod());

            System.assert(
                req.getEndpoint().contains('/documents/combined'),
                'Endpoint should contain /documents/combined'
            );

            HttpResponse res = new HttpResponse();

            res.setStatusCode(200);
            res.setHeader('Content-Type', 'application/pdf');

            // Dummy PDF content
            Blob pdfBlob = Blob.valueOf(
                '%PDF-1.4 Test Signed PDF Content'
            );

            res.setBodyAsBlob(pdfBlob);

            return res;
        }
    }


    // =====================================================
    // Test sendDocument()
    // =====================================================
    @IsTest
    static void testSendDocument() {

        // Create Opportunity
        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Prospecting',
            CloseDate = Date.today().addDays(30)
        );

        insert opp;


        // Create PDF File
        ContentVersion cv = new ContentVersion();

        cv.Title = 'Test Contract';

        cv.PathOnClient = 'TestContract.pdf';

        cv.VersionData = Blob.valueOf(
            '%PDF-1.4 Test PDF Document'
        );

        cv.IsMajorVersion = true;

        insert cv;


        // Set mock
        Test.setMock(
            HttpCalloutMock.class,
            new SendDocumentMock()
        );


        Test.startTest();

        String envelopeRecordId =
            DocuSignController.sendDocument(
                opp.Id,
                cv.Id,
                'John Doe',
                'john@example.com'
            );

        Test.stopTest();


        // Verify returned Salesforce record Id
        System.assertNotEquals(
            null,
            envelopeRecordId,
            'Envelope record Id should be returned'
        );


        // Verify DocuSign Envelope record
        DocuSign_Envelope__c env = [
            SELECT Id,
                   Name,
                   Status__c,
                   Opportunity__c,
                   Recipient_Email__c
            FROM DocuSign_Envelope__c
            WHERE Id = :envelopeRecordId
            LIMIT 1
        ];


        System.assertEquals(
            '123456789',
            env.Name
        );

        System.assertEquals(
            'Sent',
            env.Status__c
        );

        System.assertEquals(
            opp.Id,
            env.Opportunity__c
        );

        System.assertEquals(
            'john@example.com',
            env.Recipient_Email__c
        );
    }


    // =====================================================
    // Test checkEnvelopeStatus()
    // =====================================================
    @IsTest
    static void testCheckEnvelopeStatus() {

        // Create Opportunity
        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Prospecting',
            CloseDate = Date.today().addDays(30)
        );

        insert opp;


        // Create Envelope record
        DocuSign_Envelope__c env =
            new DocuSign_Envelope__c();

        env.Name = '123456789';
        env.Status__c = 'sent';
        env.Opportunity__c = opp.Id;
        env.Recipient_Email__c = 'john@example.com';

        insert env;


        // Set mock
        Test.setMock(
            HttpCalloutMock.class,
            new CheckStatusMock()
        );


        Test.startTest();

        String status =
            DocuSignController.checkEnvelopeStatus(
                env.Id
            );

        Test.stopTest();


        // Verify returned status
        System.assertEquals(
            'completed',
            status
        );


        // Verify Salesforce record updated
        DocuSign_Envelope__c updatedEnv = [
            SELECT Id,
                   Status__c,
                   Completed_Date__c
            FROM DocuSign_Envelope__c
            WHERE Id = :env.Id
            LIMIT 1
        ];


        System.assertEquals(
            'Completed',
            updatedEnv.Status__c
        );

        System.assertEquals(
            Date.today(),
            updatedEnv.Completed_Date__c
        );
    }


    // =====================================================
    // Test downloadSignedPdf()
    // =====================================================
    @IsTest
    static void testDownloadSignedPdf() {

        // Create Opportunity
        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Prospecting',
            CloseDate = Date.today().addDays(30)
        );

        insert opp;


        // Create completed Envelope
        DocuSign_Envelope__c env =
            new DocuSign_Envelope__c();

        env.Name = '123456789';
        env.Status__c = 'completed';
        env.Opportunity__c = opp.Id;
        env.Recipient_Email__c = 'john@example.com';

        insert env;


        // Set mock
        Test.setMock(
            HttpCalloutMock.class,
            new DownloadPdfMock()
        );


        Test.startTest();

        String result =
            DocuSignController.downloadSignedPdf(
                env.Id
            );

        Test.stopTest();


        // Verify method result
        System.assertEquals(
            'Signed PDF downloaded and attached successfully.',
            result
        );


        // Verify Salesforce File was created
        ContentVersion savedFile = [
            SELECT Id,
                   Title,
                   PathOnClient,
                   ContentDocumentId
            FROM ContentVersion
            WHERE Title = 'Signed Contract'
            LIMIT 1
        ];


        System.assertEquals(
            'Signed Contract',
            savedFile.Title
        );

        System.assertEquals(
            'SignedContract.pdf',
            savedFile.PathOnClient
        );


        // Verify File is linked with Opportunity
        ContentDocumentLink link = [
            SELECT Id,
                   ContentDocumentId,
                   LinkedEntityId,
                   ShareType,
                   Visibility
            FROM ContentDocumentLink
            WHERE ContentDocumentId = :savedFile.ContentDocumentId
            AND LinkedEntityId = :opp.Id
            LIMIT 1
        ];


        System.assertEquals(
            opp.Id,
            link.LinkedEntityId
        );

        System.assertEquals(
            'V',
            link.ShareType
        );
    }
}