library ieee;
use ieee.std_logic_1164.all;

entity seq1 is 
port(clock, reset, enable: in std_logic;
	contagem: out std_logic_vector(3 downto 0));
	end seq1;
	architecture arq_seq1 of seq1 is
		type STATES is (E0, E1, E2, E3, E4, E5, E6, E7, E8, E9, E10, E11, E12, E13, E14, E15);
		signal EA, PE: STATES;
begin
  
	P1: process(clock, reset)
	begin
			if reset= '1' then
				EA <= E0;
			elsif clock'event and clock= '1' and enable = '1' then
				EA <= PE;
			end if;
end process;
  
	P2: process(EA)
	begin
	
		case EA is
				when E0 =>
								contagem <= "0000";
								PE <= E5;
				when E1 =>
								contagem <= "0001";
								PE <= E4;
				when E2 =>
								contagem <= "0010";
								PE <= E13;
				when E3 => 
								contagem <= "0011";
								PE <= E12;
				when E4 =>
								contagem <= "0100";
								PE <= E10;
				when E5 =>
								contagem <= "0101";
								PE <= E2;
				when E6 =>
								contagem <= "0110";
								PE <= E9;
				when E7 =>
								contagem <= "0111";
								PE <= E1;
				when E8 =>
								contagem <= "1000";
								PE <= E0;
				when E9 =>
								contagem <= "1001";
								PE <= E7;
				when E10 =>
								contagem <= "1010";
								PE <= E3;
				when E11 =>
								contagem <= "1011";
								PE <= E8;
				when E12 =>
								contagem <= "1100";
								PE <= E11;
				when E13 =>
								contagem <= "1101";
								PE <= E15;
				when E14 =>
								contagem <= "1110";
								PE <= E6;
				when E15 =>
								contagem <= "1111";
								PE <= E14;

		end case;
		end process;
	end arq_seq1;