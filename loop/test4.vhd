--
-- Author: Pawel Szostek (pawel.szostek@cern.ch)
-- Date: 27.07.2011

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity count_ones is
    port (vec : in std_logic_vector(15 downto 0);
        count : out unsigned(4 downto 0));
end;

architecture behaviour of count_ones is
begin
    process(vec)
        variable ones : unsigned(4 downto 0);
    begin
        ones := to_unsigned(0, 5);
        for i in 15 downto 0 loop
            if vec(i) = '0' then
                next;
            end if;
            ones := ones + 1;
        end loop;
        count <= ones;
    end process;
end;
