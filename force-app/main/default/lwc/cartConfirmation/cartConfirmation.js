import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class CartConfirmation extends NavigationMixin(LightningElement) {
    @api products;
    @api nameopp;
    @api dateopp;
    @api idaconta;
    @api amountopp;
}