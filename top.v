`include "hex_keypad.v"
`include "row_sgnl.v"
`include "sync.v"

module top(
    input clk, rst, input [15:0] key, output  valid, output [3:0] row, col, code
);
wire s_row;

hex_keypad M1(.row(row),  .s_row(s_row), .clk(clk), .rst(rst), .code(code), .col(col), .valid(valid));

row_sgnl M2(key, col,  row);

sync M3(clk, rst , row, s_row);

endmodule