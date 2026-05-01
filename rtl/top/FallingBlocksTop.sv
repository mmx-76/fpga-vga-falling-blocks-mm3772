// FallingBlocksTop.sv
// MM3772 - EE22005 FPGA VGA Falling-Block Game
// Top-level integration including button pulse input, stage-1 falling block controller, VGA timing, and renderer.

module FallingBlocksTop (
    input  logic       CLOCK_50,
    input  logic       reset_n,
    input  logic       KEY_LEFT_N,
    input  logic       KEY_RIGHT_N,
    input  logic       KEY_DOWN_N,
    input  logic       KEY_RESET_N,
    output logic [3:0] VGA_R,
    output logic [3:0] VGA_G,
    output logic [3:0] VGA_B,
    output logic       VGA_HS,
    output logic       VGA_VS
);

    logic [9:0] pixel_x;
    logic [9:0] pixel_y;
    logic visible_area;

    logic left_pulse;
    logic right_pulse;
    logic down_pulse;
    logic reset_pulse;

    logic [4:0] active_block_x;
    logic [4:0] active_block_y;

    player_button_inputs u_player_button_inputs (
        .clk(CLOCK_50),
        .reset_n(reset_n),
        .btn_left_n(KEY_LEFT_N),
        .btn_right_n(KEY_RIGHT_N),
        .btn_down_n(KEY_DOWN_N),
        .btn_reset_n(KEY_RESET_N),
        .left_pulse(left_pulse),
        .right_pulse(right_pulse),
        .down_pulse(down_pulse),
        .reset_pulse(reset_pulse)
    );

    falling_block_controller u_falling_block_controller (
        .clk(CLOCK_50),
        .reset_n(reset_n),
        .reset_pulse(reset_pulse),
        .left_pulse(left_pulse),
        .right_pulse(right_pulse),
        .down_pulse(down_pulse),
        .block_x(active_block_x),
        .block_y(active_block_y)
    );

    vga_timing u_vga_timing (
        .CLOCK_50(CLOCK_50),
        .reset_n(reset_n),
        .pixel_x(pixel_x),
        .pixel_y(pixel_y),
        .visible_area(visible_area),
        .hsync(VGA_HS),
        .vsync(VGA_VS)
    );

    pixel_renderer u_pixel_renderer (
        .visible_area(visible_area),
        .pixel_x(pixel_x),
        .pixel_y(pixel_y),
        .active_block_x(active_block_x),
        .active_block_y(active_block_y),
        .vga_r(VGA_R),
        .vga_g(VGA_G),
        .vga_b(VGA_B)
    );

endmodule
