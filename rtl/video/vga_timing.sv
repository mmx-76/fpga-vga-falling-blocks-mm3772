// vga_timing.sv
// MM3772 - EE22005 FPGA VGA Falling-Block Game
// VGA 640x480@60Hz timing generator using CLOCK_50 with 25 MHz pixel enable.

module vga_timing (
    input  logic        CLOCK_50,
    input  logic        reset_n,
    output logic [9:0]  pixel_x,
    output logic [9:0]  pixel_y,
    output logic        visible_area,
    output logic        hsync,
    output logic        vsync
);

    localparam int H_VISIBLE      = 640;
    localparam int H_FRONT_PORCH  = 16;
    localparam int H_SYNC_PULSE   = 96;
    localparam int H_BACK_PORCH   = 48;
    localparam int H_TOTAL        = H_VISIBLE + H_FRONT_PORCH + H_SYNC_PULSE + H_BACK_PORCH; // 800

    localparam int V_VISIBLE      = 480;
    localparam int V_FRONT_PORCH  = 10;
    localparam int V_SYNC_PULSE   = 2;
    localparam int V_BACK_PORCH   = 33;
    localparam int V_TOTAL        = V_VISIBLE + V_FRONT_PORCH + V_SYNC_PULSE + V_BACK_PORCH; // 525

    logic pix_en_div2;
    logic [9:0] h_count;
    logic [9:0] v_count;

    // Generate 25 MHz pixel enable from 50 MHz input clock.
    always_ff @(posedge CLOCK_50 or negedge reset_n) begin
        if (!reset_n) begin
            pix_en_div2 <= 1'b0;
        end else begin
            pix_en_div2 <= ~pix_en_div2;
        end
    end

    always_ff @(posedge CLOCK_50 or negedge reset_n) begin
        if (!reset_n) begin
            h_count <= '0;
            v_count <= '0;
        end else if (pix_en_div2) begin
            if (h_count == H_TOTAL - 1) begin
                h_count <= '0;
                if (v_count == V_TOTAL - 1) begin
                    v_count <= '0;
                end else begin
                    v_count <= v_count + 10'd1;
                end
            end else begin
                h_count <= h_count + 10'd1;
            end
        end
    end

    always_comb begin
        pixel_x = h_count;
        pixel_y = v_count;

        visible_area = (h_count < H_VISIBLE) && (v_count < V_VISIBLE);

        // VGA syncs are active low for 640x480 timing.
        hsync = ~((h_count >= (H_VISIBLE + H_FRONT_PORCH)) &&
                  (h_count <  (H_VISIBLE + H_FRONT_PORCH + H_SYNC_PULSE)));

        vsync = ~((v_count >= (V_VISIBLE + V_FRONT_PORCH)) &&
                  (v_count <  (V_VISIBLE + V_FRONT_PORCH + V_SYNC_PULSE)));
    end

endmodule
