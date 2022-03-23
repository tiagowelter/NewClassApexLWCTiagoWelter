@RestResource(urlMapping = '/AulaDeApex/Leads/*')

global with sharing class LeadApi {

    @HttpGet
    global static void getLead(){

        RestResponse resultRest = RestContext.response;
        List<Lead> leadsList = new List<Lead>([SELECT Id FROM Lead]);

        resultRest.responseBody = Blob.valueOf('');
        resultRest.StatusCode = 200;

    }

     
}
