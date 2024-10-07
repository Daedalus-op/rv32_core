module mux #(
	parameter N_SEL = 2, WIDTH = 32
	)(
	output logic [WIDTH-1:0] out,
	input logic [N_sel-1:0] sel,
	input logic [WIDTH-1:0] d_in [2^N_SEL-1:0]
	);

	always_comb begin
		out = d_in[sel];
	end
endmodule
