@isTest
public class CarroTest {

    @isTest
    static void testacelerarNaoFunciona(){
        Carro carro1 = new Carro();
        Boolean acelerou = carro1.acelerar(10);
        System.assertEquals(acelerou, false);
    }

    @isTest
    static void testacelerarFunciona(){
        Carro carro1 = new Carro();
        carro1.modelo = 'AAA';
        carro1.cor = 'AAA';
        carro1.ligado = true;
        carro1.velocidadeCarro = 10;
        carro1.estadoPorta = false;
        carro1.temGasolina = true;
        Boolean acelerou = carro1.acelerar(10);
        System.assertEquals(acelerou, true);
    }

}
