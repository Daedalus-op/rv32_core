
module sign_extend(
        output logic [31:0]imm_out,
        input logic [11:0] imm_in,
	input logic [6:0] opcode
    );
always_comb
    case(opcode)
        7'b0110011:                //this is for R type
            begin
                imm_out[31:0]=31'b0;
             end
        7'b00000011 :        // this is for load 
         begin  
           imm_out[31:0]={{20{imm_in[11]}}, imm_in};
         end
         7'b0010011: begin //I Type 
           imm_out[31:0]={{20{imm_in[11]}}, imm_in};
         end 
        7'b0100011:
        begin     // store
         imm_out[31:0]={{20{imm_in[11]}}, imm_in};
        end
        7'b1100011:
        begin              
         imm_out[31:0]={{20{imm_in[11]}},imm_in};
        end      
          endcase
endmodule
