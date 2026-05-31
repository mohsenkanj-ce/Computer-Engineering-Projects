library IEEE;
use IEEE.std_logic_1164.ALL;

entity Control_Unit is
	port(
		instruction: in std_logic_vector(31 downto 0);
		RegWr: out std_logic;
		Rd: out std_logic_vector(4 downto 0);
		Rs: out std_logic_vector(4 downto 0);
		Rt: out std_logic_vector(4 downto 0);
		ALuCtr: out std_logic
	);
end Control_Unit;

architecture Control_Unit_arch of Control_Unit is

begin
	RegWr <= instruction(5);
	Rs <= instruction(25 downto 21);
	Rt <= instruction(20 downto 16);
	Rd <= instruction(15 downto 11);
	ALuCtr <= instruction(1);
end Control_Unit_arch;