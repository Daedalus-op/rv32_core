class testing;
static logic [31:0] instruction [$]= {
		32'h00002683,
		32'h00c02023,
		32'h00b50633,
		32'h00d00593,
		32'h00c00513,
		32'h00000000
	};

endclass

module RV_tb_top;
logic [31:0] out;
bit clk;

always #5 clk = ~clk;

RV dut(out, clk);
RV_tb tb(out, clk);

endmodule

program RV_tb (
	input logic [31:0] out,
	input logic clk
	);

	int good = 0, bad = 0;
	testing tb;

	initial begin
		tb = new;
		for(int i = 0; i < tb.instruction.size(); i++) begin
		@(posedge clk);
			$display("Output: %0d at %0d", out, $time); 
		end
		$display("Pass vs Fail :- %0d, %0d", good, bad); 
	end
endprogram

module ins_mem_test ( // instruction memory
	output logic [31:0] instruction,
	input logic [31:0] address
);
	logic [31:0] instruction_tb [5:0]= {
		32'h00002683,
		32'h00c02023,
		32'h00b50633,
		32'h00d00593,
		32'h00c00513,
		32'h00000000
	};

	always_comb begin
		instruction = instruction_tb[address];
		//instruction = {instruction_tb[address+3],instruction_tb[address+2],instruction_tb[address+1],instruction_tb[address]};
	end
endmodule
