//
// Author: Pawel Szostek (pawel.szostek@cern.ch)
// Date: 01.08.2011

`timescale 1ns/1ps
module bin2gray_v(input [7:0] a, input strobe, output reg [7:0] b);
    function [7:0] bin2gray(input [7:0] a);
        integer i;
        reg [7:0] temp;
        begin
            temp[7] = a[7];
            for (i=6; i>=0; i=i-1) begin
                temp[i] = a[i+1] ^ a[i];
            end
            bin2gray = temp;
        end
    endfunction
    
    always @(strobe, a) begin
        if (strobe == 1'b1)
            b = bin2gray(a);
    end
endmodule

module check(input [7:0] a, o_vhdl, o_verilog, input strobe);
    int unsigned ready;
    initial begin
        ready = 0;
        #10;
        ready = 1;
    end;
    always @(a, strobe) begin
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

module stimulus (output reg [7:0] a, output reg strobe);
    parameter S = 20000;
    int unsigned i,j,k,l;
    initial begin //stimulate data
        for (i=0; i<S; i=i+1) begin
            #3;
            for(k=0; k<8; k=k+1) begin
                a[k] <= inject();
            end
            #1;
            strobe = 1'b1;
            #1;
            strobe = 1'b0;
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
    reg [7:0] a;
    reg [7:0] o_vhdl, o_verilog;
    reg strobe;
    bin2gray   b_vhdl(a, strobe, o_vhdl);
    bin2gray_v b_verilog(a, strobe, o_verilog);
    stimulus stim(a, strobe);
    check ck(a, o_vhdl, o_verilog, strobe);
    initial begin
        #120000;
        $display("PASSED");
        $stop;
    end
endmodule
 