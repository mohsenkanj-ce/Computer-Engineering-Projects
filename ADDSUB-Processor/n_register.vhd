library IEEE;
use IEEE.std_logic_1164.ALL;

entity n_register is

	generic(
		N: integer := 32
	);

	port(
		data_in: in std_logic_vector(N-1 downto 0);
		Clk: in std_logic;
		En: in std_logic;
		data_out: out std_logic_vector(N-1 downto 0)
	);

end n_register;

architecture n_register_arch of n_register is

component D_Flip_Flop is

	port(
		D, En, Clk: in std_logic;
		Q, notQ: out std_logic
	);

end component;

begin

	generate_n_register: for i in 0 to N-1 generate
		D1: D_Flip_Flop port map(
			D => data_in(i),
			En => En,
			Clk => Clk,
			Q => data_out(i)
		);
	end generate generate_n_register;

end n_register_arch;