library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;
entity Up_Counter is
	Port ( 
		i_clk:	in std_logic;
		i_reset:	in std_logic;
		i_swich:    in std_logic;
		o_count:	out std_logic_vector (3 downto 0)
	);
end Up_Counter;


architecture Behavioral of Up_Counter is
	signal count_int : std_logic_vector (3 downto 0);
	signal counter: std_logic_vector(24 downto 0);
begin
	o_count <= count_int;
	
	clk_Frequency_Division : process(i_clk,i_reset)
	begin
		if i_reset = '1' then
			counter<=(others => '0');
		elsif rising_edge(i_clk) then
			counter <= counter + 1;
		end if;
	end process;
	
	main : process(counter,i_reset)
	begin
		
		if i_reset = '1' then
			count_int <= "0000";
		elsif rising_edge(counter(24)) then
			if i_swich = '1' then 
			    if count_int = "1001" then
			    	count_int <= "0000" ;
			    else
			    	count_int <= count_int + 1;  
			    end if;
			elsif i_swich = '0' then 
				if count_int = "0000" then
			    	count_int <= "1001" ;
			    else
			    	count_int <= count_int - 1;  
			    end if;
			end if;
		end if;
		 
	end process main;
	
end Behavioral;
