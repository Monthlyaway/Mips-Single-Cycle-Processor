`include "maindec.sv"
`include "aludec.sv"

`ifndef CONTROLLER
`define CONTROLLER

module controller (
    input logic [5:0] op,
    funct,
    input logic zero,
    output logic memtoreg,
    memwrite,
    output logic pcsrc,
    alusrc,
    output logic regdst,
    regwrite,
    output logic jump,
    output logic [2:0] alucontrol,
    input clk
);
  logic [1:0] aluop;
  logic branch;
  maindec md (
      op,
      memtoreg,
      memwrite,
      branch,
      alusrc,
      regdst,
      regwrite,
      jump,
      aluop,
      clk
  );
  aludec ad (
      funct,
      aluop,
      alucontrol
  );
  assign pcsrc = branch & zero;
endmodule

`endif
