// alu alu (
//       srca,
//       srcb,
//       alucontrol,
//       aluout,
//       zero
//   );

module alu (
    input [31:0] srca,
    srcb,
    input [2:0] alucontrol,
    output reg [31:0] aluout,
    output reg zero
);
  always_comb begin : alublock
    case (alucontrol)
      3'b000:  aluout = srca + srcb;
      3'b001:  aluout = srca - srcb;
      3'b010:  aluout = srca & srcb;
      3'b110:  aluout = srca | srcb;
      3'b111:  aluout = (srca < srcb )? 1 : 0;
      default: aluout = 32'hxxxxxxxx;
    endcase
    zero = (aluout == 0) ? 1 : 0;
  end


endmodule
