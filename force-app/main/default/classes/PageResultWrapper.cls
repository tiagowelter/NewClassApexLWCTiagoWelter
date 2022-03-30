public class PageResultWrapper {
    @AuraEnabled
    public integer tamanhoDaPagina {get;set;}

    @AuraEnabled
    public integer totalItems {get;set;}

    @AuraEnabled
    public object[] allDatas {get;set;}
}
