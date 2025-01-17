library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;
entity counter_pro is
	Port ( 
		i_clk            		:  in std_logic;
		i_reset		   		:  in std_logic;
		i_enable_1			:  in std_logic;
		i_1_SetMaxNumber	:  in unsigned (3 downto 0);
		i_1_SetMinNumber	:  in unsigned (3 downto 0);
		o_1_count        	: out std_logic_vector  (3 downto 0);
		o_2_count        	: out std_logic_vector  (3 downto 0)
	);
end counter_pro;


architecture Behavioral of counter_pro is
	signal MaxNumber_1: unsigned (3 downto 0) ;
	signal MinNumber_1: unsigned (3 downto 0) ;
	signal MaxNumber_2: unsigned (3 downto 0) ;
	signal MinNumber_2: unsigned (3 downto 0) ;
	signal set_1 : std_logic := '0';
	signal set_2 : std_logic := '1';
	signal count_1: unsigned (3 downto 0) := "0000";
	signal count_2: unsigned (3 downto 0) := "0000";
	signal counter: std_logic_vector(24 downto 0);
	signal enable : std_logic;
begin
	o_1_count <= std_logic_vector(count_1);
	o_2_count <= std_logic_vector(count_2);
	clk_Frequency_Division : process(i_clk,i_reset)
	begin
		if i_reset = '1' then
			counter<=(others => '0');
		elsif rising_edge(i_clk) then
			counter <= counter + 1;
		end if;
	end process;
	
	Set_enable : process(i_reset,i_clk)
	begin
		if i_reset = '1' then
			enable <= '0';
		elsif i_enable_1 = '1' then
			enable<='1';
		end if;
	end process;
	
	Set_MaxNumber : process(i_reset,i_1_SetMaxNumber,i_clk)
	begin
		if i_reset = '1' then
			MaxNumber_1 <= "1001";
			--MaxNumber_2 <= "1001";
		else
			MaxNumber_1 <=i_1_SetMaxNumber;
			MaxNumber_2 <=i_1_SetMaxNumber;
		end if;
	end process Set_MaxNumber;
	
	Set_MinNumber : process(i_reset,i_1_SetMinNumber,i_clk)
	begin
		if i_reset = '1' then
			MinNumber_1 <= "0000";
			--MinNumber_2 <= "0000";
		else
			MinNumber_1 <=i_1_SetMinNumber;
			MinNumber_2 <=i_1_SetMinNumber;
		end if;
	end process Set_MinNumber;
	
	counter_1 : process(i_clk,counter) 
	begin
		if i_reset = '1' then
			count_1 <= "0000";
		elsif (i_1_SetMaxNumber > i_1_SetMinNumber) then
			if (set_1 = '1') then
				if (rising_edge(counter(23))and (enable = '1')) then
					if ((count_1 >= MaxNumber_1) or (count_1 < MinNumber_1))  then
						count_1 <= MinNumber_1 ;
					else
						count_1 <= count_1 + 1;  
					end if;
				end if;
			elsif (set_1 = '0')  then
				if (rising_edge(counter(23))and (enable = '1')) then
					if ((count_1 <= MinNumber_1) or (count_1 > MaxNumber_1)) then
						count_1 <= MaxNumber_1 ;
					else
						count_1 <= count_1 - 1;  
					end if;
				end if;
			end if;
		end if;
		
	end process counter_1;
	
	counter_2 : process(i_clk,counter) 
	begin
	    if i_reset = '1' then
            count_2 <= "0000";
		elsif(MaxNumber_2 > MinNumber_2) then
			if (set_2 = '1') then
                if (rising_edge(counter(23)) and (enable = '1')) then
					if ((count_2 >= MaxNumber_2) or (count_2 < MinNumber_2))  then
						count_2 <= MinNumber_2 ;
					else
						count_2 <= count_2 + 1;  
					end if;
				end if;
			elsif (set_2 = '0')  then
				if (rising_edge(counter(23)) and (enable = '1')) then
					if ((count_2 <= MinNumber_2) or (count_2 > MaxNumber_2)) then
						count_2 <= MaxNumber_2 ;
					else
						count_2 <= count_2 - 1;  
					end if;
				end if;
			end if;
		end if;
	end process counter_2;
	
end Behavioral;