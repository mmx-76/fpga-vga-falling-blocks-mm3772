// tb_pixel_renderer.sv
// MM3772 - EE22005 FPGA VGA Falling-Block Game
// Questa-compatible combinational testbench for pixel renderer with score and state overlays.

`timescale 1ns/1ps
module tb_pixel_renderer;
    logic visible_area; logic [9:0] pixel_x, pixel_y; logic [4:0] active_block_x, active_block_y;
    logic [16*20-1:0] board_flat; logic [15:0] score; logic [1:0] game_state; logic [3:0] vga_r, vga_g, vga_b;

    pixel_renderer dut (.visible_area(visible_area), .pixel_x(pixel_x), .pixel_y(pixel_y), .active_block_x(active_block_x), .active_block_y(active_block_y),
        .board_flat(board_flat), .score(score), .game_state(game_state), .vga_r(vga_r), .vga_g(vga_g), .vga_b(vga_b));

    initial begin
        visible_area=1; active_block_x=8; active_block_y=0; board_flat='0; score=16'd20; game_state=2'd1;
        pixel_x=160; pixel_y=12; #1; assert({vga_r,vga_g,vga_b}==12'hFFF) else $fatal("score indicator failed");
        pixel_x=320; pixel_y=50; #1; assert({vga_r,vga_g,vga_b}==12'h222 || {vga_r,vga_g,vga_b}==12'h063) else $fatal("playfield failed");
        game_state=2'd2; pixel_x=300; pixel_y=240; #1; assert({vga_r,vga_g,vga_b}==12'hF00) else $fatal("gameover overlay failed");
        $display("tb_pixel_renderer: PASS");
        $finish;
    end
// Questa-compatible combinational testbench for active and locked-cell renderer paths.
`timescale 1ns/1ps
module tb_pixel_renderer;
logic visible_area; logic [9:0] pixel_x,pixel_y; logic [4:0] active_block_x,active_block_y; logic [16*20-1:0] board_cells; logic [3:0] vga_r,vga_g,vga_b;
pixel_renderer dut(.visible_area(visible_area),.pixel_x(pixel_x),.pixel_y(pixel_y),.active_block_x(active_block_x),.active_block_y(active_block_y),.board_cells(board_cells),.vga_r(vga_r),.vga_g(vga_g),.vga_b(vga_b));

task automatic check(input [9:0]x,input [9:0]y,input logic [11:0]exp,input string lbl); begin pixel_x=x; pixel_y=y; visible_area=1; #1; if({vga_r,vga_g,vga_b}!==exp) $fatal("%s failed",lbl); end endtask
initial begin
 active_block_x=8; active_block_y=0; board_cells='0; visible_area=0; #1;
 check(10'd321,10'd41,12'hF40,"active block");
 board_cells[(5*16)+4]=1'b1;
 check(10'd241,10'd141,12'h0EF,"6) renderer locked board cell info");
 $display("tb_pixel_renderer: PASS"); $finish;
end
endmodule
