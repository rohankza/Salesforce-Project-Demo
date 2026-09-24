public with sharing class AccountFileViewerController {

    /*
     * Get all files attached to the Account
     */
    @AuraEnabled(cacheable=true)
    public static List<FileWrapper> getAccountFiles(Id accountId) {

        if (accountId == null) {
            throw new AuraHandledException('Account Id is required.');
        }

        List<FileWrapper> results = new List<FileWrapper>();

        List<ContentDocumentLink> links = [
            SELECT
                Id,
                ContentDocumentId,
                ContentDocument.Title,
                ContentDocument.FileType,
                ContentDocument.ContentSize,
                ContentDocument.LatestPublishedVersionId,
                ContentDocument.CreatedDate
            FROM ContentDocumentLink
            WHERE LinkedEntityId = :accountId
            ORDER BY ContentDocument.CreatedDate DESC
        ];

        for (ContentDocumentLink link : links) {

            FileWrapper file = new FileWrapper();

            file.contentDocumentId =
                link.ContentDocumentId;

            file.contentVersionId =
                link.ContentDocument.LatestPublishedVersionId;

            file.title =
                link.ContentDocument.Title;

            file.fileType =
                link.ContentDocument.FileType;

            file.fileSize =
                link.ContentDocument.ContentSize;

            results.add(file);
        }

        return results;
    }


    /*
     * Wrapper class for LWC
     */
    public class FileWrapper {

        @AuraEnabled
        public String contentDocumentId;

        @AuraEnabled
        public String contentVersionId;

        @AuraEnabled
        public String title;

        @AuraEnabled
        public String fileType;

        @AuraEnabled
        public Long fileSize;
    }
}