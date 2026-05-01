// pixel_renderer.sv
// MM3772 - EE22005 FPGA VGA Falling-Block Game
// VGA renderer for board cells, active block, and simple score/game-state indicators.
// VGA pixel renderer: border, background grid, MM3772 marker, active falling block, and locked board cells.

module pixel_renderer #(
    parameter int unsigned GRID_COLS = 16,
    parameter int unsigned GRID_ROWS = 20
) (
    input  logic       visible_area,
    input  logic [9:0] pixel_x,
    input  logic [9:0] pixel_y,
    input  logic [4:0] active_block_x,
    input  logic [4:0] active_block_y,
    input  logic [GRID_ROWS*GRID_COLS-1:0] board_flat,
    input  logic [15:0] score,
    input  logic [1:0] game_state,
    input  logic [GRID_COLS*GRID_ROWS-1:0] board_cells,
    output logic [3:0] vga_r,
    output logic [3:0] vga_g,
    output logic [3:0] vga_b
);
    localparam int X_MIN = 160;
    localparam int X_MAX = 479;
    localparam int Y_MIN = 40;
    localparam int Y_MAX = 439;
    localparam int BORDER = 4;
    localparam int CELL_SIZE = 20;
    localparam int MARKER_X0 = 24;
    localparam int MARKER_Y0 = 24;

    logic in_playfield, on_border, grid_line, on_active_block, on_locked_block, on_score, on_gameover;
    logic [4:0] cell_x, cell_y;
    logic in_marker, marker_on;
    logic [9:0] mx, my;

    always_comb begin
        cell_x = '0;
        cell_y = '0;
        in_playfield = (pixel_x >= X_MIN) && (pixel_x <= X_MAX) && (pixel_y >= Y_MIN) && (pixel_y <= Y_MAX);
        on_border = in_playfield && ((pixel_x < (X_MIN + BORDER)) || (pixel_x > (X_MAX - BORDER)) || (pixel_y < (Y_MIN + BORDER)) || (pixel_y > (Y_MAX - BORDER)));
        grid_line = in_playfield && (((pixel_x - X_MIN) % CELL_SIZE == 0) || ((pixel_y - Y_MIN) % CELL_SIZE == 0));

        on_active_block = in_playfield &&
                          (pixel_x >= (X_MIN + (active_block_x * CELL_SIZE))) &&
                          (pixel_x <  (X_MIN + ((active_block_x + 1) * CELL_SIZE))) &&
                          (pixel_y >= (Y_MIN + (active_block_y * CELL_SIZE))) &&
                          (pixel_y <  (Y_MIN + ((active_block_y + 1) * CELL_SIZE)));

        on_locked_block = 1'b0;
        if (in_playfield) begin
            cell_x = (pixel_x - X_MIN) / CELL_SIZE;
            cell_y = (pixel_y - Y_MIN) / CELL_SIZE;
            if ((cell_x < GRID_COLS) && (cell_y < GRID_ROWS)) begin
                on_locked_block = board_flat[(cell_y*GRID_COLS)+cell_x] | board_cells[(cell_y*GRID_COLS)+cell_x];
            end
        end

        on_score = (pixel_y >= 10) && (pixel_y < 22) && (pixel_x >= 160) && (pixel_x < (10'd160 + {2'b00, score[7:0]}));
        on_gameover = (game_state == 2'd2) && (pixel_x >= 200) && (pixel_x < 440) && (pixel_y >= 220) && (pixel_y < 260);

        in_marker = (pixel_x >= MARKER_X0) && (pixel_x < (MARKER_X0 + 96)) &&
                    (pixel_y >= MARKER_Y0) && (pixel_y < (MARKER_Y0 + 16));
        mx = pixel_x - MARKER_X0;
        my = pixel_y - MARKER_Y0;

        marker_on = 1'b0;
        if (in_marker && (my >= 2) && (my <= 13)) begin
            if (((mx >= 0) && (mx <= 2)) || ((mx >= 9) && (mx <= 11)) || (((mx == 4) || (mx == 7)) && (my <= 6)) || (((mx == 5) || (mx == 6)) && (my <= 5))) marker_on = 1'b1;
            if (((mx >= 16) && (mx <= 18)) || ((mx >= 25) && (mx <= 27)) || (((mx == 20) || (mx == 23)) && (my <= 6)) || (((mx == 21) || (mx == 22)) && (my <= 5))) marker_on = 1'b1;
            if ((((mx >= 32) && (mx <= 43)) && ((my <= 3) || (my >= 11) || ((my >= 6) && (my <= 8)))) || (((mx >= 41) && (mx <= 43)) && (my >= 2) && (my <= 13))) marker_on = 1'b1;
            if ((((mx >= 48) && (mx <= 59)) && (my <= 3)) || (((mx >= 56) && (mx <= 58)) && (my >= 4) && (my <= 13)) || (((mx == 55) || (mx == 54)) && (my >= 8) && (my <= 13))) marker_on = 1'b1;
            if ((((mx >= 64) && (mx <= 75)) && (my <= 3)) || (((mx >= 72) && (mx <= 74)) && (my >= 4) && (my <= 13)) || (((mx == 71) || (mx == 70)) && (my >= 8) && (my <= 13))) marker_on = 1'b1;
            if ((((mx >= 80) && (mx <= 91)) && ((my <= 3) || (my >= 11) || ((my >= 6) && (my <= 8)))) || (((mx >= 89) && (mx <= 91)) && (my >= 2) && (my <= 6)) || (((mx >= 80) && (mx <= 82)) && (my >= 8) && (my <= 13))) marker_on = 1'b1;
        end

        vga_r = 4'h0; vga_g = 4'h0; vga_b = 4'h0;
        if (visible_area) begin
            if (on_gameover) begin
                vga_r = 4'hF; vga_g = 4'h0; vga_b = 4'h0;
            end else if (on_score) begin
                vga_r = 4'hF; vga_g = 4'hF; vga_b = 4'hF;
            end else if (on_border) begin
                vga_r = 4'hF; vga_g = 4'hF; vga_b = 4'h0;
            end else if (on_active_block) begin
                vga_r = 4'hF; vga_g = 4'h4; vga_b = 4'h0;
            end else if (on_locked_block) begin
                vga_r = 4'h0; vga_g = 4'hE; vga_b = 4'hF;
            end else if (marker_on) begin
                vga_r = 4'hF; vga_g = 4'h0; vga_b = 4'hF;
            end else if (grid_line) begin
                vga_r = 4'h2; vga_g = 4'h2; vga_b = 4'h6;
            end else if (in_playfield) begin
                vga_r = 4'h0; vga_g = 4'h6; vga_b = 4'h3;
            end else begin
                vga_r = 4'h0; vga_g = 4'h0; vga_b = 4'h2;
            end
        end
    end
endmodule
