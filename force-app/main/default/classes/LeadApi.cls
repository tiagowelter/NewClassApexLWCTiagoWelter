@RestResource(urlMapping = '/AulaDeApex/Leads/*')

global with sharing class LeadApi {

    @HttpGet
    global static void getLead(){

        RestResponse resultRest = RestContext.response;

        String asParamStr = RestContext.request.requestURI.substring(RestContext.request.requestURI.lastIndexOf('/')+1);
        //https://playful-panda-6d1pua-dev-ed.my.salesforce.com/services/apexrest/AulaDeApex/Leads?

        String sobrenome = String.IsNotBlank(asParamStr) ? RestContext.request.params.get('sobrenome') : '';

        List<Lead> leadsList = new List<Lead>();
        if(String.IsNotBlank(sobrenome)){
            leadsList = [SELECT Id, LastName FROM Lead WHERE LastName = :sobrenome];
        }else{
            leadsList = [SELECT Id, LastName FROM Lead];
        }

        //List<Lead> leadsList = new List<Lead>([SELECT Id, LastName FROM Lead]);

        resultRest.responseBody = Blob.valueOf(JSON.serializePretty(leadsList));
        resultRest.StatusCode = 200;

    }

     
}
