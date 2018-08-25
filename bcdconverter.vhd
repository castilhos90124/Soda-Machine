library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bcdconverter is
   port (
      counter   : in  std_logic_vector (4 downto 0);
      ones, tens: out std_logic_vector (3 downto 0) -- digits output in BCD
   );
end bcdconverter;

architecture behav of bcdconverter is

begin

   bin_to_bcd : process (counter)
      variable auxcounter : unsigned(12 downto 0); -- aux variable
      alias num is auxcounter(4 downto 0);  -- internal balance variable
      alias one is auxcounter(8 downto 5);
      alias ten is auxcounter(12 downto 9);
   begin
      num := unsigned(counter); -- copy balance and clear others
		one := X"0";
      ten := X"0";

      -- bcd conversion logic
      -- if X"block" >= 5 then +3
      -- shift left once
      -- repeat

      for i in 0 to 4 loop
         if one >= 5 then
            one := one + 3;
         end if;

         if ten >= 5 then
            ten := ten + 3;
         end if;

         auxcounter := shift_left(auxcounter, 1);
      end loop;
      tens     <= std_logic_vector(ten);
      ones     <= std_logic_vector(one);
   end process;

end behav;