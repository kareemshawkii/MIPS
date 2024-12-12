module SignExtend(
    input  signed [15:0] in,
    output signed [31:0] out
);

    // Extend the sign of the 16-bit input to 32 bits
    assign out = { {16{in[15]}}, in };

endmodule