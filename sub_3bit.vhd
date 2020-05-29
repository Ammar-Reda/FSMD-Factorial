library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity fullsub is

	port (a,b,cin: in std_logic ;
		cout, sub: out std_logic);

end entity fullsub;

architecture rtl of fullsub is

begin
	
	sub <= cin xor ( a xor b) ;
	cout <= ((NOT a) and b) OR (cin AND (a XNOR b));


end architecture rtl;

----------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;


entity sub_3bit is
	port(a : in std_logic_vector (2 downto 0);
		sub : out std_logic_vector (2 downto 0);
		cout: out std_logic);
end sub_3bit;


architecture rtl of sub_3bit is

component fullsub is

	port (a, b,cin: in std_logic ;
		cout, sub: out std_logic);

end component;

	
	signal c: std_logic_vector (1 downto 0);
	signal s_int: std_logic_vector (2 downto 0);

begin 

inst_0: fullsub port map (a(0), '1', '0', c(0), s_int(0));
inst_1: fullsub port map (a(1), '0', c(0), c(1), s_int(1));
inst_2: fullsub port map (a(2), '0', c(1), cout, s_int(2));



sub <= s_int;


	
end architecture rtl;

