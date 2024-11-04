module RV (
    output logic [31:0] out,
    input bit clk
);
	logic [6:0] opcode, func7;
	logic [31:0] instruction, rs1, rs2, immediate, pc, AluOut, wb_data, MemData;
	logic RegWrite, MemRead, MemWrite, branch, AluSrc, MemToReg, Op_sel, pc_branch, zero;
	logic [3:0] AluOp;
	logic [2:0] func3;
	logic [4:0] rd;
	IF u_if (instruction, pc,
		pc_branch, wb_data, clk);
	ID u_id (opcode, func7, func3, rs1, rs2, immediate,
		RegWrite, wb_data, instruction);
	CU u_cu (RegWrite, MemRead, MemWrite,  branch, AluSrc, MemToReg, Op_sel, AluOp,
		func7, func3, opcode);
	EX u_ex (AluOut, zero,
		pc, rs1, rs2, immediate, AluOp, AluSrc, OpSel);
	MA u_ma(MemData,
		rs2, AluOut, func3, MemRead, MemWrite);
	WB u_wb(wb_data,
		AluOut, MemData, MemToReg);
	Branch u_br(confirm,
		func3, opcode, AluOut, zero);

	assign out = wb_data;
	assign PcBranch = branch & confirm;

	assign exit = (instruction == 32'haaaaaaaa)? 1'b1 : 1'b0;

endmodule
