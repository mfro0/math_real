##  Copyright (C) 2021 Markus Fröschle
##
##  This program is free software: you can redistribute it and/or modify
##  it under the terms of the GNU General Public License as published by
##  the Free Software Foundation, either version 2 of the License, or
##  (at your option) any later version.
##
##  This program is distributed in the hope that it will be useful,
##  but WITHOUT ANY WARRANTY; without even the implied warranty of
##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##  GNU General Public License for more details.
##
##  You should have received a copy of the GNU General Public License
##  along with this program.  If not, see <gnu.org/licenses>.


GHDLOPTS=--std=08

SRCS=\
	math_real.vhdl \
	math_real-body.vhdl \
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
