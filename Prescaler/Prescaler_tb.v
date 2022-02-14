`default_nettype none  
`timescale 1 ns / 100 ps 
module Prescaler_tb;
localparam period = 4; //clock half period
reg CLK;
reg CE;
reg CLR;

wire CEO;

Prescaler #(.divide_factor(15)) presc_tb (.CLK(CLK),.CE(CE),.CLR(CLR), .CEO(CEO));

initial begin
    CLK = 1'b0;
    CE = 1'b0;
    CLR = 1'b0;


end

always begin
    #period CLK  = ~ CLK;
end

always begin
    #(2*period);
    #2 CLR = 1'b1;
    #1 CLR = 1'b0;
    #3 CE = 1'b1;

    #400;
	#2CLR = 1'b1;
	#400;
    $stop;


end
endmodule