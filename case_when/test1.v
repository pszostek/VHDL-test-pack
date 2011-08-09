//
// Author: Pawel Szostek (pawel.szostek@cern.ch)
// Date: 01.08.2011

module  mux4to1 ( input s0, s1, in0, in1, in2, in3, output reg out );
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
    reg unsigned [3:0] temp1, temp2, temp3;
    int unsigned i;
    initial begin
        for (i=0; i<S; i=i+1) begin
            #1;
            temp1[3:0] = $random % 16;
            temp2[3:0] = $random % 16;
            temp3[3:0] = $random %16;
            s1 <= inject(temp1);
            s0 <= inject(temp2);
            o0 <= inject(temp3);
            o1 <= inject({temp1[3:2],temp2[1:0]});
            o2 <= inject({temp3[3:2],temp1[1:0]});
            o3 <= inject({temp3[3:2],temp2[1:0]});
        end
    end
    function inject(input unsigned[3:0] value);
        reg ret;
        begin
            if(value >= 10)
                ret = 1'b1;
            else if(value >= 4)
                ret = 1'b0;
            else if(value >= 2)
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
        //$finish;
    end else begin
        $display("OK!");
        $display("INPUTS: ", i3,i2,i1,i0);
        $display("VHDL_OUTPUT: ", o_vhdl);
        $display("VERILOG_OUTPUT: ", o_verilog);
        $display("SEL: ", s1, s0);
        $display("");
    end
end
endmodule

module main;
    wire s1, s0, i0, i1, i2, i3, o_verilog, o_vhdl;

    stimulus stim(.s1(s1), .s0(s0), .o0(i0), .o1(i1), .o2(i2), .o3(i3));
    mux4to1 mux_verilog(s0, s1, i0, i1, i2, i3, o_verilog);
    mux4to1_vhdl mux_vhdl(s0, s1, i0, i1, i2, i3, o_vhdl);
    check check(o_verilog, o_vhdl,i0,i1,i2,i3, s0, s1);
    initial begin
        #120000;
        //$display("PASSED");
        $finish;
    end
endmodule
 