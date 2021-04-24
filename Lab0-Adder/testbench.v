module testbench;

reg a, b, cin; // for stimulus waveforms
wire sum, c_out;

// correct answer
reg [7:0]ans_sum;
reg [7:0]ans_carry;
reg correct, clk;
reg [7:0]counter;
// for testing half adder
//Half_Adder HAD (a, b, sum, c_out);

// for testing full adder
Full_Adder FAD (a, b, cin, sum, c_out);

initial #100 $finish; // Stopwatch
initial begin // Stimulus patterns
    clk = 1'b0;
    counter =  8'd8;
    correct = 1;
    ans_sum     = 8'b01101001;
    ans_carry   = 8'b00010111;

    #10 a = 0; b = 0; cin = 0; // Statements execute in sequence
    #10 a = 0; b = 1; cin = 0;
    #10 a = 1; b = 0; cin = 0;
    #10 a = 1; b = 1; cin = 0;
    #10 a = 0; b = 0; cin = 1;
    #10 a = 0; b = 1; cin = 1;
    #10 a = 1; b = 0; cin = 1;
    #10 a = 1; b = 1; cin = 1;
end

always #5 clk = ~clk;

always@(posedge clk) begin
    if(counter <= 7 && (ans_sum[counter] != sum || ans_carry[counter] != c_out)) begin
        $display(" Pattern %d is wrong! ", counter);
        $display(" sum %d ans %d ", sum, ans_sum[counter]);
        $display(" car %d ans %d ", c_out, ans_carry[counter]);
        correct = 0;
    end
    else if (counter == 0 && correct) begin
        $display("***************************************************");
        $display(" Congratulation! All data are correct! ");
        $display("***************************************************");
    end
    counter <= counter - 8'd1;
end




endmodule
