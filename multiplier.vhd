-------------------------TOPLEVEL (multiplier) IS LOCATED AT THE END OF THE FILE-------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity full_adder is
	port (a, b, cin: in std_logic;
		cout, sum: out std_logic);
end full_adder ;

architecture rtl of full_adder is
begin
	sum <= a xor b xor cin;
	cout <= (a and cin) or (b and cin) or (a and b);
end rtl;




library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;


entity adder_13bit is
	port(a ,b : in std_logic_vector (12 downto 0);
		sum : out std_logic_vector (12 downto 0);
		cout: out std_logic);
end adder_13bit;


architecture rtl of adder_13bit is

component full_adder is
	port (a, b, cin: in std_logic;
		cout, sum: out std_logic);
end component;	

	signal c: std_logic_vector (11 downto 0);
	signal s_int: std_logic_vector (12 downto 0);

begin 

inst_0: full_adder port map (a(0), b(0), '0', c(0), s_int(0));
inst_1: full_adder port map (a(1), b(1), c(0), c(1), s_int(1));
inst_2: full_adder port map (a(2), b(2), c(1), c(2), s_int(2));
inst_3: full_adder port map (a(3), b(3), c(2), c(3), s_int(3));
inst_4: full_adder port map (a(4), b(4), c(3), c(4), s_int(4));
inst_5: full_adder port map (a(5), b(5), c(4), c(5), s_int(5));
inst_6: full_adder port map (a(6), b(6), c(5), c(6), s_int(6));
inst_7: full_adder port map (a(7), b(7), c(6), c(7), s_int(7));
inst_8: full_adder port map (a(8), b(8), c(7), c(8), s_int(8));
inst_9: full_adder port map (a(9), b(9), c(8), c(9), s_int(9));
inst_10: full_adder port map (a(10), b(10), c(9), c(10), s_int(10));
inst_11: full_adder port map (a(11), b(11), c(10), c(11), s_int(11));
inst_12: full_adder port map (a(12), b(12), c(11), cout, s_int(12));


sum <= s_int;
	
end architecture rtl;


----------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity counter is
	port (clk, rst, en: in std_logic;
		fin: out std_logic);
end entity counter;

architecture rtl of counter is
	signal count_temp: unsigned(3 downto 0);
begin

	process (rst, clk)
	begin
		if (rst = '1') then
			count_temp <= (others =>'0');
		elsif (rising_edge(clk)) then
			if(en='1') then
				count_temp <= count_temp + 1;
			end if;
		end if;
	end process;

	fin <= '1' when count_temp =13 else '0';
end architecture rtl;

--------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity reg_13bit_shfl is

	port (clk, rst, wr, shift_left: in std_logic;
		reg_in: in std_logic_vector(12 downto 0);
		reg_out: out std_logic_vector(12 downto 0));

end entity reg_13bit_shfl;

architecture rtl of reg_13bit_shfl is

	signal reg_temp: std_logic_vector(12 downto 0);
begin

process (rst, clk)
begin

	if (rst = '1') then
		reg_temp <= (others => '0');
	elsif (rising_edge(clk)) then
		case shift_left is
			when '0'=>
					if (wr = '1') then
					 	reg_temp <=  reg_in;
					end if;
			when '1' => reg_temp <= reg_temp(11 downto 0) &'0';
			when others => reg_temp <= reg_temp; --can be omitted
		end case;
	end if;

end process;
	reg_out <= reg_temp;
end architecture rtl;

---------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity reg_13bit_shfr is

	port (clk, rst, wr, shift_right: in std_logic;
		reg_in: in std_logic_vector(12 downto 0);
		reg_out: out std_logic_vector(12 downto 0));

end entity reg_13bit_shfr;

architecture rtl of reg_13bit_shfr is

	signal reg_temp: std_logic_vector(12 downto 0);
begin

process (rst, clk)
begin

	if (rst = '1') then
		reg_temp <= (others => '0');
	elsif (rising_edge(clk)) then
		case shift_right is
			when '0'=> 
					if (wr = '1') then
					 	reg_temp <= reg_in;
					end if;
				
			when '1' => reg_temp <= '0'&reg_temp(12 downto 1);
			when others => reg_temp <= reg_temp; --can be omitted
		end case;
	end if;

end process;
	reg_out <= reg_temp;
end architecture rtl;

----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity reg_13bit is
port (clk, rst, en: in std_logic;
reg_in: in std_logic_vector(12 downto 0);
reg_out: out std_logic_vector(12 downto 0));
end entity reg_13bit;

architecture rtl of reg_13bit is
	
begin
process (rst, clk)
begin
if (rst = '1') then
reg_out <= (others => '0');
elsif (rising_edge(clk)) then
if (en = '1') then
reg_out <= reg_in;
end if;
end if;
end process;
end architecture rtl;

