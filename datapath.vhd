library IEEE;
use IEEE.Std_Logic_1164.all;

entity datapath is 
port(SW: in std_logic_vector(17 downto 0);
	clk, R1, R2, E1, E2, E3, E4, E5, E6: in std_logic;
	LEDR: out std_logic_vector(17 downto 0);
	HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7: out std_logic_vector(6 downto 0);
	end_money, end_round: out std_logic
);
end datapath;

architecture arqdtp of datapath is 

----------------------------------COMPONENTES--------------------------------------------------

component Bin_BCD is 
port (BIN: in  std_logic_vector(25 downto 0);
    BCD: out std_logic_vector(31 downto 0));
end component; 

component counter_prize is
port (load_prize: in std_logic_vector(25 downto 0);
	init_money: in std_logic_vector(11 downto 0);
	bin_money: out std_logic_vector(25 downto 0);
	clock, enable, set_money: in std_logic);
end component;

component counter_round is
port (x: out std_logic_vector(4 downto 0);
	clock, enable, set17: in std_logic;
	tc: out std_logic);
end component;

component decod_prize is
port (seq_12bits: in std_logic_vector(11 downto 0); -- HEX2 & HEX1 & HEX0
    prize: out std_logic_vector(26 downto 0));  -- Bit 26: Double | Bits 25..0: Valor em binário
end component;

component decod_term is 
port (X: in  std_logic_vector(4 downto 0);
    leds: out std_logic_vector(17 downto 0));
end component;

component decod7seg is 
port (G: in std_logic_vector(3 downto 0);
	H: out std_logic_vector(6 downto 0));
end component;

component Div_Freq_DE2 is --Para placa DE2 (CLOCK_50)
port (clk: in std_logic;
    reset: in std_logic;
    CLK_2Hz, CLK_3Hz, CLK_4Hz, CLK_5Hz: out std_logic);
end component;

component Div_Freq is --Para emulador (CLK_500Hz)
port (clk: in std_logic;
    reset: in std_logic;
    CLK_2Hz, CLK_3Hz, CLK_4Hz, CLK_5Hz: out std_logic);
end component;

component mux2_1_7bits is
port(F1, F2: in std_logic_vector(6 downto 0);
	sel: in std_logic;
	F: out std_logic_vector(6 downto 0));
end component;

component mux2_1_26bits is 
port(F1, F2: in std_logic_vector(25 downto 0);
	sel: in std_logic;
	F: out std_logic_vector(25 downto 0));
end component;

component mux4_1 is
port (F1, F2, F3, F4: in std_logic;
	sel: in std_logic_vector(1 downto 0);
	F: out std_logic);
end component;

component reg12 is
port (CLK, RST, EN: in std_logic;
    D: in std_logic_vector(11 downto 0);
    Q: out std_logic_vector(11 downto 0));
end component;

component selector is
port (x: in  std_logic_vector(4 downto 0);
	saida: out std_logic_vector(1 downto 0));
end component;

component seq0 is 
port(clock, reset, enable: in std_logic;
	contagem: out std_logic_vector(3 downto 0));
end component;

component seq1 is 
port(clock, reset, enable: in std_logic;
	contagem: out std_logic_vector(3 downto 0));
end component;

component seq2 is 
port(clock, reset, enable: in std_logic;
	contagem: out std_logic_vector(3 downto 0));
end component;


-------------------------------SINAIS---------------------------------------------
signal SPEED, SEL_MUX,doubling, E, sel, RST_SEQ: std_logic;
signal SPEED_MUX: std_logic_vector(1 downto 0);
signal X: std_logic_vector(4 downto 0);
signal CLK2Hz, CLK3Hz, CLK4Hz, CLK5Hz: std_logic;
signal INIT_MONEY, SEQ: std_logic_vector(11 downto 0);
signal PRIZE, PRIZE_OUT, BIN_MONEY,MONEY_MUX: std_logic_vector(25 downto 0);
signal PRIZE_27: std_logic_vector(26 downto 0);
signal MONEY: std_logic_vector(31 downto 0);
signal SEQ_0, SEQ_1, SEQ_2: std_logic_vector(3 downto 0);
signal D00, D01, D10, D11, D20, D21, D30, D40, D50, D60, D70, BLANK, ZEROS: std_logic_vector(6 downto 0);



