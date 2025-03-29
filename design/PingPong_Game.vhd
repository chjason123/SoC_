library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PingPong_Game is
  PORT (
    clk        : IN STD_LOGIC;
    rst        : IN STD_LOGIC;
    i_R_button : in std_logic;
    i_L_button : in std_logic;
    red_sig    : OUT STD_LOGIC_VECTOR(3 downto 0);
    green_sig  : OUT STD_LOGIC_VECTOR(3 downto 0);
    blue_sig   : OUT STD_LOGIC_VECTOR(3 downto 0);
    hsync_sig  : OUT STD_LOGIC;
    vsync_sig  : OUT STD_LOGIC
  );
end PingPong_Game;

architecture Behavioral of PingPong_Game is

COMPONENT VGA
  generic(
    h_pixels  : INTEGER  := 800;
    h_fp      : INTEGER  := 56;
    h_pulse   : INTEGER  := 120;
    h_bp      : INTEGER  := 64;
    h_pol     : STD_LOGIC := '1';
    v_pixels  : INTEGER  := 600;
    v_fp      : INTEGER  := 37;
    v_pulse   : INTEGER  := 6;
    v_bp      : INTEGER  := 23;
    v_pol     : STD_LOGIC := '1'
  );
  PORT (
    clk        : IN STD_LOGIC;
    rst        : IN STD_LOGIC;
    racket_r_x : IN INTEGER;
    racket_r_y : IN INTEGER;
    racket_l_x : IN INTEGER;
    racket_l_y : IN INTEGER;
    circle_center_x : IN INTEGER;
    circle_center_y : IN INTEGER;
    red_out    : OUT STD_LOGIC_VECTOR(3 downto 0);
    green_out  : OUT STD_LOGIC_VECTOR(3 downto 0);
    blue_out   : OUT STD_LOGIC_VECTOR(3 downto 0);
    h_sync     : OUT STD_LOGIC;
    v_sync     : OUT STD_LOGIC
  );
END COMPONENT;

SIGNAL racket_r_x : INTEGER := 0;
SIGNAL racket_r_y : INTEGER RANGE 0 TO 480  := 0;
SIGNAL racket_l_x : INTEGER := 785;
SIGNAL racket_l_y : INTEGER RANGE 0 TO 480  := 0;
SIGNAL racket_dy : INTEGER := 10;
SIGNAL circle_center_x : INTEGER RANGE -10 TO 800  := 0;
SIGNAL circle_center_y : INTEGER RANGE -10 TO 600  := 0;
SIGNAL ball_dx : INTEGER := 2;
SIGNAL ball_dy : INTEGER := 2;
signal ball_state : std_logic_vector (1 downto 0) ;
signal div_clk : STD_LOGIC := '0';
signal counter: std_logic_vector(24 downto 0);

begin

process (clk, rst)
  begin
    if rst = '1' then
      counter <= (others => '0');
      div_clk <= '0';
    elsif rising_edge(clk) then
      counter <= counter + 1;
      div_clk <= counter(20);
    end if;
end process;
  
process(clk,div_clk,rst)
begin
    if rst = '1' then
      racket_r_y <= 0;
	  racket_r_y <= 0;
    elsif rising_edge(div_clk) then
	    if(i_R_button='1' and (racket_r_y<480)) then
            racket_r_y <=racket_r_y + racket_dy;
        elsif(i_R_button='0' and (racket_r_y>0)) then
            racket_r_y <=racket_r_y - racket_dy;
		else
			racket_r_y <=racket_r_y ;
        end if;
		
        if(i_L_button='1' and (racket_l_y<480)) then
            racket_l_y <=racket_l_y + racket_dy;
        elsif(i_L_button='0' and (racket_l_y>0)) then
            racket_l_y <=racket_l_y - racket_dy;
		else
			racket_l_y <=racket_l_y ;
        end if;

    end if;
end process;
  
process(clk,div_clk,rst)
begin
    if rst = '1' then
      circle_center_x <= 400;
      circle_center_y <= 300;
      ball_dx <= 2;
      ball_dy <= 2;
	  ball_state<="11";
    elsif rising_edge(div_clk) then	
      case ball_state is  -- 假設 your_input_signal 是你的兩位元信號
      when "00" =>
        circle_center_x <= circle_center_x + ball_dx;
		circle_center_y <= circle_center_y + ball_dy;
		if circle_center_y >=600  then
        ball_state <= "01";  
        elsif circle_center_x >= 800 then
        ball_state <= "10";  
		end if;
      when "01" =>
        circle_center_x <= circle_center_x + ball_dx;
		circle_center_y <= circle_center_y - ball_dy;
		if circle_center_y <=0  then
            ball_state <= "00";  
        elsif circle_center_x >= 800 then
            ball_state <= "11";  
		end if;
      when "10" =>
        circle_center_x <= circle_center_x - ball_dx;
		circle_center_y <= circle_center_y + ball_dy;
		if circle_center_y >=600  then
            ball_state <= "11";  
        elsif circle_center_x <= 0  then
            ball_state <= "00";  
		end if;
      when "11" =>
        circle_center_x <= circle_center_x - ball_dx;
		circle_center_y <= circle_center_y - ball_dy;
		if circle_center_x <= 1 then
            ball_state <= "01"; 
        elsif circle_center_y <=1  then
            ball_state <= "10"; 
		end if;
      when others =>
        circle_center_x <= circle_center_x ;
		circle_center_y <= circle_center_y ;
	  end case;


    end if;
end process;

VGA_inst : VGA
  PORT MAP (
    clk        => clk,
    rst        => rst,
    racket_r_x => racket_r_x,
    racket_r_y => racket_r_y,
    racket_l_x => racket_l_x,
    racket_l_y => racket_l_y,
    circle_center_x => circle_center_x,
    circle_center_y => circle_center_y,
    red_out    => red_sig,
    green_out  => green_sig,
    blue_out   => blue_sig,
    h_sync     => hsync_sig,
    v_sync     => vsync_sig
  );

end Behavioral;
