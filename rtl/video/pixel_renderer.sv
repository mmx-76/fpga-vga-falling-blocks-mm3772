// pixel_renderer.sv
// MM3772 - EE22005 FPGA VGA Falling-Block Game
// VGA renderer for board cells, active block, and simple score/game-state indicators.

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

    logic in_playfield, on_border, grid_line, on_active_block, on_locked_block, on_score, on_gameover;
    logic [4:0] grid_x, grid_y;

    always_comb begin
        in_playfield = (pixel_x >= X_MIN) && (pixel_x <= X_MAX) && (pixel_y >= Y_MIN) && (pixel_y <= Y_MAX);
        on_border = in_playfield && ((pixel_x < (X_MIN + BORDER)) || (pixel_x > (X_MAX - BORDER)) || (pixel_y < (Y_MIN + BORDER)) || (pixel_y > (Y_MAX - BORDER)));
        grid_line = in_playfield && (((pixel_x - X_MIN) % CELL_SIZE == 0) || ((pixel_y - Y_MIN) % CELL_SIZE == 0));

        grid_x = (pixel_x - X_MIN) / CELL_SIZE;
        grid_y = (pixel_y - Y_MIN) / CELL_SIZE;

        on_active_block = in_playfield && (grid_x == active_block_x) && (grid_y == active_block_y);
        on_locked_block = in_playfield && board_flat[grid_y*GRID_COLS + grid_x];

        on_score = (pixel_y >= 10) && (pixel_y < 22) && (pixel_x >= 160) && (pixel_x < (160 + {6'd0, score[7:0]}));
        on_gameover = (game_state == 2'd2) && (pixel_x >= 200) && (pixel_x < 440) && (pixel_y >= 220) && (pixel_y < 260);

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
                vga_r = 4'h0; vga_g = 4'hB; vga_b = 4'hF;
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
