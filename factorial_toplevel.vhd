library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;


entity factorial_toplevel is
	port(clk ,rst ,start: in std_logic; x_in : in std_logic_vector (2 downto 0);
		result: out std_logic_vector (12 downto 0); done: out std_logic);
end factorial_toplevel;


architecture rtl of factorial_toplevel is

	component factorial_fsm is
		port (clk, rst, start, eq_flg, mult_done : in std_logic;
				x_sel ,t_sel, x_ld, t_ld, mult_start, clr, done_flg: out std_logic);
	end component;

	component multiplier is
		port(clk ,rst ,start: in std_logic; xin, yin : in std_logic_vector (12 downto 0);
			result: out std_logic_vector (12 downto 0); cout, done: out std_logic);
	end component;
	
	component sub_3bit is
		port(a  : in std_logic_vector (2 downto 0);
			sub : out std_logic_vector (2 downto 0);
			cout: out std_logic);
	end component;

	component bits_extender is
		port (a: in std_logic_vector(2 downto 0);
			y: out std_logic_vector(12 downto 0));
	end component;

	component eq_comp_3bit is
		port (a: in unsigned(2 downto 0);
			y: out std_logic);
	end component;
	
	component mux_2_1_3bit is
		port (s: in std_logic;
				a, b: in std_logic_vector(2 downto 0);
				y: out std_logic_vector(2 downto 0));
	end component;

	component mux_2_1_13bit is
		port (s: in std_logic;
				a, b: in std_logic_vector(12 downto 0);
				y: out std_logic_vector(12 downto 0));
	end component;

	component reg_par_13bit is
		port(clk, rst, en: in std_logic;
				reg_in: in std_logic_vector(12 downto 0);
				reg_out: out std_logic_vector(12 downto 0)
			);
	end component;

	component reg_par_3bit is
		port(clk, rst, en: in std_logic;
				reg_in: in std_logic_vector(2 downto 0);
				reg_out: out std_logic_vector(2 downto 0)
			);
	end component;

signal clr_i, x_sel_i, t_sel_i, x_ld_i, t_ld_i, mult_start_i, mult_done_flg, done_flg_fsm, eq_flg_i, cout_mult, cout_sub: std_logic;
signal mult_out, t_reg_out, x_ext_out, t_ext_out, mux_t_out: std_logic_vector(12 downto 0);
signal mux_x_out, x_reg_out, sub_out: std_logic_vector(2 downto 0);

begin 
	fsm: factorial_fsm port map(clk, rst, start, eq_flg_i, mult_done_flg, x_sel_i ,t_sel_i,
			x_ld_i, t_ld_i, mult_start_i, clr_i, done_flg_fsm);
	
	mult: multiplier port map(clk ,clr_i ,mult_start_i, t_reg_out, x_ext_out,
		mult_out, cout_mult, mult_done_flg);

	sub: sub_3bit port map(x_reg_out, sub_out, cout_sub);

	bit_ext_x: bits_extender port map(x_reg_out, x_ext_out);
	bit_ext_t: bits_extender port map(x_in, t_ext_out);

	eq_comp: eq_comp_3bit port map(unsigned(x_reg_out), eq_flg_i);

	mux_x: mux_2_1_3bit port map(x_sel_i, x_in, sub_out, mux_x_out);

	mux_t: mux_2_1_13bit port map(t_sel_i, t_ext_out, mult_out, mux_t_out);

	reg_t: reg_par_13bit port map(clk, clr_i, t_ld_i, mux_t_out, t_reg_out);
	reg_x: reg_par_3bit port map(clk, clr_i, x_ld_i, mux_x_out, x_reg_out);

    result <= t_reg_out;
	done <= done_flg_fsm;
end architecture rtl;
