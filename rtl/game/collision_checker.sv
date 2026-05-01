// collision_checker.sv
// MM3772 - EE22005 FPGA VGA Falling-Block Game
// Collision checker for downward movement against board and playfield bottom.

module collision_checker #(
    parameter int unsigned GRID_COLS = 16,
    parameter int unsigned GRID_ROWS = 20
) (
    input  logic [4:0] block_x,
    input  logic [4:0] block_y,
    input  logic [GRID_COLS*GRID_ROWS-1:0] board_cells,
    output logic can_move_down
);

    logic below_occupied;

    always_comb begin
        below_occupied = 1'b0;

        if ((block_x < GRID_COLS) && (block_y < (GRID_ROWS - 1))) begin
            below_occupied = board_cells[((block_y + 1)*GRID_COLS)+block_x];
        end

        can_move_down = (block_y < (GRID_ROWS - 1)) && !below_occupied;
    end

endmodule
