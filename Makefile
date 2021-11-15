GHDLOPTS=--std=08

SRCS=\
	math_real.vhdl \
	math_real-impl.vhdl
OBJS=$(patsubst %.vhdl, %.o, $(SRCS))
all: $(OBJS)

%o:%vhdl
	ghdl -i $(GHDLOPTS) $<
	ghdl -a $(GHDLOPTS) $<

.PHONY: clean
clean:
	rm $(OBJS)
