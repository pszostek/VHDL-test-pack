//
// Author: Pawel Szostek (pawel.szostek@cern.ch)
// Date: 01.08.2011

`timescale 1ns/1ps
module main;
    wire [15:0] o1 [15:0];
    wire o;
    dummy dummy_vhdl(o1);
    
    initial begin
        $display("ERROR");
        //I was unable to connect properly output of "dummy"
        //Modelsim complains about being invalid as a Verilog connection
        $stop;
    end
endmodule
