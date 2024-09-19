module pc(
	output logic [31:0] new_addr,
	input logic [31:0] old_addr,
	input bit clk
	);

	int offset = 4;
	always@(posedge clk) begin
		new_addr <= old_addr + offset;
	end
endmodule
