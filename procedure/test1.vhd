--
-- Author: Pawel Szostek (pawel.szostek@cern.ch)
-- Date: 27.07.2011

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

entity adder4 is
    port (a,b: in std_logic_vector(3 downto 0);
        cin : in std_logic;
        sum : out std_logic_vector(3 downto 0);
        cout : out std_logic
    );
end;

architecture behaviour of adder4 is
    procedure full_adder(a,b,c: in std_logic;
                        sum, cout : out std_logic) is
    begin
        sum := a xor b xor c;
        cout := (a and b) or (a and c) or (b and c);
    end;
begin
    L: process(a,b,cin)
        variable result : std_logic_vector(3 downto 0);
        variable carry : std_logic;
    begin
        full_adder(a(0), b(0), cin, result(0), carry);
        full_adder(a(1), b(1), carry, result(1), carry);
        full_adder(a(2), b(2), carry, result(2), carry);
        full_adder(a(3), b(3), carry, result(3), carry);
        sum <= result;
        cout <= carry;
    end process;
end;
