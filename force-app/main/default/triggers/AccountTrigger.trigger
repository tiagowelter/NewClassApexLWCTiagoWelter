//DESAFIO : toda vez que criar uma nova conta, com o campo Propriedade = Private, você deve criar uma tarefa para o proprietário da conta, dizendo para verificar os dados cadastrais da mesma.

trigger AccountTrigger on Account (after insert) {

    if(Trigger.isInsert && Trigger.isAfter){

        List<Task> taskList = new List<Task>();

        for(Account aTemp : Trigger.New){
            if(aTemp.OwnerShip == 'Private'){
                Task taskObj = new Task();
                taskObj.Subject = 'Verificar dados das contas';
                taskObj.ActivityDate = System.Today();
                taskObj.WhatId = aTemp.Id;
                taskObj.OwnerId = aTemp.OwnerId;
                //insert taskObj;
                taskList.add(taskObj);
            }
        }

        if(taskList.size() > 0){
            insert taskList;
        }
    }
}