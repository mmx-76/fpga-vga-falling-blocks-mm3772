// tb_falling_block_controller.sv
// MM3772 - EE22005 FPGA VGA Falling-Block Game
// Questa-compatible testbench for active falling, bottom locking, respawn, and occupied-cell collision.
`timescale 1ns/1ps
module tb_falling_block_controller;
logic clk, reset_n, reset_pulse, left_pulse, right_pulse, down_pulse;
logic [4:0] block_x, block_y;
logic can_move_down, lock_pulse;
logic [16*20-1:0] board_cells;
localparam int unsigned CLK_PERIOD_NS = 20;

collision_checker u_collision(.block_x(block_x),.block_y(block_y),.board_cells(board_cells),.can_move_down(can_move_down));
falling_block_controller #(.GRAVITY_DIV(4)) dut(
 .clk(clk),.reset_n(reset_n),.reset_pulse(reset_pulse),.left_pulse(left_pulse),.right_pulse(right_pulse),.down_pulse(down_pulse),
 .can_move_down(can_move_down),.lock_pulse(lock_pulse),.block_x(block_x),.block_y(block_y));

always #(CLK_PERIOD_NS/2) clk=~clk;
task automatic pulse_down; begin down_pulse=1; @(posedge clk); down_pulse=0; end endtask

initial begin
 clk=0; reset_n=0; reset_pulse=0; left_pulse=0; right_pulse=0; down_pulse=0; board_cells='0;
 repeat(3) @(posedge clk); reset_n=1; @(posedge clk);
 assert(block_x==8 && block_y==0) else $fatal("spawn after reset failed");
 repeat(5) @(posedge clk); assert(block_y>=1) else $fatal("2) active block falling failed");
 while (block_y!=19) pulse_down();
 pulse_down();
 assert(lock_pulse==1'b1) else $fatal("3) bottom lock pulse failed");
 @(posedge clk);
 assert(block_x==8 && block_y==0) else $fatal("4) respawn failed");
 board_cells='0;
 repeat(3) pulse_down(); // now at y=3
 board_cells[(4*16)+8]=1'b1; // occupied directly below
 pulse_down();
 assert(lock_pulse==1'b1) else $fatal("5) occupied-cell collision lock failed");
 $display("tb_falling_block_controller: PASS"); $finish;
end
endmodule
