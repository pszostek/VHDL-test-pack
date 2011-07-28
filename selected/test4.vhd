--
-- Author: Pawel Szostek (pawel.szostek@cern.ch)
-- Date: 28.07.2011

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

entity  equal IS
   port (d1,d2              : IN  STD_LOGIC_VECTOR(15 downto 0);
         output             : OUT STD_LOGIC
        );
END equal;

ARCHITECTURE when_example OF equal IS

-- =============================================================================
begin
    L: output <= '1' when d1 = d2 else '0'; --vector comparison in the condition
end when_example;
