class testing;
static logic [39:0][7:0] instruction = {
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
	
endclass

module IF (
	output logic [31:0] instruction,
	input bit PCsrc,
	input logic [31:0] branch_addr,
	output logic [31:0] new_addr,
	input logic clk
);
	logic [31:0] old_addr = 0;
	
	pc program_count(new_addr, old_addr, branch_addr, PCsrc, clk);
	ins_mem code_mem(instruction, new_addr, clk);

	always_ff@(posedge clk) old_addr <= new_addr;
    
endmodule

module ins_mem ( // instruction memory
	output logic [31:0] instruction,
	input logic [31:0] address,
	input logic clk
);
	
	always_ff @( posedge clk ) begin
        testing tb;
        tb = new;
        instruction = {tb.instruction[address+3],tb.instruction[address+2],tb.instruction[address+1],tb.instruction[address]};
	end
endmodule