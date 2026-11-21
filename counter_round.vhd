library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity counter_round is
port (x: out std_logic_vector(4 downto 0);
	clock, enable, set17: in std_logic;
	tc: out std_logic);
end counter_round;

architecture arq_cround of counter_round is
	signal tot: std_logic_vector(4 downto 0);
begin
-- Registrador e Somador:

process(clock,set17,enable)
begin
	if (set17 = '1') then
		tot <= "10001";
	elsif (clock'event AND clock = '1') then
		if (enable = '1') then
			tot <= tot - 1;
		end if;
	end if;
end process;

x <= tot;

-- Quando finalmente chega na última rodada (tot = 0):

	tc <= '1' when (tot = "00000") else
	'0';

end arq_cround;