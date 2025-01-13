library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 
entity Counter_pro_tb is
end Counter_pro_tb;

architecture arch of Counter_pro_tb is
	constant clock_period : time 	  :=10ns;
	signal s_clk      	  : std_logic :='0';
	signal s_reset    	  : std_logic ;
	
	signal s_set_1	      : std_logic ;
	signal s_enable_1	  : std_logic ;
	signal s_MaxNumber_1  : unsigned (7 downto 0) 			:="00010001" ;
	signal s_MinNumber_1  : unsigned (7 downto 0) 			:="00000000" ;
	signal s_error_1	  : std_logic :='0';
	signal s_count_1      : std_logic_vector (7 downto 0)	:="00000000" ;
	
	signal s_set_2	  	  : std_logic ;
	signal s_enable_2	  : std_logic ;
	signal s_MaxNumber_2  : unsigned (7 downto 0)			:="00001001" ;
	signal s_MinNumber_2  : unsigned (7 downto 0)			:="00000000" ;
	signal s_error_2	  : std_logic :='0';
	signal s_count_2      : std_logic_vector (7 downto 0)	:="00000000" ;
	
begin
	counter_inst: entity work.counter_pro
		port map(
			i_clk => s_clk,
			i_reset => s_reset,
			
			i_set_1 => s_set_1,
			i_1_SetMaxNumber => s_MaxNumber_1,
			i_1_SetMinNumber => s_MinNumber_1,
			i_enable_1		 => s_enable_1   ,
			o_error_1 		 => s_error_1	 ,
			o_1_count 		 => s_count_1	 ,
			
			
			i_set_2 => s_set_2,
			i_2_SetMaxNumber => s_MaxNumber_2,
			i_2_SetMinNumber => s_MinNumber_2,
			i_enable_2		 => s_enable_2   ,
			o_error_2		 => s_error_2	 ,
			o_2_count => s_count_2
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
		s_set_1 <= '1';
		s_set_2 <= '0';
		s_enable_1 <= '0';
		s_enable_2 <= '0';
		wait for clock_period*2;
		s_reset <= '0';
		s_enable_1 <= '1';
		wait for clock_period;
		s_enable_2 <= '1';
		wait for clock_period*21;
		s_MinNumber_2 <= "00000101";
		wait for clock_period*14;
		s_MaxNumber_1 <= "00001010";
		s_MinNumber_1 <= "00000101";
		s_MaxNumber_2 <= "00000011";
		wait for clock_period*13;
		s_MaxNumber_1 <= "00001100";
		s_MinNumber_1 <= "00000110";
		s_MaxNumber_2 <= "00001010";
		s_MinNumber_2 <= "00000101";
		s_set_1 <= '0';
		s_set_2 <= '1';
		wait for clock_period*21;

		wait;
	end process;
	
end arch;
