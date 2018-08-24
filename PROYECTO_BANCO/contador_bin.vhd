library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
 
entity contador_bin is
	generic (n:INTEGER:=3);
   port( D: in std_logic_vector(n downto 0);
			Enable: in std_logic;
			Load: in std_logic;
			Clock: in std_logic;
			Reset: in std_logic;
			Output: out std_logic_vector(n downto 0));
end contador_bin;
 
architecture sol of contador_bin is
   signal temp: std_logic_vector(n downto 0);
begin   
process(Clock,Reset)
   begin
      if Reset='1' then
         temp <= (others => '0');
		elsif(Clock'event and Clock='1') then
			if Enable='1' then
				if Load='1' then
					temp <= D;
				elsif temp = conv_std_logic_vector((2**(n+1))-1,n+1) then
					temp <= (others => '0');
				else
					temp <= temp + 1;
				end if;
			end if;
		end if;
   end process;
	output<=temp;
 end sol;