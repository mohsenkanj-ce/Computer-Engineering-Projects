library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;


library work;
use work.my_types.ALL;

entity mux2to1 is
	port(
		sel: in std_logic;
		data_in: in std_logic_2d_2_32;
		data_out: out std_logic_vector(31 downto 0)
	);
end mux2to1;

architecture mux2to1_arch of mux2to1 is
begin
	with sel select
		data_out <= data_in(0) when '0', 
		data_in(1) when '1',
		(others =>'0') when others;
end mux2to1_arch;