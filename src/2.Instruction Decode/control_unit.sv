class common;
	logic [6:0] tb_opcode [string];
	logic [6:0] tb_func7 [string];
	logic [2:0] tb_func3 [string];

	// define the opcodes (Look up table)
	assign tb_opcode["I_J"] = 7'b110_0111; // I-type - jalr
	assign tb_opcode["I_L"] = 7'b000_0011; // I-type - Load
		assign tb_func3["lb"]  = 3'b000;
		assign tb_func3["lh"]  = 3'b001;
		assign tb_func3["lw"]  = 3'b010;
		assign tb_func3["lbu"] = 3'b100;
		assign tb_func3["lhu"] = 3'b101;
	assign tb_opcode["I_A"] = 7'b001_0011; // I-type - Arithemtic/ Shifting
		assign tb_func3["addi"]  = 3'b000;
		assign tb_func3["slti"]  = 3'b010;
		assign tb_func3["sltiu"] = 3'b011;
		assign tb_func3["xori"]  = 3'b100;
		assign tb_func3["ori"]   = 3'b110;
		assign tb_func3["xori"]  = 3'b111;
		assign tb_func3["shift_imm"] = 3'b001; // shifting immediate
			assign tb_func7["slli"] = 7'b000_0000;
			assign tb_func7["srli"] = 7'b000_0000;
			assign tb_func7["srai"] = 7'b010_0000;

	assign tb_opcode["U_lui"]   = 7'b011_0111; // U-type (Upper) - lui
	assign tb_opcode["U_auipc"] = 7'b001_0111; // U-type (Upper) - auipc
	assign tb_opcode["J"]       = 7'b110_1111; // J-type - jal
	assign tb_opcode["B"]       = 7'b110_0011; // B-type
		assign tb_func3["beq"]  = 3'b000;
		assign tb_func3["bne"]  = 3'b001;
		assign tb_func3["blt"]  = 3'b100;
		assign tb_func3["bge"]  = 3'b101;
		assign tb_func3["bltu"] = 3'b110;
		assign tb_func3["bgeu"] = 3'b111;

	assign tb_opcode["S"] = 7'b010_0011; // S-type
		assign tb_func3["sb"] = 3'b000;
		assign tb_func3["sh"] = 3'b001;
		assign tb_func3["sw"] = 3'b010;

	assign tb_opcode["R"] = 7'b011_0011; // R-type
		assign tb_func3["add_sub"]  = 3'b000;
			assign tb_func7["add"] = 7'b000_0000;
			assign tb_func7["sub"] = 7'b010_0000;

		assign tb_func3["sll"]  = 3'b001;
		assign tb_func3["slt"]  = 3'b010;
		assign tb_func3["sltu"] = 3'b011;
		assign tb_func3["xor"]  = 3'b100;
		assign tb_func3["sr"]  = 3'b101;
			assign tb_func7["srl"] = 7'b000_0000;
			assign tb_func7["sra"] = 7'b010_0000;

		assign tb_func3["or"]   = 3'b110;
		assign tb_func3["and"]  = 3'b111;
endclass

module CU (
    output logic RegWrite, MemRead, MemWrite,  branch, ALUsrc, MemToReg, [1:0] ALUop,
    input logic [6:0] func7,
    input logic [2:0] func3,
    input logic [6:0] opcode
);
logic [7:0] outs;
assign {RegWrite, MemRead, MemWrite, branch, ALUsrc, MemToReg, ALUop} = outs;

always_comb begin
	common com;
	com = new();
	outs = {RegWrite, MemRead, MemWrite, branch, ALUsrc, MemToReg, ALUop};
	// Check for which opcode
	case (opcode)
		com.tb_opcode["I_J"] : outs = 8'b0;
		com.tb_opcode["I_L"] : begin
		case(func3) 
			com.tb_func3["lb"]  : outs = 8'b1100_11;
			com.tb_func3["lh"]  : outs = 8'b1100_11;
			com.tb_func3["lw"]  : outs = 8'b1100_11;
			com.tb_func3["lbu"] : outs = 8'b1100_11;
			com.tb_func3["lhu"] : outs = 8'b1100_11;
		endcase
		end
		com.tb_opcode["I_A"] : begin
		case(func3)
			com.tb_func3["addi"]  : outs = 8'b0;
			com.tb_func3["slti"]  : outs = 8'b0;
			com.tb_func3["sltiu"] : outs = 8'b0;
			com.tb_func3["xori"]  : outs = 8'b0;
			com.tb_func3["ori"]   : outs = 8'b0;
			com.tb_func3["xori"]  : outs = 8'b0;
			com.tb_func3["shift"] : begin
			case(func7)
				com.tb_func7["slli"] : outs = 8'b0;
				com.tb_func7["srli"] : outs = 8'b0;
				com.tb_func7["srai"] : outs = 8'b0;
			endcase
			end
		endcase
		end

		com.tb_opcode["U_lui"]   : outs = 8'b0;
		com.tb_opcode["U_auipc"] : outs = 8'b0;
		com.tb_opcode["J"]       : outs = 8'b0;
		com.tb_opcode["B"]       : begin
		case(func3) 
			com.tb_func3["beq"]  : outs = 8'b0;
			com.tb_func3["bne"]  : outs = 8'b0;
			com.tb_func3["blt"]  : outs = 8'b0;
			com.tb_func3["bge"]  : outs = 8'b0;
			com.tb_func3["bltu"] : outs = 8'b0;
			com.tb_func3["bgeu"] : outs = 8'b0;
		endcase
		end

		com.tb_opcode["S"] : begin
		case(func3)
			com.tb_func3["sb"] : outs = 8'b0;
			com.tb_func3["sh"] : outs = 8'b0;
			com.tb_func3["sw"] : outs = 8'b0;
		endcase
		end

		com.tb_opcode["R"] : begin
		case(func3)
			com.tb_func3["add_sub"]  : begin
			case(func7)
				com.tb_func7["add"] : outs = 8'b0;
				com.tb_func7["sub"] : outs = 8'b0;
			endcase
			end

			com.tb_func3["sll"]  : outs = 8'b0;
			com.tb_func3["slt"]  : outs = 8'b0;
			com.tb_func3["sltu"] : outs = 8'b0;
			com.tb_func3["xor"]  : outs = 8'b0;
			com.tb_func3["sr"]  : begin
			case(func7)
				com.tb_func7["srl"] : outs = 8'b0;
				com.tb_func7["sra"] : outs = 8'b0;
			endcase
			end

			com.tb_func3["or"]   : outs = 8'b0;
			com.tb_func3["and"]  : outs = 8'b0;
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
