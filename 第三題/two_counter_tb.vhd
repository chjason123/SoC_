library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity two_counter_tb is

end two_counter_tb;

architecture Behavioral of two_counter_tb is
 
    signal s_clk    : std_logic := '0';
    signal s_rst    : std_logic := '0';
    signal s_count1 : std_logic_vector(3 downto 0) := "0000";
    signal s_count2 : std_logic_vector(3 downto 0) := "0000";
    constant CLK_PERIOD : time := 10 ns;

begin

    TurnsCounter_inst: entity work.two_counter
        port map (
            i_clk    => s_clk,
            i_rst    => s_rst,
            o_count1 => s_count1,
            o_count2 => s_count2
        );

    clk_process: process
    begin
        while true loop
            s_clk <= '0';
            wait for CLK_PERIOD / 2;
            s_clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    stimulus_process: process
    begin
        s_rst <= '0';
        wait for 20 ns;
        s_rst <= '1';

        wait for 2000 ns;

        wait;
    end process;

end Behavioral;
