public with sharing class OpportunityController {

    @AuraEnabled
    public static Opportunity executeOpportunity(String produtos, String nameopp, Date dateopp, String idaconta){

        system.debug('produtos '+produtos);
        system.debug('nameopp '+nameopp);
        system.debug('dateopp '+dateopp);
        system.debug('idaconta '+idaconta);

        PriceBook2 pb2Obj = [SELECT Id FROM PriceBook2 WHERE IsStandard = true LIMIT 1];

        Opportunity oppObj = new Opportunity();
        oppObj.Name = nameopp;
        oppObj.CloseDate = dateopp;
        oppObj.AccountId = idaconta;
        oppObj.StageName = 'Prospecting';
        oppObj.PriceBook2Id = pb2Obj.Id;
        insert oppObj;

        //Aqui transformamos o JSON que vem num formato de string numa lista que pode ser lida
        List<OpportunityItemWrapper> productsList = (List<OpportunityItemWrapper>) JSON.deserialize(produtos, List<OpportunityItemWrapper>.class);

        map<Id, PriceBookEntry> pbeMap = new map<Id, PriceBookEntry>();
        for(PriceBookEntry cTemp : [SELECT Id, Product2Id FROM PriceBookEntry WHERE PriceBook2Id = :pb2Obj.Id]){
            pbeMap.put(cTemp.Product2Id, cTemp);
        }

        List<OpportunityLineItem> itemsList = new List<OpportunityLineItem>();
        for(OpportunityItemWrapper cTemp : productsList){

            PriceBookEntry pbeItemObj = pbeMap.get(cTemp.id);
            OpportunityLineItem item = new OpportunityLineItem();
            item.OpportunityId = oppObj.Id;
            item.PriceBookEntryId = pbeItemObj.Id;
            item.UnitPrice = cTemp.preco;
            item.Quantity = cTemp.quantidade;

            itemsList.add(item);
        }
        if(itemsList.size() > 0){
            insert itemsList;
        }
        
        return oppObj;

    }

}
