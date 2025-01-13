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
    signal count1 : std_logic_vector(3 downto 0) := (others => '0');
    signal count2 : std_logic_vector(3 downto 0) := (others => '0');
    signal count3 : std_logic_vector(3 downto 0) := (others => '0');
    signal PWM : std_logic_vector(3 downto 0) := "0001";
    signal PWM_state : std_logic := '0';
    signal cycle : std_logic_vector(3 downto 0) := "0001";
    signal state : std_logic := '0';
    signal duty_state : std_logic := '0';

begin

	o_State <= duty_state;
	
	Modulation: process(i_up_button,i_down_button,i_clk) 
	begin
		if i_rst = '0' then
			cycle <= "0001";
		elsif rising_edge(i_up_button) then
			cycle <= cycle + 1;
		elsif rising_edge(i_down_button) then
			cycle <= cycle - 1;
		end if;
	end process;
	
	PWM_FSM: process(i_clk,i_rst,state,duty_state)
	begin
        if i_rst = '0' then
            PWM_state <= '0';
        elsif rising_edge(duty_state) then    --fsm程式碼內容
            case PWM_state is
                when '0' =>
                    if PWM = "1000" then 
                        PWM_state <= '1';
                    end if;
                when '1' =>
                    if PWM = "0001" then 
                        PWM_state <= '0';
                    end if;
				when others =>
					null;
            end case;
        end if;
    end process;

    upbnd1: process(i_clk, i_rst, PWM_state,duty_state)
    begin
        if i_rst = '0' then
            PWM <= "0001";
        elsif rising_edge(duty_state) then
            case PWM_state is
                when '0' =>
                    PWM <= PWM + 1;
                when '1' =>
                    PWM <= PWM - 1; 
                when others =>
                    null;
            end case;
        end if;
    end process;

	
	-----------------------------------------------
    FSM: process(i_clk, i_rst)
    begin
        if i_rst = '0' then
            state <= '0';
        elsif rising_edge(i_clk) then    --fsm程式碼內容
            case state is
                when '0' =>
                    if count1 = cycle-1 then 
                        state <= '1';
                    end if;
                when '1' =>
                    if count2 = "0001" then 
                        state <= '0';
                    end if;
				when others =>
					null;
            end case;
        end if;
    end process;

    counter1: process(i_clk, i_rst, state)
    begin
        if i_rst = '0' then
            count1 <= "0000";
        elsif rising_edge(i_clk) then
            case state is
                when '0' =>
                    count1 <= count1 + 1;
                when '1' =>
                    count1 <= "0000"; -- count2 is active
                when others =>
                    null;
            end case;
        end if;
    end process;

    counter2: process(i_clk, i_rst, state)
    begin
        if i_rst = '0' then
            count2 <= cycle;
        elsif rising_edge(i_clk) then
            case state is
                when '0' =>
                    count2 <= cycle; -- count1 is active
                when '1' =>
                    count2 <= count2-1;
                when others =>
                    null;
            end case;
        end if;
    end process;
-------------------------------------------------------
    duty_FSM: process(i_clk, i_rst,state)   --fsm程式碼內容
    begin
        if i_rst = '0' then
            duty_state<='1';
        elsif rising_edge(state) then    
            case duty_state is
                when '1' =>
                    if  count3 = PWM-1 then
						duty_state <= '0';
                    end if;
                when '0' =>
                    if count3 = "1001" then 
                        duty_state <= '1';
                    end if;
				when others =>
					null;
            end case;
        end if;
    end process;

    counter3: process(i_clk, i_rst, state)
    begin
        if i_rst = '0' then
            count3 <= "0000";
        elsif rising_edge(state) then
            case duty_state is
                when '1' =>
                    count3 <= count3 + 1;
                when '0' =>
					if count3 = "1001" then
						count3 <= "0000"; -- count2 is active
					else
						count3 <= count3 + 1;
					end if;
                when others =>
                    null;
            end case;
        end if;
    end process;
	

end Behavioral;

