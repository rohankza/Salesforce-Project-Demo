public with sharing class TeamMemberOverviewController {

    @AuraEnabled(cacheable=true)
    public static List<Contact> getEmployees() {

        return [
            SELECT Id,
                   Name,
                   Role__c,
                   Project__c,
                   Project__r.Name,
                   Team_Lead__c,
                   Team_Lead__r.Name
            FROM Contact
            WHERE Project__c != NULL
            ORDER BY Name
        ];
    }


    @AuraEnabled(cacheable=true)
    public static List<Project_Task__c> getTasks() {

        return [
            SELECT Id,
                   Name,
                   Project__c,
                   Project__r.Name,
                   Assigned_To__c,
                   Assigned_To__r.Name,
                   Status__c                                                        
            FROM Project_Task__c
            ORDER BY Due_Date__c ASC
        ];
    }
}