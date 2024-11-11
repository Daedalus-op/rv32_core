class testing;

static logic [31:0] instruction [$]= {
		/* -------------------------------------------------------
		// R type testing ---------------

		32'h00c00513,
		32'h00d00593,
		32'h00b50633,
		32'h00c02023,
		32'h00002683,
		
		------------------------------------------------------- */
		// B type testing ---------------

		32'h00000513, 	// addi x10, x0, 0 # starting index
		32'h00c00593, 	// addi x11, x0, 12 # starting number
		32'h00858613, 	// addi x12, x11, 8 # number of numbers
				//   start:
		32'h00b501a3, 	// sb x11, 3(x10)
		32'h00150513, 	// addi x10, x10, 1 # increment
		32'h00158593, 	// addi x11, x11, 1 # increment
		32'hfec5cae3, 	// bne x11, x12, start
		32'hfff50513,   // addi x10, x10, -1
		32'h00354083, 	// lbu x1, 3(x10)

		/* -------------------------------------------------------
		// U, J type testing ---------------
		
		32'h00100393, 	// addi x7, x0, 1 # starting index
				// start:
		32'h00138393, 	// addi x7, x7, 1 # starting index
		32'h00002517,   // aupic x10, 0
		32'h000122b7,   // lui x5, 0x12
		32'hff5ff06f,	// j start
		------------------------------------------------------- */

                                
		32'h00000000		// marks the end of instructions
	};	
endclass

module RV_tb_top;
parameter INS = 1 + 61; // Number of instructions
//localparam INS = $size(testing::instruction);
logic [31:0] out;
logic [7:0] instruction_tb [INS*8:0];
bit clk, exit;

always #5 clk = ~clk;
initial clk = 0;

RV #(INS) dut(out, instruction_tb, clk, exit);
RV_tb #(INS) tb(out, instruction_tb, clk, exit);

endmodule

program RV_tb #(parameter INS = 5) (
	input logic [31:0] out,
	output logic [7:0] instruction_tb [INS*8:0],
	input logic clk, exit
	);

	int good = 0, bad = 0;
	testing tb;
	logic [31:0] ins_mem_file [0:65];
	logic testSrc = 0; // testbench source (0 for file, 1 for class)

	initial begin
		tb = new;
		$readmemh("/home/xubundadu/Desktop/Projects/rv32_core/test/program_dump.hex", ins_mem_file);
		for (int i = 0; i < INS; i++) begin
			if(testSrc == 0) begin
				instruction_tb[4*i + 3] = ins_mem_file[i][31:24];
				instruction_tb[4*i + 2] = ins_mem_file[i][23:16];
				instruction_tb[4*i + 1] = ins_mem_file[i][15:8];
				instruction_tb[4*i]     = ins_mem_file[i][7:0];
			end
			else if(testSrc == 1) begin
				instruction_tb[4*i + 3] = tb.instruction[i][31:24];
				instruction_tb[4*i + 2] = tb.instruction[i][23:16];
				instruction_tb[4*i + 1] = tb.instruction[i][15:8];
				instruction_tb[4*i] = tb.instruction[i][7:0];
			end
		end

		//for(int i = 0; i < tb.instruction.size(); i++) begin
		while (!exit) begin
		@(posedge clk);
			$display("Output: %0d at %0d", out, $time); 
		end
		$display("Pass vs Fail :- %0d, %0d", good, bad); 
	end
endprogram

module ins_mem_test #(parameter INS = 5) ( // instruction memory
	output logic [31:0] instruction,
	input logic [7:0] instruction_tb [INS*8:0],
	input logic [31:0] address
);
	always_comb begin
		instruction = {instruction_tb[address+3],instruction_tb[address+2],instruction_tb[address+1],instruction_tb[address]};
	end
endmodule
