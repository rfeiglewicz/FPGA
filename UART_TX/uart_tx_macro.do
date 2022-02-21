vlib UART_TX
set worklib UART_TX
vlog -dbg UART_TX.v UART_TX_tb.v
vsim +access +r UART_TX_tb 
wave
wave -noreg clk
wave -noreg data_in
wave -noreg data_ready
wave -noreg TX_out
wave -noreg TX_busy
wave -noreg /UART_TX_tb/UUT/data_to_send  
wave -noreg /UART_TX_tb/UUT/index_bit
wave -noreg	/UART_TX_tb/UUT/state 
wave -noreg /UART_TX_tb/UUT/count_period
run -all
  