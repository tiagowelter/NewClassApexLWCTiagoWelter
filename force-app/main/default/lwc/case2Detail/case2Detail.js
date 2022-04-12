import { LightningElement, wire, track } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import {fireEvent, registerListener} from 'c/pubsub';
import addNewCase from '@salesforce/apex/CaseController.addNewCase';
import { NavigationMixin } from 'lightning/navigation';

export default class Case2Detail extends NavigationMixin(LightningElement) {

    @wire(CurrentPageReference) pageRef;
    @track account = [];
    @track nameAccount;
    @track idAccount = '';
    @track caseName = null;
    @track caseDate = null;
    @track caseDescription = null;

    connectedCallback(){
        registerListener('selectedAccount',this.accountSelected, this);
    }

    accountSelected(accountParam){
        console.log('accountParam', accountParam);
        this.account = [];
        this.account.push( {...JSON.parse(accountParam)} );
        console.log('this.account', this.account[0].nome);
        this.nameAccount = this.account[0].nome;
        this.idAccount = this.account[0].id;
    }

    get isSelectedAccount(){
        return this.idAccount != '';
    }

    handleCaseName(event){
        this.caseName = event.currentTarget.value;
    }

    handleCaseDate(event){
        this.caseDate = event.currentTarget.value;
    }

    handleDescription(event){
        this.caseDescription = event.currentTarget.value;
    }  
    
    createNewCase(){
        addNewCase({accountId : this.idAccount, caseName : this.caseName , caseDate : this.caseDate, caseDescription : this.caseDescription}).then((response) => {
            this[NavigationMixin.Navigate]({
                type : 'standard__recordPage',
                attributes: {
                    recordId : response.Id,
                    actionName : 'view'
                }
            });  
        });
    }

    get isSaveCase(){
        return this.idAccount != '' && this.caseName && this.caseDate && this.caseDescription;
    }    

}