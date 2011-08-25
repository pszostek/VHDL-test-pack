//
// Author: Pawel Szostek (pawel.szostek@cern.ch)
// Date: 01.08.2011

`timescale 1ns/1ps
module dummy_v(input clk, input [3:0] in, output reg [15:0] out);
    integer one;
    reg [6:0] a, b, c, d;

    always @(clk) begin
        a[3:0] = in;
        one = 1;
        b = a + one;
        $display("%d %d %d", b, in, a);
        b = a + 1;
        c = a + a;
        c = c - b;
        d = c + 2;
        out[6:0] = d;
        out[15:7] = 0;
    end
endmodule

module check(input clk, [3:0] in, input [15:0] o_vhdl, o_verilog);
    int unsigned ready;
    initial begin
        ready = 0;
        #10;
        ready = 1;
    end;
    always @(clk, in) begin
        if (ready == 0)
            break;
        else if (o_vhdl !== o_verilog) begin
            $display("ERROR!");
            $display("VERILOG: ", o_verilog);
            $display("VHDL: ", o_vhdl);
            $display("IN: ", in);
            $stop;
        end
    end
endmodule

module stimulus (output reg clk, output reg [3:0] in);
    parameter S = 20000;
    int unsigned i,j,k,l;
    initial begin //stimulate data
        clk = 1'b1;
        for (i=0; i<S; i=i+1) begin
            #1;
            clk = ~clk;
        end
    end

    initial begin
        for (j=0; j<S/4; j=j+1) begin
            #4;
            for(k=0; k<4; k=k+1) begin
                in[k] <= inject();
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
    reg clk;
    reg [15:0] o_verilog, o_vhdl;
    reg [3:0] in; 
    dummy   d_vhdl(clk, in, o_vhdl);
    dummy_v d_verilog(clk, in, o_verilog);
    stimulus stim(clk, in);
    check ck(clk, in, o_vhdl, o_verilog);
    initial begin
        #120000;
        $display("PASSED");
        $stop;
    end
endmodule
 