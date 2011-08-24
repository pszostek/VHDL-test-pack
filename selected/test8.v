//
// Author: Pawel Szostek (pawel.szostek@cern.ch)
// Date: 01.08.2011

`timescale 1ns/1ps
module dummy_v(input [2:0] a, b, c, d, output reg out);
    wire c1, c2;
    assign c1 = a == b;
    assign c2 = c == d;
    assign out = c1 == c2;
endmodule

module check(input [2:0] a, b, c, d, input o_vhdl, o_verilog);
    int unsigned ready;
    initial begin
        ready = 0;
        #10;
        ready = 1;
    end;
    always @(a, b, c, d) begin
        if (ready == 0)
            break;
        else if (o_vhdl !== o_verilog) begin
            $display("ERROR!");
            $display("VERILOG: ", o_verilog);
            $display("VHDL: ", o_vhdl);
            $stop;
        end
    end
endmodule

module stimulus (output reg [2:0] a,b,c,d);
    parameter S = 20000;
    int unsigned i,j,k,l;
    initial begin //stimulate data
        for (i=0; i<S; i=i+1) begin
            #5;
            for(k=0; k<3; k=k+1) begin
                a[k] <= inject();
                b[k] <= inject();
                c[k] <= inject();
                d[k] <= inject();
            end
        end
    end

    function inject();
        reg [3:0] temp;
        begin
            temp = $random % 16;
            if(temp >= 10)
                inject = 1'b1;
            else
                inject = 1'b0;
        end
    endfunction
endmodule

module main;
    reg [2:0] a,b,c,d;
    reg o_vhdl, o_verilog;
    dummy   d_vhdl(a,b,c,d, o_vhdl);
    dummy_v d_verilog(a,b,c,d, o_verilog);
    stimulus stim(a,b,c,d);
    check ck(a,b,c,d,o_vhdl, o_verilog);
    initial begin
        #120000;
        $display("PASSED");
        $stop;
    end
endmodule
 