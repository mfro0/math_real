--  Copyright (C) 2021 Markus Fröschle
--
--  This program is free software: you can redistribute it and/or modify
--  it under the terms of the GNU General Public License as published by
--  the Free Software Foundation, either version 2 of the License, or
--  (at your option) any later version.
--
--  This program is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  GNU General Public License for more details.
--
--  You should have received a copy of the GNU General Public License
--  along with this program.  If not, see <gnu.org/licenses>.

library ieee;
use ieee.numeric_std.all;
use std.textio.all;
use work.math_real.all;

entity math_real_tb is
end entity math_real_tb;

architecture sim of math_real_tb is
    type funcs_t is (F_MOD, F_CEIL, F_SQRT, F_FLOOR, F_ROUND, F_SIGN, F_TRUNC);
    type sim_vec_t is record
        func            : funcs_t;
        arg0            : real;
        arg1            : real;
        expected        : real;
    end record;

    type sim_vecs_t is array(natural range <>) of sim_vec_t;
    constant sim_vec : sim_vecs_t :=
    (
        (F_SIGN, 1.0, 0.0, 1.0),
        (F_SIGN, -1.0, 0.0, -1.0),
        (F_CEIL, 0.9, 0.0, 1.0),
        (F_CEIL, -0.9, 0.0, 0.0),
        (F_FLOOR, 0.0, 0.0, 0.0),
        (F_FLOOR, 0.5, 0.0, 0.0),
        (F_FLOOR, -0.5, 0.0, -1.0),
        (F_ROUND, 0.0, 0.0, 0.0),
        (F_ROUND, 0.9, 0.0, 1.0),
        (F_ROUND, -10.9, 0.0, -11.0),
        (F_TRUNC, -3.1, 0.0, -3.0),
        (F_TRUNC, 4.5, 0.0, 4.0),
        (F_MOD, 100.0, 50.0, 0.0),
        (F_MOD, 100.0, 49.0, 2.0),
        (F_MOD, 2.0 ** 32 - 1.0, 16.0, -1.0),
        (F_SQRT, 9.0, 0.0, 3.0)
    );

begin
    test : process
        variable func   : funcs_t;
        variable s      : sim_vec_t;
        variable res    : real;
    begin
        for i in sim_vec'low to sim_vec'high loop
            s := sim_vec(i);
            func := s.func;

            case func is
                when F_SIGN =>
                    res := sign(s.arg0);
                when F_CEIL =>
                    res := ceil(s.arg0);
                when F_TRUNC =>
                    res := trunc(s.arg0);
                when F_FLOOR =>
                    res := floor(s.arg0);
                when F_ROUND =>
                    res := round(s.arg0);
                when F_MOD =>
                    res := s.arg0 mod s.arg1;
                when F_SQRT =>
                    res := sqrt(s.arg0);
                when others =>
                    null;
            end case;
            assert (res = s.expected) report funcs_t'image(func) & ": expected " & real'image(s.expected) &
                                             ", got " & to_string(res, "%15.5f") & " instead" severity failure;
        end loop;
        wait;
    end process test;
end architecture sim;

