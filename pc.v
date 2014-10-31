`define f 4
`define r 3
`define x 2
`define m 1
`define w 0

module pc(phase, ct_taken, dr, pc, ma, clk);
	input [`f:`w] phase;
	input ct_taken;
	input [31:0] dr;
	output [31:0] pc;
	output [31:0] ma;
	input clk;
	reg [31:0] pc; 
	reg [31:0] ma;
	
	always @(posedge clk) begin
		if (phase[`f] == 1) begin
			ma = pc;
			pc <= pc + 4;
		end
		else if (phase[`w] == 1  &&  ct_taken == 1) begin
			pc <= dr;
		end
	end // always
endmodule
