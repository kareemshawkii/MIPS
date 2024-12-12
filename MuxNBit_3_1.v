module muxNbit_3_1 #(
    parameter N = 32
) (
    input [1:0] sel,
    input [N-1:0] in1, in2, in3,
    output reg [N-1:0] out
);

    // Select between in1, in2, or in3 based on sel
    always @(*) begin
        case (sel)
            2'b00: out <= in1;
            2'b01: out <= in2;
            2'b10: out <= in3;
            default: out <= in1; // Default to in1 for unexpected sel values
        endcase
    end

endmodule