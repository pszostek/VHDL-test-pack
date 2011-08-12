//
// Author: Pawel Szostek (pawel.szostek@cern.ch)
// Date: 01.08.2011

`timescale 1ns/1ps

module stimulus (output reg [7:0] out);
    parameter S = 20000;
    int unsigned j,i;
    initial begin
        for(i=0; i<S; i=i+1) begin
            #1;
            out[0] <= inject();
            out[1] <= inject();
            out[2] <= inject();
            out[3] <= inject();
            out[4] <= inject();
            out[5] <= inject();
            out[6] <= inject();
            out[7] <= inject();
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
        
module check(input [7:0] o_verilog, o_vhdl);

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
    wire [7:0] d, o_verilog, o_vhdl;

    generate
    genvar i;
    for(i=7;i>=0;i=i-1) begin:DUPA
       assign o_verilog[i] = d[7-i];
    end
    endgenerate
    stimulus stim(d);
    inverter dummy_vhdl(d,o_vhdl);
    check check(o_verilog, o_vhdl);
    initial begin
        #120000;
        $display("PASSED");
        $stop;
    end
endmodule
 