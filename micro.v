`define f 4
`define r 3
`define x 2
`define m 1
`define w 0
//- Top module
module micro(clk, rst);
	input clk, rst;
	wire [31:0] pc;
	wire [`f: `w] phase;
	wire ct_taken, hlt;
	wire [2:0] ra1, ra2, wa;
	wire [7:0] ma;
	wire [31:0] rd1, rd2, wd;
	wire [31:0] sr, tr, dr, md_in, md_out, ir;
	wire [255:0] rf;
	
	
	phase_gen phase_gen_obj(hlt, phase, clk, rst);
	
	//pc pc_obj(phase, ct_taken, dr, pc, ma, clk);
	
	register_file register_file_obj(phase, ra1, ra2, wa, rd1, rd2, wd, we, clk, rst,rf);
	
	alu alu_obj(phase, ra1, ra2, rd1, rd2, dr, ir, clk);
	
	/*‚±‚±‚©‚«‚©‚¦‚Ä*/
	//embedded_ram ram( clk, wd,	rdaddress,	wraddress,	wren,	mdr);
	
	memory memory_obj(phase, md_in, md_out, ma, ir, clk);
	
endmodule
