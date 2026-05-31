library IEEE;
use IEEE.std_logic_1164.ALL;

entity half_adder is
	port(
		A, B: in std_logic;
		Sum, Cout: out std_logic
	);
end half_adder;

architecture half_adder_arch of half_adder is

begin
	Sum <= A xor B;
	Cout <= A and B;
end half_adder_arch;