--
-- Author: Pawel Szostek (pawel.szostek@cern.ch)
-- Date: 28.07.2011

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

entity one_counter is
    port (input  : in std_logic_vector(2 downto 0);
          output : out std_logic_vector(1 downto 0)
    );
end;

architecture behaviour of one_counter is
begin
    with input select
        output <=  "00" when "000",
                   "01" when "001" | "010" | "100" , --several alternatives
                   "10" when "011" | "101" | "110" ,
                   "11" when "111",
                   "XX" when others;
end;
