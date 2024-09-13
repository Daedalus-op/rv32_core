/****** alu.sv ******/
module hello(input clk);

logic [1:0] cnt;

assign cnt = 1'b1;

//always_ff@(posedge clk) begin
//	cnt <= cnt + 1;
// end

initial begin
	$display("hello!!! %0b %0b", clk, cnt);
end
endmodule;
