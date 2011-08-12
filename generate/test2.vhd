--
-- Author: Pawel Szostek (pawel.szostek@cern.ch)
-- Date: 27.07.2011

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

entity dummy is
    port (
        input : in std_logic_vector(7 downto 0);
        output : out std_logic_vector(7 downto 0)
    );
end dummy;

architecture arch of dummy is
begin
    INVERT:
    for i in 0 to 7 generate
        output(i) <= input(7-i);
    end generate INVERT;
end arch;
