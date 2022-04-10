trigger gsqtrigger on gsq__c (before insert,after insert,after update) {
	if(trigger.isBefore){
        if(trigger.isInsert){
        	System.debug('gsqbeforeinsert');
        } } 
     if(trigger.isAfter){
        if(trigger.isInsert){
        	/*Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
            req.setComments('Some Comments');
            Approval.ProcessResult result = Approval.process(req);*/
        } 
        if(trigger.isUpdate){
            system.debug(trigger.new);
        }
    } 
}