//
// Author: Pawel Szostek (pawel.szostek@cern.ch)
// Date: 01.08.2011

`timescale 1ns/1ps
parameter N = 8;
module adder4_v (input [3:0] a,b, input cin, output reg [3:0] sum, output reg cout);
    wire [N:0] c;
    wire [N-1:0] ab;
    wire [N-1:0] ac;
    wire [N-1:0] bc;
    task full_adder(input a,b,c, output sum, cout);
        begin
        sum = a ^ b ^ c;
        cout = (a & b) | (a & c) | (b & c);
        end
    endtask

    always @(a,b,cin)
    begin
        reg [3:0] result;
        reg carry;
        full_adder(a[0], b[0], cin, result[0], carry);
        full_adder(a[1], b[1], carry, result[1], carry);
        full_adder(a[2], b[2], carry, result[2], carry);
        full_adder(a[3], b[3], carry, result[3], carry);
        sum = result;
        cout = carry;
    end
endmodule

module stimulus (output reg [3:0] a, b);
    parameter S = 20000;
    int unsigned j,i;
    initial begin
        for(i=0; i<S; i=i+1) begin
            #1;
            a[0] <= inject();
            a[1] <= inject();
            a[2] <= inject();
            a[3] <= inject();
            b[0] <= inject();
            b[1] <= inject();
            b[2] <= inject();
            b[3] <= inject();
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
        
module check(input [3:0] o_verilog, o_vhdl, input cout_verilog, cout_vhdl);

always @(o_verilog, o_vhdl) begin
    #1;
    if (o_vhdl !== o_verilog || cout_verilog !== cout_vhdl) begin
        $display("ERROR!");
        $display("VHDL_OUTPUT: ", o_vhdl);
        $display("VHDL_COUT: ", cout_vhdl);
        $display("VERILOG_OUTPUT: ", o_verilog);
        $display("VERILOG_COUT: ", cout_verilog);
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
    wire [3:0] a,b, o_vhdl, o_verilog;
    wire cout_vhdl, cout_verilog;

    stimulus stim(a,b);
    adder4_v ripple_vl(a,b, 1'b0, o_verilog, cout_verilog);
    adder4 ripple_vhdl(a,b,1'b0, o_vhdl, cout_vhdl);
    check check_o(o_verilog, o_vhdl, cout_verilog, cout_vhdl);
    initial begin
        #120000;
        $display("PASSED");
        $stop;
    end
endmodule
 