`define f 4
`define r 3
`define x 2
`define m 1
`define w 0


module alu(phase,ra1, ra2, rd1, rd2, wd, ir, clk);
	input[31:0] rd1,rd2,ir;
	input [2:0] ra1,ra2;
	input clk;
	input [`f: `w] phase;
	output[31:0] wd;
	//output flags;
	reg[31:0] dr_out;
	wire [31:0] wd;
	
	always@(posedge clk)begin
		if(phase[`x] == 1)
			case(ir[31:16])
	/*		
				10'b1000_1010_01xx_xxxx://zLD
				10'b1000_1000_01xx_xxxx://zST
				10'b0110_0110_10xx_xxxx://zLIL
				10'b1000_1000_11xx_xxxx://zMOV
	*/			
				16'b0000_0000_11xx_xxxx: dr_out <=  rd2 + rd1;//zADD
	/*			10'b0010_1000_11://zSUB
				10'b0011_1000_11://zCMP
				10'b0010_0000_11://zAND
				10'b0000_1000_11://zOR
				10'b0011_0000_11://zXOR
				
				13'b1000_0000_11_000://zADDI
				13'b1000_0000_11_101://zSUBI
				13'b1000_0000_11_111://zCMPI
				13'b1000_0000_11_100://zANDI
				13'b1000_0000_11_001://zORI
				13'b1000_0000_11_110://zXORI
				
				13'b1111_0110_11_011://zNEG
				13'b1111_0110_11_010://zNOT
				
				13'b1100_0000_11_100://zSLL
				13'b1100_0000_11_101://zSLA
				13'b1100_0000_11_101://zSRL
				13'b1100_0000_11_111://zSRA
				
				16'b1001_0000_1110_1011://zB
				12'b1001_0000_0111://zBcc
				
				13'b1001_0000_0101_0://zPUSH
				13'b1001_0000_0101_1://zPOP
				
				8'b1111_0100://zHLT*/
			endcase
	end	
	assign wd = dr_out;
endmodule //alu
