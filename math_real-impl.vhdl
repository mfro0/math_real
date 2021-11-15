package body math_real is

function sign(x : in real) return real is
    function copysign(f : real; copyfrom : real) return real is
    begin
        report "copysign C implementation" severity note;
    end function copysign;
    attribute foreign of copysign : function is "VHPIDIRECT libm.so copysign";

begin
    return copysign(1.0, f);
end function sign;

function ceil(x : in real) return real is
begin
    report "ceil C implementation" severity note;
end function ceil;
attribute foreign of ceil : function is "VHPIDIRECT libm.so ceil";

function floor(x : in real) return real is
begin
    report "floor C implementation" severity note;
end function floor;
attribute foreign of floor : function is "VHPIDIRECT libm.so floor";

function round(x : in real) return real is
begin
    report "round C implementation" severity note;
end function round;
attribute foreign of round : function is "VHPIDIRECT libm.so round";

function trunc(x : in real) return real is
begin
    report "trunc C implementation" severity note;
end function trunc;
attribute foreign of trunc : function is "VHPIDIRECT libm.so trunc";

function "mod" (x, y : in real) return real is
begin
    report "mod C implementation" severity note;
end function "mod";
attribute foreign of "mod" : function is "VHPIDIRECT libm.so fmod";

function realmax(x, y : in real) return real is
begin
    report "realmax C implementation" severity note;
end function realmax;
attribute foreign of realmax : function is "VHPIDIRECT libm.so fmax";

function realmin(x, y : in real) return real is
begin
    report "realmin C implementation" severity note;
end function realmin;
attribute foreign of realmin : function is "VHDPIDIRECT libm.so fmin";

procedure uniform(variable seed1, seed2 : inout positive; variable x : out real) is
begin
    report "uniform C implementation" severity note;
end procedure uniform;

end package body math_real;
