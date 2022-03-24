//Essa classe devolve todas as oportunidades que precisamos para mostrar na nossa lista
public with sharing class OpportunitySummary {
    @AuraEnabled
    public static List<Opportunity> getOpportunities(){
        return [SELECT Id, Name FROM Opportunity];
    }
}