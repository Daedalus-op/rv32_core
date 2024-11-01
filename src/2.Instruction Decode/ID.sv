module ID (
    output logic [6:0] opcode, func7,
    output logic [2:0] func3,
    output logic [31:0] r1, r2,
    output logic [31:0] immediate,
    output logic [7:0] immExt,   // Extended Immediate
    input logic RegWrite,
    input logic  [31:0] wb_data,
    input logic  [31:0] instruction
);
logic [4:0] rd, rs1, rs2;
logic [11:0] imm_in, imm_out;
decoder 	decode		(opcode, rd, func3, rs1, rs2, func7, imm_in, immExt, instruction);
register 	register_file	(r1, r2, wb_data, rs1, rs2, rd, RegWrite);
sign_extend 	sign_ext	(immediate, {immExt,imm_in}, opcode);
endmodule
