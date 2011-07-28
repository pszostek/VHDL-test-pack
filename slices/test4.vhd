--
-- Author: Pawel Szostek (pawel.szostek@cern.ch)
-- Date: 27.07.2011

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

package array_pkg is
    constant SIZE : integer := 16;
    type my_array is array(0 to SIZE-1) of std_logic_vector(SIZE-1 downto 0);
end package;

use work.array_pkg.all;

entity dummy is
    port (o1: out my_array);
end;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

architecture behaviour of dummy is
    signal zeros : std_logic_vector(SIZE-1 downto 0);
begin
    o1 <= (others => zeros);
end;
