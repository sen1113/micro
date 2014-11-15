`define f 4
`define r 3
`define x 2
`define m 1
`define w 0

module  register_file(phase, ra1, ra2, wa, rd1, rd2, wd, we, clk, n_rst, rf);
	input  [ 2:0] ra1, ra2, wa;	// �A�h���X�i���W�X�^�ԍ��j
	output [31:0] rd1, rd2;    	// �ǂݏo���f�[�^
	input  [31:0] wd;         	// �������݃f�[�^
	input  we;                  	// ���C�g�E�C�l�[�u��
	input  clk, n_rst;         	// �N���b�N�C���Z�b�g
     // output reg [31:0] rf[0:7];	// ���W�X�^�E�t�@�C���{�́i�f�o�O�p�o�́j
	input [`f: `w] phase;
 	output rf;
	integer i;
	
	reg [31:0] org_rf [0:7];        	// 32-bit x 8-word ���W�X�^�E�t�@�C���{��
	reg [31:0] rd_out1,rd_out2;
	always @(posedge clk  or  negedge n_rst) begin
	   if (n_rst == 0) begin
	        for (i = 0; i < 8; i = i + 1)
	            org_rf[i] <= 0;
		end
		else if (phase [`r] == 1) begin
			rd_out1 <= org_rf[ra1];  	// �ǂݏo��
			rd_out2 <= org_rf[ra2];		// �ǂݏo��
		end
		else if (phase [`w] == 1 && we == 1) begin
			org_rf[wa] <=  wd;
		end
	end
	
	assign rd1 = rd_out1;
	assign rd2 = rd_out2;
	assign  rf  = {org_rf[0],org_rf[1],org_rf[2],org_rf[3],org_rf[4],org_rf[5],org_rf[6],org_rf[7]};

	endmodule//register_file