module memory (
    output logic [31:0] rdata,
    input logic [31:0] wdata,
    input logic [31:0] address,
    input bit clk,
    input bit MemRead,
    input bit MemWrite
);
    logic [31:0] memarr [31:0];
    always@(posedge clk) begin
        if (MemRead == 1)
            rdata <= memarr[address];
        else if (MemWrite == 1)
            memarr[address] <= wdata;
        else 
            rdata <= 'bx;
    end
endmodule
