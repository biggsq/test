import { LightningElement, track, wire } from 'lwc';
import getDataInit from '@salesforce/apex/HelloWorldLWCCtl.getData';
import updateDataJS from '@salesforce/apex/HelloWorldLWCCtl.updateData';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

var columns = [
	    { label: 'Label', fieldName: 'Name' },
	    { label: 'gsq1', fieldName: 'gsq1__c' , editable: true },
	    { label: 'gsq2', fieldName: 'gsq2__c' , editable: true },
	    { label: 'gsq3', fieldName: 'gsq3__c' },
	    { label: 'gsq4', fieldName: 'gsq4__c' }
	];

export default class helloWorldLWC extends LightningElement {
    greeting = 'World';
    greeting2 = '';
    columns = columns;
    data = [];
    rowOffset = 0;
    
	

	//init
    connectedCallback(){
        getDataInit().then(result => {
            if(result){
                let type = 'success';
                let msg = result;
                this.greeting2 = result;
                this.data = JSON.parse(result);
                //this.ShowToastEvent(msg, type); 
            }else{
                let msg = 'Fail';
	            let type = 'error';
	            this.ShowToastEvent(msg, type);
            }   
        }).catch(error => {
            let msg = 'Fail';
            let type = 'error';
            this.ShowToastEvent(msg, type);
            console.log(error);
        });
    }

    ShowToastEvent(message, type){
        const evt = new ShowToastEvent({
            title: '',
            message: message,
            variant: type
        })
        this.dispatchEvent(evt);
    }

    changeHandler(event) {
	    this.greeting = event.target.value;
	}

	handleClick(event) {
		//this.greeting = event.target.label;
		this.ShowToastEvent(this.greeting, 'success');
		var selectRows = this.template.querySelector(
            '.test-Id'
		).getSelectedRows();
		var selectId = [];
		//console.log(JSON.stringify(selectRows));
		if(selectRows && selectRows.length > 0){
            for(var i=0 ; i<selectRows.length ; i++ ){
                selectId.push(selectRows[i].Id);     
            }
		}

		updateDataJS({
			'a' : this.greeting,
			'gIdList' : selectId 
		}).then(result => {
            if(result){
                this.greeting2 = result;  
                this.data = JSON.parse(result);   
            }else{

            }   
        }).catch(error => {

            console.log(error);
        });

		const contentBlockClasslist = this.template.querySelector(
            '.test-Id-toggle'
        ).classList;
        // toggle the hidden class
        contentBlockClasslist.toggle('slds-hidden');
	}
}