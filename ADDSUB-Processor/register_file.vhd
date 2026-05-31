library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

library work;
use work.my_types.ALL;

entity register_file is
	port(
		busW: in std_logic_vector(31 downto 0);
		Clk: in std_logic;
		RegWr: in std_logic;
		Rd: in std_logic_vector(4 downto 0);
		Rs: in std_logic_vector(4 downto 0);
		Rt: in std_logic_vector(4 downto 0);
		busA: out std_logic_vector(31 downto 0);
		busB: out std_logic_vector(31 downto 0)
	);
end register_file;

architecture register_file_arch of register_file is

component decoder is
	generic(
		N: integer := 5;
		M: integer := 32
	);
	port(
		decoder_in: in std_logic_vector(N-1 downto 0);
		decoder_out: out std_logic_vector(M-1 downto 0)
	);
end component;

component n_register is

	generic(
		N: integer := 32
	);

	port(
		data_in: in std_logic_vector(N-1 downto 0);
		Clk: in std_logic;
		En: in std_logic;
		data_out: out std_logic_vector(N-1 downto 0)
	);

end component;

component mux32to1 is
	port(
		sel: in std_logic_vector(4 downto 0);
		data_in: in std_logic_2d_32_32;
		data_out: out std_logic_vector(31 downto 0)
	);
end component;

signal decoder_out: std_logic_vector(31 downto 0);
signal register_out: std_logic_2d_32_32;
signal RegWrEnable: std_logic_vector(31 downto 0);
signal Clk_per_register: std_logic_vector(31 downto 0);

begin

	decode: decoder port map(
		decoder_in => Rd,
		decoder_out => decoder_out
	);
	
	generate_registers: for i in 0 to 31 generate
		
		RegWrEnable(i) <= decoder_out(i) and RegWr;
		Clk_per_register <= Clk xor RegWr;
		
		
		register_n: n_register port map(
			data_in => busW,
			Clk => Clk,
			En => RegWrEnable(i),
			data_out => register_out(i)
		);
	end generate generate_registers;
	
	mux_reg_rs:  mux32to1 port map(
		sel => Rs,
		data_in => register_out,
		data_out => busA
	);
	
	mux_reg_rt:  mux32to1 port map(
		sel => Rt,
		data_in => register_out,
		data_out => busB
	);

end register_file_arch;