public with sharing class Carro {

    //atributos do carro
    public String modelo {get; set;}
    public String cor {get; set;}
    public Boolean ligado {get; set;}
    public Integer velocidadeCarro {get; set;}
    public Boolean estadoPorta {get; set;} //false é porta fechada
    public Boolean temGasolina {get;set;}

    //DESAFIO - No Carro criar um metodo chamado Acelerar, passar nesse metodo o numero da velocidade. retornar a mesma velocidade.
    //No motorista vocês devem mandar para o carro o valor da velocidade, porém só pode acelerar se o carro estiver ligado.
    public Boolean acelerar(Integer velocidade){        
        //DESAFIO - Verificar se o carro tem ou não gasolina para poder acelerar

        Boolean continua  = true;
        if(this.ligado == null || this.temGasolina == null){
            continua  = false;
        }else{
            continua = this.ligado && this.temGasolina;
        }

        return velocidade > 0 && velocidade != null && continua ? true : false;
    }
  
    /*public Boolean ligarCarro(Boolean ligarCarro){
        Boolean carroLigado = ligarCarro ? true : false;
        if(ligarCarro == true){
            system.debug('ligou o carro');
        }else{
            system.debug('desligou o carro');
        }
        return carroLigado;
    }
    
    public Boolean ligarFarois(Boolean ligarFarois){
        Boolean ligouFarol = ligarFarois ? true : false;
        if(ligarFarois){
            system.debug('Ligou os farois');
        }else{
            system.debug('Desligou os farois');
        }
        return ligouFarol;
    }

    public Boolean ligarSeta(Boolean ligarSeta){
        Boolean ligouSeta = ligarSeta ? true : false;
        if(ligarSeta){
            system.debug('Ligou os Seta');
        }else{
            system.debug('Desligou os Seta');
        }
        return ligouSeta;
    }*/    

}
