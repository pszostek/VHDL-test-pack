--
-- Author: Pawel Szostek (pawel.szostek@cern.ch)
-- Date: 28.07.2011

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

entity mux4to1 is
    port (s0, s1  : in std_logic;
          d0,d1,d2,d3: in std_logic;
          output : out std_logic
    );
end;

architecture behaviour of mux4to1 is
    subtype T is std_logic_vector(0 to 1);
begin
    with T'(s1 & s0) select --concatenation in select criterion
        output <=  d0 when "00",
                   d1 when "01" ,
                   d2 when "10" ,
                   d3 when "11",
                   'X' when others;
end;