module testbench_cpu;
  
  //CPU inputs
  reg test_clk;
  reg test_rst;
  reg test_ack;
  
  //cpu output
  wire [3:0]test_dados;
  wire test_send;



  


   CPU cpu(
     .cpu_rst(test_rst),
     .cpu_clk(test_clk),
     .cpu_send(test_send),
     .cpu_ack(test_ack),
     .cpu_dados(test_dados)
   );

  initial
	begin
      $dumpfile("dump.vcd");
      $dumpvars(3,testbench_cpu);
      
      //Resetar por #10
      test_clk=0;
      test_rst=1;
      test_ack=0;
      #10
      
      test_rst = 0;
      #5
      
      
      
      
      
      

		

      #100 $finish; //<-- End
	end
	
  
  	always #1 test_clk<=~test_clk; //Change Clock
endmodule
