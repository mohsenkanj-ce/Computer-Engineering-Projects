library IEEE;
use IEEE.std_logic_1164.ALL;

library work;

use work.my_types.ALL;

entity add_sub_nbit is
	generic(N: integer := 32);
	port(
		A, B: in std_logic_vector(N-1 downto 0);
		sub: in std_logic;
		Sum: out std_logic_vector(N-1 downto 0);
		Cout: out std_logic
	);
end add_sub_nbit;

architecture add_sub_nbit_arch of add_sub_nbit is

	component full_adder is
		port(
			A, B, Cin: in std_logic;
			Sum, Cout: out std_logic
		);
	end component;
	
	signal cout_signal: std_logic_vector(N-1 downto 0);
	signal B_xored: std_logic_vector(N-1 downto 0);

begin

	B_xored(0) <= B(0) xor sub;

	fa0: full_adder port map(
		A => A(0),
		B => B_xored(0),
		Cin => sub,
		Sum => Sum(0),
		Cout => cout_signal(0)
	);
	
	generate_nbit_adder: for i in 1 to N-1 generate
		B_xored(i) <= B(i) xor sub;

		fa: full_adder port map(
			A => A(i),
			B => B(i),
			Cin => cout_signal(i-1),
			Sum => Sum(i),
			Cout => cout_signal(i)
		);
		
	end generate generate_nbit_adder;
	
	Cout <= cout_signal(N-1);
	

end add_sub_nbit_arch;