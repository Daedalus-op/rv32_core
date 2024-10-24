module MA (
    output logic [31:0] rdata,
    input logic [31:0] AluOut,
    input logic [31:0] address,
    input bit MemRead, MemWrite
);
    memory u_mem (rdata, AluOut, address, MemRead, MemWrite);
endmodule