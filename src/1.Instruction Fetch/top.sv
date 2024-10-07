module IF (
	output logic [31:0] instruction,
	input bit PCsrc,
	input logic [31:0] branch_addr,
	input logic clk
);
	logic [31:0] new_addr; // address wire
	logic [31:0] old_addr = 0;
	
	pc program_count(new_addr, old_addr, branch_addr, PCsrc, clk);
	memory code_mem(instruction, _, new_addr, clk, 1, 0);

	always_ff@(posedge clk) old_addr <= new_addr;
    
endmodule