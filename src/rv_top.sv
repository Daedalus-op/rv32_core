module RV(
    output logic [31:0] out,
    output bit exit, OutType,
    input bit clk
);
  logic [6:0] opcode, func7;
  logic [31:0] instruction, rs1, rs2, immediate, pc, AluOut, wb_data, MemData, PcOut;
  logic RegWrite, MemRead, MemWrite, branch, AluSrc, MemToReg, PcRelative, PcBranch, zero;
  logic [3:0] AluOp;
  logic [2:0] func3;
  logic [4:0] rd;
  IF u_if (instruction, pc,
    PcBranch, PcOut, clk);
  ID u_id (opcode, func7, func3, rs1, rs2, immediate,
    RegWrite, clk, wb_data, instruction);
  CU u_cu (RegWrite, MemRead, MemWrite,  branch, AluSrc, MemToReg, PcRelative, OutType, AluOp,
    func7, func3, opcode);
  EX u_ex (AluOut, zero,
    pc, rs1, rs2, immediate, AluOp, AluSrc, PcRelative);
  MA u_ma(MemData,
    rs2, AluOut, func3, MemRead, MemWrite);
  WB u_wb(wb_data,
    AluOut, MemData, MemToReg);
  Branch u_br(confirm, PcOut,
    func3, opcode, AluOut, pc, immediate, zero);

  assign PcBranch = branch & confirm;

  always_comb begin : OutMux
    if (OutType == 0) // Data Output
      out = wb_data;
    else if (OutType == 1) begin // Pc Output
      out = pc;
    end
  end

  assign exit = (instruction == 32'h00000000)? 1'b1 : 1'b0;

endmodule
