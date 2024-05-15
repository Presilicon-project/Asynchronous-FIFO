vlib work
vlog fifo.sv
vlog fifo_mem.sv
vlog sync_r2w.sv
vlog sync_w2r.sv
vlog wptr_full.sv
vlog rptr_empty.sv
vlog testbench.sv
vsim -c -voptargs=+acc -coverage -vopt async_fifo_tb_class -do "coverage save -onexit -directive -codeALL coverage_report.ucdb; run -all"
vcover report -html coverage_report.ucdb


