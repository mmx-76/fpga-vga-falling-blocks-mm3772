// FallingBlocksTop.sv
// MM3772 - EE22005 FPGA VGA Falling-Block Game
// Static VGA top-level integration: timing + pixel renderer only.

module FallingBlocksTop (
    input  logic       CLOCK_50,
    input  logic       reset_n,
    output logic [3:0] VGA_R,
    output logic [3:0] VGA_G,
    output logic [3:0] VGA_B,
    output logic       VGA_HS,
    output logic       VGA_VS
);

    logic [9:0] pixel_x;
    logic [9:0] pixel_y;
    logic visible_area;

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
        .vga_r(VGA_R),
        .vga_g(VGA_G),
        .vga_b(VGA_B)
    );

endmodule
