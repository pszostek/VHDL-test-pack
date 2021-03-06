//
// Author: Pawel Szostek (pawel.szostek@cern.ch)
// Date: 01.08.2011
`timescale 1ns/1ps
module  counter_vl ( input ena, clk, reset, output reg[7:0]count );

  always @ (posedge clk or posedge reset)
  begin
    if(reset == 1'b1)
      count <= 0;
    else if(ena == 1'b1)
        count <= count +1;
    else if(ena == 1'b0)
        count <= count;
    else
        count <= 8'bxxxxxxxx;
  end

endmodule

module stimulus (output reg ena, clk, reset);
    parameter S = 20000;
    reg unsigned [3:0] temp1, temp3;
    int unsigned i,j,k;
    initial begin
        reset <= 1'b1;
        #1;
        reset <= 1'b0;
    end
    initial begin //stimulate enable input
        for (i=0; i<S/3; i=i+1) begin
         #3 ena <= inject();
        end
    end

    initial begin //stimulate clock
        clk = 0;
        for(j=0; j<S; j=j+1) begin
            #1 clk = ~clk;
        end
    end

    initial begin //stimulate reset
        for (k=0; k<S/101; k=k+1) begin
            #101 reset <= inject();
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
            /*else if(temp >= 4)
                inject = 1'b0;
            else if(temp >= 2)
                inject = 1'bx;
            else
                inject = 1'b1;
        */end
    endfunction
endmodule

module check(input [7:0] verilog, [7:0] vhdl, input ena, clk, reset);

always @(ena or clk or reset) begin
    #1; //don't look at peaks
    if (vhdl !== verilog) begin
        $display("ERROR!");
        $display("VERILOG_CNT: ", verilog);
        $display("VHDL_CNT: ", vhdl);
        $display("ENA: ", ena);
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
    wire[7:0] vhdl;
    wire[7:0] verilog;
    wire ena, clk, reset;

    stimulus stim(ena, clk, reset);
    counter_vhdl cnt_vhdl(ena, clk, reset, vhdl);
    counter_vl cnt_vl(ena, clk, reset, verilog);
    check check(verilog, vhdl, ena, clk, reset);
    initial begin
        #120000;
        $display("PASSED");
        $stop;
    end
endmodule
 