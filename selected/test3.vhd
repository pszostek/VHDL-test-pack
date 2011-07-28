--
-- Author: Pawel Szostek (pawel.szostek@cern.ch)
-- Date: 28.07.2011

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

entity  mux4_1 IS
   port (s0               : IN  STD_LOGIC;
         s1               : IN  STD_LOGIC;
         in0              : IN  STD_LOGIC;
         in1              : IN  STD_LOGIC;
         in2              : IN  STD_LOGIC;
         in3              : IN  STD_LOGIC;
         output           : OUT STD_LOGIC
        );
END mux4_1;

ARCHITECTURE when_example OF mux4_1 IS

-- =============================================================================
BEGIN
    --concatenation inside when
    output <= in0 WHEN (s1 & s0)="00" ELSE
              in1 WHEN (s1 & s0)="01" ELSE
              in2 WHEN (s1 & s0)="10" ELSE
              in3 WHEN (s1 & s0)="11" ELSE
              'X';

END when_example;
