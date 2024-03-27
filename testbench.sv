`include "top.sv"
module testbench ();
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
    $dumpfile("testbench.vcd");
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
      if (dataadr === 84 & writedata === 7) begin
        $display("Simulation succeeded");
        $finish;
      end else if (dataadr !== 80) begin
        $display("Simulation failed");
        $finish;
      end
    end
  end

endmodule
