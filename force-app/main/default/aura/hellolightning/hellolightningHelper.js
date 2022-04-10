({


    createExpense: function(component, expense) {
        var theExpenses = component.get("v.expenses");
        // Copy the expense to a new object
        // THIS IS A DISGUSTING, TEMPORARY HACK
        var newExpense = JSON.parse(JSON.stringify(expense));//???
        /*theExpenses.push(newExpense);
        console.log("theExpenses:"+JSON.stringify(theExpenses));
        component.set("v.expenses", theExpenses);*/
        
        var action = component.get("c.addexpense");
          action.setParams({
            "newExpense" : expense
        })
        action.setCallback(this, function(response) {
            var state = response.getState();
            var result = response.getReturnValue();
            if (state === "SUCCESS") {
                console.log(state);
                console.log(result.a);
                theExpenses.push(newExpense);
                console.log("theExpenses:"+JSON.stringify(theExpenses));
                alert("Congratulations!!!");
                location.reload();
            }
            else {
            	var errors = response.getError();
                console.log("Failed with state: " + state);
            }
        });

        // Send action off to be executed
        $A.enqueueAction(action);
    },

    getData:function(component) {
    	var action=component.get("c.getTournaments");
    	action.setCallback(this,function(response){
             var state=response.getState();
             var result=response.getReturnValue();
             if(state=="SUCCESS"){
               component.set("v.mydata",result.tlist);
             }
             else{
             	consloe.log("state");
             }
    	});
    	$A.enqueueAction(action);
    },

    first:function(component){
        var action=component.get("c.first2");
        action.setCallback(this,function(response){
            var state=response.getState();
            var result=response.getReturnValue();
            if(state=="SUCCESS"){
                component.set("v.mydata",result.tlist);
                component.set("v.page",1);
            }
        });
         $A.enqueueAction(action);
    },
    last:function(component){
        var action=component.get("c.last2");
        action.setCallback(this,function(response){
            var state=response.getState();
            var result=response.getReturnValue();
            if(state=="SUCCESS"){
                component.set("v.mydata",result.tlist);
                component.set("v.page",component.get("v.totalpage"));
            }
        });
         $A.enqueueAction(action);
    },
    previous:function(component,page){
        var action=component.get("c.previous2");
        action.setParams({
            "page":page
        })
        action.setCallback(this,function(response){
            var state=response.getState();
            var result=response.getReturnValue();
            if(state=="SUCCESS"){
                component.set("v.mydata",result.tlist);
                component.set("v.page",result.page);
            }
        });
         $A.enqueueAction(action);
    },
    next:function(component,page){
        var action=component.get("c.next2");
        action.setParams({
            "page" : page
        })
        action.setCallback(this,function(response){
            var state=response.getState();
            var result=response.getReturnValue();
            if(state=="SUCCESS"){
                component.set("v.mydata",result.tlist);
                component.set("v.page",result.page);
            }
        });
        $A.enqueueAction(action);
    },

    sfirst:function(component,schecked){
        var action=component.get("c.sfirst2");
        action.setParams({
            "schecked":schecked 
        })
        action.setCallback(this,function(response){
            var state=response.getState();
            var result=response.getReturnValue();
            if(state=="SUCCESS"){
                component.set("v.students",result.slist);
                component.set("v.spage",1);
            }
        });
         $A.enqueueAction(action);
    },
    slast:function(component,schecked){
        var action=component.get("c.slast2");
        action.setParams({
            "schecked":schecked 
        })
        action.setCallback(this,function(response){
            var state=response.getState();
            var result=response.getReturnValue();
            if(state=="SUCCESS"){
                component.set("v.students",result.slist);
                component.set("v.spage",component.get("v.stotalpage"));
            }
        });
         $A.enqueueAction(action);
    },
    sprevious:function(component,spage,schecked){
        var action=component.get("c.sprevious2");
        action.setParams({
            "spage":spage,
            "schecked":schecked            
        })
        action.setCallback(this,function(response){
            var state=response.getState();
            var result=response.getReturnValue();
            if(state=="SUCCESS"){
                component.set("v.students",result.slist);
                component.set("v.spage",result.spage);
            }
        });
         $A.enqueueAction(action);
    },
    snext:function(component,spage,schecked){
        var action=component.get("c.snext2");
        action.setParams({
            "spage":spage,
            "schecked":schecked 
        })
        action.setCallback(this,function(response){
            var state=response.getState();
            var result=response.getReturnValue();
            if(state=="SUCCESS"){
                component.set("v.students",result.slist);
                component.set("v.spage",result.spage);
            }
        });
        $A.enqueueAction(action);
    },
    sonepage:function(component,spage,schecked){
        var action=component.get("c.sonepage2");
        action.setParams({
            "spage":spage,
            "schecked":schecked
        })
        action.setCallback(this,function(response){
              var state=response.getState();
              var result=response.getReturnValue();
              if(state=="SUCCESS"){
                component.set("v.students",result.slist);
                component.set("v.spage",result.spage);
              }
        });
        $A.enqueueAction(action);
    },
})