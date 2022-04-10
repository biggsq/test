public without sharing class HelloWorldLWCCtl {
	@AuraEnabled
    public static String getData(){
        List<gsq__c> glist = [select id,Name,gsq1__c,gsq2__c,gsq3__c,gsq4__c from gsq__c];
        return Json.serialize(glist);
    }

    @AuraEnabled
    public static String updateData(String a,List<String> gIdList){
    	System.debug(LoggingLevel.INFO, '*** a: ' + a);
    	System.debug(LoggingLevel.INFO, '*** gIdList: ' + gIdList);
    	if(gIdList != null && gIdList.size() > 0){
            List<gsq__c> glist = [select id,gsq1__c,gsq2__c,gsq3__c,gsq4__c from gsq__c where id in :gIdList];
            for(gsq__c g : glist){
                g.gsq2__c = String.valueOf(System.now());
		        if(String.isNotBlank(a)){
		            g.gsq1__c = a;
		        } 
            }
	        update glist; 
    	}
        return getData();
    }
}