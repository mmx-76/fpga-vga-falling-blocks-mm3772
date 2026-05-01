// tb_board_memory.sv
// MM3772 - EE22005 FPGA VGA Falling-Block Game
// Questa-compatible testbench for board memory lock writes and reset clearing.
`timescale 1ns/1ps
module tb_board_memory;
logic clk, reset_n, reset_pulse, lock_write;
logic [4:0] lock_x, lock_y;
logic [16*20-1:0] board_cells;
board_memory dut(.clk(clk),.reset_n(reset_n),.reset_pulse(reset_pulse),.lock_write(lock_write),.lock_x(lock_x),.lock_y(lock_y),.board_cells(board_cells));
always #10 clk=~clk;
initial begin
 clk=0; reset_n=0; reset_pulse=0; lock_write=0; lock_x='0; lock_y='0;
 repeat(2) @(posedge clk); reset_n=1; @(posedge clk);
 assert(board_cells=='0) else $fatal("board not empty after reset");
 lock_x=5'd8; lock_y=5'd19; lock_write=1; @(posedge clk); lock_write=0;
 assert(board_cells[(19*16)+8]) else $fatal("lock write failed");
 reset_pulse=1; @(posedge clk); reset_pulse=0; @(posedge clk);
 assert(board_cells=='0) else $fatal("reset pulse clear failed");
 $display("tb_board_memory: PASS"); $finish;
end
endmodule
