`include "top.sv"
module test_bne_TB ();
  logic clk = 0;
  logic reset;
  logic [31:0] writedata, dataadr;
  logic memwrite;
  // instantiate device to be tested
  top dut (
      clk,
      reset,
      writedata,
      dataadr,
      memwrite
  );
  // initialize test
  initial begin
    $dumpfile("test_andi_TB.vcd");
    $dumpvars;
    reset <= 1;
    #22;
    reset <= 0;
  end
  // generate clock to sequence tests
  always #5 clk <= ~clk;

  // check results
  always @(negedge clk) begin
    if (memwrite) begin
      if (dataadr == 84 && writedata == 4) begin
        $display("Simulation succeeded");
        $finish;
      end else begin
        $display("Simulation failed");
        $finish;
      end
    end
  end

endmodule
