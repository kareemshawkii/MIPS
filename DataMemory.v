module DataMemory #(
    parameter MEM_DEPTH = 1024
) (
    input clk,
    input [31:0] Address, WriteData,
    input MemWrite, MemRead,
    output reg [31:0] ReadData
);

    reg [7:0] DataMem [0:(2 ** MEM_DEPTH) - 1];

    always @(posedge clk) begin
        if (MemRead) begin
            ReadData <= {DataMem[Address], DataMem[Address+1], DataMem[Address+2], DataMem[Address+3]};
        end
        if (MemWrite) begin
            {DataMem[Address], DataMem[Address+1], DataMem[Address+2], DataMem[Address+3]} <= WriteData;
        end
    end

endmodule
