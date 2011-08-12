//
// Author: Pawel Szostek (pawel.szostek@cern.ch)
// Date: 01.08.2011
`timescale 1ns/1ps
module  flip_flop_vl ( input d, clk, reset, output reg q );
  parameter SYNC = 1;
  generate
  if (SYNC == 0)
      begin : asynchronous
        always @(posedge clk or posedge reset)
        begin
            if(reset == 1)
                q <= 1'b0;
            else 
                q <= d;
        end
      end
  else
      begin : synchronous
        always @(posedge clk)
        begin
            if(reset == 1)
                q <= 1'b0;
            else
                q <= d;
        end
      end
  endgenerate
endmodule

module stimulus (output reg d, clk, reset);
    parameter S = 20000;
    reg unsigned [3:0] temp1, temp3;
    int unsigned i,j,k;
    initial begin
        reset <= 1'b1;
        #1;
        reset <= 1'b0;
    end
    initial begin //stimulate data 
        for (i=0; i<S/3; i=i+1) begin
         #5 d <= inject();
        end
    end

    initial begin //stimulate clock
        clk = 0;
        for(j=0; j<S; j=j+1) begin
            #3 clk = ~clk;
        end
    end

    initial begin //stimulate reset
        for (k=0; k<S/101; k=k+1) begin
            #11 reset <= inject();
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

module check(input vhdl, verilog, clk, reset);

always @(clk or reset) begin
    #1; //don't look at peaks
    if (vhdl !== verilog) begin
        $display("ERROR!");
        $display("VERILOG: ", verilog);
        $display("VHDL: ", vhdl);
        $display("CLK: ", clk);
        $display("RST: ", reset);
        $display("");
        $stop;
    /*end else begin
        $display("OK!");
        $display("VERILOG_CNT: ", verilog);
        $display("VHDL_CNT: ", vhdl);
        $display("ENA: ", ena);
        $display("CLK: ", clk);
        $display("RST: ", reset);
        $display("");
    */end
end
endmodule

module main;
    wire d, clk, reset;
    wire sync_vhdl, sync_vl, async_vhdl, async_vl;
    stimulus stim(d, clk, reset);
    flip_flop #(1) ff_sync_vhdl(d, clk, reset, sync_vhdl);
    flip_flop #(0) ff_async_vhdl(d, clk, reset, async_vhdl);
    flip_flop_vl #(1) ff_sync_vl(d, clk, reset, sync_vl);
    flip_flop_vl #(0) ff_async_vl(d, clk, reset, async_vl);
    
    check check_sync(sync_vhdl, sync_vl, clk, reset);
    check check_async(async_vhdl, async_vl, clk, reset);

    initial begin
        #120000;
        $display("PASSED");
        $stop;
    end
endmodule
 