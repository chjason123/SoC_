library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY VGA IS
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
    clk        : IN STD_LOGIC;              -- 100MHz時鐘輸入
    rst        : IN STD_LOGIC;              -- 重置信號
	racket_r_x : IN INTEGER;
    racket_r_y : IN INTEGER;
    racket_l_x : IN INTEGER;
    racket_l_y : IN INTEGER;
    circle_center_x : IN INTEGER;
    circle_center_y : IN INTEGER;
    red_out    : OUT STD_LOGIC_VECTOR(3 downto 0);  -- 紅色信號輸出
    green_out  : OUT STD_LOGIC_VECTOR(3 downto 0);  -- 綠色信號輸出
    blue_out   : OUT STD_LOGIC_VECTOR(3 downto 0);  -- 藍色信號輸出
    h_sync     : OUT STD_LOGIC;             -- 水平同步信號輸出
    v_sync     : OUT STD_LOGIC              -- 垂直同步信號輸出
  );
END VGA;

ARCHITECTURE behavior OF VGA IS
    CONSTANT h_period : INTEGER := h_pixels + h_fp + h_pulse + h_bp ;
    CONSTANT v_period : INTEGER := v_pixels + v_fp + v_pulse + v_bp ;
	CONSTANT x1 : INTEGER := 400;  CONSTANT y1 : INTEGER := 100;
    CONSTANT x2 : INTEGER := 227;  CONSTANT y2 : INTEGER := 400;
    CONSTANT x3 : INTEGER := 573;  CONSTANT y3 : INTEGER := 400;
    signal h_count : INTEGER RANGE 0 TO h_period - 1 := 0;
    signal v_count : INTEGER RANGE 0 TO v_period - 1 := 0;
    signal pixel_clk : STD_LOGIC := '0';    -- 50MHz 像素時鐘
    signal counter: std_logic_vector(24 downto 0);
	
	function area(xa, ya, xb, yb, xc, yc : INTEGER) return INTEGER is
	begin
		return abs(xa * (yb - yc) + xb * (yc - ya) + xc * (ya - yb));
	end function;
BEGIN
  
  -- 時鐘分頻器：將100MHz時鐘降頻至50MHz
  process (clk, rst)
  begin
    if rst = '1' then
      counter <= (others => '0');
      pixel_clk <= '0';
    elsif rising_edge(clk) then
      counter <= counter + 1;       -- 切換tmp信號
	  pixel_clk <= counter(0);
    end if;
  end process;

  -- VGA信號生成過程
  process(pixel_clk, rst)
  begin
    if rst = '1' then
      h_count <= 0; 
      v_count <= 0;
      h_sync  <= NOT h_pol;
      v_sync  <= NOT v_pol;
      red_out <= (others => '0');
      green_out <= (others => '0');
      blue_out <= (others => '0');
    elsif rising_edge(pixel_clk) then
      -- 水平計數器
      if h_count < h_period - 1 then
        h_count <= h_count + 1;
      else
        h_count <= 0;
        -- 垂直計數器
        if v_count < v_period - 1 then
          v_count <= v_count + 1;
        else
          v_count <= 0;
        end if;
      end if;

      -- 水平同步信號
      if h_count < h_pixels + h_fp or h_count >= h_pixels + h_fp + h_pulse then
        h_sync <= NOT h_pol;
      else
        h_sync <= h_pol;
      end if;

      -- 垂直同步信號
      if v_count < v_pixels + v_fp or v_count >= v_pixels + v_fp + v_pulse then
        v_sync <= NOT v_pol;
      else
        v_sync <= v_pol;
      end if;
	  
		
      -- 設置RGB輸出
      if h_count < h_pixels and v_count < v_pixels then
	    
        if ((((h_count-circle_center_x)*(h_count-circle_center_x))+((v_count-circle_center_y)*(v_count-circle_center_y))) <100) then
            red_out <= (others => '1');
            green_out <= (others => '1');
            blue_out <= (others => '0');
		elsif((h_count>(racket_r_x))and (h_count<(racket_r_x+14)))and((v_count>(racket_r_y))and (v_count<(racket_r_y+119))) then
			red_out   <= "1111";--red_out <= "0000";   -- 在此設置你需要的RGB顏色
			green_out <= "1010";
			blue_out <= "0000";--blue_out <= "0000";
		elsif((h_count>(racket_l_x))and (h_count<(racket_l_x+14)))and((v_count>(racket_l_y))and (v_count<(racket_l_y+119))) then
			red_out   <= "0000";--red_out <= "0000";   -- 在此設置你需要的RGB顏色
			green_out <= "0000";
			blue_out <= "1111";--blue_out <= "0000";
		else
			red_out <= "1111"; --red_out <= "0000";   -- 在此設置你需要的RGB顏色
			green_out <= "1111";
			blue_out <= "1111";
	    end if;
      else
        red_out <= (others => '0');
        green_out <= (others => '0');
        blue_out <= (others => '0');
      end if;
    end if;
  end process;
END behavior;
