//
// Author: Pawel Szostek (pawel.szostek@cern.ch)
// Date: 01.08.2011

`timescale 1ns/1ps

module  reg_bank_vl ( input[3:0] d , input clk, reset, output reg [3:0] q);

  always @ (negedge reset or posedge clk)
  begin
    if(reset == 1'b0)
        q <= 4'b0000;
    else 
        q <= d;
  end

endmodule

module stimulus (output reg [3:0] d, output reg clk, reset);
    parameter S = 20000;
    int unsigned i;
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
            d <= inject();
        end
    end
    initial begin
        for (i=0; i<S; i=i+1) begin
            #23;
            reset <= inject();
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
    wire  clk, reset;
    wire [3:0] d, o_verilog, o_vhdl;

    stimulus stim(d, clk, reset);
    reg_bank_vhdl reg_vhdl(d,clk,reset,o_vhdl);
    reg_bank_vl   reg_vl(d,clk,reset,o_verilog);
    check check(o_verilog, o_vhdl);
    initial begin
        #120000;
        $display("PASSED");
        $stop;
    end
endmodule
 