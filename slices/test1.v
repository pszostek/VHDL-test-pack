//
// Author: Pawel Szostek (pawel.szostek@cern.ch)
// Date: 01.08.2011

`timescale 1ns/1ps
module main;
    wire [7:0] o1, o2, o3;
    dummy dummy_vhdl(o1, o2, o3);
    
    initial begin
        #10;
        if (o1 != 0 || o2 != 8'b00001000 || o3 != 8'b10000000)
            $display("ERROR!");
        #10;
            $display("PASSED");
        $stop;
    end
endmodule
 