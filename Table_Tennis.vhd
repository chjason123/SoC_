library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity Table_Tennis is
    port (
        i_clk    : in std_logic;
        i_rst    : in std_logic;
		i_R_button : in std_logic;
		i_L_button : in std_logic;
		o_FSM_state : out std_logic_vector(2 downto 0);
        o_led : out std_logic_vector(7 downto 0)
    );
end Table_Tennis;

architecture Behavioral of Table_Tennis is
	signal FSM_state : std_logic_vector (2 downto 0);
	signal ball : std_logic_vector (7 downto 0);
	signal r_score : std_logic_vector (3 downto 0);
	signal l_score : std_logic_vector (3 downto 0);
	signal prev_FSM_state : std_logic_vector (2 downto 0);
	signal counter: std_logic_vector(24 downto 0);
begin
	
	o_FSM_state <= FSM_state;
	
	clk_Frequency_Division : process(i_clk,i_rst)
	begin
		if i_rst = '0' then
			counter<=(others => '0');
		elsif rising_edge(i_clk) then
			counter <= counter + 1;
		end if;
	end process;
	
	FSM : process(i_rst,i_clk)
	begin
		if i_rst = '0' then
            FSM_state <= "000";
        elsif  rising_edge(i_clk) then  
            case FSM_state is
                when "000" =>   --reset_game
					if(i_R_button='1') then
					    FSM_state <= "001";
					end if;
                when "001" =>    --left_move
				    if ((i_L_button='1') and (ball="10000000")) then
					    FSM_state <= "010";
					elsif ((i_L_button='1') or (ball="00000000")) then
					    FSM_state <= "100";
					end if;
				when "010" =>    --right_move
				    if ((i_R_button='1') and (ball="00000001")) then
					    FSM_state <= "001";
					elsif ((i_R_button='1') or (ball="00000000")) then
					    FSM_state <= "011";
					end if;
				when "011" =>    --left_win
				    if ( l_score="1111" and (i_L_button='1') )then
					    FSM_state <= "000";
					elsif(i_L_button='1') then
					    FSM_state <= "010";
					end if;
				when "100" =>    --right_win
                    if ( r_score="1111" and (i_R_button='1') )then
					    FSM_state <= "000";
					elsif(i_R_button='1') then
					    FSM_state <= "001";
					end if;
				when others =>
					null;
            end case;
        end if;
	end process;
	
	led_output: process(i_rst,i_clk)
	begin
	    if i_rst = '0' then
            o_led <= (others => '0');
        elsif(rising_edge(i_clk)) then
			case FSM_state is
			    when "000" =>    --reset_game
					o_led <= ball;
				when "001" =>
					o_led <= ball;
				when "010" =>
					o_led <= ball;
				when "011" =>
					o_led <= l_score&r_score;
				when "100" =>
					o_led <= l_score&r_score;
			    when others =>
            		null;
			end case;
        end if;
	end process;
	

	
	Ball_Move : process(i_rst,i_clk,counter)
	begin
	    if i_rst = '0' then
            ball <= "00000001";
        elsif (rising_edge(counter(24)))  then
			case FSM_state is
			    when "000" =>    --reset_game
					ball<="00000001";
				when "001" =>    --left_move
					ball<=ball(6 downto 0) & '0';
				when "010" =>    --right_move
					ball<='0'& ball(7 downto 1)  ;
				when "011" =>    --left_win
					ball<="10000000";
				when "100" =>    --right_win
					ball<="00000001";
			    when others =>
            		null;
			end case;
        end if;
	end process;
	
	L_Score_Update : process(i_clk, i_rst)
	begin
		if i_rst = '0' then
			l_score <= (others => '0');
		elsif rising_edge(i_clk) then
			if FSM_state = "000" then
				l_score <= (others => '0'); -- 當狀態為 "000" 時重置分數
			elsif FSM_state = "011" and prev_FSM_state /= "011" then
				l_score <= l_score + 1; -- 左邊加分
			end if;
		end if;
	end process;

	-- 右邊得分
	R_Score_Update : process(i_clk, i_rst)
	begin
		if i_rst = '0' then
			r_score <= (others => '0');
		elsif rising_edge(i_clk) then
			if FSM_state = "000" then
				r_score <= (others => '0'); -- 當狀態為 "000" 時重置分數
			elsif FSM_state = "100" and prev_FSM_state /= "100" then
				r_score <= r_score + 1; -- 右邊加分
			end if;
		end if;
	end process;
	
	Prev_State_Update : process(i_clk, i_rst)
    begin
        if i_rst = '0' then
            prev_FSM_state <= "000";
        elsif rising_edge(i_clk) then
            prev_FSM_state <= FSM_state;
        end if;
    end process;
end Behavioral;
