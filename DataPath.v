module DataPath(
    input clk, rst
);

// Control Signals
wire RegDst, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
wire [1:0] ALUOp;

// Program Counter
wire [31:0] PCResult, PCNext;
ProgramCounter pc(
    .clk(clk),
    .rst(rst),
    .PCNext(PCNext),
    .PCResult(PCResult)
);

// PC Adder
wire [31:0] PCadderResult;
PCadder pcAdder(
    .PCResult(PCResult),
    .PCadderResult(PCadderResult)
);

// Instruction Memory
wire [31:0] Instruction;
InstructionMemory insMem(
    .ReadAddress(PCResult),
    .Instruction(Instruction)
);

// Registers
wire [4:0] ReadRegister1 = Instruction[25:21];
wire [4:0] ReadRegister2 = Instruction[20:16];
wire [4:0] WriteRegister;
wire [31:0] WriteData, ReadData1, ReadData2;

muxNbit_2_1 #(.N(5)) writeRegMux(
    .sel(RegDst),
    .in1(ReadRegister2),
    .in2(Instruction[15:11]),
    .out(WriteRegister)
);

RegisterFile regfile(
    .clk(clk),
    .ReadRegister1(ReadRegister1),
    .ReadRegister2(ReadRegister2),
    .WriteRegister(WriteRegister),
    .WriteData(WriteData),
    .RegWrite(RegWrite),
    .ReadData1(ReadData1),
    .ReadData2(ReadData2)
);

// Sign Extension
wire [31:0] SignExtendOut;
SignExtend signEx(
    .in(Instruction[15:0]),
    .out(SignExtendOut)
);

// ALU Control
wire [3:0] ALUControlResult;
ALUControl alucontrol(
    .ALUOp(ALUOp),
    .FunctionCode(Instruction[5:0]),
    .ALUControlResult(ALUControlResult)
);

// Main ALU
wire [31:0] ALUResult;
wire zero;
MainALU mainALU(
    .OperandA(ReadData1),
    .OperandB(ALUSrc ? SignExtendOut : ReadData2),
    .ALUControlResult(ALUControlResult),
    .shamt(Instruction[10:6]),
    .zero(zero),
    .ALUResult(ALUResult)
);

// Control Unit
ControlUnit control(
    .operation(Instruction[31:26]),
    .RegDst(RegDst),
    .Branch(Branch),
    .MemRead(MemRead),
    .MemtoReg(MemtoReg),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite),
    .ALUOp(ALUOp)
);

// Branch Target Address
wire [31:0] BranchTarget;
BranchTargetAddress branchtarget(
    .PCadderResult(PCadderResult),
    .SignExtendOut(SignExtendOut),
    .BranchTarget(BranchTarget)
);

// Data Memory
wire [31:0] ReadData;
DataMemory #(.MEM_DEPTH(1024)) datamem(
    .clk(clk),
    .Address(ALUResult),
    .WriteData(ReadData2),
    .MemWrite(MemWrite),
    .MemRead(MemRead),
    .ReadData(ReadData)
);

// Write Data and Next PC Calculation
assign WriteData = MemtoReg ? ReadData : ALUResult;
assign PCNext = (Branch & zero) ? BranchTarget : PCadderResult;

endmodule
