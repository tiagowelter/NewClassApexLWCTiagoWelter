public with sharing class ProductController {
    
    //Ele vai listar todos os produtos
    //Retornar o total de produtos listados
    //Poder buscar pelo nome do produto
    //Buscar pela página que estamos
    @AuraEnabled(cacheable=true)
    public static PageResultWrapper getProducts(String filter, Integer pageNumber){

        Integer pageSize = 9;
        String whereClausule = '';
        Integer offSet = (pageNumber-1)*pageSize;

        whereClausule = ' WHERE PriceBook2.IsStandard = true ';
        if(String.IsNotBlank(filter)){
            whereClausule += ' AND Product2.Name LIKE \'%'+filter+'%\'';
        }
    
        PageResultWrapper result = new PageResultWrapper();
        result.tamanhoDaPagina = pageSize;
        result.totalItems = Database.countQuery('SELECT count() FROM PricebookEntry '+whereClausule);
        result.allDatas = Database.query('SELECT Product2.Id, Product2.Name, Product2.DisplayUrl, UnitPrice FROM PricebookEntry '+whereClausule+' LIMIT :pageSize OFFSET :offset ');

        return result;
    }
    

}
