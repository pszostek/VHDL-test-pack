//
// Author: Pawel Szostek (pawel.szostek@cern.ch)
// Date: 01.08.2011

`timescale 1ns/1ps
module mask_v(input [15:0] a, mask, output reg [15:0] b);
    always @(a) begin
        reg [15:0] tmp;
        b = tmp;
        tmp = a;
        tmp = tmp & mask;
        b = tmp;
    end
endmodule

module check(input [15:0] a, mask, o_vhdl, o_verilog);
    int unsigned ready;
    initial begin
        ready = 0;
        #10;
        ready = 1;
    end;
    always @(a or mask) begin
        if (ready == 0)
            break;
        else if (o_vhdl !== o_verilog) begin
            $display("ERROR!");
            $display("VERILOG: ", o_verilog);
            $display("VHDL: ", o_vhdl);
            $display("MASK: ", mask);
            $display("A: ", a);
            $stop;
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
                b[k] <= inject();
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
    reg [15:0] a, mask;
    reg [15:0] o_vhdl, o_verilog;
    mask   d_vhdl(a, mask, o_vhdl);
    mask_v d_verilog(a, mask, o_verilog);
    stimulus stim(a, mask);
    check ck(a, mask, o_vhdl, o_verilog);
    initial begin
        #120000;
        $display("PASSED");
        $stop;
    end
endmodule
 