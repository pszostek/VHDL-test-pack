--
-- Author: Pawel Szostek (pawel.szostek@cern.ch)
-- Date: 27.07.2011

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;
entity adder_ripple is
    generic (n: natural);
    port (a,b : in std_logic_vector(n-1 downto 0);
        cin : in std_logic;
        sum : out std_logic_vector(n-1 downto 0);
        cout : out std_logic);
end;

architecture behaviour of adder_ripple is
    signal c : std_logic_vector(n downto 0);
begin
    c(0) <= cin;
    ------------casual for generate statement
    gen: for i in n-1 to 0 generate
        sum(i) <= a(i) xor b(i) xor c(i);
        c(i+1) <= (a(i) and b(i)) or
                (a(i) and c(i)) or
                (b(i) and c(i));
        end generate;
        cout <= c(n);
end;
