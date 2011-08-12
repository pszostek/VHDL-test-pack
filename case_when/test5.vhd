--
-- Author: Pawel Szostek (pawel.szostek@cern.ch)
-- Date: 27.07.2011

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY  mux4to2_vhdl_1 IS
   PORT (s0               : IN  STD_LOGIC;
         in0              : IN  STD_LOGIC;
         in1              : IN  STD_LOGIC;
         in2              : IN  STD_LOGIC;
         in3              : IN  STD_LOGIC;
         out0             : OUT STD_LOGIC;
         out1             : OUT STD_LOGIC
        );
END mux4to2_vhdl_1;

ARCHITECTURE case_example OF mux4to2_vhdl_1 IS

BEGIN 

mux:PROCESS(s0, in0, in1, in2, in3)
BEGIN

  CASE s0 IS 
    WHEN  '0'  =>  out0 <= in0;
                    out1 <= in1;
    WHEN  '1'  =>  out0 <= in2;
                    out1 <= in3;
    when others => out0 <= 'X';
                    out1 <= 'X';
  END CASE;

END PROCESS mux;
  
END case_example;
