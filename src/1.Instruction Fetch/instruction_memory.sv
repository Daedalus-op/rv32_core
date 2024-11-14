module ins_mem ( // instruction memory
	output logic [31:0] instruction,
	input logic [31:0] address
);
	logic [7:0] instruction_tb [0:23]={
		8'h00,8'h00,8'h26,8'h83,
		8'h00,8'hc0,8'h20,8'h23,
		8'h00,8'hb5,8'h06,8'h33,
		8'h00,8'hd0,8'h05,8'h93,
		8'h00,8'hc0,8'h05,8'h13,
		8'h00,8'h00,8'h00,8'h00
	};
	
	always_comb begin
        instruction = {instruction_tb[address+3],instruction_tb[address+2],instruction_tb[address+1],instruction_tb[address]};
	end
endmodule
