module test;
  reg per_clk;
  //reg cpu_clk;


  //always #5 cpu_clk<=~cpu_clk; //Clock CPU


  reg per_rst;
  reg per_send;
  wire per_ack;
  reg [3:0] in_per_dados;

   PERIFERICO uut(
     .per_rst(per_rst),
     .per_clk(per_clk),
     .per_send(per_send),
     .per_ack(per_ack),
     .in_per_dados(in_per_dados)
   );

  initial
	begin
      $dumpfile("dump.vcd");
      $dumpvars(3,test);


      per_rst = 1;
      per_send = 0;
      in_per_dados = 4'b0000;
      #5

      per_rst = 0;
      per_send = 0;
      in_per_dados = 4'b0000;

      #5

      per_send = 1;
      in_per_dados = 4'b1111;





      per_clk=0;
      #100 $finish; //<-- End simulation
	end

   always #1 per_clk<=~per_clk; //Clock Periférico
endmodule