--------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;


entity mul_fsm is

port (clk, rst, start, fin, mul : in std_logic;
		shr ,shl ,wr, wrm, clr, count_en, sdone: out std_logic);
end mul_fsm;

architecture rtl of mul_fsm is
type state_type is (s_int, s_start, s_test, s_shf, s_multp, s_done);
signal current_state, next_state: state_type;

begin
process (start,fin,mul, current_state)
begin
case current_state is

when s_int =>
	shr <= '0';
	shl <= '0';
	wr <= '0';
	clr <= '1';
	wrm <= '1';
	count_en <='0';
	sdone <='0';
		
if (start = '1') then
	next_state <= s_start;
else
	next_state <= s_int;
end if;

when s_start =>  
	shr <= '0';
	shl <= '0';
	wr <= '0';
	clr <= '0';
	wrm <= '1';
	count_en <='1';  -- counter start 
	sdone <='0';

	next_state <= s_test;


when s_test =>  -- test 
	shr <= '0';
	shl <= '0';
	wr <= '0';
	clr <= '0';
	wrm <= '0';
	count_en <='0';   
	sdone <='0';
if (mul = '1') then
	next_state <= s_multp;
else
	next_state <= s_shf;
end if;

when s_shf =>
	shr <= '1';
	shl <= '1';
	wr <= '0';
	clr <= '0';
	wrm <= '0';
	count_en <='1';  
	sdone <='0';

if (fin = '0') then
	next_state <= s_test;
else
	next_state <= s_done;
end if;


when s_multp =>
	shr <= '0';
	shl <= '0';
	wr <= '1';
	clr <= '0';
	wrm <= '0';
	count_en <='0';  

	sdone <='0';


	next_state <= s_shf;

when s_done =>
	shr <= '0';
	shl <= '0';
	wr <= '1';
	clr <= '0';
	wrm <= '0';
	count_en <='0';  
	sdone <='1';

	next_state <= s_int;

when others =>
	shr <= '0';
	shl <= '0';
	wr <= '0';
	clr <= '1';
	wrm <= '0';
	count_en <='0';  
	sdone <='0';

	next_state <= s_int;
end case;
end process;
process (rst, clk)
begin
if (rst = '1') then
current_state <= s_int;
elsif (rising_edge(clk)) then
current_state <= next_state;
end if;
end process;
end rtl;

------------------------------------------------------------------
--																--
--	multiplier toplevel											--
--																--
------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;


entity multiplier is
	port(clk ,rst ,start: in std_logic; xin, yin : in std_logic_vector (12 downto 0);
		result: out std_logic_vector (12 downto 0); cout, done: out std_logic);
end multiplier;


architecture rtl of multiplier is

component reg_13bit_shfl is

	port (clk, rst, wr, shift_left: in std_logic;
		reg_in: in std_logic_vector(12 downto 0);
		reg_out: out std_logic_vector(12 downto 0));

end component;

component reg_13bit_shfr is

	port (clk, rst, wr, shift_right: in std_logic;
		reg_in: in std_logic_vector(12 downto 0);
		reg_out: out std_logic_vector(12 downto 0));

end component;

component reg_13bit is
	port (clk, rst, en: in std_logic;
		reg_in: in std_logic_vector(12 downto 0);
		reg_out: out std_logic_vector(12 downto 0));
end component;

component adder_13bit is
	port(a ,b : in std_logic_vector (12 downto 0);
		sum : out std_logic_vector (12 downto 0);
		cout: out std_logic);
end component;

component mul_fsm is

	port (clk, rst, start, fin, mul : in std_logic;
		shr ,shl ,wr, wrm, clr, count_en, sdone: out std_logic);
end component;

component counter is
	port (clk, rst, en: in std_logic;
		fin: out std_logic);
end component;


signal clr_int, shl_int, shr_int, wr_int, wrm_int, counter_fin, counter_en, sdone_int: std_logic;
signal multiplicand_out, adder_out, product_out: std_logic_vector(12 downto 0);
signal multiplier_out: std_logic_vector(12 downto 0);

begin 
	
	multiplicand: reg_13bit_shfl port map(clk, clr_int, wrm_int, shl_int, xin, multiplicand_out);
	
	multiplier: reg_13bit_shfr port map (clk, clr_int, wrm_int, shr_int, yin, multiplier_out); 
	product: reg_13bit port map (clk, clr_int, wr_int, adder_out, product_out);

	adder: adder_13bit port map (multiplicand_out, product_out, adder_out, cout);

	fsm: mul_fsm port map (clk, rst, start, counter_fin, multiplier_out(0), shr_int, shl_int, wr_int, 
				wrm_int, clr_int, counter_en, sdone_int);
	c: counter port map(clk, clr_int, counter_en, counter_fin);


        result <= product_out;

	done <= counter_fin;
end architecture rtl;
