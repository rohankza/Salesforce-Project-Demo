public with sharing class AccountPdfGenerator {

    @AuraEnabled
    public static String generateAccountPdf(Id accountId) {
        Account acc = [SELECT Id, Name, Phone, Industry FROM Account WHERE Id = :accountId];

        String content = 'Account Name: ' + acc.Name +
                          '\nPhone: ' + acc.Phone +
                          '\nIndustry: ' + acc.Industry;

        Blob pdfBlob = makePdf(content);

        ContentVersion cv = new ContentVersion();
        cv.Title = acc.Name + ' Summary';
        cv.PathOnClient = acc.Name + '.pdf';
        cv.VersionData = pdfBlob;
        insert cv;

        Id docId = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :cv.Id].ContentDocumentId;

        insert new ContentDocumentLink(
            ContentDocumentId = docId,
            LinkedEntityId = accountId,
            ShareType = 'V'
        );

        return  docId;
    }

    private static Blob makePdf(String text) {
        String stream = 'BT /F1 12 Tf 50 750 Td (' + text.replace('\n', ') Tj 0 -20 Td (') + ') Tj ET';

        String pdf = '%PDF-1.4\n' +
            '1 0 obj<</Type/Catalog/Pages 2 0 R>>endobj\n' +
            '2 0 obj<</Type/Pages/Kids[3 0 R]/Count 1>>endobj\n' +
            '3 0 obj<</Type/Page/Parent 2 0 R/Resources<</Font<</F1 4 0 R>>>>/MediaBox[0 0 612 792]/Contents 5 0 R>>endobj\n' +
            '4 0 obj<</Type/Font/Subtype/Type1/BaseFont/Helvetica>>endobj\n' +
            '5 0 obj<</Length ' + stream.length() + '>>stream\n' + stream + '\nendstream endobj\n' +
            'trailer<</Root 1 0 R>>\n%%EOF';

        return Blob.valueOf(pdf);
    }
}