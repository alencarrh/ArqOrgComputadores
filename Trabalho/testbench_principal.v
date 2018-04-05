module testbench;

  //Variáveis CPU
  reg cpu_clk;
  reg cpu_rst;
  wire cpu_send;
  wire [3:0] out_cpu_dados;

  //Variáveis Periférico
  reg per_clk;
  reg per_rst;
  wire per_ack;

  //Instâncias

  CPU cpu(
    .cpu_reset(cpu_rst),
    .cpu_clock(cpu_clk),
    .cpu_send(cpu_send),
    .cpu_ack(per_ack), // ACK recebido do PERIFÉRICO
    .cpu_dados(out_cpu_dados)
   );

   PERIFERICO per(
     .per_reset(per_rst),
     .per_clock(per_clk),
     .per_send(cpu_send),// SEND recebido da CPU
     .per_ack(per_ack),
     .in_per_dados(out_cpu_dados)
   );


  //Controle dos clock
  always #3 cpu_clk<=~cpu_clk;
  always #3 per_clk<=~per_clk;

  initial
	begin
      $dumpfile("dump.vcd");
      $dumpvars(3,testbench);

      // Resetar todos valores

      cpu_clk = 0;
      cpu_rst = 1;

      per_clk = 0;
      per_rst = 1;

      #10

      //Start
      cpu_rst = 0;
      per_rst = 0;

      #200 $finish; //<-- End simulation
	end
endmodule
