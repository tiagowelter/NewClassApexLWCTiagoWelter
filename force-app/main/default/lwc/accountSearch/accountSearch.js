import { LightningElement, track, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import {fireEvent, registerListener} from 'c/pubsub';

export default class AccountSearch extends LightningElement {

    @track accountId = null;
    @wire(CurrentPageReference) pageRef;

    handleSearch(event){
        let filter = event.target.value;
        fireEvent(this.pageRef, 'filterChangeSearch', filter);
    }

}