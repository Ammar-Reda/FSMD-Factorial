library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity mux_2_1_3bit is
    port (s: in std_logic;
            a, b: in std_logic_vector(2 downto 0);
            y: out std_logic_vector(2 downto 0));
end entity mux_2_1_3bit;

architecture rtl of mux_2_1_3bit is
begin

y <= a when s = '0' else b;

end architecture rtl;
