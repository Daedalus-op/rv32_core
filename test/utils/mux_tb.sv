module test;
  parameter N_SEL = 2;
  parameter WIDTH = 32;
  logic [WIDTH-1:0] out;
  logic [N_SEL-1:0] sel;
  logic [WIDTH-1:0] d_in [2^N_SEL-1:0];
  
  muxr #(N_SEL,WIDTH) du(out, sel, d_in);
  
  initial begin
    d_in[0] = $urandom;
    d_in[1] = $urandom;
    $strobe("din [0]:- %0d", d_in[0]);
    $strobe("din [1]:- %0d", d_in[1]);

    #1;
    sel = 0;
    $display("out [0] = %0d", d_in[sel]);
    
    
    #1;
    sel = 1;
    $display("out [1] = %0d", d_in[sel]);
    
  end
endmodule
