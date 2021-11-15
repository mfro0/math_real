package body math_real is

function sign(x : in real) return real is
    function copysign(f : real; copyfrom : real) return real is
    begin
        report "copysign C implementation" severity note;
    end function copysign;
    attribute foreign of copysign : function is "VHPIDIRECT libm.so copysign";

begin
    return copysign(1.0, x);
end function sign;

function ceil(x : in real) return real is
    function cceil(x : in real) return real is
    begin
        report "ceil C implementation" severity note;
    end function cceil;
    attribute foreign of cceil : function is "VHPIDIRECT libm.so ceil";
begin
    return cceil(x);
end function ceil;

function floor(x : in real) return real is
    function cfloor(x : in real) return real is
    begin
        report "floor C implementation" severity note;
    end function cfloor;
    attribute foreign of cfloor : function is "VHPIDIRECT libm.so floor";
begin
    return cfloor(x);
end function floor;

function round(x : in real) return real is
    function cround(x : in real) return real is
    begin
        report "round C implementation" severity note;
    end function cround;
    attribute foreign of cround : function is "VHPIDIRECT libm.so round";
begin
    return cround(x);
end function round;

function trunc(x : in real) return real is
    function ctrunc(x : in real) return real is
    begin
        report "trunc C implementation" severity note;
    end function ctrunc;
    attribute foreign of ctrunc : function is "VHPIDIRECT libm.so trunc";
begin
    return ctrunc(x);
end function trunc;

function "mod" (x, y : in real) return real is
    function cmod(x, y : in real) return real is
    begin
        report "mod C implementation" severity note;
    end function cmod;
    attribute foreign of cmod : function is "VHPIDIRECT libm.so fmod";
begin
    return cmod(x, y);
end function "mod";

function realmax(x, y : in real) return real is
    function crealmax(x, y : in real) return real is
    begin
        report "realmax C implementation" severity note;
    end function crealmax;
    attribute foreign of crealmax : function is "VHPIDIRECT libm.so fmax";
begin
    return crealmax(x, y);
end function realmax;

function realmin(x, y : in real) return real is
    function crealmin(x, y : in real) return real is
    begin
        report "realmin C implementation" severity note;
    end function crealmin;
    attribute foreign of crealmin : function is "VHPIDIRECT libm.so fmin";
begin
    return crealmin(x, y);
end function realmin;

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

function sqrt(x : in real) return real is
    function csqrt(a : in real) return real is
    begin
        report "sqrt C implementation" severity note;
    end function csqrt;
    attribute foreign of csqrt : function is "VHPIDIRECT libm.so sqrt";
begin
    return csqrt(x);
end function sqrt;

function cbrt(x : in real) return real is
    function ccbrt(a : in real) return real is
    begin
        report "cbrt C implementation" severity note;
    end function ccbrt;
    attribute foreign of ccbrt : function is "VHPIDIRECT libm.so cbrt";
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
    attribute foreign of cpow : function is "VHPIDIRECT libm.so pow";
begin
    return cpow(x, y);
end function "**";

function exp(x : in real) return real is
    function cexp(a : in real) return real is
    begin
        report "cexp C implementation" severity note;
    end function cexp;
    attribute foreign of cexp : function is "VHPIDIRECT libm.so fexp";
begin
    return cexp(x);
end function exp;

function log(x : in real) return real is
    function clog(a : in real) return real is
    begin
        report "clog C implementation" severity note;
    end function clog;
    attribute foreign of clog : function is "VHPIDIRECT libm.so log";
begin
    return clog(x);
end function log;

function log2(x : in real) return real is
    function clog2(a : in real) return real is
    begin
        report "clog2 C implementation" severity note;
    end function clog2;
    attribute foreign of clog2 : function is "VHPIDIRECT libm.so log2";
begin
    return clog2(x);
end function log2;

function log10(x : in real) return real is
    function clog10(a : in real) return real is
    begin
        report "clog10 C implementation" severity note;
    end function clog10;
    attribute foreign of clog10 : function is "VHPIDIRECT libm.so log10";
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
    attribute foreign of csin : function is "VHPIDIRECT libm.so sin";
begin
    return csin(x);
end function sin;

function cos(x : in real) return real is
    function ccos(a : in real) return real is
    begin
        report "ccos C implementation" severity note;
    end function ccos;
    attribute foreign of ccos : function is "VHPIDIRECT libm.so cos";
begin
    return ccos(x);
end function cos;

function tan(x : in real) return real is
    function ctan(a : in real) return real is
    begin
        report "ctan C implementation" severity note;
    end function ctan;
    attribute foreign of ctan : function is "VHPIDIRECT libm.so tan";
begin
    return ctan(x);
end function tan;

function arcsin(x : in real) return real is
    function carcsin(a : in real) return real is
    begin
        report "carcsin C implementation" severity note;
    end function carcsin;
    attribute foreign of carcsin : function is "VHPIDIRECT libm.so asin";
begin
    return carcsin(x);
end function arcsin;

function arccos(x : in real) return real is
    function carccos(a : in real) return real is
    begin
        report "carccos C implementation" severity note;
    end function carccos;
    attribute foreign of carccos : function is "VHPIDIRECT libm.so acos";
begin
    return carccos(x);
end function arccos;

function arctan(y : in real) return real is
    function carctan(a : in real) return real is
    begin
        report "carctan C implementation" severity note;
    end function carctan;
    attribute foreign of carctan : function is "VHPIDIRECT libm.so atan";
begin
    return carctan(y);
end function arctan;
end package body math_real;
