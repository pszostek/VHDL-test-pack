--
-- Author: Pawel Szostek (pawel.szostek@cern.ch)
-- Date: 27.07.2011

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

entity and2 is
    port (
        in1, in2 : in std_ulogic;
        output : out std_ulogic
    );
end and2;
    
architecture dummy of and2 is
begin
    output <= in1 and in2;
end dummy;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

entity mixer is
    port (
        in1_v: in std_logic_vector(7 downto 0);
        in2_v : in std_logic_vector(7 downto 0);
        in3_v : in std_logic_vector(7 downto 0);
        output_v : out std_logic_vector(7 downto 0)
    );
end mixer;

architecture arch of mixer is
    component and2 is
        port (
            in1, in2 : in std_ulogic;
            output : out std_ulogic
        );
    end component and2;
begin
    dupa: for i in 0 to 7 generate --if-generate inside for-generate statement
    begin
        R0: if(i mod 2 = 0) generate begin U0: and2 port map (in1=>in1_v(i), in2=>in2_v(i), output=>output_v(i)); end generate;
        R1: if(i mod 2 = 1) generate begin U1: and2 port map (in1=>in2_v(i), in2=>in3_v(i), output=>output_v(i)); end generate;
    end generate;
end arch;
