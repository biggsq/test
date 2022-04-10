({
	doInit : function(component, event, helper) {
		/*var sPageURL = decodeURIComponent(window.location.search.substring(1));*/ //You get the whole decoded URL of the page. window.location.是url window.location.search是问号开始
       /* var sURLVariables = sPageURL.split('&'); 
        console.log(sURLVariables);
        var sParameterName;
        var i;

        for (i = 0; i < sURLVariables.length; i++) {
            sParameterName = sURLVariables[i].split('='); 

            if (sParameterName[0] === 'firstName') { 
                sParameterName[1] === undefined ? 'Not found' : sParameterName[1];
            }
        }
        console.log('Param name'+sParameterName[0]);
        console.log('Param value'+sParameterName[1]);*/
        var id = decodeURIComponent(window.location.search.substring(4));
        var action=component.get("c.getNewhouseDetail");
        action.setParams({
        	"id":id
        })
        action.setCallback(this, function(response){
            var state=response.getState();
            var result=response.getReturnValue();
            if(state=="SUCCESS"){
               component.set("v.newHouse",result.eone);
               if(result.eone.size__c!=null){
                  component.set("v.size", result.eone.size__c);
               }
               else{
                 component.set("v.size", "尚未公布");
               }
            }
        });
        $A.enqueueAction(action);
	},
})