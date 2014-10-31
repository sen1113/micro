module sr(rd1, sr, clk);
	input [31:0] rd1;
	input clk;
	output [31:0] sr;
	reg [31:0] sr;
	
	always @(posedge clk) begin
		sr <= rd1;
	end	
endmodule
