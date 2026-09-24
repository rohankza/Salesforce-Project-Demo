public with sharing class DocuSignController {
            @AuraEnabled
        public static String sendDocument(
            Id opportunityId,
            Id contentVersionId,
            String recipientName,
            String recipientEmail
        ) {

            try{
                
                ContentVersion cv = [
                    SELECT Id,
                        Title,
                        VersionData
                    FROM ContentVersion
                    WHERE Id = :contentVersionId
                    LIMIT 1
                ];

                String base64Document = EncodingUtil.base64Encode(cv.VersionData);

                Map<String,Object> requestBody = new Map<String,Object>();

                requestBody.put('emailSubject','Please Sign this Document');
                requestBody.put('status','sent');

               
                Map<String,Object> document = new Map<String,Object>();
                document.put('documentBase64',base64Document);
                document.put('name',cv.Title);
                document.put('fileExtension','pdf');
                document.put('documentId','1');

                requestBody.put(
                    'documents',
                    new List<Object>{document}
                );

                // Signature Tab
                Map<String,Object> signHere = new Map<String,Object>();
                signHere.put('anchorString','/sn1/');
                signHere.put('anchorUnits','pixels');
                signHere.put('anchorXOffset','0');
                signHere.put('anchorYOffset','0');

                
                Map<String,Object> signer = new Map<String,Object>();
                signer.put('email',recipientEmail);
                signer.put('name',recipientName);
                signer.put('recipientId','1');
                signer.put('routingOrder','1');

                signer.put(
                    'signHereTabs',
                    new List<Object>{signHere}
                );

               
                Map<String,Object> recipients = new Map<String,Object>();

                recipients.put(
                    'signers',
                    new List<Object>{signer}
                );

                requestBody.put('recipients',recipients);

                String jsonBody = JSON.serialize(requestBody);

                System.debug(jsonBody);

                
                HttpRequest req = new HttpRequest();

                req.setEndpoint(
                    'callout:DocuSign/restapi/v2.1/accounts/49736087/envelopes'
                );

                req.setMethod('POST');

                req.setHeader(
                    'Content-Type',
                    'application/json'
                );

                req.setBody(jsonBody);

                Http http = new Http();

                HttpResponse res = http.send(req);

                System.debug(res.getStatus());
                System.debug(res.getBody());

              
                if(res.getStatusCode() == 200 || res.getStatusCode() == 201){

                    Map<String,Object> response =
                        (Map<String,Object>)JSON.deserializeUntyped(res.getBody());

                    DocuSign_Envelope__c env = new DocuSign_Envelope__c();

                    
                    env.Name = (String)response.get('envelopeId');
                    env.Status__c = (String)response.get('status');
                    env.Opportunity__c = opportunityId;
                    env.Recipient_Email__c = recipientEmail;

                    System.debug('Opportunity Id = ' + opportunityId);
                    System.debug('Recipient Email = ' + recipientEmail);
                    System.debug('Envelope Id = ' + response.get('envelopeId'));
                    System.debug('Status = ' + response.get('status'));

                    insert env;

                   // return res.getBody();
                   return env.Id;

                }else{

                    throw new AuraHandledException(
                        'DocuSign Error : ' + res.getBody()
                    );

                }

            }catch(Exception e){

                throw new AuraHandledException(
                    e.getMessage()
                );

            }

}
       @AuraEnabled
public static String checkEnvelopeStatus(Id envelopeRecordId) {

    try {

        DocuSign_Envelope__c env = [
            SELECT Id,
                   Name,
                   Status__c,
                   Opportunity__c
            FROM DocuSign_Envelope__c
            WHERE Id = :envelopeRecordId
            LIMIT 1
        ];

        HttpRequest req = new HttpRequest();

        req.setEndpoint(
            'callout:DocuSign/restapi/v2.1/accounts/49736087/envelopes/' +
            env.Name
        );

        req.setMethod('GET');

        Http http = new Http();

        HttpResponse res = http.send(req);

        System.debug('Status Code : ' + res.getStatusCode());
        System.debug('Response : ' + res.getBody());

        if(res.getStatusCode() == 200){

            Map<String,Object> response =
                (Map<String,Object>)JSON.deserializeUntyped(res.getBody());

            String status = (String)response.get('status');

            // Update Status in Salesforce
            env.Status__c = status;

            if(status == 'completed'){

                env.Completed_Date__c = Date.today();

            }

            update env;

            return status;

        }else{

            throw new AuraHandledException(
                'DocuSign Error : ' + res.getBody()
            );

        }

    }catch(Exception ex){

        throw new AuraHandledException(ex.getMessage());

    }

}



@AuraEnabled
public static String downloadSignedPdf(Id envelopeRecordId) {

    try {

        DocuSign_Envelope__c env = [
            SELECT Id,
                   Name,
                   Opportunity__c,
                   Status__c
            FROM DocuSign_Envelope__c
            WHERE Id = :envelopeRecordId
            LIMIT 1
        ];

       
        if(env.Status__c != 'completed'){
            throw new AuraHandledException(
                'Document is not completed yet.'
            );
        }

       
        HttpRequest req = new HttpRequest();

        req.setEndpoint(
            'callout:DocuSign/restapi/v2.1/accounts/49736087/envelopes/'
            + env.Name +
            '/documents/combined'
        );

        req.setMethod('GET');

        Http http = new Http();

        HttpResponse res = http.send(req);

        System.debug('Status Code : ' + res.getStatusCode());

        if(res.getStatusCode() != 200){
            throw new AuraHandledException(res.getBody());
        }

        Blob signedPdf = res.getBodyAsBlob();
System.debug('json : ' + res.getBodyAsBlob());
        ContentVersion cv = new ContentVersion();

        cv.Title = 'Signed Contract';

        cv.PathOnClient = 'SignedContract.pdf';

        cv.VersionData = signedPdf;

        insert cv;

    
        cv = [
            SELECT Id,
                   ContentDocumentId
            FROM ContentVersion
            WHERE Id = :cv.Id
            LIMIT 1
        ];

        // Link File with Opportunity
        ContentDocumentLink cdl = new ContentDocumentLink();

        cdl.ContentDocumentId = cv.ContentDocumentId;

        cdl.LinkedEntityId = env.Opportunity__c;

        cdl.ShareType = 'V';

        cdl.Visibility = 'AllUsers';

        insert cdl;

        return 'Signed PDF downloaded and attached successfully.';

    }
    catch(Exception ex){

        throw new AuraHandledException(ex.getMessage());

    }

}

} 