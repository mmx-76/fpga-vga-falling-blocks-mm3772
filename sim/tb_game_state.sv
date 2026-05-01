// tb_game_state.sv
// MM3772 - EE22005 FPGA VGA Falling-Block Game
// Questa-compatible testbench for score increment and spawn-blocked game-over behaviour.

`timescale 1ns/1ps
module tb_game_state;
    logic clk, reset_n, reset_pulse, left_pulse, right_pulse, down_pulse;
    logic [4:0] block_x, block_y;
    logic [79:0] board_flat;
    logic [15:0] score;
    logic [1:0] game_state;

    falling_block_controller #(.GRID_COLS(8), .GRID_ROWS(10), .START_X(4), .GRAVITY_DIV(1000)) dut (
        .clk(clk), .reset_n(reset_n), .reset_pulse(reset_pulse), .left_pulse(left_pulse), .right_pulse(right_pulse), .down_pulse(down_pulse),
        .block_x(block_x), .block_y(block_y), .board_flat(board_flat), .score(score), .game_state(game_state)
    );
    always #10 clk = ~clk;
    task pulse_down; begin down_pulse = 1; @(posedge clk); down_pulse = 0; end endtask

    initial begin
        clk=0; reset_n=0; reset_pulse=0; left_pulse=0; right_pulse=0; down_pulse=0;
        repeat(2) @(posedge clk); reset_n=1; repeat(2) @(posedge clk);
        assert(game_state==2'd1) else $fatal("not running");

        // Fill bottom row except spawn column, then drop to complete row => score increments
        force dut.board_flat[7:0] = 8'b1110_1111;
        repeat(9) pulse_down();
        release dut.board_flat;
        @(posedge clk);
        assert(score>=1) else $fatal("score did not increment");

        // Block spawn cell, then lock another block to trigger game-over
        force dut.board_flat[4] = 1'b1;
        repeat(9) pulse_down();
        release dut.board_flat;
        @(posedge clk);
        assert(game_state==2'd2) else $fatal("game over not detected");

        $display("tb_game_state: PASS");
        $finish;
    end
endmodule
