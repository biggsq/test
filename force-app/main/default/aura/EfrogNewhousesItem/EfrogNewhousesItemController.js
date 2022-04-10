({
	scriptsLoaded:function(component, event, helper) {
/*		var a=$("#aa").width();
		console.log(a);*/
	},
		doInit : function(component, event, helper) {
		var newHouse=component.get("v.newHouse");
		if(newHouse.status__c=="在售"){
			component.set("v.isSale", "onsale");
		}
		if(newHouse.status__c=="待售"){
			component.set("v.isSale", "forsale");
		}
		if(newHouse.feature__c!=null){
			component.set("v.hasFeature","true");
			component.set("v.features", newHouse.feature__c.split("-"));
		}
		if(newHouse.size__c!=null){
			component.set("v.size",newHouse.size__c);
		}
		else{
			component.set("v.size","尚未公布");
		}
	},
	detail:function(component,event,helper){
		// var id=event.target();
		// alert(id);
		var id=event.target.id;
		window.location.href="../c/EfrogNewhousesDetail.app?id="+id;
	},


})