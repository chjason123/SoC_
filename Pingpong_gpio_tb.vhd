library IEEE;
use IEEE.std_logic_1164.all;

entity Pingpong_gpio_tb is
end entity;

architecture sim of Pingpong_gpio_tb is
    signal clk        : std_logic := '0';
    signal rst        : std_logic := '1';

    -- 各板 GPIO 輸出與共用線
    signal gpio_a_out : std_logic := 'Z';
    signal gpio_b_out : std_logic := 'Z';
    signal gpio_line  : std_logic;

    -- 按鈕與 LED
    signal btn_a      : std_logic := '0';
    signal btn_b      : std_logic := '0';
	signal check_a      : std_logic := '0';
    signal check_b     : std_logic := '0';
    signal led_a      : std_logic_vector(7 downto 0);
    signal led_b      : std_logic_vector(7 downto 0);

    constant clk_period : time := 10 ns;

begin

    -- Clock generator
    clk_process: process
    begin
        while true loop
            clk <= '0'; wait for clk_period / 2;
            clk <= '1'; wait for clk_period / 2;
        end loop;
    end process;

    -- Reset
    rst_process: process
    begin
        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        wait;
    end process;

    -- 共用 GPIO 線模擬（雙向線路）
    gpio_line <= gpio_a_out when gpio_a_out /= 'Z' else
                 gpio_b_out when gpio_b_out /= 'Z' else
                 'Z';

    -- A 板
    UUT_A: entity work.Pingpong_gpio
        port map (
            i_clk   => clk,
            i_rst   => rst,
            i_btn   => btn_a,
			i_check => check_a,
            io_gpio => gpio_line,
            o_led   => led_a
        );

    -- B 板
    UUT_B: entity work.Pingpong_gpio
        port map (
            i_clk   => clk,
            i_rst   => rst,
            i_btn   => btn_b,
			i_check => check_b,
            io_gpio => gpio_line,
            o_led   => led_b
        );

    -- 按鈕模擬：模擬人按下按鈕發球
    btn_process: process
    begin
        wait for 200 ns;
        btn_a <= '1';         -- A 板先發球
        wait for 200 ns;
        btn_a <= '0';
		-- wait for 400 ns;       --提早打
        wait for 530 ns;     --回擊
        btn_b <= '1';         -- B 板也發球
        wait for 20 ns;
        btn_b <= '0';
		
		-- wait for 250 ns;       
        -- check_b <= '1';         -- 解鎖
        -- wait for 20 ns;
        -- check_b <= '0';
		
		
		
		wait for 660 ns;
		btn_a <= '1';         
        wait for 20 ns;
        btn_a <= '0';
		wait for 36 ns;
		check_a <= '1';         
        wait for 20 ns;
        check_a <= '0';
		wait for 100 ns;
		btn_a <= '1';         
        wait for 20 ns;
        btn_a <= '0';
		wait for 480 ns;
		btn_b <= '1';         
        wait for 20 ns;
        btn_b <= '0';
		-- wait for 2100 ns;
		-- btn_a <= '1';         
        -- wait for 200 ns;
        -- btn_a <= '0'; 
        wait;
    end process;

end architecture;



