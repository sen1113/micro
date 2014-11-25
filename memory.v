`define f 0
`define r 1
`define x 2
`define m 3
`define w 4
module memory(phase, md_in, mdr, ma, ir, pc, clk);
	input [`w:`f] phase;
	input [7:0] ma, pc;
	input [31:0] md_in;
	output [31:0] mdr, ir;
	input clk;
//	reg [31:0] memory [0:1024];
	reg [31:0] ir_out, mdr_out;
	reg wren;
	reg [7:0] ra_mem,wa_mem;
	reg [31:0] data;
	
	embedded_ram embedded_ram_obj(
	clk,
	data,
	ra_mem,
	wa_mem,
	wren,
	q);
	//(clk, md_in, pc, ma, 1'b1, ir);	
	
	always @(posedge clk) begin
		if (phase[`f] == 1) begin
			/*fetch instructions*/
			data <= 0;
			ra_mem <= ma;
			wa_mem <= 0;
			wren <= 0;
			ir_out <= q;	
		end
		else if (phase[`m] == 1)begin
			//store or load data
			case (ir[31:24])
				8'b1000_1011: begin	//store
					data <= md_in;
					ra_mem <= 0;
					wa_mem <= ma;
					wren <= 1;
				end
				8'b1000_1001: begin	//load
					data <= 0;
					ra_mem <= ma;
					wa_mem <= 0;
					wren <= 0;
					mdr_out <= q;
				end
				//8'b0101_0xxx:;//push
				//8'b0101_1xxx:;//pop
			endcase
		end
	end //always
	
	assign ir = ir_out;
	assign mdr = mdr_out; 
	
endmodule
