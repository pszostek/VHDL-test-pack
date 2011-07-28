--
-- Author: Pawel Szostek (pawel.szostek@cern.ch)
-- Date: 27.07.2011

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

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
  signal sel  :  STD_LOGIC_VECTOR(1 DOWNTO 0);
BEGIN 

  sel(0) <= s0;
  sel(1) <= s1;

mux:PROCESS(s0, s1, in0, in1, in2, in3)
BEGIN
  CASE sel IS --use signal as select criterion
    WHEN  "00"  =>  output <= in0;
    WHEN  "01"  =>  output <= in1;
    WHEN  "10"  =>  output <= in2;
    WHEN  "11"  =>  output <= in3;
    WHEN OTHERS =>  output <= 'X';
  END CASE;

END PROCESS mux;
  
END case_example;
