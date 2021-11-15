library ieee;
use ieee.numeric_std.all;
use work.math_real.all;

entity math_real_tb is
end entity math_real_tb;

architecture sim of math_real_tb is
    type sim_vec_t is record
        func            : string(1 to 20);
        arg0            : real;
        result          : real;
    end record;

    type sim_vecs_t is array(natural range <>) of sim_vec_t;
    constant sim_vec : sim_vecs_t :=
    (
        ("mod                 ", 0.0, 0.0)
    );

begin
end architecture sim;

