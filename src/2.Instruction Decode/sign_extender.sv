
module sign_extend(
        output logic [31:0]imm,
        input logic [31:0] instruction
    );
assign opcode=instruction[6:0];
always_comb
    case(opcode)
        7'b0110011:                //this is for R type
            begin
                imm[31:0]=31'b0;
             end
        7'b00000011 :        // this is for load 
         begin  
           imm[31:0]={{20{instruction[31]}}, instruction[31:20]};
         end
         7'b0010011: begin //I Type 
           imm[31:0]={{20{instruction[31]}}, instruction[31:20]};
         end 
        7'b0100011:
        begin     // store
         imm[31:0]={{20{instruction[31]}}, instruction[31:25],instruction[11:7]};
        end
        7'b1100011:
        begin              
         imm[31:0]={{20{instruction[31]}},instruction[7], instruction[30:25],instruction[11:8]};
        end      
          endcase
endmodule
