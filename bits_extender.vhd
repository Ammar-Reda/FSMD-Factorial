library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity bits_extender is
	port (a: in std_logic_vector(2 downto 0);
y: out std_logic_vector(12 downto 0));

end entity bits_extender;

architecture rtl of bits_extender is
begin
y <= "0000000000"&a;
end architecture rtl;