library IEEE;
use IEEE.std_logic_1164.ALL;

entity D_Flip_Flop is

	port(
		D, En, Clk: in std_logic;
		Q, notQ: out std_logic
	);

end D_Flip_Flop;


architecture D_Flip_Flop_arch of D_Flip_Flop is

component D_Latch is

	port(
		D, En, Clk: in std_logic;
		Q, notQ: out std_logic
	);

end component;

signal notClk: std_logic;
signal Q_sig: std_logic;

begin

	notClk <= not Clk;
	
	DL1: D_Latch port map(
		D => D,
		En => En,
		Clk => notClk,
		Q => Q_sig
	);
	
	DL2: D_Latch port map(
		D => Q_sig,
		En => En,
		Clk => Clk,
		Q => Q,
		notQ => notQ
	);

end D_Flip_Flop_arch;