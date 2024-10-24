module CU (
    output logic RegWrite, MemRead, MemWrite,  branch, ALUsrc, MemToReg, Op_sel,
    output logic [1:0] ALUop,
    input logic [6:0] func7,
    input logic [2:0] func3,
    input logic [6:0] opcode
);
logic [7:0] outs;

assign {RegWrite, MemRead, MemWrite, branch, ALUsrc, MemToReg, Op1_sel, Op2_sel, ALUop} = outs;

always_comb begin
	outs = {RegWrite, MemRead, MemWrite, branch, ALUsrc, MemToReg, Op1_sel, Op2_sel, ALUop};
	
	// Check for which opcode
	case (opcode)
		7'b110_0111 : outs = 8'b0; // I jump
		7'b000_0011 : begin  // I load
		case(func3) 
			3'b000 : outs = 10'b1100_1100; // lb 
			3'b001 : outs = 10'b1100_1100; // lh 
			3'b010 : outs = 10'b1100_1100; // lw 
			3'b100 : outs = 10'b1100_1100; // lbu
			3'b101 : outs = 10'b1100_1100; // lhu
		endcase
		end
		7'b001_0011 : begin  // I arithmetic
		case(func3)
			3'b000 : outs = 10'b1000_1000; // addi 
			3'b010 : outs = 10'b1000_1011; // slti 
			3'b011 : outs = 10'b1000_1011; // sltiu
			3'b100 : outs = 10'b1000_1010; // xori 
			3'b110 : outs = 10'b1000_1001; // ori  
			3'b111 : outs = 10'b1000_1011; // andi 
			3'b001 : begin // shift immediate
			case(func7)
				7'b000_0000 : outs = 10'b1000_1001; // s_li
				7'b010_0000 : outs = 10'b1000_1001; // srai
			endcase
			end
		endcase
		end

		7'b011_0111 : outs = 10'b0; // lui
		7'b001_0111 : outs = 10'b0; // auipc
		7'b110_1111 : outs = 10'b0; // jal
		7'b110_0011 : begin // branch
		case(func3) 
			3'b000 : outs = 10'b0001_0X01; // beq 
			3'b001 : outs = 10'b0001_0X01; // bne 
			3'b100 : outs = 10'b0001_0X10; // blt 
			3'b101 : outs = 10'b0001_0X10; // bge 
			3'b110 : outs = 10'b0001_0X11; // bltu
			3'b111 : outs = 10'b0001_0X11; // bgeu
		endcase
		end

		7'b010_0011 : begin // store
		case(func3)
			3'b000 : outs = 10'b0010_1X00; // sb
			3'b001 : outs = 10'b0010_1X00; // sh
			3'b010 : outs = 10'b0010_1X00; // sw
		endcase
		end

		7'b011_0011 : begin // R type
		case(func3)
			3'b000  : begin // add or sub
			case(func7)
				7'b000_0000 : outs = 10'b0; // add
				7'b010_0000 : outs = 10'b0; // sub
			endcase
			end

			3'b001 : outs = 10'b0; // sll 
			3'b010 : outs = 10'b0; // slt 
			3'b011 : outs = 10'b0; // sltu
			3'b100 : outs = 10'b0; // xor
			3'b101 : begin // shift right
			case(func7)
				7'b000_0000 : outs = 10'b0; // srl
				7'b010_0000 : outs = 10'b0; // sra
			endcase
			end

			3'b110  : outs = 10'b0; // or
			3'b111  : outs = 10'b0; // and
		endcase
		end
		default: outs = 8'b0000_0000;
	endcase
end
    
endmodule


module ALU_CU (
	output logic [3:0] ALU_opcode,
	input logic [1:0] ALU_op
	);
	
endmodule
