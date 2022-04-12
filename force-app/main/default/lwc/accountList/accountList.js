import { LightningElement, wire, track } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import {fireEvent, registerListener} from 'c/pubsub';
import searchClients from '@salesforce/apex/AccountController.searchClients';

export default class AccountList extends LightningElement {
    @track accountId = null;
    @track filter = null;
    @track pageNumber = 1;
    @track accountObj = [];

    @wire(CurrentPageReference) pageRef;

    connectedCallback(){
        registerListener('filterChangeSearch',this.getFilter, this);
        this.searchClientsJS();
    }
    
    getFilter(filterParam){
        this.filter = filterParam;
        console.log('ENTROU NO GET FILTER ', filterParam);
        this.searchClientsJS();
    }

    searchClientsJS(){
        searchClients({filter : this.filter, pageNumber : this.pageNumber}).then( (response) => {
            console.log('response searchClients', response);
            this.accountObj = response;
        }).catch((error) => {
            console.log('ERRO AO BUSCAR CLIENTES', error);
        });
    }

    handleAccountSelected(event){
        console.log('Capturou o evento do componente filho', event.detail);
        fireEvent(this.pageRef, 'selectedAccount', event.detail);
    }

    handlePreviousPage(){
        this.pageNumber = this.pageNumber -1;
        this.searchClientsJS();
    }

    handleNextPage(){
        this.pageNumber = this.pageNumber +1;
        this.searchClientsJS();
    }

}