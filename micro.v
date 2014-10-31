`define f 4
`define r 3
`define x 2
`define m 1
`define w 0
//- Top module
module micro(clk, rst);
	input clk, rst;
	wire [31:0] pc;
	reg [`f:`w] phase;
	wire ct_taken;
	wire [2:0] ra1, ra2, wa;
	wire [31:0] rd1, rd2, wd;
	wire [31:0] sr, tr, dr, md_in, md_out, ma, ir;
	//assign ma = pc;
	//assign ma = dr;
	
	//TODO
	//add phase generate module
	pc pc_obj(phase, ct_taken, dr, pc, ma, clk);
	ir ir_obj(md_out, ir, clk);
	register_file register_file_obj(ra1, ra2, wa, rd1, rd2, wd, we, clk, rst);
	sr sr_obj(rd1, sr, clk);
	tr tr_obj(ir, rd2, tr, clk);
	alu();
	memory memory_obj(phase, md_in, md_out, ma, ir, clk);
	//TODO
	//add dr, flags, mdr
	
endmodule
