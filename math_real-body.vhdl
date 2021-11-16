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

package body math_real is

function sign(x : in real) return real is
    function copysign(f : real; copyfrom : real) return real is
    begin
        report "copysign C implementation" severity note;
    end function copysign;
    attribute foreign of copysign : function is "VHPIDIRECT copysign";

begin
    return copysign(1.0, x);
end function sign;

function ceil(x : in real) return real is
    function cceil(a : in real) return real is
    begin
        report "ceil C implementation" severity note;
    end function cceil;
    attribute foreign of cceil : function is "VHPIDIRECT ceil";
begin
    return cceil(x);
end function ceil;

function floor(x : in real) return real is
    function cfloor(a : in real) return real is
    begin
        report "floor C implementation" severity note;
    end function cfloor;
    attribute foreign of cfloor : function is "VHPIDIRECT floor";
begin
    return cfloor(x);
end function floor;

function round(x : in real) return real is
    function cround(a : in real) return real is
    begin
        report "round C implementation" severity note;
    end function cround;
    attribute foreign of cround : function is "VHPIDIRECT round";
begin
    return cround(x);
end function round;

function trunc(x : in real) return real is
    function ctrunc(a : in real) return real is
    begin
        report "trunc C implementation" severity note;
    end function ctrunc;
    attribute foreign of ctrunc : function is "VHPIDIRECT trunc";
begin
    return ctrunc(x);
end function trunc;

