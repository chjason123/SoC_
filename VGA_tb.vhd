LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

-- 引用外部 VGA 模塊
use work.VGA;  -- 使用 work.VGA

ENTITY VGA_tb IS
END VGA_tb;

ARCHITECTURE behavior OF VGA_tb IS
    -- Signals for the UUT (Unit Under Test)
    SIGNAL clk        : STD_LOGIC := '0';
    SIGNAL rst        : STD_LOGIC := '0';
    SIGNAL red_out    : STD_LOGIC_VECTOR(3 downto 0);
    SIGNAL green_out  : STD_LOGIC_VECTOR(3 downto 0);
    SIGNAL blue_out   : STD_LOGIC_VECTOR(3 downto 0);
    SIGNAL h_sync     : STD_LOGIC;
    SIGNAL v_sync     : STD_LOGIC;

    -- Clock period definition (100 MHz)
    CONSTANT clk_period : TIME := 10 ns;

BEGIN
    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.VGA
    GENERIC MAP (
        h_pixels  => 800,
        h_fp      => 56,
        h_pulse   => 120,
        h_bp      => 64,
        h_pol     => '1',
        v_pixels  => 600,
        v_fp      => 37,
        v_pulse   => 6,
        v_bp      => 23,
        v_pol     => '1'
    )
    PORT MAP (
        clk        => clk,
        rst        => rst,
        red_out    => red_out,
        green_out  => green_out,
        blue_out   => blue_out,
        h_sync     => h_sync,
        v_sync     => v_sync
    );

    -- Clock generation process
    CLOCK_GEN : PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR clk_period / 2;
        clk <= '1';
        WAIT FOR clk_period / 2;
    END PROCESS;

    -- Stimulus process
    STIM_PROC : PROCESS
    BEGIN
        -- Reset the system
        rst <= '1';
        WAIT FOR 100 ns;
        rst <= '0';
        
        -- Wait for a few clock cycles and observe the output
        WAIT ;
        
        -- Apply some further stimuli if needed, and observe behavior
        -- You can repeat the above steps or add more time to simulate different conditions
        
        -- End the simulation after some time

    END PROCESS;
END behavior;
