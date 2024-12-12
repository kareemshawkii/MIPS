module ControlUnit(
    input [5:0] operation,
    output reg RegDst, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite,
    output reg [1:0] ALUOp
);

    always @(*) begin
        // Default values
        RegDst   = 1'b0;
        ALUOp    = 2'b00;
        ALUSrc   = 1'b0;
        Branch   = 1'b0;
        MemRead  = 1'b0;
        MemWrite = 1'b0;
        RegWrite = 1'b0;
        MemtoReg = 1'b0;

        case (operation)
            6'b000000: begin // R-format
                RegDst   = 1'b1;
                ALUOp    = 2'b10;
                RegWrite = 1'b1;
            end
            6'b000100: begin // beq
                ALUOp    = 2'b01;
                Branch   = 1'b1;
            end
            6'b000101: begin // bnq
                ALUOp    = 2'b01;
                Branch   = 1'b1;
            end
            6'b100011: begin // lw
                ALUSrc   = 1'b1;
                MemRead  = 1'b1;
                RegWrite = 1'b1;
                MemtoReg = 1'b1;
            end
            6'b101011: begin // sw
                ALUSrc   = 1'b1;
                MemWrite = 1'b1;
            end
            6'b001000: begin // addi
                ALUSrc   = 1'b1;
                RegWrite = 1'b1;
            end
        endcase
    end

endmodule
