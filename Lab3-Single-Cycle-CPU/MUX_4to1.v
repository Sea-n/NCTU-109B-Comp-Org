// Author: 0816146 韋詠祥

module MUX_4to1(
	data0_i,
	data1_i,
	data2_i,
	data3_i,
	select_i,
	data_o
);

parameter size = 0;

// I/O ports
input [size-1:0] data0_i, data1_i, data2_i, data3_i;
input [1:0] select_i;
output reg [size-1:0] data_o;

// Main function
always @(select_i, data0_i, data1_i, data2_i, data3_i) begin
	if (select_i == 2'b00)
		data_o <= data0_i;
	else if (select_i == 2'b01)
		data_o <= data1_i;
	else if (select_i == 2'b10)
		data_o <= data2_i;
	else
		data_o <= data3_i;
end

endmodule
