module test;
  reg per_clk;
  reg cpu_clk;


  always #1 cpu_clk<=~cpu_clk; //Clock CPU
  always #1 per_clk<=~per_clk; //Clock Periférico

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

      #100 $finish; //<-- End simulation
	end


endmodule
