trigger LeadTrigger on Lead (before insert, after insert, before update, after update) {

    //temos que incluir uma tarefa e associar ao lead
    if(Trigger.isInsert && Trigger.isAfter){
        List<Task> taskList = new List<Task>();
        for(Lead lTemp : Trigger.New){
            
            //Aqui crio uma tarefa vinculada a cada lead
            Task taskObj         = new Task();
            taskObj.Subject      = 'Entrar em contato com o lead';
            taskObj.ActivityDate = System.Today();
            taskObj.WhoId        = lTemp.Id; //Aqui vinculo o ID do lead com a tarefa
            taskList.add(taskObj); //Aqui adiciono a tarefa criada numa lista para depois inserir de uma só vez
        }
        if(taskList.size() > 0){
            insert taskList;
        }
    }
}