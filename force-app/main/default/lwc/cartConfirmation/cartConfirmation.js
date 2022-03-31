import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import executeOpportunity from '@salesforce/apex/OpportunityController.executeOpportunity';

export default class CartConfirmation extends NavigationMixin(LightningElement){
    @api products;
    @api nameopp;
    @api dateopp;
    @api idaconta;
    @api amountopp;

    submitDetails(){
        executeOpportunity({produtos : JSON.stringify(this.products), nameopp : this.nameopp, dateopp : this.dateopp, idaconta : this.idaconta}).then( (response) => {
            console.log('response executeOpportunity', response);

            this[NavigationMixin.Navigate]({
                type : 'standard__recordPage',
                attributes: {
                    recordId : response.Id,
                    actionName : 'view'
                }
            });            

        }).catch( (error) => {
            console.log('error executeOpportunity', error);
        });
    }
}