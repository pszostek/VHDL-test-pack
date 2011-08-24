//
// Author: Pawel Szostek (pawel.szostek@cern.ch)
// Date: 01.08.2011

`timescale 1ns/1ps
module one_counter_v(input [2:0] a, output reg [1:0] out);
    always @(a) begin
        case(a)
            3'b000: out = 2'b00;
            3'b001,
            3'b010,
            3'b100: out = 2'b01;
            3'b011,
            3'b101,
            3'b110: out = 2'b10;
            3'b111: out = 2'b11;
            default: out = 2'bxx;
        endcase
    end
endmodule

module check(input [2:0] a, input [1:0] o_vhdl, o_verilog);

always @(a) begin
    if (o_vhdl !== o_verilog) begin
        $display("ERROR!");
        $display("VERILOG: ", o_verilog);
        $display("VHDL: ", o_vhdl);
        $stop;
    end
end
endmodule

module stimulus (output reg [2:0] a);
    parameter S = 20000;
    int unsigned i,j,k,l;
    initial begin //stimulate data
        for (i=0; i<S; i=i+1) begin
            #5;
            for(k=0; k<3; k=k+1) begin
                a[k] <= inject();
            end
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

module main;
    reg [2:0] a;
    reg [1:0] o_vhdl, o_verilog;
    one_counter   d_vhdl(a, o_vhdl);
    one_counter_v d_verilog(a, o_verilog);
    stimulus stim(a);
    check c(a,o_vhdl, o_verilog);
    initial begin
        #120000;
        $display("PASSED");
        $stop;
    end
endmodule
 