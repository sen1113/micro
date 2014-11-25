`timescale 1ns / 1ps
`define f 0
`define r 1
`define x 2
`define m 3
`define w 4

module testbench;
	//input 
	reg CLK, N_RST, HLT;
	reg [31:0] ir;
	
	//output
	wire[4:0] phase;
	wire[2:0] ra1,ra2;
	wire[31:0] rd1,rd2;
	wire[31:0] dr;
	wire[2:0] wa;
	//instanciate
	phase_gen phase_gen_obj(HLT,phase,CLK,N_RST);
	ir_dec ir_dec_obj(phase, ir, ra1, ra2, CLK);
	register_file register_file_obj(phase, ra1, ra2, wa, rd1, rd2, wd, we, CLK, N_RST, rf);
	alu alu_obj(phase, ra1, ra2, rd1, rd2, dr, ir, we, wa, CLK);
	
	initial begin
	
		CLK = 0; N_RST = 0; HLT = 0;
		ir = 32'b 0000_0000_11_000_001_1001_0000_1001_0000;
		#100 N_RST = 1;
		
		#1000 HLT  = 1;
	end
	
	always begin
		#5 CLK = ~CLK;
	end
	
endmodule
		