library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;


entity factorial_fsm is

port (clk, rst, start, eq_flg, mult_done : in std_logic;
		x_sel ,t_sel, x_ld, t_ld, mult_start, clr, done_flg: out std_logic);
end factorial_fsm;

architecture rtl of factorial_fsm is
type state_type is (s_init, s_start, s_1, s_2, s_3, s_4, s_done);
signal current_state, next_state: state_type;

begin
process (start, eq_flg, mult_done, current_state)
begin
case current_state is

when s_init =>
    x_sel <= '0';
    t_sel <= '0';
    x_ld <= '0';
    t_ld <= '0';
    mult_start <= '0';
    clr <='1';
    done_flg <='0';
		
if (start = '1') then
	next_state <= s_start;
else
	next_state <= s_init;
end if;

when s_start =>  
    x_sel <= '0';
    t_sel <= '0';
    x_ld <= '1';
    t_ld <= '1';
    mult_start <= '0';
    clr <='0';
    done_flg <='0';

	next_state <= s_1;


when s_1 =>  
    x_sel <= '1';
    t_sel <= '0';
    x_ld <= '1';
    t_ld <= '0';
    mult_start <= '0';
    clr <='0';
    done_flg <='0';

if (eq_flg = '1') then
    next_state <= s_done;
else
    next_state <= s_2;
end if;

when s_2 =>
    x_sel <= '0';
    t_sel <= '0';
    x_ld <= '0';
    t_ld <= '0';
    mult_start <= '1';
    clr <='0';
    done_flg <='0';

if (eq_flg = '1') then
	next_state <= s_done;
else
	next_state <= s_3;
end if;


when s_3 =>
    x_sel <= '0';
    t_sel <= '0';
    x_ld <= '0';
    t_ld <= '0';
    mult_start <= '0';
    clr <='0';
    done_flg <='0';


if (mult_done = '1') then
    next_state <= s_4;
else
    next_state <= s_3;
end if;

when s_4 =>
    x_sel <= '0';
    t_sel <= '1';
    x_ld <= '0';
    t_ld <= '1';
    mult_start <= '0';
    clr <='0';
    done_flg <='0';

    next_state <= s_1;

    
when s_done =>
    x_sel <= '0';
    t_sel <= '0';
    x_ld <= '0';
    t_ld <= '0';
    mult_start <= '0';
    done_flg <='1';

    if (start = '1') then
        clr <='1';
        next_state <= s_1;
    else
        clr <='0';
        next_state <= s_done;
    end if;

when others =>
    x_sel <= '0';
    t_sel <= '0';
    x_ld <= '0';
    t_ld <= '0';
    mult_start <= '0';
    clr <='1';
    done_flg <='0';

    next_state <= s_init;
end case;
end process;
process (rst, clk)
begin
if (rst = '1') then
current_state <= s_init;
elsif (rising_edge(clk)) then
current_state <= next_state;
end if;
end process;
end rtl;