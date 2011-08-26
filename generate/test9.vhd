library ieee;
use ieee.std_logic_1164.all;

entity test_dff is
  
  generic (
    g_count : integer);

  port (
    clk : in std_logic;
    d: in std_logic_vector(g_count-1 downto 0);
    q: out std_logic_vector(g_count-1 downto 0));

end test_dff;

architecture rtl of test_dff is

begin  -- rtl

  gen_flipflops: for i in 0 to g_count-1 generate
    process(clk)
      begin
        if rising_edge(clk) then
          q(i) <=d (i);
        end if;
      end process;
  end generate gen_flipflops;
                   
end rtl;
