--
-- Author: Pawel Szostek (pawel.szostek@cern.ch)
-- Date: 27.07.2011

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY  mux4_1 IS
   PORT (s0               : IN  STD_LOGIC;
         s1               : IN  STD_LOGIC;
         in0              : IN  STD_LOGIC;
         in1              : IN  STD_LOGIC;
         in2              : IN  STD_LOGIC;
         in3              : IN  STD_LOGIC;
         output           : OUT STD_LOGIC
        );
END mux4_1;

ARCHITECTURE case_example OF mux4_1 IS

BEGIN 

mux:PROCESS(s0, s1, in0, in1, in2, in3)
BEGIN

  CASE s1 & s0 IS --use concatenation
    WHEN  "00"  =>  output <= in0;
    WHEN  "01"  =>  output <= in1;
    WHEN  "10"  =>  output <= in2;
    WHEN  "11"  =>  output <= in3;
  END CASE;

END PROCESS mux;
  
END case_example;
