module Branch(
	output logic confirm,
	input logic [2:0] func3,
	input logic [6:0] opcode,
	input logic [31:0] AluOut,
	input logic zero
	);
	always_comb begin
		if (opcode == 7'b110_0011) begin
			case(func3) 
				3'b000 : assign confirm = zero; // beq 
				3'b001 : assign confirm = !zero; // bne 
				3'b100 : assign confirm = (!zero) & (AluOut < 0); // blt 
				3'b101 : assign confirm = (AluOut > 0); // bge 
				3'b110 : assign confirm = (!zero) & (AluOut < 0); // bltu
				3'b111 : assign confirm = (AluOut < 0); // bgeu
			endcase
		end
	end
endmodule
