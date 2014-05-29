library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ece324_clock_divider is
	port ( 	masterClk		: in std_logic;
			period			: in std_logic_vector(3 downto 0);
			clockHR			: out std_logic;
			clockLR 		: out std_logic
		 );
end ece324_clock_divider;

architecture Behavioral of ece324_clock_divider is
signal count1 : std_logic_vector(12 downto 0);
signal count2 : std_logic_vector(3 downto 0);
signal count3 : std_logic_vector(7 downto 0);
signal clk, clk1Hz, clkPeriod : std_logic;
begin
	-- 1 HZ Clock
	Clock1HZ: process(masterClk)
	begin
		if(masterClk'EVENT and masterClk = '1') then
			if(count1 = "1111111001001") then
				count1 <= "0000000000000";
			else
				count1 <= count1 + 1;
			end if;
		end if;
	end process;
	clk1Hz <= count1(12);
	
	-- period based clock
	ClockPeriod: process(masterClk)
	begin
		if(masterClk'EVENT and masterClk = '1') then
			if(count2 = period) then
				count2 <= "0000";
				clkPeriod <= '1';
			else
				count2 <= count2 + 1;
				clkPeriod <= '0';
			end if;
		end if;
	end process;
	
	-- clocked multiplexer
	Mux: process(masterClk)
	begin
		if(masterClk'EVENT and masterClk = '1') then
			if(period = "0000") then
				clk <= clk1Hz;
			else
				clk <= clkPeriod;
			end if;
		end if;
	end process;
	
	-- 50% duty cycle outputs
	ClockMain: process(clk)
	begin
		if(clk'EVENT and clk = '1') then
			if(count3 = "11111111") then
				count3 <= "00000000";
			else
				count3 <= count3 + 1;
			end if;
		end if;
	end process;
	
	-- assign outputs
	clockLR <= count3(7);
	clockHR <= count3(1);
end Behavioral;