module muxNbit_2_1 #(
    parameter N = 32
) (
    input sel,
    input [N-1:0] in1, in2,
    output reg [N-1:0] out
);

    // Select between in1 and in2 based on sel
    always @(*) begin
        if (sel)
            out <= in2;
        else
            out <= in1;
    end

endmodule