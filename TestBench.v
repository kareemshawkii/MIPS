`timescale 1ns / 1ps

module testbench;

    // Declare input signals
    reg clk, rst;
    
    // Declare control signals
    reg [31:0] PCNext;
    wire [31:0] PCResult;
    
    // Control signals
    wire RegDst, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
    wire [1:0] ALUOp;
    
    // Instantiate the DataPath
    DataPath dp (
        .clk(clk), 
        .rst(rst)
    );
    
    // Clock generation
    always #5 clk = ~clk;  // Toggle clock every 5 ns (100 MHz clock)
    
    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        PCNext = 32'h00000000;  // Initialize PCNext to 0
        
        // Reset the design
        rst = 1;
        #10;  // Wait for 10 ns
        rst = 0;
        
        // Apply some test vectors
        // Example of a test input: Instruction memory at address 0 is set to a load instruction
        // and observe the output.
        // You can toggle `PCNext`, `MemRead`, `MemWrite`, etc., based on your design.
        
        // Add more test cases here for various operations like add, sub, branch, etc.
        
        // End simulation after some time
        #200;
        $finish;
    end
    
    // Monitor outputs (for debugging purposes)
    initial begin
        $monitor("At time %t, PC = %h, RegWrite = %b, ALUResult = %h", 
                 $time, PCResult, RegWrite, dp.ALUResult);
    end

endmodule
