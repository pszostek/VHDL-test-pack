--
-- Author: Pawel Szostek (pawel.szostek@cern.ch)
-- Date: 27.07.2011

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

entity REG is
    port (
        D, CLK, RESET : in std_ulogic;
        Q             : out std_ulogic
    );
end REG;

architecture dummy of REG is
    signal q_int : std_ulogic;
begin
    Q <= q_int;
    p:process(CLK, RESET)
    begin
        if RESET = '0' then
            q_int <= '0';
        elsif rising_edge(CLK) then
            q_int <= D;
        end if;
    end process;
end dummy;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

entity REG_BANK is
    port (
       DIN : in std_ulogic_vector(3 downto 0);
       DOUT : out std_ulogic_vector(3 downto 0);
       RESET : in std_ulogic;
       CLK : in std_ulogic
    );
end;

architecture GEN of REG_BANK is
  component REG
    port(D,CLK,RESET : in  std_ulogic;
         Q           : out std_ulogic);
  end component;
begin
   GEN_REG:
   for I in 0 to 3 generate
      REGX : REG port map
        (DIN(I), CLK, RESET, DOUT(I));
   end generate GEN_REG;
end GEN;
  