// line_clearer.sv
// MM3772 - EE22005 FPGA VGA Falling-Block Game
// Combinational full-row detection, clear, and downward compaction for board data.

module line_clearer #(
    parameter int unsigned GRID_COLS = 16,
    parameter int unsigned GRID_ROWS = 20
) (
    input  logic [GRID_ROWS*GRID_COLS-1:0] board_in,
    output logic [GRID_ROWS*GRID_COLS-1:0] board_out,
    output logic [4:0]                     rows_cleared
);
    int src_row;
    int dst_row;
    int col;
    logic row_full;

    always_comb begin
        board_out = '0;
        rows_cleared = '0;
        dst_row = GRID_ROWS - 1;

        for (src_row = GRID_ROWS - 1; src_row >= 0; src_row--) begin
            row_full = 1'b1;
            for (col = 0; col < GRID_COLS; col++) begin
                if (!board_in[src_row*GRID_COLS + col]) begin
                    row_full = 1'b0;
                end
            end

            if (row_full) begin
                rows_cleared = rows_cleared + 5'd1;
            end else begin
                for (col = 0; col < GRID_COLS; col++) begin
                    board_out[dst_row*GRID_COLS + col] = board_in[src_row*GRID_COLS + col];
                end
                dst_row = dst_row - 1;
            end
        end
    end
endmodule
