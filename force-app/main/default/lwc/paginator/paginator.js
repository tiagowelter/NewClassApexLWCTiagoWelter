import { LightningElement, api } from 'lwc';

export default class Paginator extends LightningElement {

    @api pageNumber;
    @api pageSize;
    @api totalItemCount;

    handlePrevious(){
        this.dispatchEvent(new CustomEvent('previous'));
    }

    handleNext(){
        this.dispatchEvent(new CustomEvent('next'));
    }

    get currentPageNumber(){
        return this.totalItemCount === 0 ? 0 : this.pageNumber;
    }

    get isFirstPage(){
        console.log('this.pageNumber', this.pageNumber);
        return this.pageNumber <= 1;
    }

    get totalPages(){
        return Math.ceil(this.totalItemCount / this.pageSize);
    }

    get isLastPage(){
        return this.pageNumber >= this.totalPages;
    }

}