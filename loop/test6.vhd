--
-- Author: Pawel Szostek (pawel.szostek@cern.ch)
-- Date: 28.07.2011

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity decoder is
    port (A : in integer range 0 to 4;
          Z : out std_logic_vector(0 to 3)
    );
end;

use work.pkg.all;

architecture behaviour of decoder is
begin
    process (A)
        variable I : integer range 0 to 4;
    begin
        Z <= "0000";
        I := 0;
        while (I <= 3) loop --while loop
            if (A = I) then
                Z(I) <= '1';
            end if;
            I := I + 1;
        end loop;
    end process;
end;
