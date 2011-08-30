//
// Author: Pawel Szostek (pawel.szostek@cern.ch)
// Date: 01.08.2011

`timescale 1ns/1ps
module sel_v (a_i, b_o, sel);
    parameter N = 8;
    input [N-1:0] a_i;
    output reg [N-1:0] b_o;
    input sel;

    reg [N-1:0] mix;
    generate
        genvar i;
        for(i=N-1; i>=0; i=i-1) begin:L1
            if(i % 2 == 1'b0)
                assign mix[i] = 1'b0;
            if(i % 2 == 1'b1)
                assign mix[i] = 1'b1;
        end
    endgenerate
    generate
        genvar j;
        for(j=N-1; j>=0; j=j-1) begin:L2
            assign b_o[j] = ( sel == 1? a_i[j] : mix[j] );
        end
    endgenerate
endmodule

module stimulus (output reg [7:0] a, output reg sel);
    parameter S = 20000;
    int unsigned j,i;
    initial begin
    #1;
        for(i=0; i<S; i=i+1) begin
            #2;
            a[0] <= inject();
            a[1] <= inject();
            a[2] <= inject();
            a[3] <= inject();
            a[4] <= inject();
            a[5] <= inject();
            a[6] <= inject();
            a[7] <= inject();
        end
    end
    initial begin
        for(i=0; i<S; i=i+1) begin
            #2;
            sel <= inject();
        end
    end
            
    function inject();
        reg ret;
        reg unsigned [3:0] temp;
        temp[3:0] = $random % 16;
        begin
            if(temp >= 10)
                ret = 1'b1;
            else
                ret = 1'b0;
          /*  else if(temp >= 4)
                ret = 1'b0;
            else if(temp >= 2)
                ret = 1'bx;
            else
                ret = 1'b0;*/
            inject = ret;
        end
    endfunction
endmodule
        
module check(input o_verilog, o_vhdl);
    parameter N = 8;
    input [N*N-1:0] o_verilog;
    input [N*N-1:0] o_vhdl;

always @(o_verilog, o_vhdl) begin
    #4;
    if (o_vhdl !== o_verilog) begin
        $display("ERROR!");
        $display("VERILOG_OUTPUT: ", o_verilog);
        $display("VHDL OUTPUT: ", o_vhdl);
        $display("");
        $stop;
    end
end
endmodule

module main;
    wire [7:0] a;
    wire [7:0] o_vhdl, o_verilog;
    wire sel;

    stimulus stim(a,sel);
    sel #(8) s_vhdl(a, o_vhdl, sel);
    sel_v #(8) s_verilog(a, o_verilog, sel);
    check #(8) check_o(o_verilog, o_vhdl);
    initial begin
        #120000;
        $display("PASSED");
        $stop;
    end
endmodule
 