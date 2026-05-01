// pixel_renderer.sv
// MM3772 - EE22005 FPGA VGA Falling-Block Game
// Static VGA pixel renderer: border, background grid, and MM3772 marker.

module pixel_renderer (
    input  logic       visible_area,
    input  logic [9:0] pixel_x,
    input  logic [9:0] pixel_y,
    output logic [3:0] vga_r,
    output logic [3:0] vga_g,
    output logic [3:0] vga_b
);

    localparam int X_MIN = 160;
    localparam int X_MAX = 479;
    localparam int Y_MIN = 40;
    localparam int Y_MAX = 439;
    localparam int BORDER = 4;

    localparam int MARKER_X0 = 24;
    localparam int MARKER_Y0 = 24;

    logic in_playfield;
    logic on_border;
    logic grid_line;

    logic in_marker;
    logic [9:0] mx;
    logic [9:0] my;
    logic marker_on;

    always_comb begin
        in_playfield = (pixel_x >= X_MIN) && (pixel_x <= X_MAX) &&
                       (pixel_y >= Y_MIN) && (pixel_y <= Y_MAX);

        on_border = in_playfield && (
            (pixel_x < (X_MIN + BORDER)) ||
            (pixel_x > (X_MAX - BORDER)) ||
            (pixel_y < (Y_MIN + BORDER)) ||
            (pixel_y > (Y_MAX - BORDER))
        );

        grid_line = in_playfield &&
                    (((pixel_x - X_MIN) % 20 == 0) || ((pixel_y - Y_MIN) % 20 == 0));

        in_marker = (pixel_x >= MARKER_X0) && (pixel_x < (MARKER_X0 + 96)) &&
                    (pixel_y >= MARKER_Y0) && (pixel_y < (MARKER_Y0 + 16));
        mx = pixel_x - MARKER_X0;
        my = pixel_y - MARKER_Y0;

        marker_on = 1'b0;
        if (in_marker && (my >= 2) && (my <= 13)) begin
            // MM3772 bitmap-like strokes in 6 glyph cells (each 16 pixels wide).
            // M
            if (((mx >= 0) && (mx <= 2)) || ((mx >= 9) && (mx <= 11)) ||
                (((mx == 4) || (mx == 7)) && (my <= 6)) ||
                (((mx == 5) || (mx == 6)) && (my <= 5))) marker_on = 1'b1;

            // M
            if (((mx >= 16) && (mx <= 18)) || ((mx >= 25) && (mx <= 27)) ||
                (((mx == 20) || (mx == 23)) && (my <= 6)) ||
                (((mx == 21) || (mx == 22)) && (my <= 5))) marker_on = 1'b1;

            // 3
            if ((((mx >= 32) && (mx <= 43)) && ((my <= 3) || (my >= 11) || ((my >= 6) && (my <= 8)))) ||
                (((mx >= 41) && (mx <= 43)) && (my >= 2) && (my <= 13))) marker_on = 1'b1;

            // 7
            if ((((mx >= 48) && (mx <= 59)) && (my <= 3)) ||
                (((mx >= 56) && (mx <= 58)) && (my >= 4) && (my <= 13)) ||
                (((mx == 55) || (mx == 54)) && (my >= 8) && (my <= 13))) marker_on = 1'b1;

            // 7
            if ((((mx >= 64) && (mx <= 75)) && (my <= 3)) ||
                (((mx >= 72) && (mx <= 74)) && (my >= 4) && (my <= 13)) ||
                (((mx == 71) || (mx == 70)) && (my >= 8) && (my <= 13))) marker_on = 1'b1;

            // 2
            if ((((mx >= 80) && (mx <= 91)) && ((my <= 3) || (my >= 11) || ((my >= 6) && (my <= 8)))) ||
                (((mx >= 89) && (mx <= 91)) && (my >= 2) && (my <= 6)) ||
                (((mx >= 80) && (mx <= 82)) && (my >= 8) && (my <= 13))) marker_on = 1'b1;
        end

        vga_r = 4'h0;
        vga_g = 4'h0;
        vga_b = 4'h0;

        if (visible_area) begin
            if (on_border) begin
                vga_r = 4'hF;
                vga_g = 4'hF;
                vga_b = 4'h0;
            end else if (marker_on) begin
                vga_r = 4'hF;
                vga_g = 4'h0;
                vga_b = 4'hF;
            end else if (grid_line) begin
                vga_r = 4'h2;
                vga_g = 4'h2;
                vga_b = 4'h6;
            end else if (in_playfield) begin
                vga_r = 4'h0;
                vga_g = 4'h6;
                vga_b = 4'h3;
            end else begin
                vga_r = 4'h0;
                vga_g = 4'h0;
                vga_b = 4'h2;
            end
        end
    end

endmodule
