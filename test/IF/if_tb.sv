module if_top;
logic [31:0] instruction;
logic [31:0] addr;
bit PCsrc;
logic [31:0] curr_addr;
bit clk;

always #5 clk = ~clk;

IF dut(instruction, PCsrc, addr, curr_addr, clk);
IF_tb tb(instruction, PCsrc, addr, curr_addr, clk);

endmodule

program IF_tb (
	input logic [31:0] instruction,
	output bit PCsrc,
	output logic [31:0] addr,
	input logic [31:0] curr_addr,
	input logic clk
	);
    int good = 0, bad = 0;

    assign PCsrc = 0;
    logic [31:0] tb_inst;

    initial begin
        testing tb;
        tb = new;
        for(int i = 0; i < 10; i++) begin
            addr = i*4;
            @(posedge clk);
                tb_inst = {tb.instruction[addr+3],tb.instruction[addr+2],tb.instruction[addr+1],tb.instruction[addr]};
                if(instruction == tb_inst)
                    good++;
                else begin
                    bad++;
                    $display("Error :- %0d. for PCsrc = %0b, at address(%0h) instruction != (%0h) vs %0h", i, PCsrc, curr_addr, instruction, {tb.instruction[addr+3],tb.instruction[addr+2],tb.instruction[addr+1],tb.instruction[addr]});
                end                            
         end
         $display("Pass vs Fail :- %0d, %0d", good, bad); 
     end
endprogram