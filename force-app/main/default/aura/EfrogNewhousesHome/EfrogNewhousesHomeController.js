({
	doInit : function(component, event, helper) {
		var currentpage=component.get("v.currentpage");
		var action=component.get("c.getNewHouses");
		action.setParams({
			"area":component.get("v.area"),
            "subway":component.get("v.subway"),
            "price":component.get("v.price"),
            "layout":component.get("v.layout"),
            "type":component.get("v.type"),
            "feature":component.get("v.feature"),
              "pageNumber":currentpage
		})
		action.setCallback(this, function(response) {
			var state = response.getState();
			var result=response.getReturnValue();
			if (state === "SUCCESS") {
				component.set("v.newHouseItem",result.enewlist);
				component.set("v.totalpage", result.totalpage);
				component.set("v.currentpage",currentpage);					     	
			}
			else {
				console.log("Failed with state: " + state);
			}
		});
		$A.enqueueAction(action);   
	},
	scriptsLoaded:function(component,event,helper){

	},
	changePage:function(component,event,helper){
		component.set("v.isLoading", "true");
       var page = component.get("v.currentpage"); 
      var change = event.target.value;
      page = change === "Previous" ? (parseInt(page) - 1) : (parseInt(page) + 1);
      helper.changePage(component,page);
	},

	writePage:function(component,event,helper){
      component.set("v.isLoading", "true");
      var page=event.target.value;
      if(isNaN(page)){
          page=1;
      }
      if(page>component.get("v.totalpage")){
      	page=component.get("v.totalpage");    	
      }
      if(page<1 ){
      	page=1;
      }
      page=parseInt(page);
      $("#currentpage").val(page);
      helper.changePage(component,page);
	},
     /*打开model*/
	/*aa:function(component,event,helper){
		$('#myModal').modal('toggle');
	}*/
   searchByselect:function(component,event,helper){
   	component.set("v.isLoading", "true");
   	var area=$('input[name="areaRadio"]:checked ').val();
    var subway=$('input[name="subwayRadio"]:checked ').val();
    var price=$('input[name="priceRadio"]:checked ').val();
    var layout=$('input[name="layoutRadio"]:checked ').val();
    var type=$('input[name="typeRadio"]:checked ').val();
    var feature=$('input[name="featureRadio"]:checked ').val();
    component.set("v.area",area);
    component.set("v.subway",subway);
    component.set("v.price",price);
    component.set("v.layout",layout);
    component.set("v.type",type);
    component.set("v.feature",feature);
    component.set("v.currentpage", 1);
    helper.searchByselect(component);
   },
   reset:function(component,event,helper){
   	$("input[name='areaRadio']").get(0).checked=true; 
   	$("input[name='priceRadio']").get(0).checked=true; 
   	$("input[name='layoutRadio']").get(0).checked=true; 
   	$("input[name='typeRadio']").get(0).checked=true; 
   	$("input[name='featureRadio']").get(0).checked=true;
   	$("input[name='subwayRadio']").get(0).checked=true;
   	$("input[name='subwayRadio']").get(0).checked=false;
   },

  searchByName:function(component,event,helper){
  	 component.set("v.isLoading", "true");
     var name=$("#searchbyname").val();
     component.set("v.name", name);
     component.set("v.currentpage", 1);
     helper.searchByName(component);
   },
})