`timescale 1ns/1ps
module tb;
reg clk, rst;
reg [15:0] key;
wire  valid;
wire [3:0] row, col, code;

top DUT(clk, rst, key, valid, row, col, code);

integer i,j;
initial begin
  clk = 1'b0;
  forever #5 clk = ! clk;
end

initial begin
    $dumpfile("output.vcd");
    $dumpvars(0,tb);

    rst = 1'b1;
    #10;
    rst = 1'b0;

    for (i=0 ; i<=1; i=i+1) begin
        key = 0;
        #20;
      for(j = 0 ; j<=16; j=j+1) begin
        #20 key[j] = 1;
        #60;
        key = 0;

      end
    end
    $finish;
end
endmodule