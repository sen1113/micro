`define f 4
`define r 3
`define x 2
`define m 1
`define w 0

module memory(phase, md_in, mdr, ma, ir, pc, clk);
	input [`f:`w] phase;
	input [7:0] ma, pc;
	input [31:0] md_in;
	output [31:0] mdr, ir;
	input clk;
//	reg [31:0] memory [0:1024];
	reg [31:0] ir_out, mdr_out;
	
	always @(posedge clk) begin
		if (phase[`f] == 1) begin
			//fetch instruction
			ir_out <= embedded_ram(clk, wd, pc, wd, wa, ir); 
		end
		else if (phase[`m] == 1)begin
			//store or load data
			case (ir[31:19])
				8'b1000_1011_xxxx_x: memory[ma] <= md_in;  //store
				8'b1000_1001_xxxx_x: mdr_out <= memory[ma]; //load
				8'b1001_0000_0101_0:;//push
				8'b1001_0000_0101_1:;//pop
			endcase
		end
	end //always
	
	assign ir = ir_out;
	assign mdr = mdr_out; 
	
endmodule
