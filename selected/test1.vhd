--
-- Author: Pawel Szostek (pawel.szostek@cern.ch)
-- Date: 28.07.2011

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

entity decoder is
    port (input  : in std_logic_vector(3 downto 0);
          err    : out std_logic;
          output : out std_logic_vector(1 downto 0)
    );
end;

architecture behaviour of decoder is
begin
    with input select
        output <=  "00" when "0001",
                   "01" when "0010",
                   "10" when "0100",
                   "11" when "1000",
                   "XX" when others;
    err <= '1' when input /= "0001" and input /= "0010" and input /= "0100" and input /= "1000" else '0';
end;
