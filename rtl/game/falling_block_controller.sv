// falling_block_controller.sv
// MM3772 - EE22005 FPGA VGA Falling-Block Game
// Stage-1 falling-block controller: single active block with gravity, manual movement, clamp, and bottom respawn.

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
    output logic [4:0] block_x,
    output logic [4:0] block_y
);

    logic [$clog2(GRAVITY_DIV)-1:0] gravity_count;
    logic gravity_tick;

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            gravity_count <= '0;
            gravity_tick <= 1'b0;
        end else if (reset_pulse) begin
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
        if (!reset_n) begin
            block_x <= START_X[4:0];
            block_y <= START_Y[4:0];
        end else if (reset_pulse) begin
            block_x <= START_X[4:0];
            block_y <= START_Y[4:0];
        end else begin
            logic [4:0] next_x;
            logic [4:0] next_y;

            next_x = block_x;
            next_y = block_y;

            if (left_pulse && (next_x > 0)) begin
                next_x = next_x - 5'd1;
            end
            if (right_pulse && (next_x < (GRID_COLS - 1))) begin
                next_x = next_x + 5'd1;
            end

            if (down_pulse || gravity_tick) begin
                if (next_y < (GRID_ROWS - 1)) begin
                    next_y = next_y + 5'd1;
                end else begin
                    next_x = START_X[4:0];
                    next_y = START_Y[4:0];
                end
            end

            block_x <= next_x;
            block_y <= next_y;
        end
    end

endmodule
