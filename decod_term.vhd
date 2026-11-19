library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decod_term is
    port (
        X: in  std_logic_vector(4 downto 0);
        leds: out std_logic_vector(17 downto 0)
    );
end entity decod_term;

architecture decodificador of decod_term is
    begin
        leds <= "111111111111111111" when X = "10001" else
                "011111111111111111" when X = "10000" else
                "001111111111111111" when X = "01111" else
                "000111111111111111" when X = "01110" else
                "000011111111111111" when X = "01101" else
                "000001111111111111" when X = "01100" else
                "000000111111111111" when X = "01011" else
                "000000011111111111" when X = "01010" else
                "000000001111111111" when X = "01001" else
                "000000000111111111" when X = "01000" else
                "000000000011111111" when X = "00111" else
                "000000000001111111" when X = "00110" else
                "000000000000111111" when X = "00101" else
                "000000000000011111" when X = "00100" else
                "000000000000001111" when X = "00011" else
                "000000000000000111" when X = "00010" else
                "000000000000000011" when X = "00001" else
                "000000000000000001";
end architecture;