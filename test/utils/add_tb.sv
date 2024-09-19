program add_tb #(parameter N = 32)
  (
    input bit clk,
    output logic [N-1:0] a, b,
    input logic [N-1:0] s,
    input bit ovf
  );

  initial begin
//    $dumpfile("./outputs/play.vcd");
//    $dumpvars(0, add_tb);

// ------------------------------------------------------
    @(posedge clk);
    a <= 32'd0;
    b <= 'd0;
    @(posedge clk);
    if(s == (a + b))
      $display("Matched %d + %d = %d with carry = %d", $signed(a), $signed(b), $signed(s), $signed(ovf));
    else
      $display("Error %d + %d = %d with carry = %d", $signed(a), $signed(b), $signed(s), $signed(ovf));
// ------------------------------------------------------
    @(posedge clk);
    a <= 'd12;
    b <= 'd32;
    @(posedge clk);
    if(s == (a + b))
      $display("Matched %d + %d = %d with carry = %d", $signed(a), $signed(b), $signed(s), $signed(ovf));
    else
      $display("Error %d + %d = %d with carry = %d", $signed(a), $signed(b), $signed(s), $signed(ovf));
// ------------------------------------------------------
    @(posedge clk);
    a <= 'd90;
    b <= 'd9;
    @(posedge clk);
    if(s == (a + b))
      $display("Matched %d + %d = %d with carry = %d", $signed(a), $signed(b), $signed(s), $signed(ovf));
    else
      $display("Error %d + %d = %d with carry = %d", $signed(a), $signed(b), $signed(s), $signed(ovf));
// ------------------------------------------------------
    @(posedge clk);
    a <= -'d93;
    b <= 'd70;
    @(posedge clk);
    if(s == (a + b))
      $display("Matched %d + %d = %d with carry = %d", $signed(a), $signed(b), $signed(s), $signed(ovf));
    else
      $display("Error %d + %d = %d with carry = %d", $signed(a), $signed(b), $signed(s), $signed(ovf));
// ------------------------------------------------------

/*
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
*/
    $finish();

  end
endprogram