`define f 0
`define r 1
`define x 2
`define m 3
`define w 4

module phase_gen(hlt, phase, clk, n_rst);
	input hlt;
	output [`w: `f] phase;
	input clk, n_rst;
	
	reg [2:0] n_rst_d;
	always @(posedge clk) begin
		n_rst_d <= {n_rst_d[1:0], n_rst};
	end
	
	reg[`w: `f]phase;
	always @(posedge clk or negedge n_rst) begin
		if(n_rst == 0)
			phase <= 0;
		else if (hlt == 1)
			phase <= 0;
		else if (n_rst_d[2:1] == 2'b01)
			phase <= 1;
		else 
			phase <= {phase[3:0], phase[4]};
	end
endmodule //phase_gen