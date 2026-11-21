library ieee;
use ieee.std_logic_1164.all;

entity reg12 is port (
    CLK, RST, EN: in std_logic;
    D: in std_logic_vector(11 downto 0);
    Q: out std_logic_vector(11 downto 0)
    );
end reg12;

architecture behv of reg12 is
begin
    process(CLK, D, RST)
    begin
        if RST = '0' then
            Q <= "000000000000";
        elsif (CLK'event and CLK = '1') and EN = '1' then
            Q <= D;
        end if;
    end process;
end behv; 