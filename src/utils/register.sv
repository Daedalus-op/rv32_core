module register (
    inout logic [31:0] data,
    input bit clk,
    input logic [4:0] regno,
    input bit rw
);
    logic [31:0] regarr [31:0];
    always@(posedge clk) begin
        if (rw == 0)
            data <= regarr[regno];
        else if (rw == 1)
            regarr[regno] <= data;
        else 
            data <= 'bx;
    end
endmodule