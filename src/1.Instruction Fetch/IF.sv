
module IF (
	output logic [31:0] instruction,
	input bit PCsrc,
	input logic [31:0] branch_addr,
	input logic clk
);
    logic [31:0] new_addr;
	logic [31:0] old_addr;
	
	pc program_count(new_addr, old_addr, branch_addr, PCsrc, clk);
	ins_mem code_mem(instruction, new_addr);

	assign old_addr = new_addr;
    
endmodule

module ins_mem ( // instruction memory
	output logic [31:0] instruction,
	input logic [31:0] address
);
	logic [7:0] instruction_tb [39:0]= {
		8'h12, 8'h34, 8'h56, 8'h78,
		8'h9a, 8'hbc, 8'hde, 8'hf0,
		8'h12, 8'h34, 8'h56, 8'h78,
		8'h9a, 8'hbc, 8'hde, 8'hf0,
		8'h12, 8'h34, 8'h56, 8'h78,
		8'h9a, 8'hbc, 8'hde, 8'hf0,
		8'h12, 8'h34, 8'h56, 8'h78,
		8'h9a, 8'hbc, 8'hde, 8'hf0,
		8'h12, 8'h34, 8'h56, 8'h78,
		8'h9a, 8'hbc, 8'hde, 8'hf0
	};
	
	always_comb begin
        instruction = {instruction_tb[address+3],instruction_tb[address+2],instruction_tb[address+1],instruction_tb[address]};
	end
endmodule
