vlib work
set worklib work
vlog -dbg UART_RX.v UART_RX_tb.v
vsim +access +r UART_RX_tb 
wave
wave -noreg clk
wave -noreg Data_out_t
wave -noreg data_ready_t
wave -noreg serial_rx_t
run -all
  