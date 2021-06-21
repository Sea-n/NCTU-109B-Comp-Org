// Author: 0816146 韋詠祥

module Hazard(
	RSaddr_i,
	RTaddr_i,
	RTaddr_s3_i,
	MemRead_s3_i,
	Stall_o,
);

// I/O ports
input [4:0] RSaddr_i, RTaddr_i, RTaddr_s3_i;
input MemRead_s3_i;
output wire Stall_o;

// Main function
assign Stall_o = MemRead_s3_i & ((RSaddr_i == RTaddr_s3_i) | (RTaddr_i == RTaddr_s3_i));

endmodule
