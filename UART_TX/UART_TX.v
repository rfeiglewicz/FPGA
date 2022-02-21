module UART_TX #(
	parameter clock_per_bit = 13021 // clk/baud rate == clock_per_bit
	) (
	input  clk, input  [7:0] data_in , input  data_ready, output reg TX_out, output reg TX_busy   //when TX sending data TX_busy == 1'b1 
	);
	
	integer count_period = 0;
	reg [1:0] state = 2'b00;
	localparam IDLE = 0 , START = 1 , DATA =2 ,STOP = 3;
	reg [7:0] data_to_send;
	reg [2:0] index_bit = 3'b000 ; 
	always @(posedge clk)
		begin
			case(state)
				IDLE:
					begin
						
						index_bit <= 0;
						count_period <= 0;
						TX_out <= 1'b1;
						if(data_ready == 1'b1)begin
								data_to_send <= data_in;
								TX_busy <= 1'b1;
								state <= START;
							end
						else  TX_busy <= 1'b0;
					end
				START:
					begin 
						count_period <= count_period +1;
						if(count_period == 0) begin
								TX_out <= 1'b0 ;            
							end
						else if(count_period == clock_per_bit -1)
							begin
								count_period <= 0;
								state <= DATA;    
							end
						
					end
				DATA:
					begin
						count_period <= count_period +1;
						if(count_period == 0)
							begin
								TX_out <= data_to_send[index_bit];
							end
						else if(count_period == clock_per_bit -1)
						begin
                            index_bit <= index_bit +1;
							count_period <= 0;
							if(index_bit == 7)
								begin
									index_bit <= 0;
									state <= STOP;  
								end 
						end
					end
				STOP:
					begin
						count_period <= count_period +1;
						if(count_period == 0) TX_out = 1'b1;
						else if(count_period == clock_per_bit -1)
							begin
								state <= IDLE;
								TX_busy <= 1'b0;
								count_period <= 0;
							end
						
					end
				
				
				default:
					begin
						state <= IDLE;
						TX_busy <= 1'b0;
						count_period <= 0;
						
					end
			endcase
			
			
		end
	
	
	
endmodule