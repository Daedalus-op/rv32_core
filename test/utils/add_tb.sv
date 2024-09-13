`include "cla_add.v"
`include "rca_add.v"

module add_tb;
  parameter N = 32;
  reg [N-1:0] a, b;
  wire [N-1:0] s;
  wire ovf;
  cla_add #(N) uut (
      a,
      b,
      s,
      ovf
  );

  initial begin
    $dumpfile("./outputs/play.vcd");
    $dumpvars(0, add_tb);

    a = 'd0;
    b = 'd0;
    #10;
    $display("%d + %d = %d , %b", $signed(a), $signed(b), $signed(s), ovf);
    a = 'd32;
    b = 'd61;
    #10;
    $display("%d + %d = %d , %b", $signed(a), $signed(b), $signed(s), ovf);
    a = 'd90;
    b = 'd59;
    #10;
    $display("%d + %d = %d , %b", $signed(a), $signed(b), $signed(s), ovf);
    a = 'd5;
    b = -'d100;
    #10;
    $display("%d + %d = %d , %b", $signed(a), $signed(b), $signed(s), ovf);
    a = 'hffff_ffff;
    b = 'd122;
    #10;
    $display("%d + %d = %d , %b", $signed(a), $signed(b), $signed(s), ovf);

    #10;
    $finish();

  end
endmodule
