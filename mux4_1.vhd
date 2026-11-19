library IEEE;
use IEEE.Std_Logic_1164.all;

entity mux4_1 is
	port (
		F1: in std_logic;
		F2: in std_logic;
		F3: in std_logic;
		F4: in std_logic;
		sel: in std_logic_vector(1 downto 0);
		F: out std_logic
	);
end mux4_1;

architecture arq_mux4_1 of mux4_1 is
begin
	F <= F1 when sel = "00" else
					F2 when sel = "01" else
					F3 when sel = "10" else
					F4;
end arq_mux4_1;

