import { LightningElement, track } from 'lwc';
import getOpportunities from '@salesforce/apex/OpportunitySummary.getOpportunities'; //chama o nosso metodo do Apex
import { NavigationMixin } from 'lightning/navigation';

//monta uma constante com as colunas da tabela
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

//Aqui é a nossa classe do JavaScript                
export default class OpportunitySummary extends NavigationMixin(LightningElement) {

    //Aqui montamos as variaveis
    @track columns = columns; //colunas que vão aparecer na tabela
    @track data = []; //dados que vão aparecer na tabela
    @track rowOffset = 0;

    //toda vez que carregamos o componente ele executa automaticamente o que esta dentro deste metodo
    connectedCallback(){
        this.findOpportunities();
    }

    //cria um metod que vai chamar o backend e trazer as oportunidades para cá
    findOpportunities(){
        //Aqui ele chama o metodo do Apex, e carrega os valores retornados
        getOpportunities({}).then( (response) => {
            console.log('response', response);
            this.data = response;
        });
    }

    //metdodo de quando clica no botão
    executeNewSale(){
        console.log('clicou no botão');
        this[NavigationMixin.Navigate]({
            type : 'standard__navItemPage',
            attributes: {
                apiName : 'Carrinho'
            }
        });
    }

}