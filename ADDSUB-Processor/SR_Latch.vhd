library IEEE;
use IEEE.std_logic_1164.ALL;

entity SR_Latch is

	port(
		S, R, En, Clk: in std_logic;
		Q, notQ: out std_logic
	);

end SR_Latch;

architecture SR_Latch_arch of SR_Latch is

signal Q_signal, notQ_signal: std_logic;


begin

Q_signal <= (R and Clk and En)  nor notQ_signal after 1 ns;

notQ_signal <= (S and Clk and En)  nor Q_signal after 1 ns;

Q <= Q_signal;

notQ <= notQ_signal;



end SR_Latch_arch;