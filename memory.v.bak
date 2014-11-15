`define f 4
`define r 3
`define x 2
`define m 1
`define w 0

module memory(phase, md_in, md_out, ma, ir, clk);
	input [`f:`w] phase;
	input [31:0] md_in, ma, ir;
	output [31:0] md_out;
	input clk;
	reg [31:0] memory [0:1024];
	reg [31:0] md_out;
	
	always @(posedge clk) begin
		if (phase[`f] == 1) begin
			//fetch instruction
			md_out <= memory[ma]; 
		end
		else if (phase[`m] == 1) begin
			//store or load data
			case (ir[31:24])
				8'b10001011: memory[ma] <= md_in;  //store
				8'b10001001: md_out <= memory[ma]; //load
			endcase
		end
	end //always
	
endmodule
