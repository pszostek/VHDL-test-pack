--
-- Author: Pawel Szostek (pawel.szostek@cern.ch)
-- Date: 27.07.2011

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

entity sel is
    generic(n: integer);
    port (a_i : in std_logic_vector(n-1 downto 0);
        b_o : out std_logic_vector(n-1 downto 0);
        sel : in std_logic
    );
end sel;

architecture behaviour of sel is
    signal mix : std_logic_vector(n-1 downto 0);
begin
    L1: for i in n-1 downto 0 generate
        ones:  if(i mod 2 = 0) generate begin mix(i) <= '0'; end generate;
        zeros: if(i mod 2 = 1) generate begin mix(i) <= '1'; end generate;
    end generate;

    L2: for i in n-1 downto 0 generate
        b_o(i) <= a_i(i) when (sel = '1') else mix(i);
    end generate;
end;
