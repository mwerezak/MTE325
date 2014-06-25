-- open_i2c_0.vhd

-- This file was auto-generated as part of a SOPC Builder generate operation.
-- If you edit it your changes will probably be lost.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity open_i2c_0 is
	port (
		wb_clk_i     : in  std_logic                    := '0';             --       avalon_slave_0_clock.clk
		arst_i       : in  std_logic                    := '0';             -- avalon_slave_0_clock_reset.reset_n
		wb_rst_i     : in  std_logic                    := '0';             --      avalon_slave_0_export.export
		scl_pad_i    : in  std_logic                    := '0';             --                           .export
		scl_pad_o    : out std_logic;                                       --                           .export
		scl_padoen_o : out std_logic;                                       --                           .export
		sda_pad_i    : in  std_logic                    := '0';             --                           .export
		sda_pad_o    : out std_logic;                                       --                           .export
		sda_padoen_o : out std_logic;                                       --                           .export
		wb_adr_i     : in  std_logic_vector(2 downto 0) := (others => '0'); --             avalon_slave_0.address
		wb_dat_i     : in  std_logic_vector(7 downto 0) := (others => '0'); --                           .writedata
		wb_dat_o     : out std_logic_vector(7 downto 0);                    --                           .readdata
		wb_we_i      : in  std_logic                    := '0';             --                           .write
		wb_stb_i     : in  std_logic                    := '0';             --                           .chipselect
		wb_cyc_i     : in  std_logic                    := '0';             --                           .byteenable
		wb_ack_o     : out std_logic;                                       --                           .waitrequest_n
		wb_inta_o    : out std_logic                                        --         avalon_slave_0_irq.irq
	);
end entity open_i2c_0;

architecture rtl of open_i2c_0 is
	component i2c_master_top is
		port (
			wb_clk_i     : in  std_logic                    := 'X';             -- clk
			arst_i       : in  std_logic                    := 'X';             -- reset_n
			wb_rst_i     : in  std_logic                    := 'X';             -- export
			scl_pad_i    : in  std_logic                    := 'X';             -- export
			scl_pad_o    : out std_logic;                                       -- export
			scl_padoen_o : out std_logic;                                       -- export
			sda_pad_i    : in  std_logic                    := 'X';             -- export
			sda_pad_o    : out std_logic;                                       -- export
			sda_padoen_o : out std_logic;                                       -- export
			wb_adr_i     : in  std_logic_vector(2 downto 0) := (others => 'X'); -- address
			wb_dat_i     : in  std_logic_vector(7 downto 0) := (others => 'X'); -- writedata
			wb_dat_o     : out std_logic_vector(7 downto 0);                    -- readdata
			wb_we_i      : in  std_logic                    := 'X';             -- write
			wb_stb_i     : in  std_logic                    := 'X';             -- chipselect
			wb_cyc_i     : in  std_logic                    := 'X';             -- byteenable
			wb_ack_o     : out std_logic;                                       -- waitrequest_n
			wb_inta_o    : out std_logic                                        -- irq
		);
	end component i2c_master_top;

begin

	open_i2c_0 : component i2c_master_top
		port map (
			wb_clk_i     => wb_clk_i,     --       avalon_slave_0_clock.clk
			arst_i       => arst_i,       -- avalon_slave_0_clock_reset.reset_n
			wb_rst_i     => wb_rst_i,     --      avalon_slave_0_export.export
			scl_pad_i    => scl_pad_i,    --                           .export
			scl_pad_o    => scl_pad_o,    --                           .export
			scl_padoen_o => scl_padoen_o, --                           .export
			sda_pad_i    => sda_pad_i,    --                           .export
			sda_pad_o    => sda_pad_o,    --                           .export
			sda_padoen_o => sda_padoen_o, --                           .export
			wb_adr_i     => wb_adr_i,     --             avalon_slave_0.address
			wb_dat_i     => wb_dat_i,     --                           .writedata
			wb_dat_o     => wb_dat_o,     --                           .readdata
			wb_we_i      => wb_we_i,      --                           .write
			wb_stb_i     => wb_stb_i,     --                           .chipselect
			wb_cyc_i     => wb_cyc_i,     --                           .byteenable
			wb_ack_o     => wb_ack_o,     --                           .waitrequest_n
			wb_inta_o    => wb_inta_o     --         avalon_slave_0_irq.irq
		);

end architecture rtl; -- of open_i2c_0
