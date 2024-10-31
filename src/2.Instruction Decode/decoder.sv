module decoder(
    output logic [6:0]  opcode,      // Opcode field
    output logic [4:0]  rd,          // Destination register
    output logic [2:0]  funct3,      // Funct3 field
    output logic [4:0]  rs1,         // Source register 1
    output logic [4:0]  rs2,         // Source register 2
    output logic [6:0]  funct7,      // Funct7 field (for R-type)
    output logic [19:0] immediate,   // Immediate Value
    input  logic [31:0] instruction  // 32-bit instruction
);
assign opcode=instruction[6:0];
assign immediate=20'b0;
always_comb
    case(opcode)
        7'b0110011:                //this is for R type
            begin
                 rd=instruction[11:7];
                 funct3=instruction[14:12];
                 rs1=instruction[19:15];
                 rs2=instruction[24:20];
                 funct7=instruction[31:25];
             end
        7'b00000011 || 7'b0010011:        // this is for load and I Type , doubt for shift
         begin  
                 rd=instruction[11:7];
                 funct3=instruction[14:12];
                 rs1=instruction[19:15];         
         end
        7'b0100011:
        begin     // store
         funct3=instruction[14:12];
         rs1=instruction[19:15];
         rs2=instruction[24:20];
	 immediate={instruction[31:25],instruction[11:7]};
        end
        7'b1100011:
        begin              
                 funct3=instruction[14:12];
                 rs1=instruction[19:15];
                 rs2=instruction[24:20];
		 immediate={instruction[7], instruction[30:25],instruction[11:8]};
        end      
        7'b0110111||7'b0010111:
        begin
               rd=instruction[11:7];
               immediate=instruction[31:12];
        end
        7'b1101111||7'b1100111:
        begin 
                       rd=instruction[11:7];
	 immediate={instruction[20], instruction[10:1],instruction[1],instruction[19:12]};
        end 
          endcase
endmodule
