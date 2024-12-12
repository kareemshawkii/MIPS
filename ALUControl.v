module ALUControl (
    input [1:0] ALUOp,
    input [5:0] FunctionCode,
    output reg [3:0] ALUControlResult
);

    always @(*) begin
        case (ALUOp)
            2'b00: ALUControlResult = 4'b0010; // lw/sw: add
            2'b01: ALUControlResult = 4'b0110; // branch: sub
            2'b10: begin // R-format instructions
                case (FunctionCode)
                    6'b000000: ALUControlResult = 4'b0011; // sll
                    6'b000010: ALUControlResult = 4'b0100; // srl
                    6'b000011: ALUControlResult = 4'b0101; // sra
                    6'b100000: ALUControlResult = 4'b0010; // add
                    6'b100010: ALUControlResult = 4'b0110; // sub
                    6'b100100: ALUControlResult = 4'b0000; // and
                    6'b100101: ALUControlResult = 4'b0001; // or
                    default:   ALUControlResult = 4'b0010; // default to add
                endcase
            end
            default: ALUControlResult = 4'b0010; // default to add
        endcase
    end

endmodule