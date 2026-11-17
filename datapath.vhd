library IEEE;
use IEEE.Std_Logic_1164.all;

entity datapath is 
port( SW: in std_logic_vector(17 downto 0);
	clk, R1, R2, E1, E2, E3, E4, E5, E6: in std_logic;
	LEDR: out std_logic_vector(17 downto 0);
	HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7: out std_logic_vector(6 downto 0);
	end_money, end_round: out std_logic
);
end datapath;

architecture arqdtp of datapath is 

----------------------------------COMPONENTES--------------------------------------------------

component Bin_BCD is 
  port (
        BIN : in  std_logic_vector(25 downto 0);
        BCD : out std_logic_vector(31 downto 0)
    );
end component; 

component reg12 is
port (
CLK, RST, EN: in std_logic;
D: in std_logic_vector(11 downto 0);
Q: out std_logic_vector(11 downto 0)
);
end component;

component mux4_1 is
port (F1,F2,F3,F4: in std_logic;
sel: in std_logic_vector(1 downto 0);
F: out std_logic);
end component;

component mux262 is 
port(F1, F2: in std_logic_vector(25 downto 0);
		sel: in std_logic;
		F: out std_logic_vector(25 downto 0)
);
end component;

component mux72 is
port(F1, F2: in std_logic_vector(6 downto 0);
		sel: in std_logic;
		F: out std_logic_vector(6 downto 0));
end component;

component selector is
port (x: in  std_logic_vector(4 downto 0);
   saida: out std_logic_vector(1 downto 0));
end component;

component counter_round is
port (R: in std_logic;
	  E : in std_logic;
	  clock: in std_logic;
	  end_round: out std_logic;
	  X : out std_logic_vector(4 downto 0));
end component;

component Counter_Prize is
port (load: in std_logic_vector(25 downto 0);
	  R,E,clk: in std_logic;
	  SET: in std_logic_vector(11 downto 0);
	  BIN_MONEY: out std_logic_vector(25 downto 0);
	  END_MONEY: out std_logic);
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

component decodtermo is 
port (X: in  std_logic_vector(4 downto 0);
		S: out std_logic_vector(17 downto 0));
end component;

component decod_prize is
    port (
        seq_12bits : in  std_logic_vector(11 downto 0); -- HEX2 & HEX1 & HEX0
        prize      : out std_logic_vector(26 downto 0)  -- Bit 26: Double | Bits 25..0: Valor em binário
    );
end component;

component decod7seg is 
port(G: in std_logic_vector(3 downto 0); 
      H: out std_logic_vector(6 downto 0) 
     ); 
end component;

component seq0 is 
port(clk: in std_logic;
     Rst: in std_logic;
     En: in std_logic;
     S: out std_logic_vector(3 downto 0)
     );
end component;

component seq1 is 
port(clk: in std_logic;
     Rst: in std_logic;
     En: in std_logic;
     S: out std_logic_vector(3 downto 0)
     );
end component;

component seq2 is 
port(clk: in std_logic;
     Rst: in std_logic;
     En: in std_logic;
     S: out std_logic_vector(3 downto 0)
     );
end component;


-------------------------------SINAIS---------------------------------------------
signal SPEED, SEL_MUX,doubling, E, sel: std_logic;
signal SPEED_MUX: std_logic_vector(1 downto 0);
signal X: std_logic_vector(4 downto 0);
signal clk2hz, clk3hz, clk4hz, clk5Hz: std_logic;
signal INIT_MONEY, SEQ: std_logic_vector(11 downto 0);
signal PRIZE, PRIZE_OUT, BIN_MONEY,MONEY_MUX, DOUBLE_BIN_MONEY: std_logic_vector(25 downto 0);
signal MONEY: std_logic_vector(31 downto 0);
signal Rst: std_logic;
signal SEQ_0, SEQ_1, SEQ_2: std_logic_vector(3 downto 0);
signal D00, D01, D10, D11, D20, D21, D30, D40, D50, D60, D70: std_logic_vector(6 downto 0);



begin 



DIV_FREQ_EMU: div_Freq port map(clk,R1,clk2hz,clk3hz,clk4hz,clk5Hz); --Usar esse componente para o emulador

--DIVFREQ: div_Freq_DE2 port map(clk,R1,clk2hz,clk3hz,clk4hz,clk5Hz); --Usar esse componente para a placa DE2

-- a preencher pel@ alun@

end arqdtp;