//
// Author: Pawel Szostek (pawel.szostek@cern.ch)
// Date: 01.08.2011

`timescale 1ns/1ps

module stimulus (output reg [7:0] a);
    parameter S = 20000;
    int unsigned j,i;
    initial begin
        for(i=0; i<S; i=i+1) begin
            #10;
            a[7] <= inject();
            a[6] <= inject();
            a[5] <= inject();
            a[4] <= inject();
            a[3] <= inject();
            a[2] <= inject();
            a[1] <= inject();
            a[0] <= inject();
        end
    end
    function inject();
        reg ret;
        reg unsigned [3:0] temp;
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
module main;
    wire [7:0] i,o;
    dummy dummy_vhdl(i,o);
    stimulus stim(i)
    
    initial begin
        #10;
        if (o1 != 0 || o2 != 8'b00001000 || o3 != 8'b10000000)
            $display("ERROR!");
        #10;
            $display("PASSED");
        $stop;
    end
endmodule
 