begin 

SEQ <= SEQ_2 & SEQ_1 & SEQ_0;
RST_SEQ <= R1 or R2;
BLANK <= "1111111";
ZEROS <= "0000000";
SEL_MUX <= (SW(17) or E4) or (E3 or E2);
PRIZE_OUT <= PRIZE(25 downto 0);
Doubling <= PRIZE(26);

DIV_FREQ_EMU: div_Freq port map(clk,R1,CLK2Hz,CLK3Hz,CLK4Hz,CLK5Hz); --Usar esse componente para o emulador
--DIVFREQ: div_Freq_DE2 port map(clk,R1,CLK2Hz,CLK3Hz,CLK4Hz,CLK5Hz); --Usar esse componente para a placa DE2
MUX_SPEED: mux4_1 port map(CLK2Hz,CLK3Hz,CLK4Hz,CLK5Hz,SPEED_MUX,SPEED);
REG: reg12 port map(clk,R2,E1,SW(11 downto 0),INIT_MONEY);
COUNTER_PRIZE_: counter_prize port map(PRIZE,INIT_MONEY,BIN_MONEY,clk,E5,E1);
MUX26_1: mux2_1_26bits port map(PRIZE_OUT,BIN_MONEY,(Doubling and E5),PRIZE);
COUNTER_ROUND_: counter_round port map(X,clk,((CLK2Hz and E6) or E5),R1,end_round);
DECOD_PRIZE_: decod_prize port map(SEQ, PRIZE_27);
MUX26_2: mux2_1_26bits port map(BIN_MONEY,"00000000000000000000000000",BIN_MONEY(25),MONEY_MUX);
BIN_BCD_: Bin_BCD port map(MONEY_MUX,MONEY);
SEQ0_: seq0 port map(SPEED,RST_SEQ,E2,SEQ_0);
SEQ1_: seq1 port map(SPEED,RST_SEQ,E3,SEQ_1);
SEQ2_: seq2 port map(SPEED,RST_SEQ,E4,SEQ_2);
DECOD_TERM_: decod_term port map(X,LEDR);
DECOD7SEG0_0: decod7seg port map(MONEY(3 downto 0),D00);
DECOD7SEG0_1: decod7seg port map(SEQ_0,D01);
DECOD7SEG1_0: decod7seg port map(MONEY(7 downto 4),D10);
DECOD7SEG1_1: decod7seg port map(SEQ_1,D11);
DECOD7SEG2_0: decod7seg port map(MONEY(11 downto 8),D20);
DECOD7SEG2_1: decod7seg port map(SEQ_2,D21);
DECOD7SEG3_0: decod7seg port map(MONEY(15 downto 12),D30);
DECOD7SEG4_0: decod7seg port map(MONEY(19 downto 16),D40);
DECOD7SEG5_0: decod7seg port map(MONEY(23 downto 20),D50);
DECOD7SEG6_0: decod7seg port map(MONEY(27 downto 24),D60);
DECOD7SEG7_0: decod7seg port map(MONEY(31 downto 28),D70);
MUX7_0: mux2_1_7bits port map(D00,D01,SEL_MUX,HEX0);
MUX7_1: mux2_1_7bits port map(D10,D11,SEL_MUX,HEX1);
MUX7_2: mux2_1_7bits port map(D20,D21,SEL_MUX,HEX2);
MUX7_3: mux2_1_7bits port map(D30,BLANK,SEL_MUX,HEX3);
MUX7_4: mux2_1_7bits port map(D40,BLANK,SEL_MUX,HEX4);
MUX7_5: mux2_1_7bits port map(D50,BLANK,SEL_MUX,HEX5);
MUX7_6: mux2_1_7bits port map(D60,BLANK,SEL_MUX,HEX6);
MUX7_7: mux2_1_7bits port map(D70,BLANK,SEL_MUX,HEX7);

end arqdtp;