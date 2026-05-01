// edge_detect.sv
// MM3772 - EE22005 FPGA VGA Falling-Block Game
// Rising-edge detector that creates a one-clock pulse per valid button press.

module edge_detect (
    input  logic clk,
    input  logic reset_n,
    input  logic level_in,
    output logic pulse_out
);
    logic level_d;

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            level_d <= 1'b0;
        end else begin
            level_d <= level_in;
        end
    end

    assign pulse_out = level_in & ~level_d;

endmodule
