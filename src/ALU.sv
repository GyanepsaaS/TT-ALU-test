`default_nettype none

module ALU
    (input logic clock, reset_L,
    input logic [1:0] op,
    input logic [3:0] operand,
    output logic [3:0] result
    );

    logic [3:0] state, nextState;

    always_comb begin
        case (op)
            2'b0: nextState = state + operand;
            2'b01: nextState = state - operand;
            2'b10: nextState = state | operand;
            2'b11: nextState = state ^ operand;
            default: nextState = state;
        endcase
    end

    always_ff @ (posedge clock, negedge reset_L) begin
        if (~reset_L)
            state <= 4'b0;
        else
            state <= nextState;
    end

endmodule: ALU