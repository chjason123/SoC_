library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.ALL;
entity counter_pro is
	Port ( 
		i_clk            		:  in std_logic;
		i_reset		   		:  in std_logic;
		i_set_1			   	:  in std_logic;
		i_set_2			   	:  in std_logic;
		i_enable_1			:  in std_logic;
		i_enable_2			:  in std_logic;
		i_1_SetMaxNumber	:  in unsigned (7 downto 0);
		i_1_SetMinNumber	:  in unsigned (7 downto 0);
		i_2_SetMaxNumber 	:  in unsigned (7 downto 0);
		i_2_SetMinNumber 	:  in unsigned (7 downto 0);
		o_error_1			: out std_logic;
		o_error_2			: out std_logic;
		o_1_count        	: out std_logic_vector  (7 downto 0);
		o_2_count        	: out std_logic_vector  (7 downto 0)
	);
end counter_pro;


architecture Behavioral of counter_pro is
	signal MaxNumber_1: unsigned (7 downto 0) ;
	signal MinNumber_1: unsigned (7 downto 0) ;
	signal MaxNumber_2: unsigned (7 downto 0) ;
	signal MinNumber_2: unsigned (7 downto 0) ;
	signal count_1: unsigned (7 downto 0) := "00000000";
	signal count_2: unsigned (7 downto 0) := "00000000";
	signal error1 : std_logic := '0';
	signal error2 : std_logic := '0';
begin
	
	Set_MaxNumber : process(i_reset,i_1_SetMaxNumber,i_2_SetMaxNumber,i_clk)
	begin
		if i_reset = '1' then
			MaxNumber_1 <= "00011001";
			MaxNumber_2 <= "00011001";
		else
			MaxNumber_1 <=i_1_SetMaxNumber;
			MaxNumber_2 <=i_2_SetMaxNumber;
		end if;
	end process Set_MaxNumber;
	
	Set_MinNumber : process(i_reset,i_1_SetMinNumber,i_2_SetMinNumber,i_clk)
	begin
		if i_reset = '1' then
			MinNumber_1 <= "00000000";
			MinNumber_2 <= "00000000";
		else
			MinNumber_1 <=i_1_SetMinNumber;
			MinNumber_2 <=i_2_SetMinNumber;
		end if;
	end process Set_MinNumber;
	
	counter_1 : process(i_clk) 
	begin
		if (i_1_SetMaxNumber > i_1_SetMinNumber) then
			if (i_set_1 = '1') then
				if i_reset = '1' then
					count_1 <= (others => '0');
				elsif (rising_edge(i_clk) and (i_enable_1 = '1')) then
					if ((count_1 >= MaxNumber_1) or (count_1 < MinNumber_1))  then
						count_1 <= MinNumber_1 ;
					else
						count_1 <= count_1 + "1";  
					end if;
				end if;
			elsif (i_set_1 = '0')  then
				if i_reset = '1' then
					count_1 <= (others => '0');
				elsif (rising_edge(i_clk) and (i_enable_1 = '1')) then
					if ((count_1 <= MinNumber_1) or (count_1 > MaxNumber_1)) then
						count_1 <= MaxNumber_1 ;
					else
						count_1 <= count_1 - "1";  
					end if;
				end if;
			end if;
			o_error_1 <= '0';
		else
			o_error_1 <= '1';
		end if;
		o_1_count <= std_logic_vector(count_1);
	end process counter_1;
	
	counter_2 : process(i_clk) 
	begin
		if(i_2_SetMaxNumber > i_2_SetMinNumber) then
			if (i_set_2 = '1') then
				if i_reset = '1' then
					count_2 <= (others => '0');
				elsif (rising_edge(i_clk) and (i_enable_2 = '1')) then
					if ((count_2 >= MaxNumber_2) or (count_2 < MinNumber_2))  then
						count_2 <= MinNumber_2 ;
					else
						count_2 <= count_2 + "1";  
					end if;
				end if;
			elsif (i_set_2 = '0')  then
				if i_reset = '1' then
					count_2 <= (others => '0');
				elsif (rising_edge(i_clk) and (i_enable_2 = '1')) then
					if ((count_2 <= MinNumber_2) or (count_2 > MaxNumber_2)) then
						count_2 <= MaxNumber_2 ;
					else
						count_2 <= count_2 - "1";  
					end if;
				end if;
			end if;
			o_error_2 <= '0';
		else
			o_error_2 <= '1';
		end if;
		o_2_count <= std_logic_vector(count_2);
	end process counter_2;
	
end Behavioral;