// falling_block_controller.sv
// MM3772 - EE22005 FPGA VGA Falling-Block Game
// Falling-block controller with settled-board memory, line clear/score, and basic game-state handling.

module falling_block_controller #(
    parameter int unsigned GRID_COLS = 16,
    parameter int unsigned GRID_ROWS = 20,
    parameter int unsigned START_X   = 8,
    parameter int unsigned START_Y   = 0,
    parameter int unsigned GRAVITY_DIV = 2_500_000
) (
    input  logic clk,
    input  logic reset_n,
    input  logic reset_pulse,
    input  logic left_pulse,
    input  logic right_pulse,
    input  logic down_pulse,
    input  logic can_move_down,
    output logic lock_pulse,
    output logic [4:0] block_x,
    output logic [4:0] block_y,
    output logic [GRID_ROWS*GRID_COLS-1:0] board_flat,
    output logic [15:0] score,
    output logic [1:0]  game_state
);
    localparam logic [1:0] STATE_START    = 2'd0;
    localparam logic [1:0] STATE_RUNNING  = 2'd1;
    localparam logic [1:0] STATE_GAMEOVER = 2'd2;

    logic [$clog2(GRAVITY_DIV)-1:0] gravity_count;
    logic gravity_tick;

    function automatic logic cell_occupied(input logic [GRID_ROWS*GRID_COLS-1:0] b, input int x, input int y);
        cell_occupied = b[y*GRID_COLS + x];
    endfunction

    task automatic clear_rows(
        input  logic [GRID_ROWS*GRID_COLS-1:0] src,
        output logic [GRID_ROWS*GRID_COLS-1:0] dst,
        output logic [4:0] cleared
    );
        int src_row;
        int dst_row;
        int col;
        logic row_full;
        begin
            dst = '0;
            cleared = '0;
            dst_row = GRID_ROWS - 1;
            for (src_row = GRID_ROWS - 1; src_row >= 0; src_row--) begin
                row_full = 1'b1;
                for (col = 0; col < GRID_COLS; col++) begin
                    if (!src[src_row*GRID_COLS + col]) row_full = 1'b0;
                end
                if (row_full) begin
                    cleared = cleared + 5'd1;
                end else begin
                    for (col = 0; col < GRID_COLS; col++) begin
                        dst[dst_row*GRID_COLS + col] = src[src_row*GRID_COLS + col];
                    end
                    dst_row = dst_row - 1;
                end
            end
        end
    endtask

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            gravity_count <= '0;
            gravity_tick <= 1'b0;
        end else if (reset_pulse || (game_state != STATE_RUNNING)) begin
            gravity_count <= '0;
            gravity_tick <= 1'b0;
        end else if (gravity_count == (GRAVITY_DIV - 1)) begin
            gravity_count <= '0;
            gravity_tick <= 1'b1;
        end else begin
            gravity_count <= gravity_count + 1'b1;
            gravity_tick <= 1'b0;
        end
    end

    always_ff @(posedge clk or negedge reset_n) begin
        logic [4:0] next_x;
        logic [4:0] next_y;
        logic drop_req;
        logic blocked_below;
        logic spawn_blocked;
        logic [GRID_ROWS*GRID_COLS-1:0] board_after_lock;
        logic [GRID_ROWS*GRID_COLS-1:0] board_after_clear;
        logic [4:0] rows_cleared;

        if (!reset_n) begin
            block_x <= START_X[4:0];
            block_y <= START_Y[4:0];
            board_flat <= '0;
            score <= '0;
            game_state <= STATE_START;
        end else if (reset_pulse) begin
            block_x <= START_X[4:0];
            block_y <= START_Y[4:0];
            board_flat <= '0;
            score <= '0;
            game_state <= STATE_START;
        end else begin
            case (game_state)
                STATE_START: begin
                    game_state <= STATE_RUNNING;
                    block_x <= START_X[4:0];
                    block_y <= START_Y[4:0];
                end
                STATE_RUNNING: begin
                    next_x = block_x;
                    next_y = block_y;

                    if (left_pulse && (next_x > 0) && !cell_occupied(board_flat, next_x - 1, next_y)) next_x = next_x - 5'd1;
                    if (right_pulse && (next_x < (GRID_COLS - 1)) && !cell_occupied(board_flat, next_x + 1, next_y)) next_x = next_x + 5'd1;

                    drop_req = down_pulse || gravity_tick;
                    blocked_below = (next_y == (GRID_ROWS - 1)) || cell_occupied(board_flat, next_x, next_y + 1);

                    if (drop_req && !blocked_below) begin
                        block_x <= next_x;
                        block_y <= next_y + 5'd1;
                    end else if (drop_req && blocked_below) begin
                        board_after_lock = board_flat;
                        board_after_lock[next_y*GRID_COLS + next_x] = 1'b1;
                        clear_rows(board_after_lock, board_after_clear, rows_cleared);
                        board_flat <= board_after_clear;
                        if (rows_cleared != 0) score <= score + rows_cleared;

                        spawn_blocked = cell_occupied(board_after_clear, START_X, START_Y);
                        block_x <= START_X[4:0];
                        block_y <= START_Y[4:0];
                        if (spawn_blocked) game_state <= STATE_GAMEOVER;
                    end else begin
                        block_x <= next_x;
                        block_y <= next_y;
                    end
                end
                default: begin
                    // game over: hold state until reset
                    block_x <= block_x;
                    block_y <= block_y;
                end
            endcase
        end
    end
endmodule
