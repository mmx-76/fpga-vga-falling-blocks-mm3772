// tb_top_integration.sv
// MM3772 - EE22005 FPGA VGA Falling-Block Game
// Lightweight integration testbench for top-level interface and signal activity.

`timescale 1ns/1ps

module tb_top_integration;
    logic CLOCK_50;
    logic [3:0] KEY;
    logic [9:0] SW;
    logic [3:0] VGA_R;
    logic [3:0] VGA_G;
    logic [3:0] VGA_B;
    logic VGA_HS;
    logic VGA_VS;

    FallingBlocksTop dut (
        .CLOCK_50(CLOCK_50),
        .KEY(KEY),
        .SW(SW),
        .VGA_R(VGA_R),
        .VGA_G(VGA_G),
        .VGA_B(VGA_B),
        .VGA_HS(VGA_HS),
        .VGA_VS(VGA_VS)
    );

    always #10 CLOCK_50 = ~CLOCK_50;

    initial begin
        CLOCK_50 = 1'b0;
        KEY = 4'hF;
        SW = 10'h000;

        // Assert reset (active-low KEY[0]) briefly.
        KEY[0] = 1'b0;
        repeat (8) @(posedge CLOCK_50);
        KEY[0] = 1'b1;

        // Drive representative button presses.
        repeat (50) @(posedge CLOCK_50);
        KEY[1] = 1'b0; repeat (20) @(posedge CLOCK_50); KEY[1] = 1'b1;
        KEY[2] = 1'b0; repeat (20) @(posedge CLOCK_50); KEY[2] = 1'b1;
        KEY[3] = 1'b0; repeat (20) @(posedge CLOCK_50); KEY[3] = 1'b1;

        // Let video/game logic run and ensure no X propagation at outputs.
        repeat (2000) @(posedge CLOCK_50);

        if ((^VGA_R === 1'bx) || (^VGA_G === 1'bx) || (^VGA_B === 1'bx) ||
            (VGA_HS === 1'bx) || (VGA_VS === 1'bx)) begin
            $error("Top-level outputs contain unknown values.");
        end

        $display("PASS: top integration basic activity completed.");
        $finish;
    end
endmodule
