--
-- Author: Pawel Szostek (pawel.szostek@cern.ch)
-- Date: 27.07.2011

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;


ENTITY  bin2gray IS
PORT (input               : IN  STD_LOGIC_VECTOR(7 downto 0);
        strobe                 : IN STD_LOGIC;
        output             : OUT STD_LOGIC_VECTOR(7 downto 0)
        );
END bin2gray;

ARCHITECTURE function_example OF bin2gray  IS
    FUNCTION bin2gray(B1:std_logic_vector) return std_logic_vector is
        VARIABLE G1 : std_logic_vector(B1'high downto B1'low) ;
    BEGIN
        G1(G1'high):=B1(B1'high);
        L: for i in B1'high-1 downto B1'low loop
            G1(i) := B1(i+1) XOR B1(i);
        end loop;
        return G1;
    end bin2gray; -- end function
BEGIN 
p1:PROCESS(strobe)
    BEGIN

    if strobe='1' then
        output <= bin2gray(input);
    end if;

    END PROCESS p1;
end function_example;
  
