
module IF (
	output logic [31:0] instruction, new_addr,
	input bit PCsrc,
	input logic [31:0] branch_addr,
	input logic clk
);
	logic [31:0] old_addr;
	
	pc program_count(new_addr, old_addr, branch_addr, PCsrc, clk);
	ins_mem code_mem(instruction, old_addr);

	assign old_addr = new_addr;
    
endmodule
