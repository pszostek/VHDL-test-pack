//
// Author: Pawel Szostek (pawel.szostek@cern.ch)
// Date: 01.08.2011

`timescale 1ns/1ps

module  mux4to1_v ( input s0, s1, in0, in1, in2, in3, output reg out );
  wire [1:0] sel;
  assign sel[1:0] = {s1, s0};

  always @ (s0 or s1 or in0 or in1 or in2 or in3)
  begin
    case (sel)
      2'b00:   out = in0;
      2'b01:   out = in1;
      2'b10:   out = in2;
      2'b11:   out = in3;
      default: out = 1'bx;
    endcase
  end

endmodule

module stimulus (output reg s1, s0, o0, o1, o2, o3);
    parameter S = 2000;
    int unsigned i;
    initial begin
        for (i=0; i<S; i=i+1) begin
            #10;
            s1 <= inject();
            s0 <= inject();
            o0 <= inject();
            o1 <= inject();
            o2 <= inject();
            o3 <= inject();
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
    if (o_vhdl !== o_verilog) begin
        $display("ERROR!");
        $display("INPUTS: ", i3,i2,i1,i0);
        $display("VHDL_OUTPUT: ", o_vhdl);
        $display("VERILOG_OUTPUT: ", o_verilog);
        $display("SEL: ", s1, s0);
        $display("");
        $stop;
    end 
end
endmodule

module main;
    wire s1, s0, i0, i1, i2, i3, o_verilog, o_vhdl;

    stimulus stim(.s1(s1), .s0(s0), .o0(i0), .o1(i1), .o2(i2), .o3(i3));
    mux4to1_v mux_verilog(s0, s1, i0, i1, i2, i3, o_verilog);
    mux4to1 mux_vhdl(s0, s1, i0, i1, i2, i3, o_vhdl);
    check check(o_verilog, o_vhdl,i0,i1,i2,i3, s0, s1);
    initial begin
        #120000;
        $display("PASSED");
        $stop;
    end
endmodule
 