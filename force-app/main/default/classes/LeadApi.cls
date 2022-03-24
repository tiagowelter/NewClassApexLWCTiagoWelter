@RestResource(urlMapping = '/AulaDeApex/Leads/*')

global with sharing class LeadApi {

    @HttpGet
    global static void getLead(){
        RestResponse resultRest = RestContext.response;
        String asParamStr = RestContext.request.requestURI.substring(RestContext.request.requestURI.lastIndexOf('/')+1); //aqui eu vejo se a URL do ger tem parâmetro
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

    /*
    {
        "leadList" :[
            {
                    "sobrenome" : "Silva 2222"
                    ,"nome_empresa" : "ASSSDD 2222"
                    ,"status_do_lead" : "Open - Not Contacted"
                    ,"email" : "t222@t.com.br"
                    ,"id_lead" : "00Q8c00000zdyW9EAI"
            }
        ]
    }
    */
    @HttpPost
    global static void insertUpdateLeads(List<LeadApiWrapper> leadList){

        List<Lead> leadsInsertList = new List<Lead>();

        //Aqui eu vou ler minha lista (json) de entrara (leadList), e vou criar os leads e adiciona lista leadsInsertList para posteriormente fazer o insert
        for(LeadApiWrapper cTemp : leadList){

            /*
            forma 1 instanciar um objeto
            Lead leadObj = new Lead();
            accountObj.LastName = cTemp.sobrenome;
            accountObj.Company = cTemp.nome_empresa;*/

            //forma 2 de instanciar um objeto
            Lead leadObj = new Lead();

            if(String.IsNotBlank(cTemp.id_lead)){
                leadObj = new Lead(
                    LastName = cTemp.sobrenome
                    ,Company = cTemp.nome_empresa
                    ,Status  = cTemp.status_do_lead
                    ,Id  = cTemp.id_lead
                    ,Email = cTemp.email);
            }else{
                leadObj = new Lead(
                    LastName = cTemp.sobrenome
                    ,Company = cTemp.nome_empresa
                    ,Status  = cTemp.status_do_lead
                    ,Email = cTemp.email);
            }

            leadsInsertList.add(leadObj);
        }

        /*if(leadsInsertList.size() > 0){
            insert leadsInsertList;
        }*/

        //Aqui vamos trabalhar no JSON de retorno
        RestResponse resultRest = RestContext.response;
        List<String> idsLeadsList = new List<String>(); //Lista de leads inseridos

        //verifico se a lista de leads tem algum dado
        if(leadsInsertList.size() > 0){

            //aqui utilizo uma forma de incluir que grave e retorne os ids do lead
            //upsert = insert e update
            Database.UpsertResult[] results = Database.upsert(leadsInsertList);

            //percorre o resultado no upsert que foi salvo na variavel results
            for(Integer index = 0; index < results.size(); index++){
                //aqui nos posicionamos linha a linha e verificamos se deu sucesso ou erro
                if(results[index].isSuccess()){
                    Id idDFor = results[index].Id;
                    idsLeadsList.add(idDFor);
                }else{
                    idsLeadsList.add('Erro');
                }
            }       
        }

        resultRest.responseBody = Blob.valueOf(JSON.serializePretty(idsLeadsList));
        resultRest.StatusCode = 200;
    }     
}
