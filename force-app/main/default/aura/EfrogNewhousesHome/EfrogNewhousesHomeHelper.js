({
    changePage:function(component,page){
        var action=component.get("c.getNewHouses");
        action.setParams({
          "area":component.get("v.area"),
            "subway":component.get("v.subway"),
            "price":component.get("v.price"),
            "layout":component.get("v.layout"),
            "type":component.get("v.type"),
            "feature":component.get("v.feature"),
            "name":component.get("v.name"),
          "pageNumber":page
        })
        action.setCallback(this, function (response){
            var state=response.getState();
            var result=response.getReturnValue();
            if(state=="SUCCESS"){
               component.set("v.newHouseItem", result.enewlist);              
               component.set("v.currentpage",page);              
               component.set("v.isLoading", "false");
            }
            else{
              console.log(state);
            }
        });
        $A.enqueueAction(action);
    },
    searchByselect:function(component){
        var action=component.get("c.getNewHouses");
        action.setParams({
            "area":component.get("v.area"),
            "subway":component.get("v.subway"),
            "price":component.get("v.price"),
            "layout":component.get("v.layout"),
            "type":component.get("v.type"),
            "feature":component.get("v.feature"),
            "ename":component.get("v.name"),
            "pageNumber":component.get("v.currentpage")
        })
        action.setCallback(this, function(response){
           var state=response.getState();
           var result=response.getReturnValue();
           if(state=="SUCCESS"){
           component.set("v.newHouseItem", result.enewlist);
           component.set("v.totalpage", result.totalpage);
           component.set("v.isLoading", "false");
           }
           else{
            console.log(state);
           }
        });
        $A.enqueueAction(action);
    },
    searchByName:function(component){
      var action=component.get("c.getNewHouses");
      action.setParams({
        "area":component.get("v.area"),
        "subway":component.get("v.subway"),
        "price":component.get("v.price"),
        "layout":component.get("v.layout"),
        "type":component.get("v.type"),
        "feature":component.get("v.feature"),
        "ename":component.get("v.name"),
        "pageNumber":component.get("v.currentpage")
      })
      action.setCallback(this, function(response){
        var state=response.getState();
        var result=response.getReturnValue();
        if(state=="SUCCESS"){
           component.set("v.newHouseItem", result.enewlist);
           component.set("v.totalpage", result.totalpage);
           component.set("v.isLoading", "false");
        }
        else{
          console.log(state);
        }
      });
      $A.enqueueAction(action);
    },
})