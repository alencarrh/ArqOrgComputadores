module PERIFERICO(per_rst, per_clk, per_send, per_ack, in_per_dados);

  input per_send;
  input per_rst; //reset
  input per_clk; //clock

  output reg per_ack;
  input reg [3:0] in_per_dados;
  reg [3:0] per_dados;


  reg E;  //estado
  reg PE; //próximo estado

  /***** ATUALIZAR ESTADO ATUAL *****/
  always @ (posedge per_clk)
    begin
      if(per_rst == 1)
        E <= 0;
      else
        E <= PE;
    end
  /***** END - ATUALIZAR ESTADO ATUAL *****/


  /***** CALCULAR PRÓXIMO ESTADO ATUAL *****/
  always @ (*)
    begin
    	PE = per_send;
    end
  /***** CALCULAR PRÓXIMO ESTADO ATUAL *****/


  always @ (posedge per_clk)
    begin
      if (per_send == 1)
        begin
    	  per_dados <= in_per_dados;
      	  per_ack <= 1;
        end
      else
        per_ack <= 0;
    end
endmodule

/*

module CPU(cpu_rst, cpu_clk, cpu_send, cpu_ack, cpu_dados);
  


  reg E;  //estado
  reg PE; //próximo estado

  /***** ATUALIZAR ESTADO ATUAL ***** /
  always @ (posedge cpu_clk)
    begin
      if(cpu_rst == 1)
        E <= 0;
      else
        E <= PE;
    end
  /***** END - ATUALIZAR ESTADO ATUAL ***** /

endmodule

  */
