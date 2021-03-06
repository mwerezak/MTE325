# TCL File Generated by Component Editor 10.1sp1
# Wed Jul 09 17:57:32 EDT 2014
# DO NOT MODIFY


# +-----------------------------------
# | 
# | Audio "Audio" v1.0
# | null 2014.07.09.17:57:32
# | 
# | 
# | N:/MTE325/Lab2/files/audio/hdl/Audio.v
# | 
# |    ./Audio.v syn, sim
# |    ./AUDIO_DAC_FIFO.v syn, sim
# |    ./FIFO_16_256.v syn, sim
# | 
# +-----------------------------------

# +-----------------------------------
# | request TCL package from ACDS 10.1
# | 
package require -exact sopc 10.1
# | 
# +-----------------------------------

# +-----------------------------------
# | module Audio
# | 
set_module_property NAME Audio
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property DISPLAY_NAME Audio
set_module_property TOP_LEVEL_HDL_FILE Audio.v
set_module_property TOP_LEVEL_HDL_MODULE Audio
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property ANALYZE_HDL TRUE
# | 
# +-----------------------------------

# +-----------------------------------
# | files
# | 
add_file Audio.v {SYNTHESIS SIMULATION}
add_file AUDIO_DAC_FIFO.v {SYNTHESIS SIMULATION}
add_file FIFO_16_256.v {SYNTHESIS SIMULATION}
# | 
# +-----------------------------------

# +-----------------------------------
# | parameters
# | 
# | 
# +-----------------------------------

# +-----------------------------------
# | display items
# | 
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point avalon_slave_0
# | 
add_interface avalon_slave_0 avalon end
set_interface_property avalon_slave_0 addressAlignment DYNAMIC
set_interface_property avalon_slave_0 addressUnits WORDS
set_interface_property avalon_slave_0 burstOnBurstBoundariesOnly false
set_interface_property avalon_slave_0 explicitAddressSpan 0
set_interface_property avalon_slave_0 holdTime 0
set_interface_property avalon_slave_0 isMemoryDevice false
set_interface_property avalon_slave_0 isNonVolatileStorage false
set_interface_property avalon_slave_0 linewrapBursts false
set_interface_property avalon_slave_0 maximumPendingReadTransactions 0
set_interface_property avalon_slave_0 printableDevice false
set_interface_property avalon_slave_0 readLatency 0
set_interface_property avalon_slave_0 readWaitTime 1
set_interface_property avalon_slave_0 setupTime 0
set_interface_property avalon_slave_0 timingUnits Cycles
set_interface_property avalon_slave_0 writeWaitTime 0

set_interface_property avalon_slave_0 ENABLED true

add_interface_port avalon_slave_0 iCLK_18_4 beginbursttransfer_n Input 1
add_interface_port avalon_slave_0 iDATA writebyteenable_n Input 16
add_interface_port avalon_slave_0 iRST_N beginbursttransfer_n Input 1
add_interface_port avalon_slave_0 iWR beginbursttransfer_n Input 1
add_interface_port avalon_slave_0 iWR_CLK beginbursttransfer_n Input 1
add_interface_port avalon_slave_0 oAUD_BCK readdatavalid_n Output 1
add_interface_port avalon_slave_0 oAUD_DATA readdatavalid_n Output 1
add_interface_port avalon_slave_0 oAUD_LRCK readdatavalid_n Output 1
add_interface_port avalon_slave_0 oWR_FULL readdatavalid_n Output 1
# | 
# +-----------------------------------
