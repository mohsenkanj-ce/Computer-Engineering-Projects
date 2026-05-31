library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;


library work;
use work.my_types.ALL;

entity mux32to1 is
	port(
		sel: in std_logic_vector(4 downto 0);
		data_in: in std_logic_2d_32_32;
		data_out: out std_logic_vector(31 downto 0)
	);
end mux32to1;

architecture mux32to1_arch of mux32to1 is
begin
	data_out <= data_in(to_integer(unsigned(sel)));
	
--	with sel select:
--		data_out <= data_in(0) when "00000",
--		data_in(1) when "00001",
--		data_in(2) when "00010",
end mux32to1_arch;