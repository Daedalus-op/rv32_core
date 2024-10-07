module register (
    output logic [31:0] rdata,
    input logic [31:0] wdata,
    input logic [4:0] regno,
    input bit clk,
    input bit RegRead,
    input bit RegWrite
);
    logic [31:0] regarr [4:0];
    always@(posedge clk) begin
        if (RegRead == 1)
            rdata <= regarr[regno];
        else if (RegWrite == 1)
            regarr[regno] <= wdata;
        else 
            rdata <= 'bx;
    end
endmodule
