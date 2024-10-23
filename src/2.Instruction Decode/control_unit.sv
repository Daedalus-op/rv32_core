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


typedef enum logic [2:0] {
 lb  = 3'b000,
 lh  = 3'b001,
 lw  = 3'b010,
 lbu = 3'b100,
 lhu = 3'b101
} tb_f3_l;

typedef enum logic [2:0] {
 addi  = 3'b000,
 slti  = 3'b010,
 sltiu = 3'b011,
 xori  = 3'b100,
 ori   = 3'b110,
 andi  = 3'b111
} tb_f3_logi;

typedef enum logic [2:0] {
 shift_imm = 3'b001 // shifting immediate
} tb_f3_shift;

typedef enum logic [6:0] {
s_li_add_srl = 7'b000_0000, //shift logical immediate
srai_sub_sra = 7'b010_0000 //
} tb_f7;

typedef enum logic [2:0] {
 beq  = 3'b000,
 bne  = 3'b001,
 blt  = 3'b100,
 bge  = 3'b101,
 bltu = 3'b110,
 bgeu = 3'b111
} tb_f3_b;

typedef enum logic [2:0] {
 sb = 3'b000,
 sh = 3'b001,
 sw = 3'b010
 } tb_f3_s;

typedef enum logic [2:0] {
 add_sub  = 3'b000
} tb_f3_r;

typedef enum logic [2:0] {
 sll   = 3'b001,
 slt   = 3'b010,
 sltu  = 3'b011,
 xor_  = 3'b100,
 sr    = 3'b101,
 or_   = 3'b110,
 and_  = 3'b111
} tb_f3_log;

assign {RegWrite, MemRead, MemWrite, branch, ALUsrc, MemToReg, ALUop} = outs;

always_comb begin
	outs = {RegWrite, MemRead, MemWrite, branch, ALUsrc, MemToReg, ALUop};
	
	// Check for which opcode
	case (opcode)
		7'b110_0111 : outs = 8'b0; // I jump
		7'b000_0011 : begin  // I load
		case(func3) 
			3'b000 : outs = 8'b1100_1100;
			3'b001 : outs = 8'b1100_1100;
			3'b010 : outs = 8'b1100_1100;
			3'b100 : outs = 8'b1100_1100;
			3'b101 : outs = 8'b1100_1100;
		endcase
		end
		7'b001_0011 : begin  // I arithmetic
		case(func3)
			3'b000 : outs = 8'b1000_1000;
			3'b010 : outs = 8'b1000_1011;
			3'b011 : outs = 8'b1000_1011;
			3'b100 : outs = 8'b1000_1010;
			3'b110 : outs = 8'b1000_1001;
			3'b111 : outs = 8'b1000_1011;
			3'b001 : begin
			case(func7)
				7'b000_0000 : outs = 8'b1000_1001;
				7'b010_0000 : outs = 8'b1000_1001;
			endcase
			end
		endcase
		end

		7'b011_0111 : outs = 8'b0;
		7'b001_0111 : outs = 8'b0;
		7'b110_1111 : outs = 8'b0;
		7'b110_0011 : begin
		case(func3) 
			3'b000 : outs = 8'b0001_0X01;
			3'b001 : outs = 8'b0001_0X01;
			3'b100 : outs = 8'b0001_0X10;
			3'b101 : outs = 8'b0001_0X10;
			3'b110 : outs = 8'b0001_0X11;
			3'b111 : outs = 8'b0001_0X11;
		endcase
		end

		7'b010_0011 : begin
		case(func3)
			3'b000 : outs = 8'b0010_1X00;
			3'b001 : outs = 8'b0010_1X00;
			3'b010 : outs = 8'b0010_1X00;
		endcase
		end

		7'b011_0011 : begin
		case(func3)
			3'b000  : begin
			case(func7)
				7'b000_0000 : outs = 8'b0;
				7'b010_0000 : outs = 8'b0;
			endcase
			end

			3'b001 : outs = 8'b0;
			3'b010 : outs = 8'b0;
			3'b011 : outs = 8'b0;
			3'b100 : outs = 8'b0;
			3'b101 : begin
			case(func7)
				7'b000_0000 : outs = 8'b0;
				7'b010_0000 : outs = 8'b0;
			endcase
			end

			3'b110  : outs = 8'b0;
			3'b111  : outs = 8'b0;
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
