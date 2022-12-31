module hex_keypad(
    input [3:0]row, input s_row, clk, rst, output reg [3:0]code, col, output valid
);
parameter s_0 = 6'b000_001,
          s_1 = 6'b000_010,
          s_2 = 6'b000_100,
          s_3 = 6'b001_000,
          s_4 = 6'b010_000,
          s_5 = 6'b100_000;

reg [5:0] state, next_state;

assign valid = ((state == s_1) || (state == s_2) || (state == s_3) || (state == s_4)) && row;

always @(row or col) begin
    case({row,col}) 
        8'b0001_0001: code = 4'b0000;
        8'b0001_0010: code = 4'b0001;
        8'b0001_0100: code = 4'b0010;
        8'b0001_1000: code = 4'b0011;

        8'b0010_0001: code = 4'b0100;
        8'b0010_0010: code = 4'b0101;
        8'b0010_0100: code = 4'b0110;
        8'b0010_1000: code = 4'b0111;

        8'b0100_0001: code = 4'b1000;
        8'b0100_0010: code = 4'b1001;
        8'b0100_0100: code = 4'b1010;
        8'b0100_1000: code = 4'b1011;

        8'b1000_0001: code = 4'b1100;
        8'b1000_0010: code = 4'b1101;
        8'b1000_0100: code = 4'b1110;
        8'b1000_1000: code = 4'b1111;

        default : code  = 4'b0000;
    endcase
end

always @(posedge clk or posedge rst ) begin
    if (rst)
    state <= s_0;
    else
    next_state <= state;
end

always @(state or row or s_row) begin
    next_state = state;
    col = 4'b0000;
    case (state)
        s_0 : begin
                col = 4'b1111;
                if(s_row)
                next_state = s_1;
              end
        s_1 : begin
                col = 4'b0001;
                if(row)
                next_state = s_5;
                else
                next_state = s_2;
              end
        s_2 : begin
                col = 4'b0010;
                if(row)
                next_state = s_5;
                else
                next_state = s_3;
              end
        s_3 : begin
                col = 4'b0100;
                if(row)
                next_state = s_5;
                else
                next_state = s_4;
              end
        s_4 : begin
                col = 4'b1000;
                if(row)
                next_state = s_5;
                else
                next_state = s_0;
              end
        s_5 : begin
                col = 4'b1111;
                if(row == 4'b0000)
                next_state = s_0;
              end
    endcase    
end
endmodule