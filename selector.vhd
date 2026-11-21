library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity selector is
port (x: in  std_logic_vector(4 downto 0);
	saida: out std_logic_vector(1 downto 0));
end selector;

architecture converter of selector is
begin
	process(x)
	begin
		if x = "10001" or x = "10000" or x = "01111" or x = "01110" then
			saida <= "00";
		elsif x = "01101" or x = "01100" or x = "01011" or x = "01010" or x = "01001" then
			saida <= "01";
		elsif x = "01000" or x = "00111" or x = "00110" or x = "00101" or x = "00100" then
			saida <= "10";
		else
			saida <= "11";
		end if;
	end process;
end architecture converter;