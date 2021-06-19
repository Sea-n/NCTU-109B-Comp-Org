// Author: 0816146 韋詠祥

module Forwarding(
	RSaddr_i,
	RTaddr_i,
	RDaddr_s4_i,
	RDaddr_s5_i,
	RegWrite_s4_i,
	RegWrite_s5_i,
	ForwardA_o,
	ForwardB_o
);

// I/O ports
input [4:0] RSaddr_i, RTaddr_i, RDaddr_s4_i, RDaddr_s5_i;
input RegWrite_s4_i, RegWrite_s5_i;
output wire [1:0] ForwardA_o, ForwardB_o;

// EX/MEM is s4, fwd[0]
// MEM/WB is s5, fwd[1]

// Main function
assign ForwardA_o = {RegWrite_s4_i & (|RDaddr_s4_i) & (RDaddr_s4_i == RSaddr_i),
                     RegWrite_s5_i & (|RDaddr_s5_i) & (RDaddr_s5_i == RSaddr_i)};
assign ForwardB_o = {RegWrite_s4_i & (|RDaddr_s4_i) & (RDaddr_s4_i == RTaddr_i),
                     RegWrite_s5_i & (|RDaddr_s5_i) & (RDaddr_s5_i == RTaddr_i)};

endmodule
