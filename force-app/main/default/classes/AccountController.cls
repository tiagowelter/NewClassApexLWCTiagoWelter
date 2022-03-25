public with sharing class AccountController {
    
    @AuraEnabled(cacheable=true)
    public static string getAccounts(){
        String returnStr = '';
        
        try {
            
            List<Account> accountList = [SELECT Id, Name FROM Account];
            returnStr = JSON.serialize(accountList);

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }

        return returnStr;
    }

}
