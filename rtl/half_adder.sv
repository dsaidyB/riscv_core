module half_adder(
    input logic x,
    input logic y,
    output logic carry,
    output logic sum
);
    assign carry = x & y;
    assign sum = (x&(~y)) | ((~x)&y);
endmodule