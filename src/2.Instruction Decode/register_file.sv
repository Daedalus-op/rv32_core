module register (
    output logic [31:0] r1, r2,
    input logic [31:0] wdata,
    input logic [4:0] rs1, rs2, rd,
    input bit RegWrite
);
    logic [31:0] regarr [31:0];
    always@(posedge RegWrite) begin
        if (RegWrite == 1)
            regarr[rd] <= wdata;
    end
    assign regarr[0] = 'b0;

    assign r1 = regarr[rs1];
    assign r2 = regarr[rs2];
endmodule
