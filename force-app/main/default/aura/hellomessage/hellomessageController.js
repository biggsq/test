({
    handleClick: function(component, event, helper) {
        var btnClicked = event.getSource();         // the button
        var btnMessage = btnClicked.get("v.label"); // the button's label 或者v.value 
        console.log("handleClick: Message: " + btnMessage);
        component.set("v.message", btnMessage);     // update our message
    },
    handleClick9: function(component, event, helper) { // the button's label
        component.set("v.message", "我是傻逼");     // update our message
    }
})