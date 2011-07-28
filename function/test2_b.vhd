--
-- Author: Pawel Szostek (pawel.szostek@cern.ch)
-- Date: 27.07.2011

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;


use work.fun_pkg.all;

entity bin2gray IS
PORT (input               : IN  STD_LOGIC_VECTOR(7 downto 0);
        strobe                 : IN STD_LOGIC;
        output             : OUT STD_LOGIC_VECTOR(7 downto 0)
        );
END bin2gray;

ARCHITECTURE function_example OF bin2gray  IS
BEGIN 
    p1:PROCESS(strobe, input)
    BEGIN
        if strobe='1' then
            output <= bin2gray_fun(input);
        end if;

    END PROCESS p1;
END function_example;
