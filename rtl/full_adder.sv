module full_adder (
    input logic x,
    input logic y,
    input logic cin,
    output logic cout,
    output logic sum
);
    logic not_x, not_y, not_cin;
    assign not_x = ~x;
    assign not_y = ~y;
    assign not_cin = ~cin;

    assign cout = (x&y) | (cin&y) | (cin&x);
    assign sum = (cin&not_x&not_y) | (cin&x&y) | (not_cin&not_x&y) | (not_cin&x&not_y);
endmodule