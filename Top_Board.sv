`include "imem.sv"
`include "mips.sv"
`include "dmemory_decoder.sv"

module Top_Board (
    input clk,
    input BTNC,  // reset
    input BTNL,  // sw input data
    input BTNR,  // seven segment output
    input [15:0] SW,
    output [7:0] AN,
    output [6:0] A2G
);

  reg [31:0] pc, instr;

  imem imem (
      .a (pc[7:2]),
      .rd(instr)
  );

  reg Write;  // could be memwrite, could be iowrite
  reg [31:0] dataAdr, writeData, readData;

  mips mips (
      // input logic clk,
      // reset,
      // output logic [31:0] pc,
      // input logic [31:0] instr,
      // output logic memwrite,
      // output logic [31:0] aluout,
      // writedata,
      // input logic [31:0] readdata
      .clk(clk),
      .reset(BTNC),
      .pc(pc),
      .instr(instr),
      .memwrite(Write),
      .aluout(dataAdr),
      .writedata(writeData),
      .readdata(readData)
  );

  dMemoryDecoder dMemoryDecoder (
      .clk(clk),
      .writeEN(Write),
      .addr(dataAdr[7:0]),
      .writeData(writeData),
      .readData(readData),
      .reset(BTNC),
      .btnL(BTNL),
      .btnR(BTNR),
      .switch(SW),
      .an(AN),
      .a2g(A2G)
  );

endmodule
