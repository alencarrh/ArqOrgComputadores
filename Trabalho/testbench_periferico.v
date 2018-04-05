module test;
  reg per_clk;
  reg per_rst;
  reg per_send;
  wire per_ack;
  reg [3:0] in_per_dados;


  PERIFERICO uut(
     .per_reset(per_rst),
     .per_clock(per_clk),
     .per_send(per_send),
     .per_ack(per_ack),
     .in_per_dados(in_per_dados)
   );


  always #1 per_clk<=~per_clk; //Clock Periférico

  initial
	begin
      $dumpfile("dump.vcd");
      $dumpvars(3,test);


      //Reseta todos os valores
	  per_send = 0;
      per_clk = 0;
      per_rst = 1;
      in_per_dados = 4'b0000;

      #5
      per_rst = 0;


      #5
	  in_per_dados = 4'b1010;
      per_send = 1;

      #2
      in_per_dados = 4'b1110;

      #5
      in_per_dados = 4'b1111;
      per_send = 0;




      per_clk=0;
      #100 $finish; //<-- End simulation
	end


endmodule