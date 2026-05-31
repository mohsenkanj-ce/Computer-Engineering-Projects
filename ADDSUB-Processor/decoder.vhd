library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity decoder is
	generic(
		N: integer := 5;
		M: integer := 32
	);
	port(
		decoder_in: in std_logic_vector(N-1 downto 0);
		decoder_out: out std_logic_vector(M-1 downto 0)
	);
end decoder;

architecture decoder_arch of decoder is
begin
	process(decoder_in)
	begin
		decoder_out <= ( others => '0');
		if(to_integer(unsigned(decoder_in))<M) then
			decoder_out(to_integer(unsigned(decoder_in))) <= '1';
		end if;
	end process;
end decoder_arch;