--
-- Author: Pawel Szostek (pawel.szostek@cern.ch)
-- Date: 27.07.2011

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity count_trailing_zeros is
    port (vec : in std_logic_vector(15 downto 0);
        count : out unsigned(4 downto 0));
end;

architecture behaviour of count_trailing_zeros is
begin
    process(vec)
        variable result : unsigned(4 downto 0);
    begin
        result := to_unsigned(0, result'length);
        for i in vec'reverse_range loop
            exit when vec(i) = '1'; --exit statement
            result := result + 1;
        end loop;
        count <= result;
    end process;
end;
