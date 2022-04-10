public class tableController {
@AuraEnabled
public static List<gTask__c> getTasksOfProject(String projectId){
 return [SELECT Id,Name,Start_Date__c,Due_Date__c,Stage__c
 FROM gTask__c
 WHERE gProject__c = :projectId];

}
}