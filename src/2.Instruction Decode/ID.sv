module ID (
    output logic [31:0] r1, r2,
    output logic [31:0] immediate,
    output logic MemRead, MemWrite,  branch, ALUsrc, MemToReg, Op_sel, [1:0] ALUop,
    input logic  [31:0] wb_data,
    input  logic [31:0] instruction
);
logic [4:0] rd, rs1, rs2;
logic [11:0] imm_in, imm_out;
logic [6:0] opcode, func7;
logic [2:0] func3;
logic RegWrite;
decoder 	decode		(opcode, rd, func3, rs1, rs2, func7, imm_in, instruction);
register 	register_file	(r1, r2, wb_data, rs1, rs2, rd, RegWrite);
sign_extend 	sign_ext	(immediate, imm_in, opcode);
CU 		u_cu		(RegWrite, MemRead, MemWrite,  branch, ALUsrc, MemToReg, Op_sel, ALUop,  func7, func3, opcode);
// ALU_CU	u_alucu		();
endmodule