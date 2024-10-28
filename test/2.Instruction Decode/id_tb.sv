module ID_tb_top;
logic [6:0] opcode, func7;
logic [2:0] func3;
logic [31:0] r1, r2;
logic [31:0] immediate;
logic RegWrite;
logic  [31:0] wb_data;
logic  [31:0] instruction;

ID_tb tb(.opcode(opcode), .func7(func7), .func3(func3), .r1(r1), .r2(r2), .immediate(immediate), .RegWrite(RegWrite), .wb_data(wb_data), .instruction(instruction));
ID dut(.opcode(opcode), .func7(func7), .func3(func3), .r1(r1), .r2(r2), .immediate(immediate), .RegWrite(RegWrite), .wb_data(wb_data), .instruction(instruction));
initial begin
    $display("help %h",instruction);
    #11;
    $display("help %h",instruction);
end
endmodule

program ID_tb (
    input logic [6:0] opcode, func7,
    input logic [2:0] func3,
    input logic [31:0] r1, r2,
    input logic [31:0] immediate,
    output logic RegWrite,
    output logic  [31:0] wb_data,
    output logic  [31:0] instruction
	);
    int good = 0, bad = 0;

    initial begin
        //for(int i = 0; i < 10; i++) begin
		
		instruction = 32'h00500513;
		RegWrite = 1'b0;
		wb_data = 32'haaed1233;
		$display("Instruction %h", instruction);
		$display("Opcode:- %0b", opcode);
		$display("Func7:- %0b", func7);
		$display("Func3:- %0b", func3);
		$display("r1, r2 :- %0b, %0b", r1, r2);
		$display("imm:- %0b", immediate);
        //end
        $display("Pass vs Fail :- %0d, %0d", good, bad); 
     end
endprogram
