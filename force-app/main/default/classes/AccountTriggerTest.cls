@isTest
public class AccountTriggerTest {
    
    //teste 1 - criar uma conta com tarefa
    @isTest
    static void AccountTriggerTest() {

        Account accountObj = new Account();
        accountObj.Name         = 'Teste 1';
        accountObj.OwnerShip    = 'Private';
        accountObj.Phone        = '8855555';
        insert accountObj;

        List<Task> taskList = new List<Task>([SELECT Id FROM Task WHERE WhatId = :accountObj.Id AND Subject = 'Verificar dados das contas']);

        System.AssertEquals(taskList.size(),1);

    }

    //teste 2 - criar uma conta sem tarefa
    @isTest
    static void contaSemTarefa(){
        Account accountObj = new Account();
        accountObj.Name         = 'Teste 1';
        accountObj.OwnerShip    = '';
        accountObj.Phone        = '8855555';
        insert accountObj;        

        List<Task> taskList = new List<Task>([SELECT Id FROM Task WHERE WhatId = :accountObj.Id AND Subject = 'Verificar dados das contas']);

        System.AssertEquals(taskList.size(),0);

    }

    //teste 3 massa de dados grande
    @isTest
    static void contaMassaDados(){
        
        List<Account> accountList = new List<Account>();
        Integer quntContas = 1000;
        for(Integer i = 1; i <= quntContas; i++){
            Account accObj = new Account();
            accObj.Name = 'Conta '+i;
            accObj.OwnerShip = 'Private';
            accObj.Phone = '333';
            accountList.add(accObj);
        }

        insert accountList;

        List<Task> tasksList = new List<Task>([SELECT Id FROM Task WHERE WhatId IN :accountList  AND Subject = 'Verificar dados das contas']);

        System.AssertEquals(tasksList.size(), quntContas);

    }

}
