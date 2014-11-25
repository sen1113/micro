`define f 0
`define r 1
`define x 2
`define m 3
`define w 4
//- Top module
module micro(input clk,
				 input n_rst,
				 output wire [63:0] SEG_OUT,
				 output wire [7:0] SEG_SEL
				 );
	/*wire & reg definition*/
	wire [31:0] pc;
	wire [`w: `f] phase;
	wire ct_taken, hlt;
	wire [2:0] ra1, ra2, wa;
	wire [7:0] ma;
	wire [31:0] rd1, rd2, wd;
	wire [31:0] sr, tr, dr, md_in, md_out, ir;
	
	wire [31:0] r_reg [0:7];
	wire [255:0] rf = {r_reg[0],r_reg[1],r_reg[2],r_reg[3],r_reg[4],r_reg[5],r_reg[6],r_reg[7]};
	
	reg [7:0] r_controller;
	
	assign SEG_OUT = seg_out_select(r_controller);
   assign SEG_SEL = r_controller;
 
	assign r_reg[0] = rf[255:224];
	assign r_reg[1] = rf[223:192];
	assign r_reg[2] = rf[191:160];
	assign r_reg[3] = rf[159:128];
	assign r_reg[4] = rf[127:96];
	assign r_reg[5] = rf[95:64];
	assign r_reg[6] = rf[63:32];
	assign r_reg[7] = rf[31:0];

	
	
	/* ------------------------------------------------------ */
	
	phase_gen phase_gen_obj(hlt, phase, CLK, n_rst);
	
	pc pc_obj(phase, ct_taken, dr, pc, ma, CLK);
	
	memory memory_obj(phase, md_in, md_out, ma, ir, CLK);
	
	//ir_dec ir_dec_obj(phase, ir, ra1, ra2, CLK);
	
	register_file register_file_obj(phase, ra1, ra2, wa, rd1, rd2, wd, we, CLK, n_rst, rf);
	
	alu alu_obj(phase, ra1, ra2, rd1, rd2, dr, ir, we, wa, CLK);
	
		
   /* ------------------------------------------------------ */
   // seg_controller 
   always @(posedge CLK or negedge n_rst) begin
      if(~n_rst) begin
			r_controller <= 8'b0000_0000;
      end
		else if(r_controller == 8'b0000_0000) begin
			r_controller <= 8'b0000_0001;
      end 
		else begin
			r_controller <= {r_controller[6:0] , r_controller[7]};
      end
   end
   /* ------------------------------------------------------ */
   // seg_out_selector
	//r_reg (32bit) -> 8bit
   function [63:0] seg_out_select;
		input [7:0] controller;
      case(controller)
		  8'b0000_0001 : seg_out_select = seg_decoder_32(r_reg[0]);
        8'b0000_0010 : seg_out_select = seg_decoder_32(r_reg[1]);
        8'b0000_0100 : seg_out_select = seg_decoder_32(r_reg[2]);
        8'b0000_1000 : seg_out_select = seg_decoder_32(r_reg[3]);
        8'b0001_0000 : seg_out_select = seg_decoder_32(r_reg[4]);
        8'b0010_0000 : seg_out_select = seg_decoder_32(r_reg[5]);
		  8'b0100_0000 : seg_out_select = seg_decoder_32(r_reg[6]);
	     8'b1000_0000 : seg_out_select = seg_decoder_32(r_reg[7]);
		default	     : seg_out_select = 64'd0;
      endcase
   endfunction	
	
   /* ------------------------------------------------------ */
   // seg_decoder
   function [7:0] seg_decoder_4;
      input [3:0] value;
      case(value)
        4'h0 : seg_decoder_4 = 8'b1111_1100;
        4'h1 : seg_decoder_4 = 8'b0110_0000;
        4'h2 : seg_decoder_4 = 8'b1101_1010;
        4'h3 : seg_decoder_4 = 8'b1111_0010;
        4'h4 : seg_decoder_4 = 8'b0110_0110;
        4'h5 : seg_decoder_4 = 8'b1011_0110;
        4'h6 : seg_decoder_4 = 8'b1011_1110;
        4'h7 : seg_decoder_4 = 8'b1110_0000;
        4'h8 : seg_decoder_4 = 8'b1111_1110;
        4'h9 : seg_decoder_4 = 8'b1111_0110;
        4'ha : seg_decoder_4 = 8'b1110_1110;
        4'hb : seg_decoder_4 = 8'b0011_1110;
        4'hc : seg_decoder_4 = 8'b0001_1010;
        4'hd : seg_decoder_4 = 8'b0111_1010;
        4'he : seg_decoder_4 = 8'b1001_1110;
        4'hf : seg_decoder_4 = 8'b1000_1110;
      endcase
   endfunction
   function [63:0] seg_decoder_32;
      input [31:0] value;
      seg_decoder_32 = {seg_decoder_4(value[31:28]), 
                        seg_decoder_4(value[27:24]), 
                        seg_decoder_4(value[23:20]), 
                        seg_decoder_4(value[19:16]),
                        seg_decoder_4(value[15:12]), 
                        seg_decoder_4(value[11:8]), 
                        seg_decoder_4(value[7:4]), 
                        seg_decoder_4(value[3:0])};
   endfunction
endmodule
