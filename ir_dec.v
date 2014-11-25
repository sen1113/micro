`define f 0
`define r 1
`define x 2
`define m 3
`define w 4

//-ir_dec
module ir_dec(phase, ir, ra1, ra2, clk);
	input clk;
	input [`w: `f] phase;
	input [31:0] ir;
	
	output [ 2:0] ra1, ra2;
	
	reg [ 2:0] tmp1,tmp2;
	
	always @(posedge clk) begin
		if( phase[`r] == 1)begin
			case (ir[31:27])
				8'b 0101_0 : tmp2 = ir[26:24];
 				8'b 0101_1 : tmp2 = ir[26:24];
				default    : begin
									tmp1 = ir[21:19];
									tmp2 = ir[18:16];
								 end
			endcase
		end
	end
	assign ra1 = tmp1;
	assign ra2 = tmp2;
endmodule// ir_dec
	