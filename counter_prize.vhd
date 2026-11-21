library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity counter_prize is
port (load_prize: in std_logic_vector(25 downto 0);
	init_money: in std_logic_vector(11 downto 0);
	bin_money: out std_logic_vector(25 downto 0);
	clock, enable, set_money: in std_logic);
end counter_prize;

architecture arq_cprize of counter_prize is
	signal tot: std_logic_vector(25 downto 0);
begin
-- Registrador e Somador:

process(clock,set_money,enable)
begin
  if rising_edge(clock) then
    if set_money = '1' then
      tot <= "00000000000000" & init_money;
    elsif enable = '1' then
      tot <= tot + load_prize;
    end if;
  end if;
end process;

bin_money <= tot;

end arq_cprize;