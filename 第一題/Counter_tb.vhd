library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 
entity Counter_tb is
end Counter_tb;

architecture arch of Counter_tb is
	constant clock_period : time :=10ns;
	signal s_clk: std_logic :='0';
	signal s_reset: std_logic :='1';
	signal s_upcount: unsigned(3 downto 0);
	signal s_downcount: std_logic_vector(3 downto 0);
begin
	up_counter_inst: entity work.Up_Counter
		port map(
			i_clk => s_clk,
			i_reset => s_reset,
			o_count => s_upcount
		);
		
	down_counter_inst: entity work.Down_Counter
		port map(
			i_clk => s_clk,
			i_reset => s_reset,
			o_count => s_downcount
		);
		
	
	clk_process :process
	begin
		while true loop
			s_clk <= '0';
			wait for clock_period/2;  --clock_period為週期
			s_clk <= '1';
			wait for clock_period/2;
		end loop;
	end process;
	
	stim_process :process
	begin
		s_reset <= '1';
		wait for clock_period * 10;
		s_reset <= '0';
		wait ;
	end process;
	
end arch;
