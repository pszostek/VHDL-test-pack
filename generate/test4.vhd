--
-- Author: Pawel Szostek (pawel.szostek@cern.ch)
-- Date: 27.07.2011

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

entity flip_flop is
    generic (sync: boolean);
    port (d,clk,rst : in std_logic;
        q : out std_logic);
end;

architecture test of flip_flop is
    signal q_internal : std_logic;
begin
    q <= q_internal;
    gen: if sync generate --usage of if-generate statements
        p: process(clk) begin
            if(rising_edge(clk) and rst = '1') then
                q_internal <= '0';
            elsif(rising_edge(clk)) then
                q_internal <= d;
            end if;
        end process;
    end generate;
    not_gen: if not sync generate
        p: process(clk, rst) begin
            if(rst = '1') then
                q_internal <= '0';
            elsif(rising_edge(clk)) then
                q_internal <= d;
            end if;
        end process;
    end generate;
end;
