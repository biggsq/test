({   
	doInit: function(component, event, helper) {
        var action = component.get("c.getFormatdate2");
        var expense= component.get("v.expense");
           action.setParams({
            "expense" : expense
        })
        // Add callback behavior for when response is received
        action.setCallback(this, function(response) {
            var state = response.getState();
            var result=response.getReturnValue();
            if (state === "SUCCESS") {
            	component.set("v.formatdate",result);
            }
            else {
                console.log("Failed with state: " + state);
            }
        });

        // Send action off to be executed
        $A.enqueueAction(action);   
    },

     handleUpdateExpense: function(component, event, helper) {
        var updatedExp = event.getParam("expense");
        helper.updateExpense(component, updatedExp);
    },

    clickReimbursed: function(component, event, helper) {
        var expense = component.get("v.expense");
        var updateEvent = component.getEvent("updateExpense");
        updateEvent.setParams({ "expense": expense });
        updateEvent.fire();
    }
})