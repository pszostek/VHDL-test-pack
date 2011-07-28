--
-- Author: Pawel Szostek (pawel.szostek@cern.ch)
-- Date: 27.07.2011

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

entity xor_vector is
    generic(n: integer);
    port (a_i : in std_logic_vector(n-1 downto 0);
        b_i : in std_logic_vector(n-1 downto 0);
        c_o : out std_logic_vector(n*n-1 downto 0)
    );
end xor_vector;

architecture behaviour of xor_vector is
begin
    gen_o: for i in n-1 downto 0 generate
        gen_i: for j in n-1 downto 0 generate
            c_o(n*i+j) <= a_i(i) xor b_i(j);
        end generate gen_i;
    end generate gen_o;
end;
