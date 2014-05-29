library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ece324_latency_tracker is
port(	response	: in std_logic;
		pulse		: in std_logic;
		clk 		: in std_logic;
		reset		: in std_logic;
		enable		: in std_logic;
		missed		: out std_logic_vector(15 downto 0);
		latency 	: out std_logic_vector (15 downto 0)
	);
end ece324_latency_tracker;

architecture Behavioral of ece324_latency_tracker is
signal responded, pulsed, enabled : std_logic;
signal respondedReset, pulsedReset : std_logic;
signal count : std_logic_vector(15 downto 0);
signal misses : std_logic_vector(15 downto 0);
signal currentLatency : std_logic_vector(15 downto 0);
begin
	-- sync response to the clock
	syncResponse: process(clk)
	begin
		if(clk'EVENT and clk = '1') then
			if(response = '1' and respondedReset = '0') then
				responded <= '1';
				respondedReset <= '1';
			elsif(responded = '1') then
				responded <= '0';
			elsif(response = '0') then
				respondedReset <= '0';
			end if;
		end if;
	end process;
	-- sync pulse to the clock
	syncPulse: process(clk)
	begin
		if(clk'EVENT and clk = '1') then
			if(pulse = '1' and pulsedReset = '0') then
				pulsed <= '1';
				pulsedReset <= '1';
			elsif(pulsed = '1') then
				pulsed <= '0';
			elsif(pulse = '0') then
				pulsedReset <= '0';
			end if;
		end if;
	end process;
	-- enable the counter on a pulse
	enabler: process(clk)
	begin
		if(clk'EVENT and clk = '1') then
			if(responded = '1' or reset = '1') then
				enabled <= '0';
			else
				enabled <= pulsed or enabled;
			end if;
		end if;
	end process;
	-- latency counter
	latcount: process(clk)
	begin
		if(clk'EVENT and clk = '1') then
			if(responded = '1' or reset = '1') then
				count <= "0000000000000000";
			elsif(enabled = '1' and enable = '1') then
				count <= count + 1;
			end if;
		end if;
	end process;
	-- missed pulses counter
	misscount: process(clk)
	begin
		if(clk'EVENT and clk = '1') then
			if(reset = '1') then
				misses <= "0000000000000000";
			elsif(enabled = '1' and enable = '1' and pulsed = '1') then
				misses <= misses + 1;
			end if;
		end if;
	end process;
	-- maximum latency register
	latregister: process(clk)
	begin
		if(clk'EVENT and clk = '1') then
			if(reset = '1') then
				currentLatency <= "0000000000000000";
			elsif(count > currentLatency) then
				currentLatency <= count;
			end if;
		end if;
	end process;
	-- assign our outputs
	missed <= misses;
	latency <= currentLatency;
end Behavioral;