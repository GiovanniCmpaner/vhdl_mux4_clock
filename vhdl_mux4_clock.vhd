library IEEE;
use IEEE.std_logic_1164.all;
USE IEEE.numeric_std.ALL;

entity vhdl_mux4_clock is 
generic (
	CLOCK_FREQ : integer := 50_000_000
);
port
(
	CLOCK_50MHz :     in std_logic;
	SW          :     in std_logic_vector(3 downto 0);
	LED_R       : buffer std_logic := '0'
);
end vhdl_mux4_clock;

architecture hardware of vhdl_mux4_clock is
	type vetor is array(3 downto 0) of integer;
	CONSTANT max : vetor := ( 
		4 * CLOCK_FREQ, 
		3 * CLOCK_FREQ, 
		2 * CLOCK_FREQ, 
		1 * CLOCK_FREQ
	); 
begin
		process(CLOCK_50MHz)
			variable count : integer := 0;
		begin
			if(CLOCK_50MHz'event and CLOCK_50MHz='1') then
				count := count + 1;
				if(count >= max(to_integer(unsigned(SW)))) then
					LED_R <= not LED_R;
					count := 0;
				end if;
			end if;
		end process;
end hardware;
