import { LightningElement, wire, track } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import {fireEvent, registerListener} from 'c/pubsub';
import getProducts from '@salesforce/apex/ProductController.getProducts';

export default class ProductListItems extends LightningElement {

    @track accountId = null;
    @track filter = null;
    @track pageNumber = 1;
    @track productsObj;

    @wire(CurrentPageReference) pageRef;

    connectedCallback(){
        registerListener('selectedAccount', this.getAccount, this);
        registerListener('filterChangeSearch',this.getFilter, this);
        this.getProductsJS();
    }

    getAccount(account){
        this.accountId = account;
    }

    get getAccountId(){
        return this.accountId;
    }    
    
    getFilter(filterParam){
        this.filter = filterParam;
        console.log('ENTROU NO GET FILTER ', filterParam);
        this.getProductsJS();
    }

    getProductsJS(){
        getProducts({filter : this.filter, pageNumber : this.pageNumber}).then( (response) => {
            console.log('response getProducts', response);
            this.productsObj = response;
        }).catch((error) => {
            console.log('ERRO AO BUSCAR PRODUTOS', error);
        });
    }

    handleProductSelected(event){
        console.log('Capturou o evento do componente filho', event.detail);
        fireEvent(this.pageRef, 'selectedProduct', event.detail);
    }

    handlePreviousPage(){
        this.pageNumber = this.pageNumber -1;
        this.getProductsJS();
    }

    handleNextPage(){
        this.pageNumber = this.pageNumber +1;
        this.getProductsJS();
    }

}