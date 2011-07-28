--
-- Author: Pawel Szostek (pawel.szostek@cern.ch)
-- Date: 27.07.2011

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL; 

ENTITY  mux2_1 IS
   PORT (s0               : IN  STD_LOGIC;
         in0              : IN  STD_LOGIC;
         in1              : IN  STD_LOGIC;
         output           : OUT STD_LOGIC
        );
END mux2_1;

ARCHITECTURE case_example OF mux2_1 IS
  signal sel  :  STD_LOGIC_VECTOR(1 DOWNTO 0);
BEGIN 

sel(0) <= s0;

mux:PROCESS(s0, in0, in1)
BEGIN

  CASE sel(0) IS --use signal slice in select criterion 
    WHEN  '0'  =>  output <= in0;
    WHEN  '1'  =>  output <= in1;
    WHEN OTHERS => output <= 'X';
  END CASE;

END PROCESS mux;
  
END case_example;
