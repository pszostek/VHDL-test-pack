//
// Author: Pawel Szostek (pawel.szostek@cern.ch)
// Date: 01.08.2011

`timescale 1ns/1ps

module test_dff_v (clk, d, q);
parameter g_count = 1;
input [g_count-1:0] d;
input clk;
output reg [g_count-1:0] q;
    genvar i;
  generate
    for(i=0; i<=g_count-1; i=i+1) begin:REG
        always @ (posedge clk)
            q[i] <= d[i];
        end
  endgenerate
endmodule

module stimulus (output reg [15:0] d, output reg clk);
    parameter S = 20000;
    int unsigned j,i;
    initial begin
        clk <= 0;
        for (i=0; i<S; i=i+1) begin
            #1;
            clk <= ~clk;
        end
    end
    initial begin
        for (i=0; i<S; i=i+1) begin
            #3;
            for(j=0; j<=15; j=j+1) begin
                d[j] <= inject();
            end
        end
    end
    function inject();
        reg ret;
        reg [3:0] temp;
        temp[3:0] = $random % 16;
        begin
            if(temp >= 10)
                ret = 1'b1;
            else if(temp >= 4)
                ret = 1'b0;
            else if(temp >= 2)
                ret = 1'bx;
            else
                ret = 1'b0;
            inject = ret;
        end
    endfunction
endmodule
        
module check(input [3:0] o_verilog, o_vhdl);

always @(o_verilog, o_vhdl) begin
    #1;
    if (o_vhdl !== o_verilog) begin
        $display("ERROR!");
        $display("VHDL_OUTPUT: ", o_vhdl);
        $display("VERILOG_OUTPUT: ", o_verilog);
        $display("");
        $stop;
    end else begin
   /*     $display("OK!");
        $display("VHDL_OUTPUT: ", o_vhdl);
        $display("VERILOG_OUTPUT: ", o_verilog);
        $display("");
     */   
    end
end
endmodule

module main;
    wire  clk;
    wire [15:0] d, o_verilog, o_vhdl;

    stimulus stim(d, clk);
    test_dff #(16)   reg_vhdl(clk,d,o_vhdl);
    test_dff_v #(16) reg_vl(clk,d,o_verilog);
    check check(o_verilog, o_vhdl);
    initial begin
        #120000;
        $display("PASSED");
        $stop;
    end
endmodule
 