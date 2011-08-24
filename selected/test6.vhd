--
-- Author: Pawel Szostek (pawel.szostek@cern.ch)
-- Date: 28.07.2011

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

entity flip_flop is
    port (d,clk,rst  : in std_logic;
        q        : out std_logic
    );
end;

architecture behaviour of flip_flop is
begin
    FF: q <= '0' when rst = '1' else d when rising_edge(clk); --assign only on clock's rising edge
end;
