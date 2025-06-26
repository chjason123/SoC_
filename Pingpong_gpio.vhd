library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
entity Pingpong_gpio is
    port (
        i_clk   : in std_logic;
        i_rst   : in std_logic;
        i_btn   : in std_logic;
        i_check   : in std_logic;
        io_gpio : inout std_logic;
        o_led   : out std_logic_vector(7 downto 0)
    );
end entity;

architecture Behavioral of Pingpong_gpio is
    type fsm_type is ( RECEIVE, SEND, MOVE_R, MOVE_L);
    signal fsm          : fsm_type ;
    signal ball         : std_logic_vector(9 downto 0) ;
    signal clk_div      : std_logic_vector(28 downto 0);
    signal slow_clk     : std_logic;

    signal gpio_in      : std_logic;
    signal gpio_prev    : std_logic ;
    signal recv_edge    : std_logic ;
    signal first_ball_reset : std_logic ;
    signal lock  : std_logic ;
    signal send_pulse   : std_logic := '0';
    signal pulse_counter: std_logic_vector(3 downto 0);
    
begin
    
    io_gpio <= send_pulse when  fsm = SEND else 'Z';
    gpio_in <= io_gpio;
    slow_clk <= clk_div(23);

    -- 除頻器(div_clk)
    process (i_clk, i_rst)
    begin
        if i_rst = '1'  then
            clk_div <= (others => '0');
        elsif rising_edge(i_clk) then
            clk_div <= std_logic_vector(unsigned(clk_div) + 1); 
        end if;
    end process;

    -- 上升緣偵測(RECEIVE)
    process(i_clk)
    begin
        if rising_edge(i_clk) then
            if gpio_in = '1' and gpio_prev = '0' then
                recv_edge <= '1';
            else
                recv_edge <= '0';
            end if;
            gpio_prev <= gpio_in;
        end if;
    end process;
    
    --  
    process(i_clk, i_rst)
    begin
        if i_rst = '1' then
            lock <= '0';
        end if;
        if rising_edge(i_clk) then
            case fsm is
                when RECEIVE =>
                    if i_check='1' then
                        lock <= '0';
                    end if;
                when MOVE_R =>
                    lock <='1';
                when SEND =>
                    
                when MOVE_L =>
                    lock <='1';
                when others =>
            end case;
        end if;
    end process;
    
    -- FSM
    process(i_clk, i_rst)
    begin
        if i_rst = '1' then
            fsm <= RECEIVE;
        elsif rising_edge(i_clk) then
            case fsm is
                when RECEIVE =>
                    if recv_edge = '1' then
                        fsm <= MOVE_L;
                    elsif ((i_btn = '1') and (ball = "0000000001")and lock='0') then
                        fsm <= MOVE_R;
                    end if;
                when MOVE_R =>
                    if ball = "1000000000" then
                        fsm <= SEND;
                    end if;
                when SEND =>
                    if pulse_counter = "1000" then
                        fsm <= RECEIVE;
                    end if;
                when MOVE_L =>
                    if ball = "0000000001"and first_ball_reset='0'  then
                            fsm <= RECEIVE;  
                    elsif (i_btn = '1')then
                        if ( ball = "0000000010") then
                            fsm <= MOVE_R;
                        else
                            fsm <= RECEIVE; 
                        end if;
                    end if;
                when others =>
                    null;
            end case;
        end if;
    end process;
    


    -- LED 
    o_led <=ball(8 downto 1);
    

    -- 球移動邏輯
    process(slow_clk, i_rst)
    begin
        if i_rst = '1' then
            ball <= "0000000001";
            first_ball_reset<='1';
        elsif rising_edge(slow_clk) then
            case fsm is
                when RECEIVE =>
                    
                when MOVE_R =>
                    ball <= ball(8 downto 0) & ball(9)  ;
                when SEND =>
                    
                when MOVE_L =>
                    if first_ball_reset = '1' then
                        ball <= "1000000000";
                        first_ball_reset <= '0';
                    end if;
                    ball <=ball(0) & ball(9 downto 1)  ;
                    
                when others =>
                    null;
            end case;
        end if;
        
        if fsm=RECEIVE and lock ='0' then 
            ball <= "0000000001";
        end if;
    end process;

    -- 傳送控制
    process(i_clk, i_rst)
    begin
        if i_rst = '1' then
            pulse_counter <= "0000";
            send_pulse <= '0';
        elsif rising_edge(i_clk) then
            case fsm is
                when SEND =>
                    if pulse_counter < "1000" then
                        pulse_counter <= pulse_counter + 1;
                        send_pulse <= '1';
                    else
                        pulse_counter <= "0000";
                        send_pulse <= '0';
                    end if;
                when others =>
                    pulse_counter <= "0000";
                    send_pulse <= '0';
            end case;
        end if;
    end process;


end Behavioral;