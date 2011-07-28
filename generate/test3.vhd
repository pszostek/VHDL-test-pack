--
-- Author: Pawel Szostek (pawel.szostek@cern.ch)
-- Date: 27.07.2011

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

entity one_to_one is
    port (
        input : in std_ulogic;
        output : out std_ulogic
    );
end entity one_to_one;
    
architecture dummy of one_to_one is
begin
    output <= input;
end dummy;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

entity inverter is
    port (
        input_v : in std_logic_vector(7 downto 0);
        output_v : out std_logic_vector(7 downto 0)
    );
end inverter;

architecture arch of inverter is
    component one_to_one is
        port (
            input : in std_ulogic;
            output : out std_ulogic
        );
    end component;
begin
    gen: for i in 0 to 7 generate --component instantiation inside for-generate statement
        comp: one_to_one port map (input => input_v(i), output => output_v(7-i));
    end generate;
end arch;
