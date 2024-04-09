module aludec (
    input logic [5:0] funct,
    input logic [2:0] aluop,
    output logic [2:0] alucontrol
);

  always_comb begin : aludecblock
    case (aluop)
      3'b000: alucontrol = 3'b000;  // add (for lw/sw/addi)
      3'b001: alucontrol = 3'b001;  // sub (for beq)
      3'b010: alucontrol = 3'b110;  // or (ori)
      3'b011: alucontrol = 3'b010;  // and (andi)
      default:
      case (funct)
        // R-type instructions
        6'b100000: alucontrol = 3'b000;  // add
        6'b100010: alucontrol = 3'b001;  // sub
        6'b100100: alucontrol = 3'b010;  // and
        6'b100101: alucontrol = 3'b110;  // or ???
        6'b101010: alucontrol = 3'b111;  // slt
        default:   alucontrol = 3'bxxx;  // ???
      endcase
    endcase
  end

// change aluop to three bytes
// 

endmodule
