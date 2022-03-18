public with sharing class Motorista {
    public static void carrodoMotorista() {
        Carro carroFusca = new Carro();
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
        system.debug('opalaLigado '+opalaLigado);
    }

    //DESAFIO - No Carro criar um metodo chamado Acelerar, passar nesse metodo o numero da velocidade. retornar a mesma velocidade.
    //No motorista vocês devem mandar para o carro o valor da velocidade, porém só pode acelerar se o carro estiver ligado.

}
