library IEEE;
use IEEE.std_logic_1164.ALL;

entity full_adder is
	port(
		A, B, Cin: in std_logic;
		Sum, Cout: out std_logic
	);
end full_adder;



architecture full_adder_arch of full_adder is

	component half_adder is
		port(
			A, B: in std_logic;
			Sum, Cout: out std_logic
		);
	end component;
	
	signal ha1_sum, ha1_cout, ha2_cout: std_logic;

begin

	ha1: half_adder port map(
		A => A,
		B => B,
		Sum => ha1_sum,
		Cout => ha1_cout
	);
	
	ha2: half_adder port map(
		A => Cin,
		B => ha1_sum,
		Sum => Sum,
		Cout => ha2_cout
	);
	
	Cout <= ha1_cout or ha2_cout;
	
end full_adder_arch;