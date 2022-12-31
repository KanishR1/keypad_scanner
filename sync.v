module sync(
    input clk,rst, input [3:0] row, output reg s_row
);
reg a_row;

always @(negedge clk or posedge rst) begin
    if(rst)
    begin
      a_row <= 0;
      s_row <= 0;
    end    
    else begin
      a_row <= (row[0] || row[1] || row[2] || row[3]);
      s_row <= a_row;
    end
end

endmodule