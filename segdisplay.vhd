library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity segdisplay is
port (
      reset : in std_logic;
      bcd : in std_logic_vector(3 downto 0);  --BCD input
      segment : out std_logic_vector(6 downto 0)  -- 7 bit decoded output
    );
end segdisplay;
architecture behav of segdisplay is
begin
	digit_display : process (reset, bcd)
	begin
		if reset = '0' then
			segment <="0000001"; -- display 0 on reset
		else
			case bcd is			      -- 0123456
				when "0000"=> segment <="0000001";  -- '0'
				when "0001"=> segment <="0100100";  -- '5'
				when "0010"=> segment <="0000001";  -- '0'
				when "0011"=> segment <="0100100";  -- '5'
				when "0100"=> segment <="0000001";  -- '0'
				when "0101"=> segment <="0100100";  -- '5'
				when "0110"=> segment <="0000001";  -- '0'
				when "0111"=> segment <="0100100";  -- '5'
				when "1000"=> segment <="0000001";  -- '0'
				when "1001"=> segment <="0100100";  -- '5'
				when "1010"=> segment <="0000001";  -- '0'
				when "1011"=> segment <="0100100";  -- '5'
				when "1100"=> segment <="0000001";  -- '0'
				when "1101"=> segment <="0100100";  -- '5'
				when "1110"=> segment <="0000001";  -- '0'
				when "1111"=> segment <="0100100";  -- '5'
			end case;
		end if;
	end process;

end behav;