// tb_pixel_renderer.sv
// MM3772 - EE22005 FPGA VGA Falling-Block Game
// Questa-compatible combinational testbench for static pixel renderer.

`timescale 1ns/1ps

module tb_pixel_renderer;
    logic       visible_area;
    logic [9:0] pixel_x;
    logic [9:0] pixel_y;
    logic [4:0] active_block_x;
    logic [4:0] active_block_y;
    logic [3:0] vga_r;
    logic [3:0] vga_g;
    logic [3:0] vga_b;

    pixel_renderer dut (
        .visible_area(visible_area),
        .pixel_x(pixel_x),
        .pixel_y(pixel_y),
        .active_block_x(active_block_x),
        .active_block_y(active_block_y),
        .vga_r(vga_r),
        .vga_g(vga_g),
        .vga_b(vga_b)
    );

    task automatic check_color(
        input logic [9:0] x,
        input logic [9:0] y,
        input logic       vis,
        input logic [3:0] exp_r,
        input logic [3:0] exp_g,
        input logic [3:0] exp_b,
        input string      label
    );
    begin
        pixel_x = x;
        pixel_y = y;
        visible_area = vis;
        #1;
        if ({vga_r, vga_g, vga_b} !== {exp_r, exp_g, exp_b}) begin
            $error("%s mismatch at x=%0d y=%0d vis=%0b : got %h%h%h expected %h%h%h",
                   label, x, y, vis, vga_r, vga_g, vga_b, exp_r, exp_g, exp_b);
        end
    end
    endtask

    initial begin
        active_block_x = 5'd8;
        active_block_y = 5'd0;
        check_color(10'd0,   10'd0,   1'b0, 4'h0, 4'h0, 4'h0, "Blanking");
        check_color(10'd160, 10'd40,  1'b1, 4'hF, 4'hF, 4'h0, "Border");
        check_color(10'd180, 10'd60,  1'b1, 4'h2, 4'h2, 4'h6, "Grid line");
        check_color(10'd181, 10'd61,  1'b1, 4'h0, 4'h6, 4'h3, "Playfield fill");
        check_color(10'd24,  10'd26,  1'b1, 4'hF, 4'h0, 4'hF, "MM3772 marker");
        check_color(10'd80,  10'd20,  1'b1, 4'h0, 4'h0, 4'h2, "Background outside field");

        $display("tb_pixel_renderer: PASS");
        $finish;
    end
endmodule
