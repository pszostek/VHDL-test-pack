--
-- Author: Pawel Szostek (pawel.szostek@cern.ch)
-- Date: 27.07.2011

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

package pkg is
    constant FIFTEEN : integer := 15;
    constant TEN : integer := 10;
    constant ZERO_BIT : std_logic := '0';
    constant ZERO : integer := 0;
end package;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity count_ones is
    port (vec : in std_logic_vector(15 downto 0);
        count : out unsigned(4 downto 0));
end;

use work.pkg.all;

--let's use some constants (not absolutely necessary...)
architecture behaviour of count_ones is
begin
    process(vec)
        variable ones : unsigned(4 downto 0);
    begin
        ones := to_unsigned(ZERO, FIFTEEN-TEN);
        for i in FIFTEEN downto 0 loop
            if vec(i) = ZERO_BIT then
                next;
            end if;
            ones := ones + 1;
        end loop;
        count <= ones;
    end process;
end;
