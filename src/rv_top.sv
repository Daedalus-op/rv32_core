module rv_top (
    input logic PCsrc, clk
);
    logic [31:0] instruction, branch_addr = 0, wb_data = 0, rs1, rs2, immediate;
    logic [6:0] opcode, func7;
    logic RegWrite, MemRead, MemWrite, branch, ALUsrc, MemToReg;
    logic [1:0] AluOp;
    logic [2:0] func3;
    logic [4:0] rd;
    IF u_if (instruction, pc,
	    PCsrc, branch_addr, clk);
    ID u_id (rs1, rs2, rd, immediate, opcode, func7, func3,
	    RegWrite, MemRead, MemWrite,  branch, ALUsrc, MemToReg, AluOp,
	    wb_data, instruction);
    EX u_ex (AluOut, zero,
	    pc, rs1, rs2, immediate, rd, AluOp, AluSrc);
endmodule
