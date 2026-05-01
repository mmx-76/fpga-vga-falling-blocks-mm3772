// tb_falling_block_controller.sv
// MM3772 - EE22005 FPGA VGA Falling-Block Game
// Questa-compatible testbench for stage-1 falling block behaviour.

`timescale 1ns/1ps

module tb_falling_block_controller;

    logic clk;
    logic reset_n;
    logic reset_pulse;
    logic left_pulse;
    logic right_pulse;
    logic down_pulse;
    logic [4:0] block_x;
    logic [4:0] block_y;

    localparam int unsigned CLK_PERIOD_NS = 20;

    falling_block_controller #(
        .GRAVITY_DIV(4)
    ) dut (
        .clk(clk),
        .reset_n(reset_n),
        .reset_pulse(reset_pulse),
        .left_pulse(left_pulse),
        .right_pulse(right_pulse),
        .down_pulse(down_pulse),
        .block_x(block_x),
        .block_y(block_y)
    );

    always #(CLK_PERIOD_NS/2) clk = ~clk;

    task automatic pulse_left;
    begin
        left_pulse = 1'b1;
        @(posedge clk);
        left_pulse = 1'b0;
    end
    endtask

    task automatic pulse_right;
    begin
        right_pulse = 1'b1;
        @(posedge clk);
        right_pulse = 1'b0;
    end
    endtask

    task automatic pulse_down;
    begin
        down_pulse = 1'b1;
        @(posedge clk);
        down_pulse = 1'b0;
    end
    endtask

    initial begin
        clk = 1'b0;
        reset_n = 1'b0;
        reset_pulse = 1'b0;
        left_pulse = 1'b0;
        right_pulse = 1'b0;
        down_pulse = 1'b0;

        repeat (3) @(posedge clk);
        reset_n = 1'b1;
        @(posedge clk);

        assert (block_x == 5'd8 && block_y == 5'd0) else $fatal("Reset start position failed");

        repeat (5) @(posedge clk);
        assert (block_y >= 5'd1) else $fatal("Gravity movement failed");

        pulse_left();
        assert (block_x == 5'd7) else $fatal("Left movement failed");

        pulse_right();
        assert (block_x == 5'd8) else $fatal("Right movement failed");

        pulse_down();
        assert (block_y >= 5'd2) else $fatal("Down movement failed");

        repeat (20) pulse_left();
        assert (block_x == 5'd0) else $fatal("Left boundary clamp failed");

        repeat (40) pulse_right();
        assert (block_x == 5'd15) else $fatal("Right boundary clamp failed");

        // Force to bottom then one more move to trigger respawn.
        while (block_y != 5'd19) pulse_down();
        pulse_down();
        assert (block_x == 5'd8 && block_y == 5'd0) else $fatal("Bottom respawn failed");

        $display("tb_falling_block_controller: PASS");
        $finish;
    end

endmodule
