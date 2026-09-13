`timescale 1ns/1ps

module full_adder_tb;
    logic x, y, cin, cout, sum;
    logic [1:0] expected;
    int errors = 0;

    full_adder dut (.x(x), .y(y), .cin(cin), .cout(cout), .sum(sum));

    initial begin
        $dumpfile("sim/full_adder.vcd");
        $dumpvars(0, full_adder_tb);

        for (int i = 0; i < 8; i++) begin
            {cin, x, y} = i[2:0];
            expected = cin + x + y;
            #10;
            
            if ({cout, sum} !== expected) begin
                $display("FAIL: x=%b y=%b cin=%b got cout=%b sum=%b   expected %b", x, y, cin, cout, sum, expected);
                errors++;
            end else begin
                $display("PASS: x=%b y=%b cin=%b  cout=%b sum=%b", x, y, cin, cout, sum);
            end
        end

        if (errors == 0) $display("=== all tests passed ===");
        else             $display("=== %0d failures ===", errors);
        $finish;
    end

endmodule