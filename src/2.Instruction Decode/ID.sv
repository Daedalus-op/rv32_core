module ID (
    output logic [31:0] r1, r1,
    output logic [4:0] rd,
    output logic [31:0] immediate,
    output logic [6:0]  opcode,
    output logic [6:0]  func7,
    output logic [2:0]  func3,
    output logic RegWrite, MemRead, MemWrite,  branch, ALUsrc, MemToReg, [1:0] ALUop,
    input logic  [31:0] wb_data,
    input  logic [31:0] instruction
);
logic [4:0] rs1, rs2, rd;
decoder 	decode		(opcode, rd, func3, rs1, rs2, func7, instruction);
register 	register_file	(r1, r2, wb_data, rs1, rs2, rd, RegWrite);
sign_extend 	sign_ext	(immediate, instruction);
CU 		u_cu		(RegWrite, MemRead, MemWrite,  branch, ALUsrc, MemToReg, ALUop, func7, func3, opcode);
endmodule
