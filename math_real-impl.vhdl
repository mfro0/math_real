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



end package body math_real;
