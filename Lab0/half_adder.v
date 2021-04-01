`timescale 1ns / 1ps

module Half_Adder(
    In_A, In_B, Sum, Carry_out
    );
    input In_A, In_B;
    output Sum, Carry_out;
    
    // implement half adder circuit, your code starts from here.
	// gate(output, input1, input2)
    xor(Sum, In_A, In_B);
	and(Carry_out, In_A, In_B);
	
endmodule
