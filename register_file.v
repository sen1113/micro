`define f 0
`define r 1
`define x 2
`define m 3
`define w 4
module  register_file(phase, ra1, ra2, wa, rd1, rd2, wd, we, clk, n_rst, rf);
	input  [ 2:0] ra1, ra2, wa;	// アドレス（レジスタ番号）
	output [31:0] rd1, rd2;    	// 読み出しデータ
	input  [31:0] wd;         	// 書き込みデータ
	input  we;                  	// ライト・イネーブル
	input  clk, n_rst;         	// クロック，リセット
     // output reg [31:0] rf[0:7];	// レジスタ・ファイル本体（デバグ用出力）
	input [`w: `f] phase;
 	output rf;
	integer i;
	reg [31:0] ir;
	reg [31:0] org_rf [0:7];        	// 32-bit x 8-word レジスタ・ファイル本体
	reg [31:0] rd_out1,rd_out2;
	
	
	ir_dec ir_dec_obj (phase, ir, ra1, ra2, clk);
	
	always @(posedge clk or negedge n_rst) begin
	   if (n_rst == 0) begin
	        for (i = 0; i < 8; i = i + 1)
	            org_rf[i] <= 1;
		end
		else if (phase [`r] == 1) begin
			rd_out1 <= org_rf[ra1];  	// 読み出し
			rd_out2 <= org_rf[ra2];		// 読み出し
		end
		else if (phase [`w] == 1 && we == 1) begin
			org_rf[wa] <=  wd;
		end
	end
	
	assign rd1 = rd_out1;
	assign rd2 = rd_out2;
	assign rf  = {org_rf[0],org_rf[1],org_rf[2],org_rf[3],org_rf[4],org_rf[5],org_rf[6],org_rf[7]};

	endmodule//register_file