// tb_vga_timing.sv
// MM3772 - EE22005 FPGA VGA Falling-Block Game
// Questa-compatible testbench for VGA timing generator.

`timescale 1ns/1ps

module tb_vga_timing;

    logic CLOCK_50;
    logic reset_n;
    logic [9:0] pixel_x;
    logic [9:0] pixel_y;
    logic visible_area;
    logic hsync;
    logic vsync;

    vga_timing dut (
        .CLOCK_50(CLOCK_50),
        .reset_n(reset_n),
        .pixel_x(pixel_x),
        .pixel_y(pixel_y),
        .visible_area(visible_area),
        .hsync(hsync),
        .vsync(vsync)
    );

    localparam int H_VISIBLE      = 640;
    localparam int H_FRONT_PORCH  = 16;
    localparam int H_SYNC_PULSE   = 96;
    localparam int H_TOTAL        = 800;

    localparam int V_VISIBLE      = 480;
    localparam int V_FRONT_PORCH  = 10;
    localparam int V_SYNC_PULSE   = 2;
    localparam int V_TOTAL        = 525;

    always #10 CLOCK_50 = ~CLOCK_50; // 50 MHz

    task automatic wait_pixel_ticks(input int unsigned ticks);
        int unsigned i;
        begin
            for (i = 0; i < ticks; i++) begin
                // Counter update occurs on every other CLOCK_50 rising edge.
                @(posedge CLOCK_50);
                @(posedge CLOCK_50);
            end
        end
    endtask

    initial begin
        CLOCK_50 = 1'b0;
        reset_n = 1'b0;

        repeat (4) @(posedge CLOCK_50);
        reset_n = 1'b1;

        // Allow first active update edge.
        @(posedge CLOCK_50);
        @(posedge CLOCK_50);

        // Check initial visible region.
        if (pixel_x >= H_VISIBLE || pixel_y >= V_VISIBLE || !visible_area) begin
            $error("Visible area should be active at frame start. x=%0d y=%0d vis=%0b", pixel_x, pixel_y, visible_area);
        end

        // Move into horizontal sync pulse start: x = 656.
        wait_pixel_ticks(H_VISIBLE + H_FRONT_PORCH - pixel_x);
        if (hsync !== 1'b0) begin
            $error("HSYNC should be active-low at pulse start. x=%0d", pixel_x);
        end

        // Move to end of HSYNC pulse.
        wait_pixel_ticks(H_SYNC_PULSE);
        if (hsync !== 1'b1) begin
            $error("HSYNC should return high after pulse. x=%0d", pixel_x);
        end

        // Advance to start of VSYNC line (y=490) at x=0.
        wait_pixel_ticks((V_VISIBLE + V_FRONT_PORCH - pixel_y) * H_TOTAL + (H_TOTAL - pixel_x));
        if (pixel_x != 0 || pixel_y != (V_VISIBLE + V_FRONT_PORCH)) begin
            $error("Did not reach expected VSYNC start line. x=%0d y=%0d", pixel_x, pixel_y);
        end
        if (vsync !== 1'b0) begin
            $error("VSYNC should be active-low at pulse start. y=%0d", pixel_y);
        end

        // Hold through two VSYNC pulse lines then verify deassertion.
        wait_pixel_ticks(V_SYNC_PULSE * H_TOTAL);
        if (vsync !== 1'b1) begin
            $error("VSYNC should return high after pulse. y=%0d", pixel_y);
        end

        // Advance to next frame origin.
        wait_pixel_ticks((V_TOTAL - pixel_y) * H_TOTAL - pixel_x);
        if (pixel_x != 0 || pixel_y != 0) begin
            $error("Frame did not wrap correctly. x=%0d y=%0d", pixel_x, pixel_y);
        end

        $display("tb_vga_timing: PASS");
        $finish;
    end

endmodule
