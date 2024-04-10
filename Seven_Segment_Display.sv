module Seven_Segment_Display (
    input i_clk,
    input i_reset,
    input [31:0] i_digit,
    // switch [31:16]
    // led [11:0]
    output reg [7:0] o_AN,
    output reg o_DP,  // decimal point
    output reg [6:0] o_A2G
);

  reg [2:0] r_counter = 0;
  reg [3:0] value;

  assign o_DP = 1;

  always @(posedge i_clk) begin
    if (i_reset) begin
      o_AN  <= 8'b11111110;
      o_A2G <= 7'b0000001;
    end else begin
      if (r_counter == 8) r_counter = 0;
      else r_counter = r_counter + 1;
      case (r_counter)
        3'b111: begin
          value <= i_digit[31:28];
          o_AN  <= 8'b01111111;
        end
        3'b110: begin
          value <= i_digit[27:24];
          o_AN  <= 8'b10111111;
        end
        3'b101: begin
          value <= i_digit[23:20];
          o_AN  <= 8'b11011111;
        end
        3'b100: begin
          value <= i_digit[19:16];
          o_AN  <= 8'b11101111;
        end
        // TODO: led not assigned
        default: value <= 4'b0000;
      endcase

      case (value)
        4'b0000: o_A2G <= 7'b0000001;  // "0"  
        4'b0001: o_A2G <= 7'b1001111;  // "1" 
        4'b0010: o_A2G <= 7'b0010010;  // "2" 
        4'b0011: o_A2G <= 7'b0000110;  // "3" 
        4'b0100: o_A2G <= 7'b1001100;  // "4" 
        4'b0101: o_A2G <= 7'b0100100;  // "5" 
        4'b0110: o_A2G <= 7'b0100000;  // "6" 
        4'b0111: o_A2G <= 7'b0001111;  // "7" 
        4'b1000: o_A2G <= 7'b0000000;  // "8"  
        4'b1001: o_A2G <= 7'b0000100;  // "9" 
        default: o_A2G <= 7'b0000001;  // "0"
      endcase
    end
  end



endmodule
