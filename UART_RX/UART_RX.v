// Uart Reciver Radoslaw Feiglewicz

module UART_RX #(parameter clock_per_bit = 13021) // default baud rate 9600, CLK/BAUD_RATE == clock_per_bit
	( output reg [7:0] Data_out , input serial_rx, clk, output reg data_ready );
	
	reg serial_dat, serial_dat_2; // additional  double regiseter to reduce metastability
	localparam IDLE = 0 , START_BIT = 1 , DATA_READ = 2, STOP_BIT =3;		// FSM state
	reg [1:0] next_state,cur_state = IDLE;
	integer count_period = 0; //
	reg [2:0] index_bit = 3'b000 ; 
	
	initial 
		begin
			data_ready <= 1'b0;
			
		end
	
	
	always @(posedge clk) 	   //Reduce metastability
		begin 
			serial_dat_2 <= serial_rx;
			serial_dat <= serial_dat_2;	
		end
	
	
	always @(posedge clk)
		begin
			cur_state = next_state;
		end
	
	
	always @(posedge clk)
		begin
			case(cur_state)
				IDLE:
					begin 
						count_period = 0;
						if (serial_dat == 1'b0)
							next_state = START_BIT;	
					end
				START_BIT:
					begin
						if(count_period < clock_per_bit -1)
							count_period = count_period +1;
						else
							begin
								count_period = 0;
								next_state = DATA_READ;	
							end
					end
				DATA_READ:
					begin
						if(count_period == (clock_per_bit -1)/2)
							Data_out[index_bit] =  serial_dat; 
						
						if(count_period < clock_per_bit -1)
							count_period = count_period +1;
						
						else if(index_bit == 7)
							begin
								count_period = 0;
								index_bit = 0 ;
								next_state = STOP_BIT;
							end
						else 
							begin
								count_period = 0;
								index_bit = index_bit +1;
							end
						
					end
				STOP_BIT:
					begin
						if(count_period ==0)
							data_ready = 1'b1;
						else
							data_ready = 1'b0;
						if(count_period < clock_per_bit -1)
							count_period = count_period +1;
						else  
							begin
								count_period = 0;
								next_state = IDLE;	
							end
					end
				default: 
				begin
				next_state = IDLE;
				index_bit = 0 ;
				count_period = 0;
				end
			endcase
		end
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
endmodule