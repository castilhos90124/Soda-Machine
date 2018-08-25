library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_arith.all;

entity top is
	port(
		in_switch25, in_switch50, in_switch100 : in  std_logic;
		clk, reset : in  std_logic;
		in_bj, in_bs : in std_logic;
		in_cancel : in std_logic;
		out_counter : out std_logic_vector (4 downto 0);
		led : out std_logic;
		ssd0 : out std_logic_vector (6 downto 0);
		ssd1 : out std_logic_vector (6 downto 0);
		ssd2 : out std_logic_vector (6 downto 0);
		ssd3 : out std_logic_vector (6 downto 0)
		);
end top;

architecture behav of top is

signal switch25, switch50, switch100 : std_logic;
signal bs, bj, cancel : std_logic;
signal led_state : std_logic;
signal counter : std_logic_vector (4 downto 0);
signal digit0, digit1, digit2, digit3 : std_logic_vector (3 downto 0);

begin
Debouncer25: entity work.debouncer port map(in_switch25, clk, reset, switch25);
Debouncer50: entity work.debouncer port map(in_switch50, clk, reset, switch50);
Debouncer100: entity work.debouncer port map(in_switch100, clk, reset, switch100);
DebouncerBJ: entity work.debouncer port map(in_bj, clk, reset, bj);
DebouncerBS: entity work.debouncer port map(in_bs, clk, reset, bs);
DebouncerCL: entity work.debouncer port map(in_cancel, clk, reset, cancel);
Display0: entity work.segdisplay port map (reset, digit0, ssd0);
Display1: entity work.segdisplay1 port map (reset, digit0, ssd1);
Display2: entity work.segdisplay2 port map (reset, digit0, ssd2);
Display3: entity work.segdisplay port map (reset, digit3, ssd3);
converter : entity work.bcdconverter port map(counter, digit0, digit1);
out_counter <= counter;

--proc_sw : process(clk, reset, switch25, switch50, switch100, in_bj, in_bs, cancel)
proc_sw : process(clk, reset)
begin
    if (reset = '0') then
        led_state <= '0';
		  counter <= (others => '0');
    elsif (clk'event and clk = '1') then
        if (switch25 = '1') then --caso moeda de 25
            led_state <= not led_state;
				counter <= unsigned(counter) + 1;
				
			elsif (switch50 = '1') then --caso moeda de 50
            led_state <= not led_state;
				counter <= unsigned(counter) + 2;
				
			elsif (switch100 = '1') then --caso moeda de 100
            led_state <= not led_state;
				counter <= unsigned(counter) + 4;
				
			elsif (bj = '1') then --caso compre suco
				if (counter >= "00011") then --se tiver saldo zera
					counter <= unsigned(counter) - 3;
				else
					counter <= counter;
				end if;
				--111 - 011 = 100
			elsif (bs = '1') then --caso compre refrigerante
				if (counter >= "00110") then
					counter <= unsigned(counter) - 6;
				else
					counter <= counter;	
				end if;
			
			elsif (cancel = '1') then --caso cancele
				counter <= "00000";
			
        else
            led_state <= led_state;
				counter <= counter;
        end if;
    end if;

end process;

led <= led_state;
end behav;
