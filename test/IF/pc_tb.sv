module pc_top;
logic [31:0] new_addr;
logic [31:0] old_addr;
logic [31:0] branch_addr;
bit PCsrc;
bit clk;

always #5 clk = ~clk;

pc_tb tb(new_addr, old_addr, branch_addr, PCsrc, clk);
pc dut(new_addr, old_addr, branch_addr, PCsrc, clk);

endmodule

program pc_tb (
	input logic [31:0] new_addr,
	output logic [31:0] old_addr,
	output logic [31:0] branch_addr,
	output bit PCsrc,
	input bit clk
	);
    int good = 0, bad = 0;

    initial begin
        for(int i = 0; i <= 100; i++) begin
            old_addr = $urandom;
            branch_addr = $urandom;
            PCsrc = $urandom;
            @(posedge clk);
            if(PCsrc == 1) begin
                if(new_addr == branch_addr)
                    good++;
                else begin
                    bad++;
                    $display("Error :- for PCsrc = %0d, new(%0d) != branch(%0d)", PCsrc, new_addr, branch_addr);
                end
            end 
            else begin
                if(new_addr == (old_addr + 4))
                    good++;
                else begin
                    bad++;
                    $display("Error :- for PCsrc = %0d, new(%0d) != old(%0d) + 4", PCsrc, new_addr, old_addr);
                end
            end
        end
        $display("Number of good vs bad :- %0d / %0d",good, bad);
    end
endprogram