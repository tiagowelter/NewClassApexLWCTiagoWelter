public with sharing class AccountController {
    
    @AuraEnabled(cacheable=true)
    public static string getAccounts(){
        List<InputWrapper> inputList = new List<InputWrapper>();
        
        try {
            
            List<Account> accountList = [SELECT Id, Name FROM Account];
            for(Account cTemp : accountList){
                inputList.add(new InputWrapper(cTemp.Id, cTemp.Name));
            }

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }

        return JSON.serialize(inputList);
    }

}
