// tb_collision_checker.sv
// MM3772 - EE22005 FPGA VGA Falling-Block Game
// Questa-compatible testbench for down-collision checking against bottom and occupied cells.
`timescale 1ns/1ps
module tb_collision_checker;
logic [4:0] block_x, block_y;
logic [16*20-1:0] board_cells;
logic can_move_down;
collision_checker dut(.block_x(block_x),.block_y(block_y),.board_cells(board_cells),.can_move_down(can_move_down));
initial begin
 board_cells='0; block_x=5'd8; block_y=5'd0; #1;
 assert(can_move_down) else $fatal("empty board movement failed");
 block_y=5'd19; #1; assert(!can_move_down) else $fatal("bottom collision failed");
 block_y=5'd5; board_cells[(6*16)+8]=1'b1; #1;
 assert(!can_move_down) else $fatal("occupied-cell collision failed");
 $display("tb_collision_checker: PASS"); $finish;
end
endmodule
