`timescale 1ns/1ps

// Author: 0816146 韋詠祥

module Sign_Extend(
	data_i,
	data_o
);

// I/O ports
input [16-1:0] data_i;
output reg [32-1:0] data_o;

// Sign extended
always @(data_i) begin
	if (data_i[15])
		data_o <= {16'b1, data_i};
	else
		data_o <= {16'b0, data_i};
end

endmodule
