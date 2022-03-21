//Toda vez que inserirmos um contato novo, enviar um email de aviso informando o mesmo
trigger ContactTrigger on Contact (after insert) {

    if(Trigger.isInsert && Trigger.isAfter){
        for(Contact cTemp : Trigger.New){

            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            string[] toAddress = new String[]{'tiagowelter@gmail.com'};

            //List<String> toAddressList = new List<String>();
            //toAddressList.add('tiagowelter@gmail.com');

        }
    }

}