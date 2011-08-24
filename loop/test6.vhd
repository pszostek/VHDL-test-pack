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
        variable i : natural;
    begin
        ones := to_unsigned(0, 5);
        i := 0;
        while i < 16 loop
            if vec(i) = '0' then
                i := i+1;
                next;
            end if;
            ones := ones + 1;
            i := i+1;
        end loop;
        count <= ones;
    end process;
end;
