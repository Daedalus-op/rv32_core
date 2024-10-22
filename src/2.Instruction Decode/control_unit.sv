module CU (
    output logic RegWrite, MemRead, MemWrite,  branch, ALUsrc, MemToReg, 
    output logic [1:0] ALUop,
    input logic [6:0] func7,
    input logic [2:0] func3,
    input logic [6:0] opcode
);
logic [7:0] outs;

// define the opcodes (Look up table)
typedef enum logic [6:0] {
 I_J 	= 7'b110_0111, 	// I-type - jalr
 I_L 	= 7'b000_0011, 	// I-type - Load
 I_A 	= 7'b001_0011, 	// I-type - Arithemtic/ Shifting
 U_lui  = 7'b011_0111, // U-type (Upper) - lui
 U_auipc= 7'b001_0111, // U-type (Upper) - auipc
 J      = 7'b110_1111, // J-type - jal
 B      = 7'b110_0011, // B-type
 S 	= 7'b010_0011, 	// S-type
 R 	= 7'b011_0011 	// R-type
} tb_op;

typedef enum logic [6:0] {
 s_li_add_srl = 7'b000_0000, //shift logical immediate
 srai_sub_sra = 7'b010_0000 //
} tb_f7;

typedef enum logic [2:0] {
 lb  = 3'b000,
 lh  = 3'b001,
 lw  = 3'b010,
 lbu = 3'b100,
 lhu = 3'b101,
} tb_f3_l;

typedef enum logic [2:0] {
 addi  = 3'b000,
 slti  = 3'b010,
 sltiu = 3'b011,
 xori  = 3'b100,
 ori   = 3'b110,
 andi  = 3'b111,
} tb_f3_logi;

typedef enum logic [2:0] {
 shift_imm = 3'b001, // shifting immediate
} tb_f3_shift;

typedef enum logic [2:0] {
 beq  = 3'b000,
 bne  = 3'b001,
 blt  = 3'b100,
 bge  = 3'b101,
 bltu = 3'b110,
 bgeu = 3'b111,
} tb_f3_b;

typedef enum logic [2:0] {
 sb = 3'b000,
 sh = 3'b001,
 sw = 3'b010,
} tb_f3_s;

typedef enum logic [2:0] {
 add_sub  = 3'b000,
} tb_f3_r;

typedef enum logic [2:0] {
 sll  = 3'b001,
 slt  = 3'b010,
 sltu = 3'b011,
 xor_  = 3'b100,
 sr  = 3'b101,
 or_   = 3'b110,
 and_  = 3'b111
} tb_f3_log;

tb_op tb_opcode;
tb_f7 tb_func7;
tb_f3_logi	tb_func3_logi;
tb_f3_shift	tb_func3_shift;
tb_f3_b		tb_func3_b;
tb_f3_s		tb_func3_s;
tb_f3_r		tb_func3_r;
tb_f3_l		tb_func3_l;

assign {RegWrite, MemRead, MemWrite, branch, ALUsrc, MemToReg, ALUop} = outs;

always_comb begin
	outs = {RegWrite, MemRead, MemWrite, branch, ALUsrc, MemToReg, ALUop};
	tb_opcode = tb_op'{opcode};
	// Check for which opcode
	case (tb_opcode)
		I_J : outs = 8'b0; // I jump
		I_L : begin  // I load
		case(func3) 
			tb_func3_l.lb  : outs = 8'b1100_1100;
			tb_func3_l.lh  : outs = 8'b1100_1100;
			tb_func3_l.lw  : outs = 8'b1100_1100;
			tb_func3_l.lbu : outs = 8'b1100_1100;
			tb_func3_l.lhu : outs = 8'b1100_1100;
		endcase
		end
		I_A : begin  // I arithmetic
		case(func3)
			addi  : outs = 8'b1000_1000;
			slti  : outs = 8'b1000_1011;
			sltiu : outs = 8'b1000_1011;
			xori  : outs = 8'b1000_1010;
			ori   : outs = 8'b1000_1001;
			andi  : outs = 8'b1000_1011;
			shift_imm : begin
			case(func7)
				s_li_add_srl : outs = 8'b1000_1001;
				srai_sub_sra : outs = 8'b1000_1001;
			endcase
			end
		endcase
		end

		U_lui   : outs = 8'b0;
		U_auipc : outs = 8'b0;
		J       : outs = 8'b0;
		B       : begin
		case(func3) 
			beq  : outs = 8'b0001_0X01;
			bne  : outs = 8'b0001_0X01;
			blt  : outs = 8'b0001_0X10;
			bge  : outs = 8'b0001_0X10;
			bltu : outs = 8'b0001_0X11;
			bgeu : outs = 8'b0001_0X11;
		endcase
		end

		S : begin
		case(func3)
			sb : outs = 8'b0010_1X00;
			sh : outs = 8'b0010_1X00;
			sw : outs = 8'b0010_1X00;
		endcase
		end

		R : begin
		case(func3)
			add_sub  : begin
			case(func7)
				s_li_add_srl : outs = 8'b0;
				srai_sub_sra : outs = 8'b0;
			endcase
			end

			sll  : outs = 8'b0;
			slt  : outs = 8'b0;
			sltu : outs = 8'b0;
			xor_  : outs = 8'b0;
			sr  : begin
			case(func7)
				s_li_add_srl : outs = 8'b0;
				srai_sub_sra : outs = 8'b0;
			endcase
			end

			or_   : outs = 8'b0;
			and_  : outs = 8'b0;
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
