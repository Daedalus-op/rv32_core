module MA (
    output logic [31:0] rdata,
    input logic [31:0] wdata,
    input logic [31:0] address,
    input logic [2:0] func3, 
    input bit MemRead, MemWrite
);
    
    logic [7:0] memarr [1023:0];
    always@(*) begin
        if (MemRead) begin
            case (func3)
                3'b000 : rdata <= memarr[address]; // lb
                3'b001 : rdata <= {memarr[address+1],memarr[address]}; // lh
                3'b010 : rdata <= {memarr[address+3],memarr[address+2],memarr[address+1],memarr[address]}; // lw
                3'b100 : rdata <= memarr[address]; // lbu
                3'b101 : rdata <= {memarr[address+1],memarr[address]};// lhu
            endcase
        end
    
        if (MemWrite) begin
            case(func3)
                3'b000 : memarr[address] <= wdata; // sb
                3'b001 : {memarr[address+1],memarr[address]} <= wdata; // sh
                3'b010 : {memarr[address+3],memarr[address+2],memarr[address+1],memarr[address]} <= wdata; // sw
            endcase
        end
    end
endmodule
