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
	i_Start_button : in std_logic;
	o_led    : OUT STD_LOGIC_VECTOR(7 downto 0);
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
    v_sync     : OUT STD_LOGIC;
	pixel_x    : OUT INTEGER;              
	pixel_y    : OUT INTEGER   
  );
END COMPONENT;

signal racket_r_x : INTEGER := 785;
signal racket_r_y : INTEGER RANGE 0 TO 480  := 0;
signal racket_l_x : INTEGER := 0;
signal racket_l_y : INTEGER RANGE 0 TO 480  := 0;
signal racket_dy : INTEGER := 5;
signal circle_center_x : INTEGER RANGE -10 TO 800  := 0;
signal circle_center_y : INTEGER RANGE -10 TO 600  := 0;
signal ball_dx : INTEGER range 0 to 10 := 5;
signal ball_dy : INTEGER range 0 to 10 := 5;
signal ball_state : std_logic_vector (1 downto 0) ;
signal game_state : std_logic_vector (1 downto 0) ;
signal div_clk : STD_LOGIC := '0';
signal counter: std_logic_vector(24 downto 0);
signal pixel_x : INTEGER ;
signal pixel_y : INTEGER ;
signal r_score : std_logic_vector (3 downto 0);
signal l_score : std_logic_vector (3 downto 0);
signal flag_r_score : std_logic;
signal flag_l_score : std_logic;

begin
o_led <= l_score&r_score;
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


racket_MOVE:process(clk,div_clk,rst)  --球拍移動
begin
    if rst = '1' then
      racket_r_y <= 0;
	  racket_l_y <= 0;
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

GAME_FSM:process(clk,rst)
begin
    if rst = '1' then
	  game_state<="11";
    elsif rising_edge(clk) then	
      case game_state is  -- 假設 your_input_signal 是你的兩位元信號
      when "00" =>   --球移動
		if circle_center_x <= 10  then
			game_state <= "01";  
		elsif circle_center_x >= 789 then
			game_state <= "10";  
		end if;
      when "01" =>   --右加分
		if flag_r_score = '1'then
			game_state <= "11";
		end if;
      when "10" =>   --左加分
		if flag_l_score ='1' then
			game_state <= "11";
		end if;
      when "11" =>   --球不動
		if i_Start_button='1' then
			game_state <= "00";
		end if;
      when others =>
        game_state <= game_state ;
	  end case;
    end if;
end process;

L_Score_Update : process(clk, rst)
begin
    if rst = '1' then
	    flag_l_score <= '0';
        l_score <= "0000";
    elsif rising_edge(clk) then
		if (game_state = "10")and flag_l_score = '0' then
            l_score <= l_score + 1; -- 左邊加分
			flag_l_score <= '1';
		elsif  game_state = "11" then
			flag_l_score <= '0';
        end if;
    end if;
end process;

    -- 右邊得分
R_Score_Update : process(clk, rst)
begin
    if rst = '1' then
	    flag_r_score <= '0';
        r_score <= "0000";
    elsif rising_edge(clk) then
        if (game_state ="01") and flag_r_score = '0'  then
            r_score <= r_score + 1; -- 左邊加分
			flag_r_score <= '1';
		elsif  game_state = "11" then
			flag_r_score <= '0';
        end if;
    end if;
end process;
  
Ball_FSM:process(clk,rst)
begin
    if rst = '1' then
	  ball_state<="11";
    elsif rising_edge(clk) then	
      case ball_state is  -- 假設 your_input_signal 是你的兩位元信號
      when "00" =>   --右下
		if circle_center_y >=589  then
			ball_state <= "01";  
		elsif  ((pixel_x>(racket_r_x))and (pixel_x<(racket_r_x+14)))and((pixel_y>(racket_r_y))and (pixel_y<(racket_r_y+119)))  then
			if ((((pixel_x-circle_center_x)*(pixel_x-circle_center_x))+((pixel_y-circle_center_y)*(pixel_y-circle_center_y))) =100) then
				ball_state <= "10";  
			end if;
		elsif (circle_center_x >= 789)  then
			--ball_state <= "10";  
		end if;
      when "01" =>   --右上
		if circle_center_y <=9  then
            ball_state <= "00";  
		elsif  ((pixel_x>(racket_r_x))and (pixel_x<(racket_r_x+14)))and((pixel_y>(racket_r_y))and (pixel_y<(racket_r_y+119)))  then
			if ((((pixel_x-circle_center_x)*(pixel_x-circle_center_x))+((pixel_y-circle_center_y)*(pixel_y-circle_center_y))) =100) then
				ball_state <= "11";  
			end if;
        elsif circle_center_x >= 789 then
            --ball_state <= "11";  
		end if;
      when "10" =>   --左下
		if circle_center_y >=589  then
            ball_state <= "11";  
		elsif  ((pixel_x>(racket_l_x))and (pixel_x<(racket_l_x+14)))and((pixel_y>(racket_l_y))and (pixel_y<(racket_l_y+119)))  then
			if ((((pixel_x-circle_center_x)*(pixel_x-circle_center_x))+((pixel_y-circle_center_y)*(pixel_y-circle_center_y))) =100) then
				ball_state <= "00";  
			end if;
        elsif circle_center_x <= 9  then
            --ball_state <= "00";  
		end if;
      when "11" =>   --左上
		if circle_center_x <= 9 then
            --ball_state <= "01"; 
		elsif  ((pixel_x>(racket_l_x))and (pixel_x<(racket_l_x+14)))and((pixel_y>(racket_l_y))and (pixel_y<(racket_l_y+119)))  then
			if ((((pixel_x-circle_center_x)*(pixel_x-circle_center_x))+((pixel_y-circle_center_y)*(pixel_y-circle_center_y))) =100) then
				ball_state <= "10";  
			end if;
        elsif circle_center_y <=9  then
            ball_state <= "10"; 
		end if;
      when others =>
        ball_state <= ball_state ;
	  end case;
    end if;
end process;

Ball_Move:process(clk,div_clk,rst)
begin
    if rst = '1' then
      circle_center_x <= 400;
      circle_center_y <= 300;
    elsif rising_edge(div_clk) then	
	    case game_state is 
	    when "00"=>
		    case ball_state is  -- 假設 your_input_signal 是你的兩位元信號
		    when "00" =>
			    circle_center_x <= circle_center_x + ball_dx;
			    circle_center_y <= circle_center_y + ball_dy;
		    when "01" =>
			    circle_center_x <= circle_center_x + ball_dx;
			    circle_center_y <= circle_center_y - ball_dy;
		    when "10" =>
			    circle_center_x <= circle_center_x - ball_dx;
			    circle_center_y <= circle_center_y + ball_dy;
		    when "11" =>
			    circle_center_x <= circle_center_x - ball_dx;
			    circle_center_y <= circle_center_y - ball_dy;
		    when others =>
			    circle_center_x <= circle_center_x ;
			    circle_center_y <= circle_center_y ;
		    end case;
        when "10" =>
			circle_center_x <= 400 ;
			circle_center_y <= 300 ;
		when "01" =>
			circle_center_x <= 400 ;
			circle_center_y <= 300 ;
		when "11" =>
			circle_center_x <= 400 ;
			circle_center_y <= 300 ;
		when others  =>
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
    v_sync     => vsync_sig,
	pixel_x    => pixel_x,              
	pixel_y    => pixel_y 
  );

end Behavioral;
