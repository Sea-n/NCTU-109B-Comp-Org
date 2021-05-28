// Author: 0816146 韋詠祥

module MUX_2to1(
	data0_i,
	data1_i,
	select_i,
	data_o
);

parameter size = 0;

// I/O ports
input [size-1:0] data0_i, data1_i;
input select_i;
output reg [size-1:0] data_o;

// Main function
always @(select_i, data0_i, data1_i) begin
	case (select_i)
		1'b0: data_o <= data0_i;
		1'b1: data_o <= data1_i;
	endcase
end

endmodule
