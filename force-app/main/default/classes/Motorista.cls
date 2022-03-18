public with sharing class Motorista {
    public static void carrodoMotorista() {
        
        Carro carro1 = new Carro();
        carro1.modelo = 'Fusca';
        carro1.cor = 'Preto';
        carro1.ligado = true;
        carro1.velocidadeCarro = 10;
        carro1.estadoPorta = false;
        system.debug('O modelo do carro 1 é '+carro1.modelo);
        system.debug('carro1 '+carro1);
        Boolean aceleraCarro1 = carro1.acelerar(carro1.velocidadeCarro);
        system.debug('Acelerou o carro? '+aceleraCarro1);

        Carro carro2 = new Carro();
        carro2.modelo = 'Opala';
        carro2.cor = 'Rosa';
        carro2.ligado = false;
        carro2.velocidadeCarro = 10;
        carro2.estadoPorta = false;
        system.debug('O modelo do carro 2 é '+carro2.modelo);
        system.debug('carro2 '+carro2);
        Boolean aceleraCarro2 = carro2.acelerar(carro2.velocidadeCarro);
        system.debug('Acelerou o carro? '+aceleraCarro2);
        
        /*Carro carroFusca = new Carro();
        Boolean fuscaLigado = carroFusca.ligarCarro(true);
        if(fuscaLigado){
            carroFusca.ligarSeta(true);
        }
        system.debug('fuscaLigado '+fuscaLigado);

        Carro carroOpala = new Carro();
        Boolean opalaLigado = carroOpala.ligarCarro(false);
        if(opalaLigado){
            carroOpala.ligarSeta(true);
        }        
        system.debug('opalaLigado '+opalaLigado);*/
    }

    //DESAFIO - Verificar se o carro tem ou não gasolina para poder acelerar

}
