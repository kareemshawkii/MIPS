module MainALU(
    input signed [31:0] OperandA, OperandB,
    input [3:0] ALUControlResult,
    input [4:0] shamt,

    output zero,
    output reg [31:0] ALUResult
);

    assign zero = (OperandA == OperandB);

    always @(*) begin
        case (ALUControlResult)
            4'b0000: ALUResult <= OperandA & OperandB; // AND
            4'b0001: ALUResult <= OperandA | OperandB; // OR
            4'b0010: ALUResult <= OperandA + OperandB; // ADD
            4'b0011: ALUResult <= OperandB << shamt;   // SHIFT LEFT
            4'b0100: ALUResult <= OperandB >> shamt;   // SHIFT RIGHT LOGICAL
            4'b0101: ALUResult <= OperandB >>> shamt;  // SHIFT RIGHT ARITHMETIC
            4'b0110: ALUResult <= OperandA - OperandB; // SUBTRACT
            4'b1010: ALUResult <= OperandA ^ OperandB; // XOR
            default: ALUResult <= 32'b0;              // DEFAULT
        endcase
    end

endmodule