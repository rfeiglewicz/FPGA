vlib Prescaler
set worklib Prescaler
vlog -dbg Prescaler.v Prescaler_tb.v
vsim +access +r Prescaler_tb 
wave
wave -noreg CLK
wave -noreg CE
wave -noreg CLR
wave -noreg CEO
run -all
  