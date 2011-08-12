//
// Author: Pawel Szostek (pawel.szostek@cern.ch)
// Date: 01.08.2011

`timescale 1ns/1ps

module  mux4to2_vl ( input s0, in0, in1, in2, in3, output reg out0, out1);
  always @ (s0 or in0 or in1 or in2 or in3)
  begin
    case (s0)
      1'b0:begin
              out0 <= in0;
              out1 <= in1;
           end
      1'b1:begin
              out0 <= in2;
              out1 <= in3;
           end
      default: {out0, out1} = 2'bxx;
    endcase
  end

endmodule

module stimulus (output reg s0, o0, o1, o2, o3);
    parameter S = 2000;
    int unsigned i;
    initial begin
        for (i=0; i<S; i=i+1) begin
            #10;
            s0<= inject();
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
        
module check(input o_verilog, o_vhdl,i0,i1,i2,i3, s0);

always @(s0,i0,i1,i2,i3) begin
    #1;
    if (o_vhdl !== o_verilog) begin
        $display("ERROR!");
        $display("INPUTS: ", i3,i2,i1,i0);
        $display("VHDL_OUTPUT: ", o_vhdl);
        $display("VERILOG_OUTPUT: ", o_verilog);
        $display("SEL: ", s0);
        $display("");
        $stop;
    end else begin
     /*   $display("INPUTS: ", i3,i2,i1,i0);
        $display("VHDL_OUTPUT: ", o_vhdl);
        $display("VERILOG_OUTPUT: ", o_verilog);
        $display("SEL: ", s0);
        $display("");
    */end
end
endmodule

module main;
    wire s0;
    wire [3:0] i;
    wire [1:0] o_verilog;
    wire [1:0] o_vhdl;

    stimulus stim(.s0(s0), .o0(i[0]), .o1(i[1]), .o2(i[2]), .o3(i[3]));
    mux4to2_vl mux_verilog(s0, i[0], i[1], i[2], i[3], o_verilog[0], o_verilog[1]);
    mux4to2_vhdl_1 mux_vhdl(s0, i[0], i[1], i[2], i[3], o_vhdl[0], o_vhdl[1]);
    check check(o_verilog, o_vhdl,i[0],i[1],i[2],i[3], s0);
    initial begin
        #120000;
        $display("PASSED");
        $stop;
    end
endmodule
 