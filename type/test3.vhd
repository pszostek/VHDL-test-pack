--
-- Author: Pawel Szostek (pawel.szostek@cern.ch)
-- Date: 28.07.2011

LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity comparator is
    port (a: in std_logic_vector(3 downto 0);
          b: in std_logic_vector(3 downto 0);
          comp : out std_logic
    );
end;

architecture behaviour of comparator is
    function to_bit(arg: boolean) return std_logic is --user-defined convertion function
    begin
        case arg is
            when true => return '1';
            when false => return '0';
        end case;
    end;
begin
    comp <= to_bit(a=b);
end;
