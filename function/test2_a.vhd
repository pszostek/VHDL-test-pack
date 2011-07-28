--
-- Author: Pawel Szostek (pawel.szostek@cern.ch)
-- Date: 27.07.2011

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

package fun_pkg is
    FUNCTION bin2gray_fun(B1:std_logic_vector) return std_logic_vector;
end fun_pkg;
package body fun_pkg is
    FUNCTION bin2gray_fun(B1:std_logic_vector) return std_logic_vector is
        VARIABLE G1 : std_logic_vector(B1'high downto B1'low) ;
    BEGIN
        G1(G1'high):=B1(B1'high);
        for i in B1'high-1 downto B1'low loop
            G1(i) := B1(i+1) XOR B1(i);
        end loop;
        return G1;
    end bin2gray_fun; -- end function
end fun_pkg;
