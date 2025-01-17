library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity BreatheLamp is
    port (
        i_clk    : in std_logic;
        i_rst    : in std_logic;
		i_up_button: in std_logic;
		i_down_button: in std_logic;

        o_State : out std_logic
    );
end BreatheLamp;
architecture Behavioral of BreatheLamp is

	signal pwm_count : std_logic_vector(15 downto 0);
	signal Frequency_times : std_logic_vector(15 downto 0);
	signal FSM_1_state : std_logic ;
	signal up_limit : std_logic_vector(7 downto 0) ;
	signal down_limit : std_logic_vector(7 downto 0) ;
	
	signal FSM_2_state :  std_logic ;
	signal count1 : std_logic_vector(7 downto 0);
	signal count2 : std_logic_vector(7 downto 0);
	
	signal counter: std_logic_vector(24 downto 0);
begin
	o_State <=FSM_2_state ;

	clk_Frequency_Division : process(i_clk,i_rst)
	begin
		if i_rst = '0' then
			counter<=(others => '0');
		elsif rising_edge(i_clk) then
			counter <= counter + 1;
		end if;
	end process;
	
	
	-----------------------------------------------
	FSM_1: process(i_rst,i_clk,pwm_count)
	begin
        if i_rst = '0' then
            FSM_1_state <= '0';
        elsif rising_edge(i_clk) then    
            case FSM_1_state is
                when '0' =>
                    if up_limit = "00111111" then 
                        FSM_1_state <= '1';
                    end if;
                when '1' =>
                    if down_limit = "11111111" then 
                        FSM_1_state <= '0';
                    end if;
				when others =>
					null;
            end case;
        end if;
    end process;

    upbnd1 : process( i_rst,pwm_count)
    begin
        if i_rst = '0' then
            up_limit <= (others => '0');
        elsif (rising_edge(counter(19)))  then
            if FSM_1_state='0' then 
				up_limit <= up_limit + 1;
			elsif FSM_1_state='1' then
				up_limit <= up_limit - 1; 
			end if;
        end if;
    end process;

	upbnd2: process( i_rst,pwm_count)
    begin
        if i_rst = '0' then
            down_limit <= "11111111";
        elsif (rising_edge(counter(19)))  then
            if FSM_1_state='0' then 
				down_limit <= down_limit - 1;
			elsif FSM_1_state='1' then
				down_limit <= down_limit + 1; 
			end if;
        end if;
    end process;
	-----------------------------------------------
    FSM_2: process(i_clk, i_rst)
    begin
        if i_rst = '0' then
            FSM_2_state <= '1';
        elsif rising_edge(i_clk) then    
            case FSM_2_state is
                when '0' =>
                    if count2 = down_limit then 
                        FSM_2_state <= '1';
                    end if;
                when '1' =>
                    if count1 = up_limit then 
                        FSM_2_state <= '0';
                    end if;
				when others =>
					null;
            end case;
        end if;
    end process;

    counter1: process(i_rst,counter)
    begin
        if i_rst = '0' then
            count1 <= (others => '0');
        elsif rising_edge(counter(3)) then
            case FSM_2_state is
                when '1' =>
                    count1 <= count1 + 1;
                when '0' =>
                    count1 <= (others => '0'); 
                when others =>
                    null;
            end case;
        end if;
    end process;

    counter2: process(i_rst,counter)
    begin
        if i_rst = '0' then
            count2 <= (others => '0');
        elsif rising_edge(counter(3)) then
            case FSM_2_state is
                when '1' =>
                    count2 <=(others => '0'); 
                when '0' =>
					count2 <= count2 + 1;
                when others =>
                    null;
            end case;
        end if;
    end process;


	

end Behavioral;

