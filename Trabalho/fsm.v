module PERIFERICO(per_reset, per_clock, per_send, per_ack, in_per_dados);

  input per_send; //bit indicativo se CPU já enviou os dados
  input per_reset;  //reset
  input per_clock;  //clock

  output reg per_ack; //ack que indica o recebimento dos dados

  input [3:0] in_per_dados;
  reg [3:0] per_dados; //dados recebidos da CPU

  reg estado_atual;
  reg proximo_estado;

  //variáveis de controle
  reg copiou_dados; //Indica se os dados foram copiados

  /***** ATUALIZAR ESTADO ATUAL *****/
  always @ (posedge per_clock)
    begin
      if(per_reset == 1)
          estado_atual <= 0;
      else
	      estado_atual <= proximo_estado;
    end
  /***** END - ATUALIZAR ESTADO ATUAL *****/


  /***** CALCULAR PRÓXIMO ESTADO *****/
  always @ (*)
    begin
      if (per_send == 1 && per_reset == 0)
    	proximo_estado = 1;
      else
        proximo_estado = 0;
    end
  /***** END - CALCULAR PRÓXIMO ESTADO *****/

  /***** ATUALIZAR O ACK *****/
  always @ (posedge per_clock)
    begin
      if (copiou_dados == 1 && estado_atual == 1)
        per_ack <= 1;
      else
        per_ack <= 0;
    end
    /***** END - ATUALIZAR O ACK *****/


  /***** TRATAR COM DADOS *****/
  always @ (estado_atual)
    begin
      if (per_send == 1 && estado_atual == 1)
        begin
          copiou_dados = 1;
          per_dados = in_per_dados;
        end
      else
        begin
          copiou_dados = 0;
          per_dados = 4'b0000;
        end
    end
  /***** END - TRATAR COM DADOS *****/
endmodule








module CPU(cpu_rst, cpu_clk, cpu_send, cpu_ack, cpu_dados);
  input cpu_ack;
  input cpu_rst; //reset
  input cpu_clk; //clock

  output reg cpu_send;
  output reg [3:0] cpu_dados;

  reg E;  //estado
  reg PE; //próximo estado
  reg last_ack;

  /***** ATUALIZAR ESTADO ATUAL *****/
  always @ (posedge cpu_clk)
    begin
      if(cpu_rst == 1)
        E <= 0;
      else
        E <= PE;
    end
  /***** END - ATUALIZAR ESTADO ATUAL *****/

  /***** CALCULAR PRÓXIMO ESTADO *****/
  always @ (*)
    begin
      if(cpu_ack == 0)
        PE = 2'b01;
      else
        PE = 2'b00;
	end
  /***** CALCULAR PRÓXIMO ESTADO *****/

  /***** ATUALIZAR O ACK *****/
  always @ (posedge cpu_clk)
    begin
      if (cpu_rst == 1)
        begin
          cpu_send <= 0;
          last_ack <= 0;
        end
      else if ((cpu_ack == 1 && last_ack == 0) || (last_ack == 1 && cpu_ack == 1))
        begin
          cpu_send <= 0;
          last_ack <= 1;
        end
      else
        begin
          cpu_send <= 1;
          last_ack <= 0;
        end
    end
   /*****END - ATUALIZAR O ACK *****/
  
   /***** DEFINE PRÓXIMO VALOR PARA DADOS *****/
   always @ (posedge cpu_clk)
     begin
       if (cpu_rst == 1 || cpu_dados == 4'b1111)
		cpu_dados <= 0;
       else
         cpu_dados <= cpu_dados + 1;
     end
   /***** DEFINE PRÓXIMO VALOR PARA DADOS *****/
endmodule