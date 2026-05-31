library IEEE;
use IEEE.std_logic_1164.ALL;

library work;
use work.my_types.ALL;


entity registers_add_sub_tb is
end entity;

architecture registers_add_sub_tb_arch of registers_add_sub_tb is

component Control_Unit is
	port(
		instruction: in std_logic_vector(31 downto 0);
		RegWr: out std_logic;
		Rd: out std_logic_vector(4 downto 0);
		Rs: out std_logic_vector(4 downto 0);
		Rt: out std_logic_vector(4 downto 0);
		ALuCtr: out std_logic
	);
end component;

component register_file is
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
end component;

component add_sub_nbit is
	generic(N: integer := 32);
	port(
		A, B: in std_logic_vector(N-1 downto 0);
		sub: in std_logic;
		Sum: out std_logic_vector(N-1 downto 0);
		Cout: out std_logic
	);
end component;

component mux2to1 is
	port(
		sel: in std_logic;
		data_in: in std_logic_2d_2_32;
		data_out: out std_logic_vector(31 downto 0)
	);
end component;


signal instruction: std_logic_vector(31 downto 0);
signal RegWr, ALuCtr: std_logic;
signal Rd, Rs, Rt: std_logic_vector(4 downto 0);
signal busW, busA, busB: std_logic_vector(31 downto 0);
signal Clk: std_logic;
signal Cout: std_logic;
signal MemToRegSel: std_logic;
signal MemToRegInput: std_logic_2d_2_32;
signal ALU_Result: std_logic_vector(31 downto 0);

begin

	Clk_proc: process
	begin
		Clk <= '1';
		wait for 5 ns;
		Clk <= '0';
		wait for 5 ns;
	end process;

	CU: Control_Unit port map(
		instruction => instruction,
		RegWr => RegWr,
		Rd => Rd,
		Rs => Rs,
		Rt => Rt,
		ALuCtr => ALuCtr
	);
	
	
	reg_file: register_file port map(
		busW => busW,
		Clk => Clk,
		RegWr => RegWr,
		Rd => Rd,
		Rs => Rs,
		Rt => Rt,
		busA => busA,
		busB => busB
	);
	
	ALU: add_sub_nbit port map(
		A => busA,
		B => busB,
		sub => ALuCtr,
		Sum => ALU_Result,
		Cout =>Cout
	);
	
	MemToRegInput(0) <= ALU_Result;
	
	mux2to1_comp: mux2to1 port map(
		sel => MemToRegSel,
		data_in => MemToRegInput,
		data_out => busW
	);
	
	
	reg_add_sub_proc: process
	begin
		MemToRegSel <='1';
		instruction <= "00000010001100101000100000100000"; -- workaround to initialize values  of the registers, because this is a add instruction
		MemToRegInput(1) <= "00000000000000000000000000000100";
		wait for 10 ns;
		instruction <= "00000010001100101001000000100000";
		MemToRegInput(1) <= "00000000000000000000000000001001";
		wait for 10 ns;
		MemToRegSel <='0';
		instruction <= "00000010001100101001100000100000";
		wait for 10 ns;
		MemToRegSel <='0';
		instruction <= "00000010001100111010000000100000";
		wait for 10 ns;
		instruction <= "00000010001100111010000000100000";
		wait for 10 ns;
		instruction <= "00000010001100111010000000100000";
		wait for 10 ns;
		instruction <= "00000010001100111010000000100000";
		wait for 10 ns;
	end process;
	

	

end registers_add_sub_tb_arch;