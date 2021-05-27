`timescale 1ns / 1ps
//Subject:     CO project 4 - Pipe CPU 1
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Pipe_CPU_1(
    clk_i,
    rst_i
    );
    
/****************************************
I/O ports
****************************************/
input clk_i;
input rst_i;

/****************************************
Internal signal
****************************************/
/**** IF stage ****/

/**** ID stage ****/

//control signal


/**** EX stage ****/

//control signal


/**** MEM stage ****/

//control signal


/**** WB stage ****/

//control signal


/****************************************
Instantiate modules
****************************************/
//Instantiate the components in IF stage
MUX_2to1 #(.size(N) Mux0(

);

ProgramCounter PC(

);

Instruction_Memory IM(

);
			
Adder Add_pc(

);

		
Pipe_Reg #(.size(N) IF_ID(       //N is the total length of input/output

);


//Instantiate the components in ID stage
Reg_File RF(

);

Decoder Control(

);

Sign_Extend Sign_Extend(

);	

Pipe_Reg #(.size(N) ID_EX(

);


//Instantiate the components in EX stage	   
Shift_Left_Two_32 Shifter(

);

ALU ALU(

);
		
ALU_Control ALU_Control(

);

MUX_2to1 #(.size(32)) Mux1(

);
		
MUX_2to1 #(.size(5)) Mux2(

);

Adder Add_pc_branch(
   
);

Pipe_Reg #(.size(N) EX_MEM(

);


//Instantiate the components in MEM stage
Data_Memory DM(

);

Pipe_Reg #(.size(N) MEM_WB(

);


//Instantiate the components in WB stage
MUX_2to1 #(.size(32)) Mux3(

);

/****************************************
signal assignment
****************************************/

endmodule

