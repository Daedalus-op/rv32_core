module top;
  parameter N = 32;
  logic [N - 1:0] a,b;
  logic [N - 1:0] s;
  bit        ovf;
  bit clk;
  always #50 clk = ~clk;

  rca_add #(32) a1 (a, b, s, ovf);   // Sample 4-1
  add_tb t1 (clk, a, b, s, ovf);  // Sample 4-2
endmodule