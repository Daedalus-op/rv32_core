module pc(
	output logic [31:0] new_addr,
	input logic [31:0] old_addr,
	input logic [31:0] branch_addr,
	input bit PCsrc,
	input bit clk
	);

	logic [2:0] offset = 3'd4;
	always@(posedge clk) begin
		if (PCsrc == 0) // default offset - 4
			new_addr <= old_addr + offset;
		else if (PCsrc == 1) // branch statements
			new_addr <= branch_addr;
	end
endmodule
