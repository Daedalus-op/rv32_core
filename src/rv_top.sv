module rv_top (
    input logic PCsrc, clk
);
    logic [31:0] instruction, rs1, rs2, immediate, pc, AluOut;
    logic [6:0] opcode, func7;
    logic RegWrite, MemRead, MemWrite, branch, AluSrc, MemToReg;
    logic [1:0] AluOp;
    logic [2:0] func3;
    logic [4:0] rd;
    IF u_if (instruction, pc,
	    PCsrc, AluOut, clk);
    ID u_id (rs1, rs2, rd, immediate, opcode, func7, func3,
	    RegWrite, MemRead, MemWrite,  branch, AluSrc, MemToReg, AluOp,
	    AluOut, instruction);
    EX u_ex (AluOut, zero,
	    pc, rs1, rs2, immediate, AluOp, AluSrc, 1'b0);
endmodule
