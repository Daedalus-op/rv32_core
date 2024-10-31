module decoder(
    output logic [6:0]  opcode,      // Opcode field
    output logic [4:0]  rd,          // Destination register
    output logic [2:0]  funct3,      // Funct3 field
    output logic [4:0]  rs1,         // Source register 1
    output logic [4:0]  rs2,         // Source register 2
    output logic [6:0]  funct7,      // Funct7 field (for R-type)
    output logic [11:0] immediate,   // Immediate Value
    input  logic [31:0] instruction  // 32-bit instruction
);
assign opcode=instruction[6:0];
always_comb
    case(opcode)
        7'b0110011:		// R-type
        begin
		rd=instruction[11:7];
		funct3=instruction[14:12];
		rs1=instruction[19:15];
		rs2=instruction[24:20];
		funct7=instruction[31:25];
        end
        7'b0000011: 		// I-type
        begin
		rd=instruction[11:7];
		funct3=instruction[14:12];
		rs1=instruction[19:15];
		immediate=instruction[31:20];
        end
        7'b0010011:		// Load
        begin  
		rd=instruction[11:7];
		funct3=instruction[14:12];
		rs1=instruction[19:15];
		immediate=instruction[31:20];
        end
        7'b0100011:		// S-Type
        begin
		funct3=instruction[14:12];
		rs1=instruction[19:15];
		rs2=instruction[24:20];
		immediate={instruction[31:25],instruction[11:7]};
	end
	7'b1100011:		// B-Type
	begin
		funct3=instruction[14:12];
		rs1=instruction[19:15];
		rs2=instruction[24:20];
		immediate={instruction[31], instruction[7], instruction[30:25],instruction[11:8]};
        end
	7'b:			// U-Type !
	begin
		funct3=instruction[14:12];
		rs1=instruction[19:15];
		rs2=instruction[24:20];
		immediate={instruction[31], instruction[7], instruction[30:25],instruction[11:8]};
        end
	7'b:			// J-Type !
	begin
		funct3=instruction[14:12];
		rs1=instruction[19:15];
		rs2=instruction[24:20];
		immediate={instruction[31], instruction[7], instruction[30:25],instruction[11:8]};
        end
          endcase
endmodule
