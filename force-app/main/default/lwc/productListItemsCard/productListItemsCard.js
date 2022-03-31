import { LightningElement, api, track } from 'lwc';

export default class ProductListItemsCard extends LightningElement {
    @track _product;
    @api
    get product(){
        return this._product;
    }
    set product(value){

        let image = value.Product2.DisplayUrl ? value.Product2.DisplayUrl : 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png';

        this._product = {id : value.Product2.Id, nome : value.Product2.Name, preco: value.UnitPrice, imagem : image};

    }

    handleProductSelected(){
        const productSelected = new CustomEvent("selected", {
            detail: JSON.stringify(this._product),
        });
        console.log('esta disparando o evento no componente filho');
        this.dispatchEvent(productSelected);
    }

}