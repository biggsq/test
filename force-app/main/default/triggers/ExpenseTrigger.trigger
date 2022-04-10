trigger ExpenseTrigger on expense__c (before update) {
	if(trigger.isBefore){
        if(trigger.isUpdate){
        	System.debug('gsq');
        	System.debug(trigger.old);
        	System.debug(trigger.new);
        } } 
}