public with sharing class Carro {
  
    public Boolean ligarCarro(Boolean ligarCarro){
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
    }    

}
