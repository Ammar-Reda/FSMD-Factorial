library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity eq_comp_3bit is
	port (a: in unsigned(2 downto 0);
y: out std_logic);

end entity eq_comp_3bit;

architecture rtl of eq_comp_3bit is

begin
process (a)
begin
	if (a = 1 or a = 0) then
		y <= '1';
	else 
		y <= '0';
end if;
end process;
end architecture rtl;