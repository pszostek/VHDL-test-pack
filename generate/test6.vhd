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

   ------------casual for-generate statement
    gen: for i in n-1 to 0 generate
        c(i+1) <= (a(i) and b(i)) or
                (a(i) and c(i)) or
                (b(i) and c(i));
       -- sum(i) <= a(i) xor b(i) xor c(i);
        end generate;
    sum(0) <= a(0) xor b(0) xor c(0);
    sum(1) <= a(1) xor b(1) xor c(1);
    sum(2) <= a(2) xor b(2) xor c(2);
    sum(3) <= a(3) xor b(3) xor c(3);
    sum(4) <= a(4) xor b(4) xor c(4);
    sum(5) <= a(5) xor b(5) xor c(5);
    sum(6) <= a(6) xor b(6) xor c(6);
    sum(7) <= a(7) xor b(7) xor c(7);
        cout <= c(n);
end;
