module xor_gate (
  input  logic a,
  input  logic b,
  output logic y
);
  logic not_a, not_b;
  logic term1, term2;

  assign not_a = ~a;
  assign not_b = ~b;
  assign term1 = a & not_b;
  assign term2 = not_a & b;
  assign y     = term1 | term2;
endmodule
