class testing;

static logic [31:0] instruction [$]= {
		32'h00002683,
		32'h00c02023,
		32'h00b50633,
		32'h00d00593,
		32'h00c00513,
		32'h00000000
	};

/*
static logic [31:0] instruction [$]= {
		//32'hx,		// marks the end of instructions

		32'h00352083, 	// addi x10, x3, 0 # starting index
		32'hfec59ae3, 	// addi x11, x0, 12 # starting number
		32'h00158593, 	// addi x12, x11, 3 # number of numbers
                                //   start:
		32'h00150513, 	// sb x11, 3(x10)
		32'h00b501a3, 	// addi x10, x10, 1 # increment
		32'h00358613, 	// addi x11, x11, 1 # increment
		32'h00c00593, 	// bne x11, x12, start
		32'h00018513, 	// lw x1, 3(x10)

		32'h00000000  	// start of instructions
	};	
*/
endclass


module RV_tb_top;
logic [31:0] out;
bit clk;

always #5 clk = ~clk;

RV #(8) dut(out, instruction_tb, clk);
RV_tb tb(out, instruction_tb, clk);

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
