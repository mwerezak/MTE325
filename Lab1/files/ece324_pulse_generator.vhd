library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ece324_pulse_generator is
	port(
		clk, oneStep	: in std_logic;
		duty_cycle		: in std_logic_vector(3 downto 0);
		reset			: in std_logic; 
		enable			: in std_logic;
		pulse			: out std_logic	
	);
end ece324_pulse_generator;

architecture Behavioral of ece324_pulse_generator is
signal count : std_logic_vector(3 downto 0);
signal generatedSignal : std_logic;
begin
	pulsar: process(clk)
	begin
		if(clk'EVENT and clk = '1') then
			if(reset = '1') then
				count <= "1111";
			elsif(enable = '1') then
				if(count = "1111") then
					count <= "0000";
				else
					count <= count + 1;
				end if;
			end if;
			
			if(count < duty_cycle) then
				generatedSignal <= '1';
			else
				generatedSignal <= '0';
			end if;
		end if;
	end process;
	
	-- clocked multiplexer
	Mux: process(clk)
	begin
		if(clk'EVENT and clk = '1') then
			if(duty_cycle = "0000") then
				pulse <= oneStep;
			else
				pulse <= generatedSignal;
			end if;
		end if;
	end process;
end Behavioral;