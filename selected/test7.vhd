--
-- Author: Pawel Szostek (pawel.szostek@cern.ch)
-- Date: 28.07.2011

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

entity equal is
    port (d1, d2  : in std_logic_vector(2 downto 0);
          output : out std_logic
    );
end;

architecture behaviour of equal is
begin
    with d1 = d2 select
        output <=  '1' when true,
                   '0' when false,
                   'X' when others;
end;
