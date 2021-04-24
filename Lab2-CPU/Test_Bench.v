`timescale 1ns/1ps

// Author: 0816146 韋詠祥

`define CYCLE_TIME 10
`define END_COUNT 25
module TestBench;

// Internal Signals
reg CLK, RST;
integer count, handle, end_count;
// Greate tested modle
Simple_Single_CPU cpu(
	.clk_i(CLK),
	.rst_i(RST)
);

// Main function

always #(`CYCLE_TIME/2) CLK = ~CLK;

initial begin
	handle = $fopen("results.txt");
	CLK = 0;
	RST = 0;
	count = 0;
	end_count = 25;
	#(`CYCLE_TIME) RST = 1;
	#(`CYCLE_TIME*`END_COUNT) $fclose(handle);
	$finish;
end

// Print result to the file
always @(posedge CLK) begin
	count = count + 1;
	if (count == `END_COUNT) begin
		$display(handle, "r0=%d\nr1=%d\nr2=%d\nr3=%d\nr4=%d\nr5=%d\nr6=%d\nr7=%d\nr8=%d\nr9=%d\nr10=%d\nr11=%d\nr12=%d",
			cpu.RF.Reg_File[0], cpu.RF.Reg_File[1], cpu.RF.Reg_File[2], cpu.RF.Reg_File[3], cpu.RF.Reg_File[4],
			cpu.RF.Reg_File[5], cpu.RF.Reg_File[6], cpu.RF.Reg_File[7], cpu.RF.Reg_File[8], cpu.RF.Reg_File[9],
			cpu.RF.Reg_File[10], cpu.RF.Reg_File[11], cpu.RF.Reg_File[12]
		);
		$fdisplay(handle, "r0=%d\nr1=%d\nr2=%d\nr3=%d\nr4=%d\nr5=%d\nr6=%d\nr7=%d\nr8=%d\nr9=%d\nr10=%d\nr11=%d\nr12=%d",
			cpu.RF.Reg_File[0], cpu.RF.Reg_File[1], cpu.RF.Reg_File[2], cpu.RF.Reg_File[3], cpu.RF.Reg_File[4],
			cpu.RF.Reg_File[5], cpu.RF.Reg_File[6], cpu.RF.Reg_File[7], cpu.RF.Reg_File[8], cpu.RF.Reg_File[9],
			cpu.RF.Reg_File[10], cpu.RF.Reg_File[11], cpu.RF.Reg_File[12]
		);
	end
end

endmodule
