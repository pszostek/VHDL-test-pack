--
-- Author: Pawel Szostek (pawel.szostek@cern.ch)
-- Date: 27.07.2011

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity  counter IS
   PORT (ena               : IN  STD_LOGIC;
         clk              : IN STD_LOGIC;
         reset            : IN std_logic;
         count            : OUT STD_LOGIC_VECTOR(7 downto 0)
        );
END counter;

ARCHITECTURE case_example OF counter IS
   signal inner_count : std_logic_vector(7 downto 0);
BEGIN 

inner_count <= (others => '0') when reset = '1';
count <= inner_count;

p1:PROCESS(clk)
BEGIN
    case ena IS
      WHEN '1' => inner_count <= std_logic_vector(unsigned(inner_count)+1);
      WHEN '0' => inner_count <= inner_count;
      WHEN OTHERS => inner_count <= (others => 'X');
    end case;
END PROCESS p1;

END case_example;
