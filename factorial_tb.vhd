library ieee,std;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use std.textio.all;
use ieee.numeric_std.all;

entity factorial_tb is
end factorial_tb ;

architecture behav of factorial_tb is
  file vectors:text open read_mode is "factorial_vec.txt";
  file result_vectors:text open write_mode is "factorial_results.txt";

  constant clockperiod: time:=100000 ps;
  signal clk: std_logic:='0';
  signal start: std_logic:='0';
  signal rst: std_logic:='1';
  signal finish_flg: std_logic;
  signal x_in : std_logic_vector (2 downto 0);
  signal factorial_result: std_logic_vector (12 downto 0);
  
    component factorial_toplevel is
        port(clk ,rst ,start: in std_logic; x_in : in std_logic_vector (2 downto 0);
            result: out std_logic_vector (12 downto 0); done: out std_logic);
    end component;
	
  begin

	clk <= not clk after clockperiod /2;
    dut: factorial_toplevel port map(clk ,rst ,start ,x_in ,factorial_result, finish_flg);
    
    process
      variable vectorline, v_OLINE: line;
      variable d_var: bit_vector(2 downto 0);
	begin
      d_var:= "000";
	  wait for clockperiod;
	  rst <='0';
      while(not endfile(vectors)) loop
        readline(vectors, vectorline);
        if vectorline(1)='#' then
          next;
        end if;
		read(vectorline, d_var);
        x_in <= to_stdlogicvector(d_var);
		wait for clockperiod;
		rst <='1';
		wait for clockperiod;
		rst <='0';
		wait for clockperiod;
		start <= '1';
		wait for clockperiod;
		start <= '0';
		--wait for 2500000 ps;
		wait for 161* clockperiod;
		write(v_OLINE,  to_integer(ieee.numeric_std.unsigned(factorial_result)), right, 1);
		writeline(result_vectors, v_OLINE);
      end loop;
	  
	  wait for 1* clockperiod;
      wait;
    end process;
  end behav;