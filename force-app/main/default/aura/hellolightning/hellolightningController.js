({
	   doInit: function(component, event, helper) {

        // Create the action
        var action = component.get("c.getExpenses");

        // Add callback behavior for when response is received
        action.setCallback(this, function(response) {
            var state = response.getState();
            var result=response.getReturnValue();
            if (state === "SUCCESS") {
                //component.set("v.newExpense", result.c);
                component.set("v.expenses", result.elist);
                component.set("v.message", result.a);
                component.set("v.totalpage",result.totalpage);
                component.set("v.stotalpage",result.stotalpage);
                var stotalpages=component.get("v.stotalpages");
                for(var i=1;i<=result.stotalpage;i++){
                   stotalpages.push(i);
                }
                component.set("v.stotalpages",stotalpages);
                /*component.set("v.newExpense.Name","我是傻逼123");*/
                document.getElementById("aa").value=result.a;
                component.set("v.students",result.slist);
                //table
                component.set('v.mycolumns', [
                {label: 'Id', fieldName: 'Id', type: 'text',sortable: true },
                {label: 'Name', fieldName: 'Name', type: 'text'},
                {label: 'Date', fieldName: 'Date__c', type: 'date'},
                {label: 'Entry Fee', fieldName: 'Entry_Fee__c', type: 'currency', typeAttributes: { currencyCode: 'EUR'}},
                {label: 'Game', fieldName: 'Game__c', type: 'text'},
            ]);
            helper.getData(component);
/*            component.set('v.mycolumns', [
                {label: 'Opportunity name', fieldName: 'opportunityName', type: 'text'},
                {label: 'Confidence', fieldName: 'confidence', type: 'percent', cellAttributes:
                    { iconName: { fieldName: 'trendIcon' }, iconPosition: 'right' }},
                {label: 'Amount', fieldName: 'amount', type: 'currency', typeAttributes: { currencyCode: 'EUR'}},
                {label: 'Contact Email', fieldName: 'contact', type: 'email'},
                {label: 'Contact Phone', fieldName: 'phone', type: 'phone'}
            ]);
        component.set('v.mydata', [{
                id: 'a',
                opportunityName: 'Cloudhub',
                confidence: 0.2,
                amount: 25000,
                contact: 'jrogers@cloudhub.com',
                phone: '2352235235',
                trendIcon: 'utility:down'
            },
            {
                id: 'b',
                opportunityName: 'Quip',
                confidence: 0.78,
                amount: 740000,
                contact: 'quipy@quip.com',
                phone: '2352235235',
                trendIcon: 'utility:up'
            }]);*/

            }
            else {
                console.log("Failed with state: " + state);
            }
        });

        // Send action off to be executed
        $A.enqueueAction(action);
    },

    

    clickCreate: function(component, event, helper) {
        var validExpense = component.find('expenseform').reduce(function (validSoFar, inputCmp) {
            // Displays error messages for invalid fields
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
        // If we pass error checking, do some real work
        if(validExpense){
            // Create the new expense
            var newExpense = component.get("v.newExpense");
            console.log("Create expense: " + JSON.stringify(newExpense));
            helper.createExpense(component, newExpense);
        }
    },
    getSelectedName: function (component, event,helper) {
        var selectedRows = event.getParam('selectedRows');
        // Display that fieldName of the selected rows
        for (var i = 0; i < selectedRows.length; i++){
            alert("You selected: " + selectedRows[i].Id);
        }
        console.log("You selected: " , selectedRows);
    },

    previous:function(component,event,helper){
        var page=component.get("v.page");
        var totalpage=component.get("v.totalpage");
        if(page>1){
            page=page-1;
        helper.previous(component,page);}
    },
    first:function(component,event,helper){
        helper.first(component);
    },
    next:function(component,event,helper){
        var page=component.get("v.page");
        var totalpage=component.get("v.totalpage");
        if(page<totalpage){
        page=page+1;
        helper.next(component,page);}
    },
    last:function(component,event,helper){
        helper.last(component);
    },


    sprevious:function(component,event,helper){
        var spage=component.get("v.spage");
        var stotalpage=component.get("v.stotalpage");
        if(spage>1){
            spage=spage-1;
        var schecked=component.get("v.checked");
        helper.sprevious(component,spage,schecked);}
    },
    sfirst:function(component,event,helper){
        var schecked=component.get("v.checked");
        helper.sfirst(component,schecked);
    },
    snext:function(component,event,helper){
        var spage=component.get("v.spage");
        var stotalpage=component.get("v.stotalpage");
        if(spage<stotalpage){
        spage=spage+1;
        var schecked=component.get("v.checked");
        helper.snext(component,spage,schecked);}
    },
    slast:function(component,event,helper){
        var schecked=component.get("v.checked");
        helper.slast(component,schecked);
    },
   sonepage: function(component,event,helper){
      var spage=event.getSource().get("v.label");
      var schecked=component.get("v.checked");
      helper.sonepage(component,spage,schecked);
   },

openModel: function(component, event, helper) {
      // for Display Model,set the "isOpen" attribute to "true"
      component.set("v.isOpen", true);
   },
 
   closeModel: function(component, event, helper) {
      // for Hide/Close Model,set the "isOpen" attribute to "Fasle"  
      component.set("v.isOpen", false);
   },
 
   likenClose: function(component, event, helper) {
      // Display alert message on the click on the "Like and Close" button from Model Footer 
      // and set set the "isOpen" attribute to "False for close the model Box.
      alert('thanks for like Us :)');
      component.set("v.isOpen", true);
   },

   checked1:function(component,event,helper){
    //var a=document.getElementByName("0040").value;
    var ctarget = event.currentTarget;
    var data = ctarget.dataset.value;
    data=data.split("-");
    console.log(data);
    var checked=component.get("v.checked");
    if(checked.indexOf(data[0])<0){
    checked=checked+"&&"+data[0];
    component.set("v.newStudent.Name",data[1]);
    component.set("v.newStudent.sex__c",data[2]);}
    else{
    checked=checked.replace("&&"+data[0],"");
    component.set("v.newStudent.Name",'');
    component.set("v.newStudent.sex__c",'');
    }
    component.set("v.checked",checked);
   },

   openStuModel: function(component, event, helper) {
      // for Display Model,set the "isOpen" attribute to "true"
      component.set("v.isStuOpen", true);
   },
 
   closeStuModel: function(component, event, helper) {
      // for Hide/Close Model,set the "isOpen" attribute to "Fasle"  
      component.set("v.isStuOpen", false);
   },
   CreateStu:function(component,event,helper){
    // 两个以上才能用reduce
        component.find("studentform").showHelpMessageIfInvalid();
        var validStu = component.find('studentform').get("v.validity").valid;
        component.find("picksex").showHelpMessageIfInvalid();
        validStu=validStu && (component.find("picksex").get("v.validity").valid);
        // If we pass error checking, do some real work
        if(validStu){
            // Create the new expense
            component.set("v.newStudent.sex__c",component.find("picksex").get("v.value"));
            var newStudent = component.get("v.newStudent");     
            console.log("Create student: " + JSON.stringify(newStudent));
    }
   }

})