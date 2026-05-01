// tb_button_inputs.sv
// MM3772 - EE22005 FPGA VGA Falling-Block Game
// Questa-compatible testbench for button debounce and one-cycle edge pulse generation.

`timescale 1ns/1ps

module tb_button_inputs;
    localparam int unsigned CNTR_MAX_TB = 3;

    logic clk;
    logic reset_n;
    logic btn_left_n;
    logic btn_right_n;
    logic btn_down_n;
    logic btn_reset_n;
    logic left_pulse;
    logic right_pulse;
    logic down_pulse;
    logic reset_pulse;

    player_button_inputs #(.CNTR_MAX(CNTR_MAX_TB)) dut (
        .clk(clk),
        .reset_n(reset_n),
        .btn_left_n(btn_left_n),
        .btn_right_n(btn_right_n),
        .btn_down_n(btn_down_n),
        .btn_reset_n(btn_reset_n),
        .left_pulse(left_pulse),
        .right_pulse(right_pulse),
        .down_pulse(down_pulse),
        .reset_pulse(reset_pulse)
    );

    always #5 clk = ~clk;

    task automatic tick(input int n);
        repeat (n) @(posedge clk);
    endtask

    task automatic press_with_bounce(ref logic btn_n_sig);
        begin
            btn_n_sig = 1'b0;
            tick(1);
            btn_n_sig = 1'b1;
            tick(1);
            btn_n_sig = 1'b0;
            tick(1);
            btn_n_sig = 1'b1;
            tick(1);
            btn_n_sig = 1'b0;
            tick(CNTR_MAX_TB + 3);
        end
    endtask

    task automatic release_clean(ref logic btn_n_sig);
        begin
            btn_n_sig = 1'b1;
            tick(CNTR_MAX_TB + 3);
        end
    endtask

    initial begin
        clk = 1'b0;
        reset_n = 1'b0;
        btn_left_n = 1'b1;
        btn_right_n = 1'b1;
        btn_down_n = 1'b1;
        btn_reset_n = 1'b1;

        tick(2);
        reset_n = 1'b1;
        tick(2);

        press_with_bounce(btn_left_n);
        if (left_pulse !== 1'b1) $error("Left pulse was not asserted after debounced press");
        tick(1);
        if (left_pulse !== 1'b0) $error("Left pulse was not one cycle wide");
        release_clean(btn_left_n);

        press_with_bounce(btn_right_n);
        if (right_pulse !== 1'b1) $error("Right pulse was not asserted after debounced press");
        tick(1);
        if (right_pulse !== 1'b0) $error("Right pulse was not one cycle wide");
        release_clean(btn_right_n);

        press_with_bounce(btn_down_n);
        if (down_pulse !== 1'b1) $error("Down pulse was not asserted after debounced press");
        tick(1);
        if (down_pulse !== 1'b0) $error("Down pulse was not one cycle wide");
        release_clean(btn_down_n);

        press_with_bounce(btn_reset_n);
        if (reset_pulse !== 1'b1) $error("Reset pulse was not asserted after debounced press");
        tick(1);
        if (reset_pulse !== 1'b0) $error("Reset pulse was not one cycle wide");
        release_clean(btn_reset_n);

        $display("tb_button_inputs: PASS - raw button activity converted to debounced one-cycle pulses");
        $finish;
    end
endmodule
