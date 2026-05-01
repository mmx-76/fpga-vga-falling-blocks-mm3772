// player_button_inputs.sv
// MM3772 - EE22005 FPGA VGA Falling-Block Game
// Debounce + edge-detect wrapper for left/right/down/reset active-low push buttons.

module player_button_inputs #(
    parameter int unsigned CNTR_MAX = 250_000
) (
    input  logic clk,
    input  logic reset_n,
    input  logic btn_left_n,
    input  logic btn_right_n,
    input  logic btn_down_n,
    input  logic btn_reset_n,
    output logic left_pulse,
    output logic right_pulse,
    output logic down_pulse,
    output logic reset_pulse
);
    logic left_level;
    logic right_level;
    logic down_level;
    logic reset_level;

    button_debounce #(.CNTR_MAX(CNTR_MAX)) u_db_left (
        .clk(clk), .reset_n(reset_n), .btn_n_raw(btn_left_n), .btn_pressed(left_level)
    );
    button_debounce #(.CNTR_MAX(CNTR_MAX)) u_db_right (
        .clk(clk), .reset_n(reset_n), .btn_n_raw(btn_right_n), .btn_pressed(right_level)
    );
    button_debounce #(.CNTR_MAX(CNTR_MAX)) u_db_down (
        .clk(clk), .reset_n(reset_n), .btn_n_raw(btn_down_n), .btn_pressed(down_level)
    );
    button_debounce #(.CNTR_MAX(CNTR_MAX)) u_db_reset (
        .clk(clk), .reset_n(reset_n), .btn_n_raw(btn_reset_n), .btn_pressed(reset_level)
    );

    edge_detect u_ed_left (.clk(clk), .reset_n(reset_n), .level_in(left_level), .pulse_out(left_pulse));
    edge_detect u_ed_right (.clk(clk), .reset_n(reset_n), .level_in(right_level), .pulse_out(right_pulse));
    edge_detect u_ed_down (.clk(clk), .reset_n(reset_n), .level_in(down_level), .pulse_out(down_pulse));
    edge_detect u_ed_reset (.clk(clk), .reset_n(reset_n), .level_in(reset_level), .pulse_out(reset_pulse));

endmodule
