library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity two_counter is
    port (
        i_clk    : in std_logic;
        i_rst    : in std_logic;
        o_count1 : out std_logic_vector(3 downto 0);
        o_count2 : out std_logic_vector(3 downto 0)
    );
end two_counter;

architecture Behavioral of two_counter is
	signal counter: std_logic_vector(24 downto 0);
    signal count1 : std_logic_vector(3 downto 0) ;
    signal count2 : std_logic_vector(3 downto 0) ;
    signal state  : std_logic := '0';
begin

    o_count1 <= count1;
    o_count2 <= count2;
	
	clk_Frequency_Division : process(i_clk,i_rst)
	begin
		if i_rst = '0' then
			counter<=(others => '0');
		elsif rising_edge(i_clk) then
			counter <= counter + 1;
		end if;
	end process;
	
    FSM: process(i_clk, i_rst,counter)
    begin
        if i_rst = '0' then
            state <= '0';
        elsif rising_edge(counter(24)) then    --fsm程式碼內容
            case state is
                when '0' =>
                    if count1 = "1111" then 
                        state <= '1';
                    end if;
                when '1' =>
                    if count2 = "0000" then 
                        state <= '0';
                    end if;
                when others =>
                    null;
            end case;
        end if;
    end process;

    counter1: process(i_clk, i_rst, state,counter)
    begin
        if i_rst = '0' then
            count1 <= "0000";
        elsif rising_edge(counter(24)) then
			--count1 <= count1 + 1;
            case state is
                when '0' =>
                    count1 <= count1 + 1;
                when '1' =>
                    null; -- count2 is active
                when others =>
                    null;
            end case;
        end if;
    end process;

    counter2: process(i_clk, i_rst, state,counter)
    begin
        if i_rst = '0' then
            count2 <= "1111";
        elsif rising_edge(counter(24)) then
            case state is
                when '0' =>
                    null; -- count1 is active
                when '1' =>
                    count2 <= count2 - 1;
                when others =>
                    null;
            end case;
        end if;
    end process;

end Behavioral;
