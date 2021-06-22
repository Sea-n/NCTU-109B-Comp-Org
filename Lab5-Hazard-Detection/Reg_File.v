// Author: 0816146 韋詠祥

module Reg_File(
	clk_i,
	rst_i,
	RSaddr_i,
	RTaddr_i,
	RDaddr_i,
	RDdata_i,
	RegWrite_i,
	RSdata_o,
	RTdata_o
);

// I/O ports
input clk_i, rst_i, RegWrite_i;
input [5-1:0] RSaddr_i, RTaddr_i, RDaddr_i;
input [32-1:0] RDdata_i;
output [32-1:0] RSdata_o, RTdata_o;

reg signed [32-1:0] Reg_Bank [0:32-1];  // 32 word registers

// Read the data
assign RSdata_o = (RegWrite_i & (RSaddr_i == RDaddr_i)) ? RDdata_i : Reg_Bank[RSaddr_i];
assign RTdata_o = (RegWrite_i & (RTaddr_i == RDaddr_i)) ? RDdata_i : Reg_Bank[RTaddr_i];

// Writing data when postive edge clk_i and RegWrite_i was set.
always @(posedge rst_i, posedge clk_i) begin
	if (~rst_i) begin
		Reg_Bank[0]  <= 0; Reg_Bank[1]  <= 0; Reg_Bank[2]  <= 0; Reg_Bank[3]  <= 0;
		Reg_Bank[4]  <= 0; Reg_Bank[5]  <= 0; Reg_Bank[6]  <= 0; Reg_Bank[7]  <= 0;
		Reg_Bank[8]  <= 0; Reg_Bank[9]  <= 0; Reg_Bank[10] <= 0; Reg_Bank[11] <= 0;
		Reg_Bank[12] <= 0; Reg_Bank[13] <= 0; Reg_Bank[14] <= 0; Reg_Bank[15] <= 0;
		Reg_Bank[16] <= 0; Reg_Bank[17] <= 0; Reg_Bank[18] <= 0; Reg_Bank[19] <= 0;
		Reg_Bank[20] <= 0; Reg_Bank[21] <= 0; Reg_Bank[22] <= 0; Reg_Bank[23] <= 0;
		Reg_Bank[24] <= 0; Reg_Bank[25] <= 0; Reg_Bank[26] <= 0; Reg_Bank[27] <= 0;
		Reg_Bank[28] <= 0; Reg_Bank[29]<=128; Reg_Bank[30] <= 0; Reg_Bank[31] <= 0;
	end else begin
		if (RegWrite_i)
			Reg_Bank[RDaddr_i] <= RDdata_i;
		else
			Reg_Bank[RDaddr_i] <= Reg_Bank[RDaddr_i];
	end
end

endmodule
