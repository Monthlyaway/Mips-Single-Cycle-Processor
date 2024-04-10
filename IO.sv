module IO (
    // connected to CPU
    input clk,
    input reset,
    input pRead,
    input pWrite,
    input [1:0] addr,
    input [11:0] pWriteData,
    output reg [31:0] pReadData,
    // connected to FPGA
    input buttonL,  // led status
    input buttonR,  // switch status
    input [15:0] switch,  // output directly
    output reg [11:0] led
);

reg [1:0] r_status;
reg [15:0] r_switch;
reg [11:0] r_led;

always @(posedge clk ) begin
    if (reset) begin
        r_status <= 0;
        r_led <= 0;
        r_switch <= 0;
    end
    else begin
        // switches are set
        if (buttonR) begin
           r_status[1] <= 1;
           r_switch <= switch; 
        end

        if (buttonL) begin
            r_status[0] <= 1;
            led <= r_led;
        end

        if (pWrite & (addr == 2'b01)) begin
           r_led <= pWriteData;
           r_status[0] <= 0; 
        end
    end
end

always @(pRead) begin
    if (pRead) begin
        case (addr)
            2'b11: pReadData = {24'b0, r_switch[15:8]};
            2'b10: pReadData = {24'b0, r_switch[7:0]};
            2'b00: pReadData = {30'b0, r_status};
            default: pReadData = 32'b0;
        endcase
    end
end

endmodule
