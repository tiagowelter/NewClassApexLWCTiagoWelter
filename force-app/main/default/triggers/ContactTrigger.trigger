//Toda vez que inserirmos um contato novo, enviar um email de aviso informando o mesmo
trigger ContactTrigger on Contact (after insert) {

    if(Trigger.isInsert && Trigger.isAfter){

        //vamos enviar para contatos que tenham uma conta vinculada e tenham o email, enviar para o email da conta
        Set<Id> idsContasSet = new Set<Id>();
        for(Contact cTemp : Trigger.New){
            idsContasSet.add(cTemp.AccountId);
        }

        //exemplo usando list
        List<Account> accountList = new List<Account>([SELECT Id, Email FROM Account WHERE Id IN :idsContasSet]);

        //Exemplo do Map
        Map<Id, Account> accountMap = new Map<Id, Account>([SELECT Id, Email FROM Account WHERE Id IN :idsContasSet]);

        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();

        for(Contact cTemp : Trigger.New){

            String emailCliente = null;
            /*if(accountList.size() > 0){
                for(Account aTemp : accountList){
                    if(cTemp.AccountId == aTemp.Id){
                        emailCliente = aTemp.Email;
                    }
                }
            }*/
            emailCliente = accountMap.containsKey(cTemp.AccountId) ? accountMap.get(cTemp.AccountId).Email : null;

            /*if(accountMap.containsKey(cTemp.AccountId)){
                emailCliente = accountMap.get(cTemp.AccountId).Email;
            }*/

            if(String.IsNotBlank(emailCliente)){
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                String[] toAddress = new String[]{emailCliente};
    
                //Aqui uma coleção parecida com a de cima
                //List<String> toAddressList = new List<String>();
                //toAddressList.add('tiagowelter@gmail.com');
    
                String nomeContato = String.isNotBlank(cTemp.FirstName) ? cTemp.FirstName : '';
    
                email.saveAsActivity = false;
                email.setTargetObjectId(UserInfo.getUserId());
                email.setToAddresses(toAddress);
                email.setSubject('Novo Contato Adicionado');
                email.setPlainTextBody('Foi criado o contato com o seguinte nome: '+ nomeContato +' ' + cTemp.LastName + ' - Id: ' + cTemp.Id);
    
                emailList.add(email);
                //Messaging.sendEmail( new Messaging.SingleEmailMessage[] {email} );
            }
        }

        if(emailList.size() > 0){
            Messaging.sendEmail( emailList );
        }
        
    }

}