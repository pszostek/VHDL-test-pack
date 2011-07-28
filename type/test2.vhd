--
-- Author: Pawel Szostek (pawel.szostek@cern.ch)
-- Date: 28.07.2011

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

entity repeater is
    port (a: in std_logic_vector(3 downto 0); --inputs have different lenghts
          b: in std_ulogic_vector(1 downto 0);
          sum : out integer range 0 to 31 --output is integer
    );
end;

architecture behaviour of repeater is
begin
    --do some legal conversion
    sum <= conv_integer(a) + conv_integer(std_logic_vector(b));
    --no idea what will be given to the output, this should me checked with some prof. tool
    --anyway this operations are allowed
end;
