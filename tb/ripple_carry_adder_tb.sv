`timescale 1ns/1ps

module ripple_carry_adder_tb;

  logic [31:0] a, b, sum;
  logic        cin, cout;
  logic [32:0] expected;
  int          errors = 0;

  ripple_carry_adder #(.N(32)) dut (
    .a    (a),
    .b    (b),
    .cin  (cin),
    .sum  (sum),
    .cout (cout)
  );

  // drive one case, wait, predict, compare
  task check(input logic [31:0] ta, tb, input logic tc);
    a = ta; b = tb; cin = tc;
    #10;
    expected = {1'b0, ta} + {1'b0, tb} + tc;
    if ({cout, sum} !== expected) begin
      $display("FAIL: %h + %h + %b -> %b_%h, expected %h",
               ta, tb, tc, cout, sum, expected);
      errors++;
    end
  endtask

  initial begin
    // waveforms only when run with +dump
    if ($test$plusargs("dump")) begin
      $dumpfile("sim/ripple_carry_adder_tb.vcd");
      $dumpvars(0, ripple_carry_adder_tb);
    end

    // --- directed corner cases (always run) ---
    check(32'h0000_0000, 32'h0000_0000, 1'b0);  // zero
    check(32'h0000_0000, 32'h0000_0000, 1'b1);  // cin only
    check(32'hFFFF_FFFF, 32'h0000_0001, 1'b0);  // ripple through all 32 stages
    check(32'hFFFF_FFFF, 32'h0000_0000, 1'b1);  // same ripple, via cin
    check(32'hFFFF_FFFF, 32'hFFFF_FFFF, 1'b1);  // max everything
    check(32'h7FFF_FFFF, 32'h0000_0001, 1'b0);  // signed overflow boundary
    check(32'h8000_0000, 32'h8000_0000, 1'b0);  // carry out of MSB only
    check(32'h5555_5555, 32'hAAAA_AAAA, 1'b0);  // alternating, no carries
    check(32'h5555_5555, 32'hAAAA_AAAA, 1'b1);  // alternating, one carry in
    $display("directed cases done");

    // --- random layers, skipped when dumping ---
    if (!$test$plusargs("dump")) begin
      repeat (10_000)
        check($urandom_range(0, 255), $urandom_range(0, 255), $urandom_range(0, 1));
      repeat (100_000)
        check($urandom(), $urandom(), $urandom_range(0, 1));
    end

    if (errors == 0) $display("=== all cases passed ===");
    else             $display("=== %0d failures ===", errors);

    $finish;
  end

endmodule