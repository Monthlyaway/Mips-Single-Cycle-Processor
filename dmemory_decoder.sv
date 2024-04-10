`include "IO.sv"
`include "dmem.sv"
`include "dmemory_decoder.sv"

module dMemoryDecoder (
    input clk,
    input writeEN,
    input [7:0] addr,
    input [31:0] writeData,
    output [31:0] readData,
    input reset,
    input btnL,  // LED button
    input btnR,  // switch button
    input [15:0] switch,  // 16 swtiches
    output [7:0] an,  // 阳极
    output [6:0] a2g,
    output dp
    // It's chosen as a shorthand or mnemonic for the seven segments labeled 'a' through 'g' in the seven-segment display. Each bit of a2g could correspond to one of these segments.
);

  wire [31:0] w_dmem_rd;

  dmem dmem (
      // input logic clk,
      // we,
      // input logic [31:0] a,
      // wd,
      // output logic [31:0] rd
      .clk(clk),
      .we (writeEN),
      .a  ({24'h000000, addr}),
      .wd (writeData),
      .rd (w_dmem_rd)
  );

  wire w_pWrite;
  assign w_pWrite = writeEN & addr[7];
  wire [31:0] w_readdata2;
  wire [11:0] w_led2seven;
  IO IO (
      // // connected to CPU
      // input clk,
      // input reset,
      // input pRead,
      // input pWrite,
      // input [1:0] addr,
      // input [11:0] pWriteData,
      // output reg [31:0] pReadData,
      // // connected to FPGA
      // input buttonL,  // led status
      // input buttonR,  // switch status
      // input [15:0] switch,  // output directly
      // output reg [11:0] led
      .clk(clk),
      .reset(reset),
      .pRead(addr[7]),
      .pWrite(w_pWrite),
      .addr(addr[3:2]),
      .pWriteData(writeData[11:0]),
      .pReadData(w_readdata2),
      .buttonL(btnL),
      .buttonR(btnR),
      .switch(switch),
      .led(w_led2seven)
  );

  assign readData = addr[7] ? w_readdata2 : w_dmem_rd;

  Seven_Segment_Display Seven_Segment_Display (
      // input i_clk,
      // input i_reset,
      // input [31:0] i_digit,
      // // switch [31:16]
      // // led [11:0]
      // output reg [7:0] o_AN,
      // output reg o_DP,  // decimal point
      // output reg [6:0] o_A2G
      .i_clk(clk),
      .i_reset(reset),
      .i_digit({switch, 4'b0000, w_led2seven}),
      .o_AN(an),
      .o_DP(dp),
      .o_A2G(a2g)
  );

endmodule
