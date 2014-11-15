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
	reg wren;
	reg [7:0] ra,wa;
	reg [31:0] data;
	
	embedded_ram embedded_ram_obj(
	clk,
	data,
	ra,
	wa,
	wren,
	q);
	//(clk, md_in, pc, ma, 1'b1, ir);	
	
	always @(posedge clk) begin
		if (phase[`f] == 1) begin
			/*fetch instructions*/
			data <= 0;
			ra <= pc;
			wa <= 0;
			wren <= 0;
			ir_out <= q;	
		end
		else if (phase[`m] == 1)begin
			//store or load data
			case (ir[31:19])
				13'b1000_1011_xxxx_x: begin	//store
					data <= md_in;
					ra <= 0;
					wa <= ma;
					wren <= 1;
				end
				13'b1000_1001_xxxx_x: begin	//load
					data <= 0;
					ra <= ma;
					wa <= 0;
					wren <= 0;
					mdr_out <= q;
				end
				13'b1001_0000_0101_0:;//push
				13'b1001_0000_0101_1:;//pop
			endcase
		end
	end //always
	
	assign ir = ir_out;
	assign mdr = mdr_out; 
	
endmodule
