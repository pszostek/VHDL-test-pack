//
// Author: Pawel Szostek (pawel.szostek@cern.ch)
// Date: 01.08.2011

`timescale 1ns/1ps
module count_ones_v(input [15:0] vec, output reg [4:0] count);
    integer i;
    integer results;
    parameter LEN = 15;
    always @(vec) begin
        result = 0;
        for (i=0; i<=LEN; i=i+1) begin
            if(vec[i] == 1'b0)
                continue; 
            else
                result = result + 1;
        end
        count = result;
    end
endmodule

module check(input [15:0] a, [4:0] o_vhdl, o_verilog);
    reg ena;
initial begin
    ena = 0;
    #10;
    ena = 1;
end
always @(a)begin
    if (ena == 0) begin end
    else if (o_vhdl !== o_verilog) begin
        $display("ERROR!");
        $display("VERILOG: ", o_verilog);
        $display("VHDL: ", o_vhdl);
    end
end
endmodule

module stimulus (output reg [15:0] a);
    parameter S = 20000;
    int unsigned i,j,k,l;
    initial begin //stimulate data
        for (i=0; i<S; i=i+1) begin
            #5;
            for(k=0; k<16; k=k+1) begin
                a[k] <= inject();
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
    reg [15:0] a;
    reg [4:0] o_vhdl, o_verilog;

    count_ones_v c_vhdl(a,o_verilog);
    count_ones   c_verilog(a,o_vhdl);
    stimulus stim(a);
    check c(a,o_vhdl, o_verilog);

    initial begin
        #120000;
        $display("PASSED");
    end
    
endmodule
 