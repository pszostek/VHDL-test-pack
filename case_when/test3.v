//
// Author: Pawel Szostek (pawel.szostek@cern.ch)
// Date: 01.08.2011

`timescale 1ns/1ps
 
module  mux2to1_vl ( input s0, in0, in1, output reg out );
  wire [1:0] sel;
  assign sel[0] = s0;

  always @ (sel[0] or in0 or in1)
  begin
    case (sel[0])
      1'b0:   out <= in0;
      1'b1:   out <= in1;
      default: out <= 1'bx;
    endcase
  end

endmodule

module stimulus (output reg  s0, o0, o1);
    parameter S = 2000;
    int unsigned i;
    initial begin
        for (i=0; i<S; i=i+1) begin
            #10;
            s0 <= inject();
            o0 <= inject();
            o1 <= inject();
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
        
module check(input o_verilog, o_vhdl,i0,i1,i2,i3, s0, s1);

always @(s0,s1,i0,i1,i2,i3) begin
    #1;
    if (o_vhdl !== o_verilog) begin
        $display("ERROR!");
        $display("INPUTS: ", i3,i2,i1,i0);
        $display("VHDL_OUTPUT: ", o_vhdl);
        $display("VERILOG_OUTPUT: ", o_verilog);
        $display("SEL: ", s1, s0);
        $display("");
        //$stop;
    end else begin
   /*     $display("OK!");
        $display("INPUTS: ", i3,i2,i1,i0);
        $display("VHDL_OUTPUT: ", o_vhdl);
        $display("VERILOG_OUTPUT: ", o_verilog);
        $display("SEL: ", s1, s0);
        $display("");
     */   
    end
end
endmodule

module main;
    wire s1, s0, i0, i1, i2, i3, o_verilog, o_vhdl;

    stimulus stim(.s0(s0), .o0(i0), .o1(i1));
    mux2to1_vl mux_verilog(s0, i0, i1, o_verilog);
    mux2to1_vhdl_1 mux_vhdl(s0, i0, i1, o_vhdl);
    check check(o_verilog, o_vhdl,i0,i1,i2,i3, s0, s1);
    initial begin
        #120000;
        $display("PASSED");
        $stop;
    end
endmodule
 