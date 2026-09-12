`timescale 1ns/1ps

module xor_tb;
  logic a, b, y;
  int errors = 0;

  xor_gate dut (.a(a), .b(b), .y(y));

  initial begin
    $dumpfile("sim/xor.vcd");
    $dumpvars(0, xor_tb);

    for (int i = 0; i < 4; i++) begin
      {a, b} = i[1:0];
      #10;
      if (y !== (a ^ b)) begin
        $display("FAIL: a=%b b=%b  got y=%b  expected %b", a, b, y, a ^ b);
        errors++;
      end else begin
        $display("PASS: a=%b b=%b  y=%b", a, b, y);
      end
    end

    if (errors == 0) $display("=== all tests passed ===");
    else             $display("=== %0d failures ===", errors);
    $finish;
  end
endmodule
