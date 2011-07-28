--
-- Author: Pawel Szostek (pawel.szostek@cern.ch)
-- Date: 28.07.2011

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;
use ieee.std_logic_arith;

entity repeater is
    port (a: in std_logic_vector(1 downto 0);
          signed_a : out integer range -3 to 3;
          unsigned_a : out integer range 0 to 3;
          a_incr : out std_logic_vector(1 downto 0);
          a_inc : out std_logic_vector(1 downto 0)
    );
end;

architecture behaviour of repeater is
begin
   signed_a <= conv_integer(a);
   unsigned_a <= conv_integer('0'&a);
   a_incr <= std_logic_vector(unsigned(a)+1);
   a_inc  <= std_logic_vector(to_unsigned(a, a'length)+1);
end;
