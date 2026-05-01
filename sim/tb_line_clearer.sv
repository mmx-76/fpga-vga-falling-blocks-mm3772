// tb_line_clearer.sv
// MM3772 - EE22005 FPGA VGA Falling-Block Game
// Questa-compatible testbench for row detect, clear, and shift-down behaviour.

`timescale 1ns/1ps
module tb_line_clearer;
    localparam int C = 4;
    localparam int R = 4;
    logic [R*C-1:0] board_in, board_out;
    logic [4:0] rows_cleared;

    line_clearer #(.GRID_COLS(C), .GRID_ROWS(R)) dut (.board_in(board_in), .board_out(board_out), .rows_cleared(rows_cleared));

    initial begin
        board_in = '0;
        board_in[0 +: C] = 4'b1111; // full row detect
        #1;
        assert(rows_cleared == 1) else $fatal("full row detect failed");
        assert(board_out[0 +: C] == 4'b0000) else $fatal("row clear failed");

        board_in = '0;
        board_in[8 +: C] = 4'b1010; // above row
        board_in[4 +: C] = 4'b1111; // full row below it
        #1;
        assert(rows_cleared == 1) else $fatal("second clear detect failed");
        assert(board_out[4 +: C] == 4'b1010) else $fatal("shift down failed");

        $display("tb_line_clearer: PASS");
        $finish;
    end
endmodule
