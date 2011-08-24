//
// Author: Pawel Szostek (pawel.szostek@cern.ch)
// Date: 01.08.2011

`timescale 1ns/1ps
module decoder_v(input [3:0] a, output reg err, output reg [1:0] out);
    always @(a) begin
        case(a)
            4'b0001: out = 2'b00;
            4'b0010: out = 2'b01;
            4'b0100: out = 2'b10;
            4'b1000: out = 2'b11;
            default: out = 2'bxx;
        endcase
        if (a != 4'b0001 && a != 4'b0010 && a != 4'b0100 && a != 4'b1000)
            err = 1;
        else
            err = 0;
    end
endmodule

module check(input [3:0] a, input [1:0] o_vhdl, o_verilog, input err_vhdl, err_verilog);

always @(a) begin
    if (o_vhdl !== o_verilog || err_vhdl !== err_verilog) begin
        $display("ERROR!");
        $display("VERILOG: ", o_verilog);
        $display("VHDL: ", o_vhdl);
        $display("ERR_VERILOG: ", err_verilog);
        $display("ERR_VHDL: ", err_vhdl);
        $stop;
    end
end
endmodule

module stimulus (output reg [3:0] a);
    parameter S = 20000;
    int unsigned i,j,k,l;
    initial begin //stimulate data
        for (i=0; i<S; i=i+1) begin
            #5;
            for(k=0; k<4; k=k+1) begin
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
    reg [3:0] a;
    reg [1:0] o_vhdl, o_verilog;
    reg err_vhdl, err_verilog;
    decoder   d_vhdl(a,err_vhdl, o_vhdl);
    decoder_v d_verilog(a, err_verilog, o_verilog);
    stimulus stim(a);
    check c(a,o_vhdl, o_verilog);
    initial begin
        #120000;
        $display("PASSED");
        $stop;
    end
endmodule
 