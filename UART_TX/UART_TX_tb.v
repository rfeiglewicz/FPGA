`timescale 1ns/100ps

module UART_TX_tb;
localparam half_period = 4;
localparam clock_per_bit_uart = 10;	
wire TX_out , TX_busy;
reg [7:0] data_in;
reg clk = 1'b0;
reg data_ready = 1'b0;

UART_TX #(.clock_per_bit(clock_per_bit_uart)) UUT (.clk(clk), .data_in(data_in), .data_ready(data_ready),
                                                     .TX_out(TX_out),.TX_busy(TX_busy));

always
    begin
        #(half_period) clk = ~clk;
    end

always  begin
    #(4*half_period);
    data_in = 8'b10101010;
    #1;
    data_ready = 1'b1;
    #(2*half_period);
    data_ready = 1'b0;
    #7;

    #(200*half_period);
	$finish;
end




endmodule