// button_debounce.sv
// MM3772 - EE22005 FPGA VGA Falling-Block Game
// Synchronizing debounce filter for active-low FPGA push buttons.

module button_debounce #(
    parameter int unsigned CNTR_MAX = 250_000
) (
    input  logic clk,
    input  logic reset_n,
    input  logic btn_n_raw,
    output logic btn_pressed
);
    logic raw_sync_ff1;
    logic raw_sync_ff2;
    logic raw_level;
    logic stable_level;
    logic [$clog2(CNTR_MAX+1)-1:0] stable_count;

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            raw_sync_ff1 <= 1'b1;
            raw_sync_ff2 <= 1'b1;
        end else begin
            raw_sync_ff1 <= btn_n_raw;
            raw_sync_ff2 <= raw_sync_ff1;
        end
    end

    assign raw_level = ~raw_sync_ff2;

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            stable_level <= 1'b0;
            stable_count <= '0;
        end else if (raw_level == stable_level) begin
            stable_count <= '0;
        end else if (stable_count == CNTR_MAX[$clog2(CNTR_MAX+1)-1:0]) begin
            stable_level <= raw_level;
            stable_count <= '0;
        end else begin
            stable_count <= stable_count + 1'b1;
        end
    end

    assign btn_pressed = stable_level;

endmodule
