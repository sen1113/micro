`define f 0
`define r 1
`define x 2
`define m 3
`define w 4
module alu(phase, ra1, ra2, rd1, rd2, dr, ir, we, wa, clk);
	input clk;
	input [`w: `f] phase;
	
	input[31:0] rd1,rd2,ir;
	input [2:0] ra1,ra2;//ïsóvÅH
	output[31:0] dr;
	output[1:0] we;
	output[2:0] wa;
	//output flags;
	reg [1:0] we_out;
	reg [31:0] dr_out;
	reg [2:0] wa_out;
	//wire [31:0] wd;
	
	always@(posedge clk)begin
		if(phase[`x] == 1)
			case(ir[31:22])
	/*		
				10'b1000_1010_01xx_xxxx://zLD
				10'b1000_1000_01xx_xxxx://zST
				10'b0110_0110_10xx_xxxx://zLIL
				10'b1000_1000_11xx_xxxx://zMOV
	*/			
				//zADD
				10'b 0000_0000_11: begin
					dr_out <=  rd2 + rd1;
					we_out <= 1;
					wa_out <= ra2;
				end
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
				
				13'b0101_0xxx_xxxx_xxxx://zPUSH
				13'b0101_1xxx_xxxx_xxxx://zPOP
				
				8'b1111_0100://zHLT*/
			endcase
	end	
	assign dr = dr_out;
	assign we = we_out;
	assign wa = wa_out;
endmodule //alu
