vlib Debouncer
set worklib Debouncer
vlog -dbg Debouncer.v Debouncer_tb.v
vsim +access +r Debouncer_tb 
wave
wave -noreg CLK
wave -noreg CEI
wave -noreg CLR	 
wave -noreg /Debouncer_tb/UUT/DELAY
wave -noreg PUSH
wave -noreg PE
run -all
  