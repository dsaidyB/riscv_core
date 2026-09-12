TOP ?= adder_tb
SRC  = rtl/*.sv tb/$(TOP).sv
VVP  = sim/$(TOP).vvp
VCD  = sim/$(TOP).vcd

.PHONY: sim waves clean list

sim:
	@mkdir -p sim
	iverilog -g2012 -o $(VVP) $(SRC)
	@vvp $(VVP) | tee sim/$(TOP).log

waves: sim
	@gtkwave $(VCD) sim/$(TOP).gtkw 2>/dev/null & 

clean:
	rm -f sim/*.vvp sim/*.vcd sim/*.log

list:
	@ls tb/*.sv | sed 's|tb/||; s|\.sv||'
