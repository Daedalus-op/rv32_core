module memory (
    output logic [31:0] rdata,
    input logic [31:0] wdata,
    input logic [31:0] address,
    input bit MemRead,
    input bit MemWrite
);
    logic [31:0] memarr [1023:0];
    always@(posedge MemRead) rdata <= memarr[address];
    always@(posedge MemWrite) memarr[address] <= wdata;
endmodule
