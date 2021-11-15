GHDLOPTS=--std=08

SRCS=\
	math_real.vhdl \
	math_real-impl.vhdl \
	math_real_tb.vhdl

OBJS=$(patsubst %.vhdl, %.o, $(SRCS))
all: $(OBJS) math_real_tb

math_real_tb: $(OBJS)
	ghdl -m $(GHDLOPTS) $@

%o:%vhdl
	ghdl -i $(GHDLOPTS) $<
	ghdl -a $(GHDLOPTS) $<

.PHONY: clean
clean:
	rm $(OBJS)
