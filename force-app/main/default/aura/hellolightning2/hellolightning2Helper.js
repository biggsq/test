({
	  updateExpense: function(component, expense) {
        var action = component.get("c.saveExpense");
        action.setParams({
            "expense": expense
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                alert(new Date().toLocaleString());
                alert(Date.parse(new Date(new Date().toLocaleString()))/1000);
                var newDate = new Date();
                newDate.setTime(1505091600000);
                alert(newDate.toDateString());
            }
        });
        $A.enqueueAction(action);
    }
})