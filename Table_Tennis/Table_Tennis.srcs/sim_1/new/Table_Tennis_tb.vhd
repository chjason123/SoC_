library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Table_Tennis_tb is
    -- No ports for a testbench
end Table_Tennis_tb;

architecture Behavioral of Table_Tennis_tb is
    -- Component declaration
    component Table_Tennis
        port (
            i_clk       : in std_logic;
            i_rst       : in std_logic;
            i_R_button  : in std_logic;
            i_L_button  : in std_logic;
			o_FSM_state : out std_logic_vector(2 downto 0);
            o_led       : out std_logic_vector(7 downto 0)
        );
    end component;

    -- Signals for the testbench
    signal i_clk      : std_logic := '0';
    signal i_rst      : std_logic := '0';
    signal i_R_button : std_logic := '0';
    signal i_L_button : std_logic := '0';
	signal o_FSM_state :  std_logic_vector(2 downto 0);
    signal o_led      : std_logic_vector(7 downto 0);
    --signal o_ball     : std_logic_vector(7 downto 0);
    -- Clock period constant
    constant clk_period : time := 10 ns;
begin
    -- Instantiate the Unit Under Test (UUT)
    uut: Table_Tennis
        port map (
            i_clk       => i_clk,
            i_rst       => i_rst,
            i_R_button  => i_R_button,
            i_L_button  => i_L_button,
			o_FSM_state => o_FSM_state,
            o_led       => o_led
        );

    -- Clock process
    clk_process: process
    begin
        while True loop
            i_clk <= '0';
            wait for clk_period / 2;
            i_clk <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Stimulus process
    stimulus_process: process
    begin
        -- Reset system
        i_rst <= '0';
        wait for clk_period;
        i_rst <= '1';
        wait for 9*clk_period;
        i_R_button <= '1';
        wait for 3*clk_period;
        i_R_button <= '0';

        wait for 200 * clk_period; -- Wait for ball to move
		wait;
    end process;

end Behavioral;
