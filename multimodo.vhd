library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.std_logic_signed.all;

entity multimodo is
port(--CLOCK_50:in std_logic; --usar na placa DE2
     CLK_500Hz:in std_logic; --usar no emulador
     KEY:in std_logic_vector(3 downto 0);
     SW:in std_logic_vector(9 downto 0);
     LEDR:out std_logic_vector(9 downto 0);
     HEX0,HEX1,HEX2,HEX3,HEX4,HEX5: out std_logic_vector(6 downto 0));
end multimodo;

architecture circuito_exe2 of multimodo is
signal saida, soma, entrada, direita, esquerda, F: std_logic_vector(3 downto 0);
signal shr_in, shl_in: std_logic;
-- colocar aqui os sinais auxiliares

component mux is
port (
F1: in std_logic_vector(3 downto 0);
F2: in std_logic_vector(3 downto 0);
F3: in std_logic_vector(3 downto 0);
F4: in std_logic_vector(3 downto 0);
sel: in std_logic_vector(1 downto 0);
F: out std_logic_vector(3 downto 0)
);
end component;

component D_4FF is
port (
RST: in std_logic;
CLK: in std_logic;
D: in std_logic_vector(3 downto 0);
Q: out std_logic_vector(3 downto 0)
);
end component;

begin

mu: mux port map(entrada, soma, direita, esquerda, SW(9 downto 8), F);
reg: D_4FF port map(KEY(0), KEY(1), F, saida);

shr_in <= SW(4);
shl_in <= SW(5);
direita <= shr_in & saida(3 downto 1);
esquerda <= saida(2 downto 0) & shl_in;
entrada <= SW(3 downto 0);
soma <= saida + SW(3 downto 0);
LEDR(3 downto 0) <= saida;

end circuito_exe2;