--
-- Author: Pawel Szostek (pawel.szostek@cern.ch)
-- Date: 28.07.2011

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

entity dummy is
    port (d1, d2, d3, d4  : in std_logic_vector(2 downto 0);
          output : out std_logic
    );
end;

architecture behaviour of dummy is
    signal c1, c2 : boolean;
begin
    c1 <= d1 = d2;
    c2 <= d3 = d4;
    with c1 = c2 select --use boolean comparison in the criterion expression
        output <=  '1' when true,
                   '0' when false,
                   'X' when others;
end;
