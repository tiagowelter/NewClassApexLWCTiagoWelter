//nome da classe
public with sharing class ClasseDemonstraEstrutura {//inicio da classe

    //SALVAR SEMPRE = CTRL + S
    
    //metodo da classe, uma classe pode ter varios metodos
    public static boolean nomeDoMetodo(){//inicio do método

        //TIPO VARIAVEL | NOME VARIAVEL | VALOR VARIAVEL
        Boolean bTrue = true;
        Boolean bFalse = false;
        Boolean bExemple;
        String exemploString = 'texto 123456';
        Integer exemploInteiro = 1;
        Decimal exemploDecimal = 1.02;
        Double exemploDouble = 1.0255464454546;

        //coleções
        List<String> exemploLista = new List<String>();
        //[0] - Edgar
        //[1] - João Paulo
        //[2] - Arnaldo
        //[3] - Guilherme
        exemploLista.add('Edgar');
        exemploLista.add('João Paulo');
        exemploLista.add('Arnaldo');
        exemploLista.add('Guilherme');
        exemploLista.add('Guilherme');
        exemploLista.add('Guilherme');
        exemploLista.add('Guilherme');
        system.debug('exemploLista = '+exemploLista);
        system.debug('exemploLista posição 2 = '+exemploLista.get(2));
        system.debug('exemploLista tamanho = '+exemploLista.size());

        ///Adição sem usar o add
        List<String> exemploLista2 = new List<String>{'Edgar', 'João Paulo', 'Arnaldo'};

        List<Integer> exemploListaInteger = new List<Integer>();
        exemploListaInteger.add(null);
        exemploListaInteger.add(1);
        exemploListaInteger.add(2);
        exemploListaInteger.add(3);
        system.debug('exemploListaInteger = '+exemploListaInteger);

        //coleção set
        Set<String> exemploSet = new Set<String>();
        exemploSet.add('Edgar');
        exemploSet.add('João Paulo');
        exemploSet.add('Arnaldo');
        exemploSet.add('Guilherme');
        exemploSet.add('Guilherme');
        exemploSet.add('Guilherme');
        exemploSet.add('Guilherme');
        system.debug('exemploSet = '+exemploSet);
        system.debug('exemploSet tamalho = '+exemploSet.size());

        List<Opportunity> opportunityList =  new List<Opportunity>([SELECT Id, Name FROM Opportunity]);
        system.debug('opportunityList = '+opportunityList);
        system.debug('opportunityList posição 2 = '+opportunityList.get(2));
        system.debug('opportunityList nome posição 2 = '+opportunityList.get(2).Name);
        /*
        (
              Opportunity:{Id=0068c00000pMREmAAO, Name=Edge Emergency Generator}
            , Opportunity:{Id=0068c00000pMREtAAO, Name=Edge Installation}
            , Opportunity:{Id=0068c00000pMREuAAO, Name=Edge SLA}
            , Opportunity:{Id=0068c00000pMRF8AAO, Name=Edge Emergency Generator}
            , Opportunity:{Id=0068c00000pMRF1AAO, Name=Burlington Textiles Weaving Plant Generator}
            , Opportunity:{Id=0068c00000pMREoAAO, Name=Pyramid Emergency Generators}
            , Opportunity:{Id=0068c00000pMREeAAO, Name=Dickenson Mobile Generators}
        )
        */

        Account contaObjeto = new Account();
        contaObjeto.Name = 'Test';
        system.debug('contaObjeto '+contaObjeto);

        return bFalse;
    }//fim do método

    //classe sem retorno
    public static void metodoSemRetorno(){
        
    }

    //Estrutura do SOQL
    //SELECT
    //campos
    //FROM
    //nome do objeto
    //WHERE
    //condição de busca
    private static List<Account> getAccounts(){
        List<Account> accountList =  new List<Account>([SELECT Id, Name FROM Account WHERE Id != '']);
        return accountList;
    }

    public static void getAccountPrivate(){
        system.debug(ClasseDemonstraEstrutura.getAccounts());
    }

    //DESAFIO - Montar um método que busque e retorne uma lista com todas as oportunidade com a faze igual  'Closed Won'
    public static List<Opportunity> getOpportunitiesClosedWon(){
        List<Opportunity> oppList = new List<Opportunity>();

        oppList = [SELECT Id, Name FROM Opportunity WHERE StageName = 'Closed Won'];

        system.debug(oppList);
        system.debug('tamanho '+oppList.size());

        return oppList;
    }

    public static List<Opportunity> getOpportunitiesClosedWon2(){
        return [SELECT Id, Name FROM Opportunity WHERE StageName = 'Closed Won'];
    } 
    
    public static List<Opportunity> getOpportunitiesClosedWon3(){
        List<Opportunity> oppList = new List<Opportunity>([SELECT Id, Name FROM Opportunity WHERE StageName != 'Closed Won' AND StageName != 'Closed Lost']);
        system.debug(oppList);
        system.debug('tamanho '+oppList.size());
        return oppList;
    } 
    
    //Exemplo parâmetros
    public static Integer exemploParametros(Integer pInt, Integer pDiv){
        Integer intTest = (10 + pInt)/pDiv;
        system.debug('o valor de intTest é '+intTest);
        return intTest;
    }

    //DESAFIO - criar um método que recebe um nome de uma pessoa, e imprima com o system debug 'Olá NOME'
    public static void helloName(String name, String sobrenome){
        system.debug('Olá '+name+' '+sobrenome);
    }

    public static String helloName2(String name, String sobrenome){
        return 'Olá '+name+' '+sobrenome;
    } 
    
    public static void callMethods(){
        //exemplo chamando o void
        ClasseDemonstraEstrutura.helloName('Tiago','Welter');

        //exemplo chamando um  metodo sem void e com retorno
        system.debug('O retorno do metodo helloName2 é : '+ClasseDemonstraEstrutura.helloName2('Tiago','Welter'));
    }

    //EXECUÇÃO DML - insert - update - delete - upsert
    public static Account dmlAccountInsert(String name){
        Account accountObj = new Account();
        accountObj.Name = name;
        insert accountObj;
        return accountObj;
    }

    public static Account dmlAccountUpdate(String name, String idDaConta){
        List<Account> accountList = new List<Account>([SELECT Id, Name FROM Account WHERE Id = :idDaConta]); //primeiro buscamos as informações

        //Account accountUnique = [SELECT Id, Name FROM Account WHERE Id = :idDaConta LIMIT 1]; //Podemos buscar desta forma també,

        Account accountObj = new Account();
        if(accountList.size() > 0){
            accountObj = accountList.get(0); //depois pegamos a unica linha que retorna e colocamos no objeto Account
            accountObj.Name = name;
            update accountObj;
            system.debug('Velho '+accountList.get(0).Name);
            system.debug('Novo '+accountObj.Name);
        }

        return accountObj;
    }

    public static void dmlAccountDelete(String idDaConta){
        List<Account> accountList = [SELECT Id FROM Account WHERE Id = :idDaConta];
        delete accountList;
    }

    //DESAFIO - Receber o sobrenome e o nome da empresa e vamos inserir um Lead, o método deve retornar o Id do lead inserid
    public static Id insertLead(String lastName, String companyName){
        Lead leadObj = new Lead();
        leadObj.LastName = lastName;
        leadObj.Company = companyName;

        insert leadObj;

        return leadObj.Id;
    }

    //estruturas de condição
    public static boolean demosntraEstruturaCondicao(Integer idade){
        //quero returnar true se a pessoa for maior de idade, senão retorna false
        boolean bMaiorDeIdade;
        if( idade < 18 ){
            system.debug('menor de idade');
            bMaiorDeIdade = false;
        }else{
            system.debug('maior de idade');
            bMaiorDeIdade = true;
        }
        return bMaiorDeIdade;
    }

    public static void demosntraEstruturaCondicao2(Integer idade){
        if(idade < 0 || idade == null){
            system.debug('idade inválida');
        }else{
            if(idade < 13){
                system.debug('criança');
            }else if(idade >= 13 && idade <= 21 ){
                system.debug('adolescente');
            }else if(idade > 21 && idade < 65){
                system.debug('adulto');
            }else{
                system.debug('idoso');
            }
        }
    }

    //DESAFIO
    //Construir um método que receba dois parâmetros do tipo Inteiro e retorne o a soma destes dois parâmetros
    //Se o parâmetro 1 for maior do 5 deve somar mais dois neste resultado
    public static Integer somaDoisValoresComIf(Integer p1, Integer p2){
        Integer resultado = p1 + p2;
        if(p1 > 5){
            resultado = resultado + 2;
        }
        system.debug('resultado '+ resultado);
        return resultado;
    }

    public static Integer somaDoisValoresComIf2(Integer p1, Integer p2){
        return p1 > 5 ? p1 + p2 + 2 : p1 + p2;
    }

    //ESTRUTURA DE REPETIÇÃO
    public static Decimal getOpportunitiesTotal(){
        Decimal total = 0;
        List<Opportunity> opportunityList = new List<Opportunity>([SELECT Amount FROM Opportunity]);

        for(Opportunity vTemp : opportunityList){
            total = total + vTemp.Amount;
        }
        system.debug('valor total das oportunidades = '+total);
        return total;
    }

    public static Decimal getOpportunitiesTotal2(){
        Decimal total = 0;

        for(Opportunity vTemp : [SELECT Amount FROM Opportunity]){
            total += vTemp.Amount;
        }
        system.debug('valor total das oportunidades = '+total);
        return total;
    }

    //DESAFIOS
    //1 - Buscar e retornar o valor total das oportunidade que a fases não sejam 'Closed Won' e 'Closed Lost'
    public static Decimal getOpportunitiesTotalDesafio(){
        Decimal total = 0;
        for(Opportunity vTemp : [SELECT Amount FROM Opportunity WHERE StageName != 'Closed Won' AND StageName != 'Closed Lost']){
            total += vTemp.Amount; //faz a soma e mantem o valor anterior
        }
        system.debug('total '+total);
        return total;
    }

    public static Decimal getOpportunitiesTotalDesafio2(){
        Decimal total = 0;
        //aqui fizemos a query diferente utilizando o NOT IN
        for(Opportunity vTemp : [SELECT Amount FROM Opportunity WHERE StageName NOT IN ('Closed Won', 'Closed Lost')]){
            total += vTemp.Amount;
        }
        return total;
    }

    //2 - Criar 10 contas com o nome 'Conta 1', 'Conta 2', e assim por diante. Não retornar nada
    public static void inserAccountsModoErradoFazer(){
        //isto esta errado pois estamos acessando o banco de dados várias vezes, e isso pode dar erro de limite DML
        for(Integer itemp = 1; itemp <= 10; itemp++){
            system.debug('itemp '+itemp);
            Account accountObj = new Account();
            accountObj.Name = 'Conta '+itemp;
            insert accountObj;
        }        
    }

    public static void inserAccountsModoCert(){
        List<Account> accountList = new List<Account>();
        for(Integer itemp = 1; itemp <= 10; itemp++){
            system.debug('itemp '+itemp);
            Account accountObj = new Account();
            accountObj.Name = 'Conta TESTE DOIS '+itemp;
            accountList.add(accountObj);
        }
        insert accountList;
    }

    //DESAFIO - Receber um número inteiro no parâmetro, e vão criar as contas conforme este número com o nome 'Conta DESAFIO 1', 'Conta DESAFIO 2';
    public static void insertAccountsDesafio(Integer quantidadeContas){
        List<Account> accountList = new List<Account>();

        for(Integer itemp = 1; itemp <= quantidadeContas; itemp++){
            Account accountObj = new Account();
            accountObj.Name = 'Conta DESAFIO '+itemp;
            accountList.add(accountObj);
        }
        if(accountList.size() > 0){
            insert accountList;
        }
    }

    //MAPS
    public static void demonstraMap(){
        List<Opportunity> opportunityList =  new List<Opportunity>([SELECT Id, Name FROM Opportunity]);
        system.debug('opportunityList '+opportunityList);
        /*
            opportunityList (
                Opportunity:{Id=0068c00000pMREmAAO, Name=Edge Emergency Generator}
                , Opportunity:{Id=0068c00000pMREtAAO, Name=Edge Installation}
                , Opportunity:{Id=0068c00000pMREuAAO, Name=Edge SLA}
                , Opportunity:{Id=0068c00000pMRF8AAO, Name=Edge Emergency Generator}
            )
        */

        for(Opportunity vTemp : opportunityList){
            if(vTemp.Id == '0068c00000pMREeAAO'){

            }
        }

        //Mapas
        Map<Id, Opportunity> opportunityMap = new Map<Id, Opportunity>([SELECT Id, Name FROM Opportunity]);
        system.debug('opportunityMap '+opportunityMap);
        /*
            opportunityMap {
                0068c00000pMREeAAO=Opportunity:{Id=0068c00000pMREeAAO, Name=Dickenson Mobile Generators}
                , 0068c00000pMREfAAO=Opportunity:{Id=0068c00000pMREfAAO, Name=United Oil Office Portable Generators}
                , 0068c00000pMREgAAO=Opportunity:{Id=0068c00000pMREgAAO, Name=Express Logistics Standby Generator}
                , 0068c00000pMREhAAO=Opportunity:{Id=0068c00000pMREhAAO, Name=GenePoint Standby Generator}
                , 0068c00000pMREiAAO=Opportunity:{Id=0068c00000pMREiAAO, Name=Grand Hotels Kitchen Generator}
            }    
        */
        if(opportunityMap.containsKey('0068c00000pMREeZZZ')){
            system.debug('Contem o id');
        }else{
            system.debug('Não contem o id');
        }
    }

    public static void demonstraMap2(){
        Map<String, Account> contasComCpf = new Map<String, Account>();
        for(Account vTemp : [SELECT Id, Name, CPF_CNPJ__c FROM Account WHERE CPF_CNPJ__c != '']){
            system.debug('vtemp '+vtemp);
            contasComCpf.put(vTemp.CPF_CNPJ__c, vtemp);
        }
        system.debug('contasComCpf '+contasComCpf);

        /*
            contasComCpf {
                28987241068=Account:{Id=0018c00002ExDT5AAN, Name=Conta DESAFIO 3, CPF_CNPJ__c=28987241068}, 
                56875327066=Account:{Id=0018c00002ExCnFAAV, Name=Conta 6, CPF_CNPJ__c=56875327066}, 
                71533936099=Account:{Id=0018c00002ExCufAAF, Name=Conta TESTE DOIS 7, CPF_CNPJ__c=71533936099}}
        */
        if(contasComCpf.containsKey('56875327066')){
            system.debug('contem o cpf');
        }else{
            system.debug('não contém o cpf');
        }
    }    

    //DESAFIO - Receber um número inteiro no parâmetro, e vão criar as contas conforme este número com o nome 'Conta DESAFIO 1', 'Conta DESAFIO 2'; Caso a conta com o nome exista, não deve ser criado, pois não queremos mais de uma conta com o mesmo nome
    public static void insertAccountsDesafioNomeSemMap(Integer quantidadeContas){
        List<Account> accountList = new List<Account>();

        for(Integer itemp = 1; itemp <= quantidadeContas; itemp++){
            String nameAcoount = 'Conta DESAFIO '+itemp;
            List<Account> accountListCons = new List<Account>([SELECT Id, Name FROM Account WHERE Name = : nameAcoount]);
            if(accountListCons.size() == 0){
                Account accountObj = new Account();
                accountObj.Name = nameAcoount;
                accountList.add(accountObj);
            }
        }
        if(accountList.size() > 0){
            insert accountList;
        }
    }    

    public static void insertAccountsDesafioNomeComMap(Integer quantidadeContas){
        List<Account> accountList = new List<Account>();

        //aqui eu crio e alimento o meu map
        Map<String, Account> accountMap = new Map<String, Account>();
        for(Account vTemp : [SELECT Id, Name FROM Account]){
            accountMap.put(vTemp.Name, vTemp);
        }

        for(Integer itemp = 1; itemp <= quantidadeContas; itemp++){
            String nameAcoount = 'Conta DESAFIO '+itemp;
            //se não tiver no map croa, o "!" é usado para negação
            if(!accountMap.containsKey(nameAcoount)){
                Account accountObj = new Account();
                accountObj.Name = nameAcoount;
                accountList.add(accountObj);
            }
        }
        if(accountList.size() > 0){
            insert accountList;
        }
    }    


}//fim da classe
