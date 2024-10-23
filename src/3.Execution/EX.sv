module EX (
    output logic [31:0] AluOut,
    output bit zero,
    input logic [31:0] pc, rs1, rs2, imm,
    input logic [1:0] AluOp,
    input bit AluSrc, pc_relative
);
    logic [31:0] r1, r2;
    mux mux1(r1, AluSrc, imm, rs1);
    mux mux2(r2, pc_relative, pc, rs2);
    alu #(32) alu_unit(AluOut, zero, clk, AluOp, r1, r2);
endmodule
