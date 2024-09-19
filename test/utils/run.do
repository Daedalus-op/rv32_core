vlib work
vlog src/utils/adder.sv 
vlog src/utils/rca.sv 
vlog src/utils/register.sv 
vlog src/utils/memory.sv 
vlog test/utils/add_tb.sv 
vlog test/utils/reg_tb.sv 
vlog top.sv
vsim work.top
#add wave -r *
run -all