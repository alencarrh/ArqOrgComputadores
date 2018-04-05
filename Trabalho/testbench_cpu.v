module testbench_cpu;
  reg cpu_clk;
  reg cpu_rst;
  reg cpu_ack;

  wire cpu_send;
  wire [3:0] out_cpu_dados;

  CPU cpu(
    .cpu_reset(cpu_rst),
    .cpu_clock(cpu_clk),
    .cpu_send(cpu_send),
    .cpu_ack(cpu_ack),
    .cpu_dados(out_cpu_dados)
   );

  always #1 cpu_clk<=~cpu_clk; //Change Clock

  initial
	begin
      $dumpfile("dump.vcd");
      $dumpvars(3,testbench_cpu);

      // Resetar todos valores
      cpu_clk = 0;
      cpu_rst = 1;
      cpu_ack = 0;
      #5

      cpu_rst = 0;
      #5

      cpu_ack = 1;
      #5

      cpu_ack = 0;
      #5

      cpu_ack = 1;



      #100 $finish; //<-- End simulation
	end



endmodule
