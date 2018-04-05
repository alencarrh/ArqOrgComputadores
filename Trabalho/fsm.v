module PERIFERICO(per_reset, per_clock, per_send, per_ack, in_per_dados);

  input per_send; //bit indicativo se CPU já enviou os dados
  input per_reset;  //reset
  input per_clock;  //clock

  output reg per_ack; //ack que indica o recebimento dos dados

  input [3:0] in_per_dados;
  reg [3:0] per_dados; //dados recebidos da CPU

  reg per_estado_atual;
  reg per_proximo_estado;

  //variáveis de controle
  reg copiou_dados; //Indica se os dados foram copiados

  /***** ATUALIZAR ESTADO ATUAL *****/
  always @ (posedge per_clock)
    begin
      if(per_reset == 1)
          per_estado_atual <= 0;
      else
	      per_estado_atual <= per_proximo_estado;
    end
  /***** END - ATUALIZAR ESTADO ATUAL *****/


  /***** CALCULAR PRÓXIMO ESTADO *****/
  always @ (*)
    begin
      if (per_send == 1)
    	per_proximo_estado = 1;
      else
        per_proximo_estado = 0;
    end
  /***** END - CALCULAR PRÓXIMO ESTADO *****/

  /***** ATUALIZAR O ACK *****/
  always @ (*)
    begin
      if (copiou_dados == 1 && per_estado_atual == 1)
        per_ack <= 1;
      else
        per_ack <= 0;
    end
    /***** END - ATUALIZAR O ACK *****/


  /***** TRATAR COM DADOS *****/
  always @ (per_estado_atual)
    begin
      if (per_send == 1 && per_estado_atual == 1)//Talvez validar o send não é necessário
        begin
          per_dados = in_per_dados;
          copiou_dados = 1;
        end
      else
        begin
          copiou_dados = 0;
          per_dados = 4'b0000;
        end
    end
  /***** END - TRATAR COM DADOS *****/
endmodule


module CPU(cpu_reset, cpu_clock, cpu_send, cpu_ack, cpu_dados);
  input cpu_ack; //Bit indicativo se o periférico já recebeu os dados
  input cpu_reset; //reset
  input cpu_clock; //clock

  output reg cpu_send; // Bit para indicar que os dados estão no barramento.
  output reg [3:0] cpu_dados; //Dados gerados pela CPU

  reg cpu_estado_atual;  //estado
  reg cpu_proximo_estado; //próximo estado

  /***** ATUALIZAR ESTADO ATUAL *****/
  always @ (posedge cpu_clock)
    begin
      if(cpu_reset == 1)
        cpu_estado_atual <= 0;
      else
        cpu_estado_atual <= cpu_proximo_estado;
    end
  /***** END - ATUALIZAR ESTADO ATUAL *****/

  /***** CALCULAR PRÓXIMO ESTADO *****/
  always @ (*)
    begin
      if(cpu_ack == 0)
        cpu_proximo_estado = 1;
      else
        cpu_proximo_estado = 0;
	end
  /***** CALCULAR PRÓXIMO ESTADO *****/

  /***** ATUALIZAR O SEND *****/
  always @ (posedge cpu_clock)
    begin
      if(cpu_estado_atual == 1 && cpu_ack == 0)
        cpu_send <= 1;
      else
        cpu_send <= 0;
    end
   /*****END - ATUALIZAR O SEND *****/

   /***** DEFINE PRÓXIMO VALOR PARA DADOS *****/
  always @ (posedge cpu_clock)
     begin
       if (cpu_reset == 1 || cpu_dados == 4'b1111)
         cpu_dados <= 0;
       else
         cpu_dados <= cpu_dados + 1;
     end
   /***** DEFINE PRÓXIMO VALOR PARA DADOS *****/
endmodule