import { LightningElement, track } from 'lwc';
import getOpportunities from '@salesforce/apex/OpportunitySummary.getOpportunities';

const columns = [
                    {
                        label: 'Id da oportunidade',
                        fieldName : 'Id',
                        type: 'text',
                        shortable : false
                    },
                    {
                        label: 'Nome da oportunidade',
                        fieldName : 'Name',
                        type: 'text',
                        shortable : true
                    },
                ];

export default class OpportunitySummary extends LightningElement {

    @track columns = columns;
    @track data = [];

    connectedCallback(){
        this.findOpportunities();
    }

    //cria um metod que vai chamar o backend e trazer as oportunidades para cá
    findOpportunities(){
        getOpportunities({}).then( (response) => {
            console.log('response', response);
            this.data = response;
        });
    }

}