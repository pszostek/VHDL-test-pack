//
// Author: Pawel Szostek (pawel.szostek@cern.ch)
// Date: 01.08.2011

`timescale 1ns/1ps
module equal_v(input [15:0] a, b, output reg out);
    assign out = (a == b ? 1 : 0);
endmodule

module check(input [15:0] a, b, input o_vhdl, o_verilog);
    int unsigned ready;
    initial begin
        ready = 0;
        #10;
        ready = 1;
    end;
    always @(a) begin
        if (ready == 0)
            break;
        else if (o_vhdl !== o_verilog) begin
            $display("ERROR!");
            $display("VERILOG: ", o_verilog);
            $display("VHDL: ", o_vhdl);
            //$stop;
        end
    end
endmodule

module stimulus (output reg [15:0] a,b);
    parameter S = 20000;
    int unsigned i,j,k,l;
    initial begin //stimulate data
        for (i=0; i<S; i=i+1) begin
            #5;
            for(k=0; k<16; k=k+1) begin
                a[k] <= inject();
            end
            for(j=0; j<16; j=j+1) begin
                b[j] <= inject();
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
    reg [15:0] a,b;
    reg o_vhdl, o_verilog;
    equal   e_vhdl(a,b, o_vhdl);
    equal_v e_verilog(a,b, o_verilog);
    stimulus stim(a,b);
    check c(a,b,o_vhdl, o_verilog);
    initial begin
        #120000;
        $display("PASSED");
        $stop;
    end
endmodule
 