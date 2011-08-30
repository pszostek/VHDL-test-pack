//
// Author: Pawel Szostek (pawel.szostek@cern.ch)
// Date: 01.08.2011

`timescale 1ns/1ps
module xor_vector_v (a_i,b_i,c_o);
    parameter N = 8;
    input [N-1:0] a_i;
    input [N-1:0] b_i;
    output reg [N*N-1:0] c_o;

    generate
        genvar i;
        genvar j;
        for(i=N-1; i>= 0; i=i-1) begin:A
            for(j=N-1; j>=0; j=j-1) begin:B
                assign c_o[N*i+j] = a_i[i] ^ b_i[j];
            end
        end
    endgenerate
endmodule

module stimulus (output reg [7:0] a, b);
    parameter S = 20000;
    int unsigned j,i;
    initial begin
        for(i=0; i<S; i=i+1) begin
            #1;
            a[0] <= inject();
            a[1] <= inject();
            a[2] <= inject();
            a[3] <= inject();
            a[4] <= inject();
            a[5] <= inject();
            a[6] <= inject();
            a[7] <= inject();
            b[0] <= inject();
            b[1] <= inject();
            b[2] <= inject();
            b[3] <= inject();
            b[4] <= inject();
            b[5] <= inject();
            b[6] <= inject();
            b[7] <= inject();
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
    #1;
    if (o_vhdl !== o_verilog) begin
        $display("ERROR!");
        $display("VERILOG_OUTPUT: ", o_verilog);
        $display("VHDL OUTPUT: ", o_vhdl);
        $display("");
       // $stop;
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
    wire [7:0] a,b;
    wire [63:0] o_vhdl, o_verilog;

    stimulus stim(a,b);
    xor_vector_v #(8) x_verilog(a,b, o_verilog);
    xor_vector #(8) x_vhdl(a,b, o_vhdl);
    check #(8) rheck_o(o_verilog, o_vhdl);
    initial begin
        #120000;
        $display("PASSED");
        $stop;
    end
endmodule
 