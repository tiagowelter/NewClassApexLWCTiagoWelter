import { LightningElement, track, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import {fireEvent, registerListener} from 'c/pubsub';

export default class ProductSearch extends LightningElement {

    @track accountId = null;
    @wire(CurrentPageReference) pageRef;

    connectedCallback(){
        //this.getAccount();
        registerListener('selectedAccount', this.getAccount, this);
    }

    getAccount(account){
        this.accountId = account;
        console.log('SELECIONOU O ID NO COMPONENTE DOS PRODUTOS', this.accountId);
    }

    get getAccountId(){
        return this.accountId;
    }

    handleSearch(event){
        let filter = event.target.value;
        fireEvent(this.pageRef, 'filterChangeSearch', filter);
    }

}