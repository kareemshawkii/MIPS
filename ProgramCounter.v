module ProgramCounter(
    input clk, rst,
    input [31:0] PCNext,
    output reg [31:0] PCResult
);

    always @(posedge clk or posedge rst) begin
        if (rst) 
            PCResult <= 0;
        else 
            PCResult <= PCNext;
    end
    
endmodule