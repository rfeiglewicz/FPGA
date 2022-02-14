/*
Prescaler module using for example as CE input for flip-flops
This code is translate from VHDL to VERILOG additionally I add parameter to set divide factor to how many register neeed to obtain divide factor.
VHDL code is property of Pawe³ Rajda and Jerzy Kasperek, AGH professors

*/

`default_nettype none  
module Prescaler #(
    parameter divide_factor = 10  // add how often CEO will be change
) (
    input wire CLK,
    input wire CE,
    input wire CLR,
    output wire CEO
);
    reg [($clog2(divide_factor)-1):0] DIVIDER;


    assign  CEO =  ( DIVIDER ==  (divide_factor -1) && (CE == 1'b1) ) ? 1'b1 : 1'b0;

    always @(posedge CLK, posedge CLR) begin
        if (CLR == 1'b1) DIVIDER <= 0;
        else if (CLK == 1'b1)
            if (CE == 1'b1) 
                if (DIVIDER == (divide_factor -1 ))
                    DIVIDER <= 0;
                else 
                    DIVIDER <= DIVIDER +1;
    
    end


endmodule