-- NOTE: fmod is *NOT* the same thing (rounding mode is different,
-- therefore we need to use remainder() here
function "mod" (x, y : in real) return real is
    function cmod(a, b : in real) return real is
    begin
        report "mod C implementation" severity note;
    end function cmod;
    attribute foreign of cmod : function is "VHPIDIRECT remainder";
begin
    return cmod(x, y);
end function "mod";

function realmax(x, y : in real) return real is
    function crealmax(a, b : in real) return real is
    begin
        report "realmax C implementation" severity note;
    end function crealmax;
    attribute foreign of crealmax : function is "VHPIDIRECT fmax";
begin
    return crealmax(x, y);
end function realmax;

function realmin(x, y : in real) return real is
    function crealmin(a, b : in real) return real is
    begin
        report "realmin C implementation" severity note;
    end function crealmin;
    attribute foreign of crealmin : function is "VHPIDIRECT fmin";
begin
    return crealmin(x, y);
end function realmin;

/*
procedure uniform(variable seed1, seed2 : inout positive; variable x : out real) is
    function crand return integer is
    begin
        report "rand C implementation" severity note;
    end function crand;
    attribute foreign of crand : function is "VHPIDIRECT rand";

    procedure csrand(variable seed : integer) is
    begin
        report "srand C implementation" severity note;
    end procedure csrand;
    attribute foreign of csrand : procedure is "VHPIDIRECT srand";

    constant RAND_MAX : integer := 2147483647;          -- copied from stdlib.h
begin
    if seed2 /= -1 then         -- FIXME: humble attempt of static
        csrand(seed1);
        seed2 := positive'high;
    end if;
    x := real(crand) / real(RAND_MAX);
end procedure uniform;
*/

-- use original implementation to make sure uniform sequence for given
-- seed values are the same
procedure uniform (variable seed1, seed2 : inout positive; variable x : out real) is
    variable z, k : integer;
    variable s1, s2 : integer;
begin
    k := seed1 / 53668;
    s1 := 40014 * (seed1 - k * 53668) - k * 12211;
    if s1 < 0 then
        seed1 := s1 + 2147483563;
    else
        seed1 := s1;
    end if;

    k := seed2 / 52774;
    s2 := 40692 * (seed2 - k * 52774) - k * 3791;
    if s2 < 0 then
        seed2 := s2 + 2147483399;
    else
        seed2 := s2;
    end if;

    z := seed1 - seed2;
    if z < 1 then
        z := z + 2147483562;
    end if;

    x := real (z) * 4.656613e-10;
end uniform;


function sqrt(x : in real) return real is
    function csqrt(a : in real) return real is
    begin
        report "sqrt C implementation" severity note;
    end function csqrt;
    attribute foreign of csqrt : function is "VHPIDIRECT sqrt";
begin
    return csqrt(x);
end function sqrt;

function cbrt(x : in real) return real is
    function ccbrt(a : in real) return real is
    begin
        report "cbrt C implementation" severity note;
    end function ccbrt;
    attribute foreign of ccbrt : function is "VHPIDIRECT cbrt";
begin
    return ccbrt(x);
end function cbrt;

function "**" (x : in integer; y : in real) return real is
begin
    return "**"(real(x), y);
end function "**";

function "**" (x : in real; y : in real) return real is
    function cpow(a : in real; b : in real) return real is
    begin
        report "pow C implementation" severity note;
    end function cpow;
    attribute foreign of cpow : function is "VHPIDIRECT pow";
begin
    return cpow(x, y);
end function "**";

function exp(x : in real) return real is
    function cexp(a : in real) return real is
    begin
        report "cexp C implementation" severity note;
    end function cexp;
    attribute foreign of cexp : function is "VHPIDIRECT exp";
begin
    return cexp(x);
end function exp;

function log(x : in real) return real is
    function clog(a : in real) return real is
    begin
        report "clog C implementation" severity note;
    end function clog;
    attribute foreign of clog : function is "VHPIDIRECT log";
begin
    return clog(x);
end function log;

function log2(x : in real) return real is
    function clog2(a : in real) return real is
    begin
        report "clog2 C implementation" severity note;
    end function clog2;
    attribute foreign of clog2 : function is "VHPIDIRECT log2";
begin
    return clog2(x);
end function log2;

function log10(x : in real) return real is
    function clog10(a : in real) return real is
    begin
        report "clog10 C implementation" severity note;
    end function clog10;
    attribute foreign of clog10 : function is "VHPIDIRECT log10";
begin
    return clog10(x);
end function log10;

function log(x : in real; base : in real) return real is
begin
    return log(x) / log(base);
end function log;

function sin(x : in real) return real is
    function csin(a : in real) return real is
    begin
        report "csin C implementation" severity note;
    end function csin;
    attribute foreign of csin : function is "VHPIDIRECT sin";
begin
    return csin(x);
end function sin;

function cos(x : in real) return real is
    function ccos(a : in real) return real is
    begin
        report "ccos C implementation" severity note;
    end function ccos;
    attribute foreign of ccos : function is "VHPIDIRECT cos";
begin
    return ccos(x);
end function cos;

function tan(x : in real) return real is
    function ctan(a : in real) return real is
    begin
        report "ctan C implementation" severity note;
    end function ctan;
    attribute foreign of ctan : function is "VHPIDIRECT tan";
begin
    return ctan(x);
end function tan;

function arcsin(x : in real) return real is
    function carcsin(a : in real) return real is
    begin
        report "carcsin C implementation" severity note;
    end function carcsin;
    attribute foreign of carcsin : function is "VHPIDIRECT asin";
begin
    return carcsin(x);
end function arcsin;

function arccos(x : in real) return real is
    function carccos(a : in real) return real is
    begin
        report "carccos C implementation" severity note;
    end function carccos;
    attribute foreign of carccos : function is "VHPIDIRECT acos";
begin
    return carccos(x);
end function arccos;

function arctan(y : in real) return real is
    function carctan(a : in real) return real is
    begin
        report "carctan C implementation" severity note;
    end function carctan;
    attribute foreign of carctan : function is "VHPIDIRECT atan";
begin
    return carctan(y);
end function arctan;

function arctan(y : in real; x : in real) return real is
    function carctan2(ya : in real; xa : in real) return real is
    begin
        report "carctan2 C implementation" severity note;
    end function carctan2;
    attribute foreign of carctan2 : function is "VHPIDIRECT atan2";
begin
    return carctan2(y, x);
end function arctan;

function sinh(x : in real) return real is
    function csinh(a : in real) return real is
    begin
        report "csinh C implementation" severity note;
    end function csinh;
    attribute foreign of csinh : function is "VHPIDIRECT sinh";
begin
    return csinh(x);
end function sinh;

function cosh(x : in real) return real is
    function ccosh(a : in real) return real is
    begin
        report "ccosh C implementation" severity note;
    end function ccosh;
    attribute foreign of ccosh : function is "VHPIDIRECT cosh";
begin
    return ccosh(x);
end function cosh;

function tanh(x : in real) return real is
    function ctanh(a : in real) return real is
    begin
        report "ctanh C implementation" severity note;
    end function ctanh;
    attribute foreign of ctanh : function is "VHPIDIRECT tanh";
begin
    return ctanh(x);
end function tanh;

function arcsinh(x : in real) return real is
    function carcsinh(a : in real) return real is
    begin
        report "carcsinh C implementation" severity note;
    end function carcsinh;
    attribute foreign of carcsinh : function is "VHPIDIRECT asinh";
begin
    return arcsinh(x);
end function arcsinh;

function arccosh(x : in real) return real is
    function carccosh(a : in real) return real is
    begin
        report "carccosh C implementation" severity note;
    end function carccosh;
    attribute foreign of carccosh : function is "VHPIDIRECT acosh";
begin
    return carccosh(x);
end function arccosh;

function arctanh(x : in real) return real is
    function carctanh(a : in real) return real is
    begin
        report "carctanh C implementation" severity note;
    end function carctanh;
    attribute foreign of carctanh : function is "VHPIDIRECT atanh";
begin
    return carctanh(x);
end function arctanh;

end package body math_real;
