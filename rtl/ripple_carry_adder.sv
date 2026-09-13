module ripple_carry_adder #(
  parameter int N = 4
)(
  input  logic [N-1:0] a,
  input  logic [N-1:0] b,
  input  logic         cin, // this can be reused for subtract command where i invert then add 1 (2's complements)
  output logic [N-1:0] sum,
  output logic         cout
);
  logic [N:0] c;

  assign c[0] = cin;

  genvar i;
  generate
    for (i = 0; i < N; i++) begin : adder_loop
      full_adder fa (
        .x         (a[i]),
        .y         (b[i]),
        .cin       (c[i]),
        .sum       (sum[i]),
        .cout      (c[i+1])
      );
    end
  endgenerate

  assign cout = c[N];
endmodule