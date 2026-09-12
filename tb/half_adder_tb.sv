`timescale 1ns/1ps

module half_adder_tb;
    logic x, y, carry, sum;
    logic [1:0] expected;
    int errors = 0;

    half_adder dut (.x(x), .y(y), .carry(carry), .sum(sum));

    initial begin
        $dumpfile("sim/half_adder.vcd");
        $dumpvars(0, half_adder_tb);

        for (int i = 0; i < 4; i++) begin
            {x, y} = i[1:0];
            expected = x + y;
            #10;
            
            if ({carry, sum} !== expected) begin
                $display("FAIL: x=%b y=%b  got carry=%b sum=%b   expected %b", x, y, carry, sum, expected);
                errors++;
            end else begin
                $display("PASS: x=%b y=%b  carry=%b sum=%b", x, y, carry, sum);
            end
        end

        if (errors == 0) $display("=== all tests passed ===");
        else             $display("=== %0d failures ===", errors);
        $finish;
    end

endmodule