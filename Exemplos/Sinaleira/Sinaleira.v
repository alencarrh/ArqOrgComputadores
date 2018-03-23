`timescale 1ns / 1ps

module fsmAulaSinaleira(TA,TB,LA,LB,clk,rst);
	output reg [1:0] LA;//Luz rua A
	output reg [1:0] LB;//LUZ rua B
	/*
	luzes:
	00 = verde
	01 = amarelo
	10 = vermelho
	*/
	input TA;//tem transito rua A
	input TB;//tem transito rua B
	input clk;//clock
	input rst;//reset
	
	reg [1:0] S;//state
	reg [1:0] NS;//next state

	/***** STATE *****/
	always @ (posedge clk)
		begin
			if(rst == 1)
				S <= 2'b00;
			else
				S <= NS;
		end
	/***** STATE *****/

	/***** NEXT STATE *****/
	always @ (*)
		begin
			case ({S})
				2'b00://estado 00
					if(TA == 0)
						NS = 2'b01;
					else
						NS = 2'b00;
				2'b01://estado 01
						NS = 2'b10;
				2'b10://estado 10
					if(TB == 0)
						NS = 2'b11;
					else
						NS = 2'b10;
				2'b11:// estado 11
					NS = 2'b00;
			endcase
		end
	/***** NEXT STATE *****/

	/***** OUTPUTS *****/
	always @ (*)
		begin
			case ({S})
				2'b00:begin
					LA = 2'b00;
					LB = 2'b10;
				end
				2'b01:begin
					LA = 2'b01;
					LB = 2'b10;
				end
				2'b10:begin
					LA = 2'b10;
					LB = 2'b00;
				end
				2'b11:begin
					LA = 2'b10;
					LB = 2'b01;
				end
			endcase
		end
	/***** OUTPUTS *****/
endmodule