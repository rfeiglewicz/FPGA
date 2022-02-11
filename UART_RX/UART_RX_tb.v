// Uart Reciver testbench Radoslaw Feiglewicz
`default_nettype none  
`timescale 1 ns / 100 ps 
module UART_RX_tb;
	
	reg clk = 1'b0;
	localparam clock_per_bit_uart = 10;	 // Use 10 to faster simulation
	wire[7:0] Data_out_t;
	wire data_ready_t;
	reg serial_rx_t;
	
	localparam period = 4; 
	
	UART_RX #(.clock_per_bit(clock_per_bit_uart) ) UUT (.Data_out(Data_out_t), .serial_rx(serial_rx_t) , .clk(clk), .data_ready(data_ready_t));
	
	
	
	always
		begin
			#period clk = ~clk;    
		end
	
	always
		
		begin  
			
			
			serial_rx_t = 1'b1;
			#10	; 
			// start frame
			
			serial_rx_t = 1'b0;		  //start bit
			#(clock_per_bit_uart*8);
			
			serial_rx_t = 1'b1;		//data  LSB to MSB  Data == 10100001 ==  'hA1
			#(clock_per_bit_uart*8);
			
			serial_rx_t = 1'b0;
			#(clock_per_bit_uart*8);
			
			serial_rx_t = 1'b0;
			#(clock_per_bit_uart*8);
			
			serial_rx_t = 1'b0;
			#(clock_per_bit_uart*8);
			
			serial_rx_t = 1'b0;
			#(clock_per_bit_uart*8);
			
			serial_rx_t = 1'b1;
			#(clock_per_bit_uart*8);
			
			serial_rx_t = 1'b0;
			#(clock_per_bit_uart*8);
			
			serial_rx_t = 1'b1;
			#(clock_per_bit_uart*8);
			
			serial_rx_t = 1'b1;		// stop bit
			#(clock_per_bit_uart*8);  
			// END frame
			
			
			
			// start second frame
			
			serial_rx_t = 1'b0;		  //start bit
			#(clock_per_bit_uart*8);
			
			serial_rx_t = 1'b0;		//data  LSB to MSB  Data == 10000000 ==  'h80
			#(clock_per_bit_uart*8);
			
			serial_rx_t = 1'b0;
			#(clock_per_bit_uart*8);
			
			serial_rx_t = 1'b0;
			#(clock_per_bit_uart*8);
			
			serial_rx_t = 1'b0;
			#(clock_per_bit_uart*8);
			
			serial_rx_t = 1'b0;
			#(clock_per_bit_uart*8);
			
			serial_rx_t = 1'b0;
			#(clock_per_bit_uart*8);
			
			serial_rx_t = 1'b0;
			#(clock_per_bit_uart*8);
			
			serial_rx_t = 1'b1;
			#(clock_per_bit_uart*8);
			
			serial_rx_t = 1'b1;		// stop bit
			#(clock_per_bit_uart*8);  
			// END frame
			
			
			$stop ;
		end
	
	
endmodule