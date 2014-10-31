module ir(md_out, ir, ra1, ra2, clk);
	input [31:0] md_out;
	output [31:0] ir;
	output [2:0] ra1, ra2;
	input clk;
	
	reg [31:0] ir;
	always @(posedge clk) begin
		ir <= md_out; //load instruction from memory
	end
	assign ra1 = ir[21:19];
	assign ra2 = ir[18:16];
	
	//TODO
	//assign imm
	//sim8 or imm16 
	
endmodule
