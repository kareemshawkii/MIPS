module RegisterFile(
    input clk,
    input [4:0] ReadRegister1, ReadRegister2, WriteRegister,
    input [31:0] WriteData,
    input RegWrite,

    output [31:0] ReadData1, ReadData2
);
    reg [31:0] regmem [31:0];

    // Assigning read values directly
    assign ReadData1 = regmem[ReadRegister1];
    assign ReadData2 = regmem[ReadRegister2];

    // Writing data on negative clock edge if RegWrite is active
    always @(negedge clk) begin
        if (RegWrite)
            regmem[WriteRegister] <= WriteData;
    end
endmodule