// board_memory.sv
// MM3772 - EE22005 FPGA VGA Falling-Block Game
// Board memory storage for locked cells in playfield grid.

module board_memory #(
    parameter int unsigned GRID_COLS = 16,
    parameter int unsigned GRID_ROWS = 20
) (
    input  logic clk,
    input  logic reset_n,
    input  logic reset_pulse,
    input  logic lock_write,
    input  logic [4:0] lock_x,
    input  logic [4:0] lock_y,
    output logic [GRID_COLS*GRID_ROWS-1:0] board_cells
);

    localparam int unsigned BOARD_SIZE = GRID_COLS * GRID_ROWS;

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            board_cells <= '0;
        end else if (reset_pulse) begin
            board_cells <= '0;
        end else if (lock_write && (lock_x < GRID_COLS) && (lock_y < GRID_ROWS)) begin
            board_cells[(lock_y*GRID_COLS)+lock_x] <= 1'b1;
        end
    end

endmodule
