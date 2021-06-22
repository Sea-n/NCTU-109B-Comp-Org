// Author: 0816146 韋詠祥

module Hazard(
	RSaddr_i,
	RTaddr_i,
	RSaddr_s3_i,
	RTaddr_s3_i,
	RSaddr_s4_i,
	RTaddr_s4_i,
	Branch_i,
	MemRead_i,
	Branch_s3_i,
	MemRead_s3_i,
	MemRead_s4_i,
	Stall_o,
);

// I/O ports
input [4:0] RSaddr_i, RSaddr_s3_i, RSaddr_s4_i;
input [4:0] RTaddr_i, RTaddr_s3_i, RTaddr_s4_i;
input MemRead_i, MemRead_s3_i, MemRead_s4_i, Branch_i, Branch_s3_i;
output reg Stall_o;

// Main function
always @(RSaddr_i, RSaddr_s3_i, RSaddr_s4_i, RTaddr_i, RTaddr_s3_i, RTaddr_s4_i,
		 MemRead_i, MemRead_s3_i, MemRead_s4_i, Branch_i, Branch_s3_i) begin
	Stall_o <= 0;

	if (((RSaddr_i == RTaddr_s3_i) | (RTaddr_i == RTaddr_s3_i)) & MemRead_i)
		Stall_o <= 1;

	if (((RSaddr_i == RSaddr_s3_i) | (RTaddr_i == RSaddr_s3_i)
	   | (RSaddr_i == RTaddr_s3_i) | (RTaddr_i == RTaddr_s3_i)) & MemRead_s3_i & Branch_i)
		Stall_o <= 1;

	if (((RSaddr_i == RSaddr_s4_i) | (RTaddr_i == RSaddr_s4_i)
	   | (RSaddr_i == RTaddr_s4_i) | (RTaddr_i == RTaddr_s4_i)) & MemRead_s4_i & Branch_i)
		Stall_o <= 1;
end

endmodule
