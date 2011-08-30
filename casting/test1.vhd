--
-- Author: Pawel Szostek (pawel.szostek@cern.ch)
-- Date: 28.07.2011

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

ENTITY  cnt IS
   PORT (clk               : IN  STD_LOGIC;
        ena                 : IN STD_LOGIC;
        reset               : IN STD_LOGIC;
       counter_o             : OUT STD_LOGIC_VECTOR(7 downto 0)
        );
END cnt;

ARCHITECTURE case_example OF cnt IS
    signal counter : std_logic_vector(7 downto 0);
BEGIN 
    counter_o <= counter;
p1:PROCESS(clk)
BEGIN
    if rising_edge(clk) then
        if reset = '1' then
            counter <= "00000000";
        else if ena = '1' then
            counter <= std_logic_vector(unsigned(counter)+1);
        end if;end if;
    end if;
END PROCESS p1;
  
END case_example;
