//Subject:     CO project 2 - Simple Single CPU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
`timescale 1ns/1ps
module Simple_Single_CPU(
        clk_i,
		rst_i
		);
		
//I/O port
input         clk_i;
input         rst_i;

//Internal Signles


//Greate componentes
ProgramCounter PC(
        .clk_i(),      
	    .rst_i (),     
	    .pc_in_i() ,   
	    .pc_out_o() 
	    );
	
Adder Adder1(
        .src1_i(),     
	    .src2_i(),     
	    .sum_o()    
	    );
	
Instr_Memory IM(
        .pc_addr_i(),  
	    .instr_o()    
	    );

MUX_2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(),
        .data1_i(),
        .select_i(),
        .data_o()
        );	
		
Reg_File RF(
        .clk_i(),      
	    .rst_i() ,     
        .RSaddr_i() ,  
        .RTaddr_i() ,  
        .RDaddr_i() ,  
        .RDdata_i()  , 
        .RegWrite_i (),
        .RSdata_o() ,  
        .RTdata_o()   
        );
	
Decoder Decoder(
        .instr_op_i(), 
	    .RegWrite_o(), 
	    .ALU_op_o(),   
	    .ALUSrc_o(),   
	    .RegDst_o(),   
		.Branch_o()   
	    );

ALU_Ctrl AC(
        .funct_i(),   
        .ALUOp_i(),   
        .ALUCtrl_o() 
        );
	
Sign_Extend SE(
        .data_i(),
        .data_o()
        );

MUX_2to1 #(.size(32)) Mux_ALUSrc(
        .data0_i(),
        .data1_i(),
        .select_i(),
        .data_o()
        );	
		
ALU ALU(
        .src1_i(),
	    .src2_i(),
	    .ctrl_i(),
	    .result_o(),
		.zero_o()
	    );
		
Adder Adder2(
        .src1_i(),     
	    .src2_i(),     
	    .sum_o()      
	    );
		
Shift_Left_Two_32 Shifter(
        .data_i(),
        .data_o()
        ); 		
		
MUX_2to1 #(.size(32)) Mux_PC_Source(
        .data0_i(),
        .data1_i(),
        .select_i(),
        .data_o()
        );	

endmodule
		  


