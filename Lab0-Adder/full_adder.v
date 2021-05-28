`timescale 1ns / 1ps

module Full_Adder(
	In_A,
	In_B,
	Carry_in,
	Sum,
	Carry_out
);
input In_A, In_B, Carry_in;
output Sum, Carry_out;
wire a, b, c;

// implement full adder circuit, your code starts from here.
// use half adder in this module, fulfill I/O ports connection.
Half_Adder HAD0 (
	.In_A(In_A),
	.In_B(In_B),
	.Sum(a),
	.Carry_out(b)
);

	Half_Adder HAD1 (
		.In_A(a),
		.In_B(Carry_in),
		.Sum(Sum),
		.Carry_out(c)
	);

	or(Carry_out, b, c);

endmodule
