//
// Author: Pawel Szostek (pawel.szostek@cern.ch)
// Date: 01.08.2011

`timescale 1ns/1ps

module  cnt_v (clk, ena, reset, counter_o);
  input clk;
  input ena;
  input reset;
  output reg [7:0] counter_o;

  always @(posedge clk) begin
    if(reset == 1'b1)
        counter_o <= 8'b00000000;
    else
        if(ena == 1'b1)
            counter_o <= counter_o +1;
  end

endmodule

module stimulus (output reg clk, ena, reset);
    parameter S = 2000;
    int unsigned i,j,k;
    initial begin
        reset <= 1'b1;
        #10
        for(i=0; i<S/122; i=i+1) begin
            reset <= 1'b0;
            #121;
            reset <= 1'b1;
            #1;
        end
    end
        
    initial begin
        clk <= 1'b0;
        for(j=0; j<S; j=j+1) begin
            #1;
            clk <= ~clk;
        end
    end

    initial begin
        ena <= 1'b0;
        #20;
        for(k=0; k<S/5; k=k+1) begin
            #4;
            ena <= 1'b1;
            #1;
            ena <= 1'b0;
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
        
module check(input clk, ena, reset, input [7:0] o_verilog, o_vhdl);

always @(clk, ena, reset) begin
    if (o_vhdl !== o_verilog) begin
        $display("ERROR!");
        $display("VHDL_OUTPUT: ", o_vhdl);
        $display("VERILOG_OUTPUT: ", o_verilog);
        $display("");
        //$stop;
    end
end
endmodule

module main;
    wire clk, ena, reset;
    reg [7:0] o_verilog, o_vhdl;

    stimulus stim(clk, ena, reset);
    cnt_v c_v(clk, ena, reset, o_verilog);
    cnt c_vhdl(clk, ena, reset, o_vhdl);
    check check(clk, ena, reset, o_verilog, o_vhdl);
    initial begin
        #120000;
        $display("PASSED");
        $stop;
    end
endmodule
 