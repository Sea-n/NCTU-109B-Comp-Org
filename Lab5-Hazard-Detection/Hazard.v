// Author: 0816146 韋詠祥

module Hazard(
	RSaddr_i,
	RTaddr_i,
	RSaddr_s3_i,
	RTaddr_s3_i,
	Branch_i,
	MemRead_i,
	MemRead_s3_i,
	Stall_o,
);

// I/O ports
input [4:0] RSaddr_i, RTaddr_i, RSaddr_s3_i, RTaddr_s3_i;
input MemRead_i, MemRead_s3_i, Branch_i;
output wire Stall_o;

// Main function
assign Stall_o = (((RSaddr_i == RTaddr_s3_i) | (RTaddr_i == RTaddr_s3_i)) & MemRead_s3_i) |
				 (((RSaddr_i == RSaddr_s3_i) | (RTaddr_i == RSaddr_s3_i)
				 | (RSaddr_i == RTaddr_s3_i) | (RTaddr_i == RTaddr_s3_i)) & Branch_i) |
				 (((RSaddr_i == RSaddr_s3_i) | (RTaddr_i == RSaddr_s3_i)
				 | (RSaddr_i == RTaddr_s3_i) | (RTaddr_i == RTaddr_s3_i)) & MemRead_i & Branch_i);

endmodule
