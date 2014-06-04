//megafunction wizard: %Altera SOPC Builder%
//GENERATION: STANDARD
//VERSION: WM1.0


//Legal Notice: (C)2014 Altera Corporation. All rights reserved.  Your
//use of Altera Corporation's design tools, logic functions and other
//software and tools, and its AMPP partner logic functions, and any
//output files any of the foregoing (including device programming or
//simulation files), and any associated documentation or information are
//expressly subject to the terms and conditions of the Altera Program
//License Subscription Agreement or other applicable license agreement,
//including, without limitation, that your use is for the sole purpose
//of programming logic devices manufactured by Altera and sold by Altera
//or its authorized distributors.  Please refer to the applicable
//agreement for further details.

// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module button_pio_s1_arbitrator (
                                  // inputs:
                                   button_pio_s1_irq,
                                   button_pio_s1_readdata,
                                   clk,
                                   cpu_0_data_master_address_to_slave,
                                   cpu_0_data_master_read,
                                   cpu_0_data_master_waitrequest,
                                   cpu_0_data_master_write,
                                   cpu_0_data_master_writedata,
                                   reset_n,

                                  // outputs:
                                   button_pio_s1_address,
                                   button_pio_s1_chipselect,
                                   button_pio_s1_irq_from_sa,
                                   button_pio_s1_readdata_from_sa,
                                   button_pio_s1_reset_n,
                                   button_pio_s1_write_n,
                                   button_pio_s1_writedata,
                                   cpu_0_data_master_granted_button_pio_s1,
                                   cpu_0_data_master_qualified_request_button_pio_s1,
                                   cpu_0_data_master_read_data_valid_button_pio_s1,
                                   cpu_0_data_master_requests_button_pio_s1,
                                   d1_button_pio_s1_end_xfer
                                )
;

  output  [  1: 0] button_pio_s1_address;
  output           button_pio_s1_chipselect;
  output           button_pio_s1_irq_from_sa;
  output  [  3: 0] button_pio_s1_readdata_from_sa;
  output           button_pio_s1_reset_n;
  output           button_pio_s1_write_n;
  output  [  3: 0] button_pio_s1_writedata;
  output           cpu_0_data_master_granted_button_pio_s1;
  output           cpu_0_data_master_qualified_request_button_pio_s1;
  output           cpu_0_data_master_read_data_valid_button_pio_s1;
  output           cpu_0_data_master_requests_button_pio_s1;
  output           d1_button_pio_s1_end_xfer;
  input            button_pio_s1_irq;
  input   [  3: 0] button_pio_s1_readdata;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_waitrequest;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            reset_n;

  wire    [  1: 0] button_pio_s1_address;
  wire             button_pio_s1_allgrants;
  wire             button_pio_s1_allow_new_arb_cycle;
  wire             button_pio_s1_any_bursting_master_saved_grant;
  wire             button_pio_s1_any_continuerequest;
  wire             button_pio_s1_arb_counter_enable;
  reg     [  1: 0] button_pio_s1_arb_share_counter;
  wire    [  1: 0] button_pio_s1_arb_share_counter_next_value;
  wire    [  1: 0] button_pio_s1_arb_share_set_values;
  wire             button_pio_s1_beginbursttransfer_internal;
  wire             button_pio_s1_begins_xfer;
  wire             button_pio_s1_chipselect;
  wire             button_pio_s1_end_xfer;
  wire             button_pio_s1_firsttransfer;
  wire             button_pio_s1_grant_vector;
  wire             button_pio_s1_in_a_read_cycle;
  wire             button_pio_s1_in_a_write_cycle;
  wire             button_pio_s1_irq_from_sa;
  wire             button_pio_s1_master_qreq_vector;
  wire             button_pio_s1_non_bursting_master_requests;
  wire    [  3: 0] button_pio_s1_readdata_from_sa;
  reg              button_pio_s1_reg_firsttransfer;
  wire             button_pio_s1_reset_n;
  reg              button_pio_s1_slavearbiterlockenable;
  wire             button_pio_s1_slavearbiterlockenable2;
  wire             button_pio_s1_unreg_firsttransfer;
  wire             button_pio_s1_waits_for_read;
  wire             button_pio_s1_waits_for_write;
  wire             button_pio_s1_write_n;
  wire    [  3: 0] button_pio_s1_writedata;
  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_button_pio_s1;
  wire             cpu_0_data_master_qualified_request_button_pio_s1;
  wire             cpu_0_data_master_read_data_valid_button_pio_s1;
  wire             cpu_0_data_master_requests_button_pio_s1;
  wire             cpu_0_data_master_saved_grant_button_pio_s1;
  reg              d1_button_pio_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_button_pio_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 24: 0] shifted_address_to_button_pio_s1_from_cpu_0_data_master;
  wire             wait_for_button_pio_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~button_pio_s1_end_xfer;
    end


  assign button_pio_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_button_pio_s1));
  //assign button_pio_s1_readdata_from_sa = button_pio_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign button_pio_s1_readdata_from_sa = button_pio_s1_readdata;

  assign cpu_0_data_master_requests_button_pio_s1 = ({cpu_0_data_master_address_to_slave[24 : 4] , 4'b0} == 25'h1001070) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //button_pio_s1_arb_share_counter set values, which is an e_mux
  assign button_pio_s1_arb_share_set_values = 1;

  //button_pio_s1_non_bursting_master_requests mux, which is an e_mux
  assign button_pio_s1_non_bursting_master_requests = cpu_0_data_master_requests_button_pio_s1;

  //button_pio_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign button_pio_s1_any_bursting_master_saved_grant = 0;

  //button_pio_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign button_pio_s1_arb_share_counter_next_value = button_pio_s1_firsttransfer ? (button_pio_s1_arb_share_set_values - 1) : |button_pio_s1_arb_share_counter ? (button_pio_s1_arb_share_counter - 1) : 0;

  //button_pio_s1_allgrants all slave grants, which is an e_mux
  assign button_pio_s1_allgrants = |button_pio_s1_grant_vector;

  //button_pio_s1_end_xfer assignment, which is an e_assign
  assign button_pio_s1_end_xfer = ~(button_pio_s1_waits_for_read | button_pio_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_button_pio_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_button_pio_s1 = button_pio_s1_end_xfer & (~button_pio_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //button_pio_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign button_pio_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_button_pio_s1 & button_pio_s1_allgrants) | (end_xfer_arb_share_counter_term_button_pio_s1 & ~button_pio_s1_non_bursting_master_requests);

  //button_pio_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          button_pio_s1_arb_share_counter <= 0;
      else if (button_pio_s1_arb_counter_enable)
          button_pio_s1_arb_share_counter <= button_pio_s1_arb_share_counter_next_value;
    end


  //button_pio_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          button_pio_s1_slavearbiterlockenable <= 0;
      else if ((|button_pio_s1_master_qreq_vector & end_xfer_arb_share_counter_term_button_pio_s1) | (end_xfer_arb_share_counter_term_button_pio_s1 & ~button_pio_s1_non_bursting_master_requests))
          button_pio_s1_slavearbiterlockenable <= |button_pio_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master button_pio/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = button_pio_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //button_pio_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign button_pio_s1_slavearbiterlockenable2 = |button_pio_s1_arb_share_counter_next_value;

  //cpu_0/data_master button_pio/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = button_pio_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //button_pio_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign button_pio_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_button_pio_s1 = cpu_0_data_master_requests_button_pio_s1 & ~(((~cpu_0_data_master_waitrequest) & cpu_0_data_master_write));
  //button_pio_s1_writedata mux, which is an e_mux
  assign button_pio_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_button_pio_s1 = cpu_0_data_master_qualified_request_button_pio_s1;

  //cpu_0/data_master saved-grant button_pio/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_button_pio_s1 = cpu_0_data_master_requests_button_pio_s1;

  //allow new arb cycle for button_pio/s1, which is an e_assign
  assign button_pio_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign button_pio_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign button_pio_s1_master_qreq_vector = 1;

  //button_pio_s1_reset_n assignment, which is an e_assign
  assign button_pio_s1_reset_n = reset_n;

  assign button_pio_s1_chipselect = cpu_0_data_master_granted_button_pio_s1;
  //button_pio_s1_firsttransfer first transaction, which is an e_assign
  assign button_pio_s1_firsttransfer = button_pio_s1_begins_xfer ? button_pio_s1_unreg_firsttransfer : button_pio_s1_reg_firsttransfer;

  //button_pio_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign button_pio_s1_unreg_firsttransfer = ~(button_pio_s1_slavearbiterlockenable & button_pio_s1_any_continuerequest);

  //button_pio_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          button_pio_s1_reg_firsttransfer <= 1'b1;
      else if (button_pio_s1_begins_xfer)
          button_pio_s1_reg_firsttransfer <= button_pio_s1_unreg_firsttransfer;
    end


  //button_pio_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign button_pio_s1_beginbursttransfer_internal = button_pio_s1_begins_xfer;

  //~button_pio_s1_write_n assignment, which is an e_mux
  assign button_pio_s1_write_n = ~(cpu_0_data_master_granted_button_pio_s1 & cpu_0_data_master_write);

  assign shifted_address_to_button_pio_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //button_pio_s1_address mux, which is an e_mux
  assign button_pio_s1_address = shifted_address_to_button_pio_s1_from_cpu_0_data_master >> 2;

  //d1_button_pio_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_button_pio_s1_end_xfer <= 1;
      else 
        d1_button_pio_s1_end_xfer <= button_pio_s1_end_xfer;
    end


  //button_pio_s1_waits_for_read in a cycle, which is an e_mux
  assign button_pio_s1_waits_for_read = button_pio_s1_in_a_read_cycle & button_pio_s1_begins_xfer;

  //button_pio_s1_in_a_read_cycle assignment, which is an e_assign
  assign button_pio_s1_in_a_read_cycle = cpu_0_data_master_granted_button_pio_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = button_pio_s1_in_a_read_cycle;

  //button_pio_s1_waits_for_write in a cycle, which is an e_mux
  assign button_pio_s1_waits_for_write = button_pio_s1_in_a_write_cycle & 0;

  //button_pio_s1_in_a_write_cycle assignment, which is an e_assign
  assign button_pio_s1_in_a_write_cycle = cpu_0_data_master_granted_button_pio_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = button_pio_s1_in_a_write_cycle;

  assign wait_for_button_pio_s1_counter = 0;
  //assign button_pio_s1_irq_from_sa = button_pio_s1_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign button_pio_s1_irq_from_sa = button_pio_s1_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //button_pio/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpu_0_jtag_debug_module_arbitrator (
                                            // inputs:
                                             clk,
                                             cpu_0_data_master_address_to_slave,
                                             cpu_0_data_master_byteenable,
                                             cpu_0_data_master_debugaccess,
                                             cpu_0_data_master_read,
                                             cpu_0_data_master_waitrequest,
                                             cpu_0_data_master_write,
                                             cpu_0_data_master_writedata,
                                             cpu_0_instruction_master_address_to_slave,
                                             cpu_0_instruction_master_latency_counter,
                                             cpu_0_instruction_master_read,
                                             cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register,
                                             cpu_0_jtag_debug_module_readdata,
                                             cpu_0_jtag_debug_module_resetrequest,
                                             reset_n,

                                            // outputs:
                                             cpu_0_data_master_granted_cpu_0_jtag_debug_module,
                                             cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module,
                                             cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module,
                                             cpu_0_data_master_requests_cpu_0_jtag_debug_module,
                                             cpu_0_instruction_master_granted_cpu_0_jtag_debug_module,
                                             cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module,
                                             cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module,
                                             cpu_0_instruction_master_requests_cpu_0_jtag_debug_module,
                                             cpu_0_jtag_debug_module_address,
                                             cpu_0_jtag_debug_module_begintransfer,
                                             cpu_0_jtag_debug_module_byteenable,
                                             cpu_0_jtag_debug_module_chipselect,
                                             cpu_0_jtag_debug_module_debugaccess,
                                             cpu_0_jtag_debug_module_readdata_from_sa,
                                             cpu_0_jtag_debug_module_reset_n,
                                             cpu_0_jtag_debug_module_resetrequest_from_sa,
                                             cpu_0_jtag_debug_module_write,
                                             cpu_0_jtag_debug_module_writedata,
                                             d1_cpu_0_jtag_debug_module_end_xfer
                                          )
;

  output           cpu_0_data_master_granted_cpu_0_jtag_debug_module;
  output           cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module;
  output           cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module;
  output           cpu_0_data_master_requests_cpu_0_jtag_debug_module;
  output           cpu_0_instruction_master_granted_cpu_0_jtag_debug_module;
  output           cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module;
  output           cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module;
  output           cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;
  output  [  8: 0] cpu_0_jtag_debug_module_address;
  output           cpu_0_jtag_debug_module_begintransfer;
  output  [  3: 0] cpu_0_jtag_debug_module_byteenable;
  output           cpu_0_jtag_debug_module_chipselect;
  output           cpu_0_jtag_debug_module_debugaccess;
  output  [ 31: 0] cpu_0_jtag_debug_module_readdata_from_sa;
  output           cpu_0_jtag_debug_module_reset_n;
  output           cpu_0_jtag_debug_module_resetrequest_from_sa;
  output           cpu_0_jtag_debug_module_write;
  output  [ 31: 0] cpu_0_jtag_debug_module_writedata;
  output           d1_cpu_0_jtag_debug_module_end_xfer;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input   [  3: 0] cpu_0_data_master_byteenable;
  input            cpu_0_data_master_debugaccess;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_waitrequest;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input   [ 24: 0] cpu_0_instruction_master_address_to_slave;
  input            cpu_0_instruction_master_latency_counter;
  input            cpu_0_instruction_master_read;
  input            cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register;
  input   [ 31: 0] cpu_0_jtag_debug_module_readdata;
  input            cpu_0_jtag_debug_module_resetrequest;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_requests_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_saved_grant_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_arbiterlock;
  wire             cpu_0_instruction_master_arbiterlock2;
  wire             cpu_0_instruction_master_continuerequest;
  wire             cpu_0_instruction_master_granted_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_saved_grant_cpu_0_jtag_debug_module;
  wire    [  8: 0] cpu_0_jtag_debug_module_address;
  wire             cpu_0_jtag_debug_module_allgrants;
  wire             cpu_0_jtag_debug_module_allow_new_arb_cycle;
  wire             cpu_0_jtag_debug_module_any_bursting_master_saved_grant;
  wire             cpu_0_jtag_debug_module_any_continuerequest;
  reg     [  1: 0] cpu_0_jtag_debug_module_arb_addend;
  wire             cpu_0_jtag_debug_module_arb_counter_enable;
  reg     [  1: 0] cpu_0_jtag_debug_module_arb_share_counter;
  wire    [  1: 0] cpu_0_jtag_debug_module_arb_share_counter_next_value;
  wire    [  1: 0] cpu_0_jtag_debug_module_arb_share_set_values;
  wire    [  1: 0] cpu_0_jtag_debug_module_arb_winner;
  wire             cpu_0_jtag_debug_module_arbitration_holdoff_internal;
  wire             cpu_0_jtag_debug_module_beginbursttransfer_internal;
  wire             cpu_0_jtag_debug_module_begins_xfer;
  wire             cpu_0_jtag_debug_module_begintransfer;
  wire    [  3: 0] cpu_0_jtag_debug_module_byteenable;
  wire             cpu_0_jtag_debug_module_chipselect;
  wire    [  3: 0] cpu_0_jtag_debug_module_chosen_master_double_vector;
  wire    [  1: 0] cpu_0_jtag_debug_module_chosen_master_rot_left;
  wire             cpu_0_jtag_debug_module_debugaccess;
  wire             cpu_0_jtag_debug_module_end_xfer;
  wire             cpu_0_jtag_debug_module_firsttransfer;
  wire    [  1: 0] cpu_0_jtag_debug_module_grant_vector;
  wire             cpu_0_jtag_debug_module_in_a_read_cycle;
  wire             cpu_0_jtag_debug_module_in_a_write_cycle;
  wire    [  1: 0] cpu_0_jtag_debug_module_master_qreq_vector;
  wire             cpu_0_jtag_debug_module_non_bursting_master_requests;
  wire    [ 31: 0] cpu_0_jtag_debug_module_readdata_from_sa;
  reg              cpu_0_jtag_debug_module_reg_firsttransfer;
  wire             cpu_0_jtag_debug_module_reset_n;
  wire             cpu_0_jtag_debug_module_resetrequest_from_sa;
  reg     [  1: 0] cpu_0_jtag_debug_module_saved_chosen_master_vector;
  reg              cpu_0_jtag_debug_module_slavearbiterlockenable;
  wire             cpu_0_jtag_debug_module_slavearbiterlockenable2;
  wire             cpu_0_jtag_debug_module_unreg_firsttransfer;
  wire             cpu_0_jtag_debug_module_waits_for_read;
  wire             cpu_0_jtag_debug_module_waits_for_write;
  wire             cpu_0_jtag_debug_module_write;
  wire    [ 31: 0] cpu_0_jtag_debug_module_writedata;
  reg              d1_cpu_0_jtag_debug_module_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  reg              last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module;
  reg              last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module;
  wire    [ 24: 0] shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_data_master;
  wire    [ 24: 0] shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_instruction_master;
  wire             wait_for_cpu_0_jtag_debug_module_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~cpu_0_jtag_debug_module_end_xfer;
    end


  assign cpu_0_jtag_debug_module_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module | cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module));
  //assign cpu_0_jtag_debug_module_readdata_from_sa = cpu_0_jtag_debug_module_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign cpu_0_jtag_debug_module_readdata_from_sa = cpu_0_jtag_debug_module_readdata;

  assign cpu_0_data_master_requests_cpu_0_jtag_debug_module = ({cpu_0_data_master_address_to_slave[24 : 11] , 11'b0} == 25'h1000800) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //cpu_0_jtag_debug_module_arb_share_counter set values, which is an e_mux
  assign cpu_0_jtag_debug_module_arb_share_set_values = 1;

  //cpu_0_jtag_debug_module_non_bursting_master_requests mux, which is an e_mux
  assign cpu_0_jtag_debug_module_non_bursting_master_requests = cpu_0_data_master_requests_cpu_0_jtag_debug_module |
    cpu_0_instruction_master_requests_cpu_0_jtag_debug_module |
    cpu_0_data_master_requests_cpu_0_jtag_debug_module |
    cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;

  //cpu_0_jtag_debug_module_any_bursting_master_saved_grant mux, which is an e_mux
  assign cpu_0_jtag_debug_module_any_bursting_master_saved_grant = 0;

  //cpu_0_jtag_debug_module_arb_share_counter_next_value assignment, which is an e_assign
  assign cpu_0_jtag_debug_module_arb_share_counter_next_value = cpu_0_jtag_debug_module_firsttransfer ? (cpu_0_jtag_debug_module_arb_share_set_values - 1) : |cpu_0_jtag_debug_module_arb_share_counter ? (cpu_0_jtag_debug_module_arb_share_counter - 1) : 0;

  //cpu_0_jtag_debug_module_allgrants all slave grants, which is an e_mux
  assign cpu_0_jtag_debug_module_allgrants = (|cpu_0_jtag_debug_module_grant_vector) |
    (|cpu_0_jtag_debug_module_grant_vector) |
    (|cpu_0_jtag_debug_module_grant_vector) |
    (|cpu_0_jtag_debug_module_grant_vector);

  //cpu_0_jtag_debug_module_end_xfer assignment, which is an e_assign
  assign cpu_0_jtag_debug_module_end_xfer = ~(cpu_0_jtag_debug_module_waits_for_read | cpu_0_jtag_debug_module_waits_for_write);

  //end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module = cpu_0_jtag_debug_module_end_xfer & (~cpu_0_jtag_debug_module_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //cpu_0_jtag_debug_module_arb_share_counter arbitration counter enable, which is an e_assign
  assign cpu_0_jtag_debug_module_arb_counter_enable = (end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module & cpu_0_jtag_debug_module_allgrants) | (end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module & ~cpu_0_jtag_debug_module_non_bursting_master_requests);

  //cpu_0_jtag_debug_module_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_jtag_debug_module_arb_share_counter <= 0;
      else if (cpu_0_jtag_debug_module_arb_counter_enable)
          cpu_0_jtag_debug_module_arb_share_counter <= cpu_0_jtag_debug_module_arb_share_counter_next_value;
    end


  //cpu_0_jtag_debug_module_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_jtag_debug_module_slavearbiterlockenable <= 0;
      else if ((|cpu_0_jtag_debug_module_master_qreq_vector & end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module) | (end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module & ~cpu_0_jtag_debug_module_non_bursting_master_requests))
          cpu_0_jtag_debug_module_slavearbiterlockenable <= |cpu_0_jtag_debug_module_arb_share_counter_next_value;
    end


  //cpu_0/data_master cpu_0/jtag_debug_module arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = cpu_0_jtag_debug_module_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //cpu_0_jtag_debug_module_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign cpu_0_jtag_debug_module_slavearbiterlockenable2 = |cpu_0_jtag_debug_module_arb_share_counter_next_value;

  //cpu_0/data_master cpu_0/jtag_debug_module arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = cpu_0_jtag_debug_module_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //cpu_0/instruction_master cpu_0/jtag_debug_module arbiterlock, which is an e_assign
  assign cpu_0_instruction_master_arbiterlock = cpu_0_jtag_debug_module_slavearbiterlockenable & cpu_0_instruction_master_continuerequest;

  //cpu_0/instruction_master cpu_0/jtag_debug_module arbiterlock2, which is an e_assign
  assign cpu_0_instruction_master_arbiterlock2 = cpu_0_jtag_debug_module_slavearbiterlockenable2 & cpu_0_instruction_master_continuerequest;

  //cpu_0/instruction_master granted cpu_0/jtag_debug_module last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module <= 0;
      else 
        last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module <= cpu_0_instruction_master_saved_grant_cpu_0_jtag_debug_module ? 1 : (cpu_0_jtag_debug_module_arbitration_holdoff_internal | ~cpu_0_instruction_master_requests_cpu_0_jtag_debug_module) ? 0 : last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module;
    end


  //cpu_0_instruction_master_continuerequest continued request, which is an e_mux
  assign cpu_0_instruction_master_continuerequest = last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module & cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;

  //cpu_0_jtag_debug_module_any_continuerequest at least one master continues requesting, which is an e_mux
  assign cpu_0_jtag_debug_module_any_continuerequest = cpu_0_instruction_master_continuerequest |
    cpu_0_data_master_continuerequest;

  assign cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module = cpu_0_data_master_requests_cpu_0_jtag_debug_module & ~(((~cpu_0_data_master_waitrequest) & cpu_0_data_master_write) | cpu_0_instruction_master_arbiterlock);
  //cpu_0_jtag_debug_module_writedata mux, which is an e_mux
  assign cpu_0_jtag_debug_module_writedata = cpu_0_data_master_writedata;

  assign cpu_0_instruction_master_requests_cpu_0_jtag_debug_module = (({cpu_0_instruction_master_address_to_slave[24 : 11] , 11'b0} == 25'h1000800) & (cpu_0_instruction_master_read)) & cpu_0_instruction_master_read;
  //cpu_0/data_master granted cpu_0/jtag_debug_module last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module <= 0;
      else 
        last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module <= cpu_0_data_master_saved_grant_cpu_0_jtag_debug_module ? 1 : (cpu_0_jtag_debug_module_arbitration_holdoff_internal | ~cpu_0_data_master_requests_cpu_0_jtag_debug_module) ? 0 : last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module;
    end


  //cpu_0_data_master_continuerequest continued request, which is an e_mux
  assign cpu_0_data_master_continuerequest = last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module & cpu_0_data_master_requests_cpu_0_jtag_debug_module;

  assign cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module = cpu_0_instruction_master_requests_cpu_0_jtag_debug_module & ~((cpu_0_instruction_master_read & ((cpu_0_instruction_master_latency_counter != 0) | (|cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register))) | cpu_0_data_master_arbiterlock);
  //local readdatavalid cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module, which is an e_mux
  assign cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module = cpu_0_instruction_master_granted_cpu_0_jtag_debug_module & cpu_0_instruction_master_read & ~cpu_0_jtag_debug_module_waits_for_read;

  //allow new arb cycle for cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_jtag_debug_module_allow_new_arb_cycle = ~cpu_0_data_master_arbiterlock & ~cpu_0_instruction_master_arbiterlock;

  //cpu_0/instruction_master assignment into master qualified-requests vector for cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_jtag_debug_module_master_qreq_vector[0] = cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module;

  //cpu_0/instruction_master grant cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_instruction_master_granted_cpu_0_jtag_debug_module = cpu_0_jtag_debug_module_grant_vector[0];

  //cpu_0/instruction_master saved-grant cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_instruction_master_saved_grant_cpu_0_jtag_debug_module = cpu_0_jtag_debug_module_arb_winner[0] && cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;

  //cpu_0/data_master assignment into master qualified-requests vector for cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_jtag_debug_module_master_qreq_vector[1] = cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module;

  //cpu_0/data_master grant cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_data_master_granted_cpu_0_jtag_debug_module = cpu_0_jtag_debug_module_grant_vector[1];

  //cpu_0/data_master saved-grant cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_data_master_saved_grant_cpu_0_jtag_debug_module = cpu_0_jtag_debug_module_arb_winner[1] && cpu_0_data_master_requests_cpu_0_jtag_debug_module;

  //cpu_0/jtag_debug_module chosen-master double-vector, which is an e_assign
  assign cpu_0_jtag_debug_module_chosen_master_double_vector = {cpu_0_jtag_debug_module_master_qreq_vector, cpu_0_jtag_debug_module_master_qreq_vector} & ({~cpu_0_jtag_debug_module_master_qreq_vector, ~cpu_0_jtag_debug_module_master_qreq_vector} + cpu_0_jtag_debug_module_arb_addend);

  //stable onehot encoding of arb winner
  assign cpu_0_jtag_debug_module_arb_winner = (cpu_0_jtag_debug_module_allow_new_arb_cycle & | cpu_0_jtag_debug_module_grant_vector) ? cpu_0_jtag_debug_module_grant_vector : cpu_0_jtag_debug_module_saved_chosen_master_vector;

  //saved cpu_0_jtag_debug_module_grant_vector, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_jtag_debug_module_saved_chosen_master_vector <= 0;
      else if (cpu_0_jtag_debug_module_allow_new_arb_cycle)
          cpu_0_jtag_debug_module_saved_chosen_master_vector <= |cpu_0_jtag_debug_module_grant_vector ? cpu_0_jtag_debug_module_grant_vector : cpu_0_jtag_debug_module_saved_chosen_master_vector;
    end


  //onehot encoding of chosen master
  assign cpu_0_jtag_debug_module_grant_vector = {(cpu_0_jtag_debug_module_chosen_master_double_vector[1] | cpu_0_jtag_debug_module_chosen_master_double_vector[3]),
    (cpu_0_jtag_debug_module_chosen_master_double_vector[0] | cpu_0_jtag_debug_module_chosen_master_double_vector[2])};

  //cpu_0/jtag_debug_module chosen master rotated left, which is an e_assign
  assign cpu_0_jtag_debug_module_chosen_master_rot_left = (cpu_0_jtag_debug_module_arb_winner << 1) ? (cpu_0_jtag_debug_module_arb_winner << 1) : 1;

  //cpu_0/jtag_debug_module's addend for next-master-grant
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_jtag_debug_module_arb_addend <= 1;
      else if (|cpu_0_jtag_debug_module_grant_vector)
          cpu_0_jtag_debug_module_arb_addend <= cpu_0_jtag_debug_module_end_xfer? cpu_0_jtag_debug_module_chosen_master_rot_left : cpu_0_jtag_debug_module_grant_vector;
    end


  assign cpu_0_jtag_debug_module_begintransfer = cpu_0_jtag_debug_module_begins_xfer;
  //cpu_0_jtag_debug_module_reset_n assignment, which is an e_assign
  assign cpu_0_jtag_debug_module_reset_n = reset_n;

  //assign cpu_0_jtag_debug_module_resetrequest_from_sa = cpu_0_jtag_debug_module_resetrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign cpu_0_jtag_debug_module_resetrequest_from_sa = cpu_0_jtag_debug_module_resetrequest;

  assign cpu_0_jtag_debug_module_chipselect = cpu_0_data_master_granted_cpu_0_jtag_debug_module | cpu_0_instruction_master_granted_cpu_0_jtag_debug_module;
  //cpu_0_jtag_debug_module_firsttransfer first transaction, which is an e_assign
  assign cpu_0_jtag_debug_module_firsttransfer = cpu_0_jtag_debug_module_begins_xfer ? cpu_0_jtag_debug_module_unreg_firsttransfer : cpu_0_jtag_debug_module_reg_firsttransfer;

  //cpu_0_jtag_debug_module_unreg_firsttransfer first transaction, which is an e_assign
  assign cpu_0_jtag_debug_module_unreg_firsttransfer = ~(cpu_0_jtag_debug_module_slavearbiterlockenable & cpu_0_jtag_debug_module_any_continuerequest);

  //cpu_0_jtag_debug_module_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_jtag_debug_module_reg_firsttransfer <= 1'b1;
      else if (cpu_0_jtag_debug_module_begins_xfer)
          cpu_0_jtag_debug_module_reg_firsttransfer <= cpu_0_jtag_debug_module_unreg_firsttransfer;
    end


  //cpu_0_jtag_debug_module_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign cpu_0_jtag_debug_module_beginbursttransfer_internal = cpu_0_jtag_debug_module_begins_xfer;

  //cpu_0_jtag_debug_module_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  assign cpu_0_jtag_debug_module_arbitration_holdoff_internal = cpu_0_jtag_debug_module_begins_xfer & cpu_0_jtag_debug_module_firsttransfer;

  //cpu_0_jtag_debug_module_write assignment, which is an e_mux
  assign cpu_0_jtag_debug_module_write = cpu_0_data_master_granted_cpu_0_jtag_debug_module & cpu_0_data_master_write;

  assign shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //cpu_0_jtag_debug_module_address mux, which is an e_mux
  assign cpu_0_jtag_debug_module_address = (cpu_0_data_master_granted_cpu_0_jtag_debug_module)? (shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_data_master >> 2) :
    (shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_instruction_master >> 2);

  assign shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_instruction_master = cpu_0_instruction_master_address_to_slave;
  //d1_cpu_0_jtag_debug_module_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_cpu_0_jtag_debug_module_end_xfer <= 1;
      else 
        d1_cpu_0_jtag_debug_module_end_xfer <= cpu_0_jtag_debug_module_end_xfer;
    end


  //cpu_0_jtag_debug_module_waits_for_read in a cycle, which is an e_mux
  assign cpu_0_jtag_debug_module_waits_for_read = cpu_0_jtag_debug_module_in_a_read_cycle & cpu_0_jtag_debug_module_begins_xfer;

  //cpu_0_jtag_debug_module_in_a_read_cycle assignment, which is an e_assign
  assign cpu_0_jtag_debug_module_in_a_read_cycle = (cpu_0_data_master_granted_cpu_0_jtag_debug_module & cpu_0_data_master_read) | (cpu_0_instruction_master_granted_cpu_0_jtag_debug_module & cpu_0_instruction_master_read);

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = cpu_0_jtag_debug_module_in_a_read_cycle;

  //cpu_0_jtag_debug_module_waits_for_write in a cycle, which is an e_mux
  assign cpu_0_jtag_debug_module_waits_for_write = cpu_0_jtag_debug_module_in_a_write_cycle & 0;

  //cpu_0_jtag_debug_module_in_a_write_cycle assignment, which is an e_assign
  assign cpu_0_jtag_debug_module_in_a_write_cycle = cpu_0_data_master_granted_cpu_0_jtag_debug_module & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = cpu_0_jtag_debug_module_in_a_write_cycle;

  assign wait_for_cpu_0_jtag_debug_module_counter = 0;
  //cpu_0_jtag_debug_module_byteenable byte enable port mux, which is an e_mux
  assign cpu_0_jtag_debug_module_byteenable = (cpu_0_data_master_granted_cpu_0_jtag_debug_module)? cpu_0_data_master_byteenable :
    -1;

  //debugaccess mux, which is an e_mux
  assign cpu_0_jtag_debug_module_debugaccess = (cpu_0_data_master_granted_cpu_0_jtag_debug_module)? cpu_0_data_master_debugaccess :
    0;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //cpu_0/jtag_debug_module enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end


  //grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_0_data_master_granted_cpu_0_jtag_debug_module + cpu_0_instruction_master_granted_cpu_0_jtag_debug_module > 1)
        begin
          $write("%0d ns: > 1 of grant signals are active simultaneously", $time);
          $stop;
        end
    end


  //saved_grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_0_data_master_saved_grant_cpu_0_jtag_debug_module + cpu_0_instruction_master_saved_grant_cpu_0_jtag_debug_module > 1)
        begin
          $write("%0d ns: > 1 of saved_grant signals are active simultaneously", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpu_0_data_master_arbitrator (
                                      // inputs:
                                       button_pio_s1_irq_from_sa,
                                       button_pio_s1_readdata_from_sa,
                                       clk,
                                       cpu_0_data_master_address,
                                       cpu_0_data_master_byteenable_sdram_0_s1,
                                       cpu_0_data_master_granted_button_pio_s1,
                                       cpu_0_data_master_granted_cpu_0_jtag_debug_module,
                                       cpu_0_data_master_granted_green_led_pio_s1,
                                       cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave,
                                       cpu_0_data_master_granted_lcd_display_control_slave,
                                       cpu_0_data_master_granted_led_pio_s1,
                                       cpu_0_data_master_granted_pio_dutycycle_s1,
                                       cpu_0_data_master_granted_pio_egmenable_s1,
                                       cpu_0_data_master_granted_pio_egmreset_s1,
                                       cpu_0_data_master_granted_pio_latency_s1,
                                       cpu_0_data_master_granted_pio_missed_s1,
                                       cpu_0_data_master_granted_pio_period_s1,
                                       cpu_0_data_master_granted_pio_pulse_s1,
                                       cpu_0_data_master_granted_pio_response_s1,
                                       cpu_0_data_master_granted_red_led_pio_s1,
                                       cpu_0_data_master_granted_sdram_0_s1,
                                       cpu_0_data_master_granted_seven_seg_middle_pio_s1,
                                       cpu_0_data_master_granted_seven_seg_pio_s1,
                                       cpu_0_data_master_granted_seven_seg_right_pio_s1,
                                       cpu_0_data_master_granted_switch_pio_s1,
                                       cpu_0_data_master_granted_sysid_control_slave,
                                       cpu_0_data_master_granted_timer_0_s1,
                                       cpu_0_data_master_granted_timer_1_s1,
                                       cpu_0_data_master_qualified_request_button_pio_s1,
                                       cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module,
                                       cpu_0_data_master_qualified_request_green_led_pio_s1,
                                       cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave,
                                       cpu_0_data_master_qualified_request_lcd_display_control_slave,
                                       cpu_0_data_master_qualified_request_led_pio_s1,
                                       cpu_0_data_master_qualified_request_pio_dutycycle_s1,
                                       cpu_0_data_master_qualified_request_pio_egmenable_s1,
                                       cpu_0_data_master_qualified_request_pio_egmreset_s1,
                                       cpu_0_data_master_qualified_request_pio_latency_s1,
                                       cpu_0_data_master_qualified_request_pio_missed_s1,
                                       cpu_0_data_master_qualified_request_pio_period_s1,
                                       cpu_0_data_master_qualified_request_pio_pulse_s1,
                                       cpu_0_data_master_qualified_request_pio_response_s1,
                                       cpu_0_data_master_qualified_request_red_led_pio_s1,
                                       cpu_0_data_master_qualified_request_sdram_0_s1,
                                       cpu_0_data_master_qualified_request_seven_seg_middle_pio_s1,
                                       cpu_0_data_master_qualified_request_seven_seg_pio_s1,
                                       cpu_0_data_master_qualified_request_seven_seg_right_pio_s1,
                                       cpu_0_data_master_qualified_request_switch_pio_s1,
                                       cpu_0_data_master_qualified_request_sysid_control_slave,
                                       cpu_0_data_master_qualified_request_timer_0_s1,
                                       cpu_0_data_master_qualified_request_timer_1_s1,
                                       cpu_0_data_master_read,
                                       cpu_0_data_master_read_data_valid_button_pio_s1,
                                       cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module,
                                       cpu_0_data_master_read_data_valid_green_led_pio_s1,
                                       cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave,
                                       cpu_0_data_master_read_data_valid_lcd_display_control_slave,
                                       cpu_0_data_master_read_data_valid_led_pio_s1,
                                       cpu_0_data_master_read_data_valid_pio_dutycycle_s1,
                                       cpu_0_data_master_read_data_valid_pio_egmenable_s1,
                                       cpu_0_data_master_read_data_valid_pio_egmreset_s1,
                                       cpu_0_data_master_read_data_valid_pio_latency_s1,
                                       cpu_0_data_master_read_data_valid_pio_missed_s1,
                                       cpu_0_data_master_read_data_valid_pio_period_s1,
                                       cpu_0_data_master_read_data_valid_pio_pulse_s1,
                                       cpu_0_data_master_read_data_valid_pio_response_s1,
                                       cpu_0_data_master_read_data_valid_red_led_pio_s1,
                                       cpu_0_data_master_read_data_valid_sdram_0_s1,
                                       cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register,
                                       cpu_0_data_master_read_data_valid_seven_seg_middle_pio_s1,
                                       cpu_0_data_master_read_data_valid_seven_seg_pio_s1,
                                       cpu_0_data_master_read_data_valid_seven_seg_right_pio_s1,
                                       cpu_0_data_master_read_data_valid_switch_pio_s1,
                                       cpu_0_data_master_read_data_valid_sysid_control_slave,
                                       cpu_0_data_master_read_data_valid_timer_0_s1,
                                       cpu_0_data_master_read_data_valid_timer_1_s1,
                                       cpu_0_data_master_requests_button_pio_s1,
                                       cpu_0_data_master_requests_cpu_0_jtag_debug_module,
                                       cpu_0_data_master_requests_green_led_pio_s1,
                                       cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave,
                                       cpu_0_data_master_requests_lcd_display_control_slave,
                                       cpu_0_data_master_requests_led_pio_s1,
                                       cpu_0_data_master_requests_pio_dutycycle_s1,
                                       cpu_0_data_master_requests_pio_egmenable_s1,
                                       cpu_0_data_master_requests_pio_egmreset_s1,
                                       cpu_0_data_master_requests_pio_latency_s1,
                                       cpu_0_data_master_requests_pio_missed_s1,
                                       cpu_0_data_master_requests_pio_period_s1,
                                       cpu_0_data_master_requests_pio_pulse_s1,
                                       cpu_0_data_master_requests_pio_response_s1,
                                       cpu_0_data_master_requests_red_led_pio_s1,
                                       cpu_0_data_master_requests_sdram_0_s1,
                                       cpu_0_data_master_requests_seven_seg_middle_pio_s1,
                                       cpu_0_data_master_requests_seven_seg_pio_s1,
                                       cpu_0_data_master_requests_seven_seg_right_pio_s1,
                                       cpu_0_data_master_requests_switch_pio_s1,
                                       cpu_0_data_master_requests_sysid_control_slave,
                                       cpu_0_data_master_requests_timer_0_s1,
                                       cpu_0_data_master_requests_timer_1_s1,
                                       cpu_0_data_master_write,
                                       cpu_0_data_master_writedata,
                                       cpu_0_jtag_debug_module_readdata_from_sa,
                                       d1_button_pio_s1_end_xfer,
                                       d1_cpu_0_jtag_debug_module_end_xfer,
                                       d1_green_led_pio_s1_end_xfer,
                                       d1_jtag_uart_0_avalon_jtag_slave_end_xfer,
                                       d1_lcd_display_control_slave_end_xfer,
                                       d1_led_pio_s1_end_xfer,
                                       d1_pio_dutycycle_s1_end_xfer,
                                       d1_pio_egmenable_s1_end_xfer,
                                       d1_pio_egmreset_s1_end_xfer,
                                       d1_pio_latency_s1_end_xfer,
                                       d1_pio_missed_s1_end_xfer,
                                       d1_pio_period_s1_end_xfer,
                                       d1_pio_pulse_s1_end_xfer,
                                       d1_pio_response_s1_end_xfer,
                                       d1_red_led_pio_s1_end_xfer,
                                       d1_sdram_0_s1_end_xfer,
                                       d1_seven_seg_middle_pio_s1_end_xfer,
                                       d1_seven_seg_pio_s1_end_xfer,
                                       d1_seven_seg_right_pio_s1_end_xfer,
                                       d1_switch_pio_s1_end_xfer,
                                       d1_sysid_control_slave_end_xfer,
                                       d1_timer_0_s1_end_xfer,
                                       d1_timer_1_s1_end_xfer,
                                       green_led_pio_s1_readdata_from_sa,
                                       jtag_uart_0_avalon_jtag_slave_irq_from_sa,
                                       jtag_uart_0_avalon_jtag_slave_readdata_from_sa,
                                       jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa,
                                       lcd_display_control_slave_readdata_from_sa,
                                       lcd_display_control_slave_wait_counter_eq_0,
                                       lcd_display_control_slave_wait_counter_eq_1,
                                       led_pio_s1_readdata_from_sa,
                                       pio_dutycycle_s1_readdata_from_sa,
                                       pio_egmenable_s1_readdata_from_sa,
                                       pio_egmreset_s1_readdata_from_sa,
                                       pio_latency_s1_readdata_from_sa,
                                       pio_missed_s1_readdata_from_sa,
                                       pio_period_s1_readdata_from_sa,
                                       pio_pulse_s1_irq_from_sa,
                                       pio_pulse_s1_readdata_from_sa,
                                       pio_response_s1_readdata_from_sa,
                                       red_led_pio_s1_readdata_from_sa,
                                       reset_n,
                                       sdram_0_s1_readdata_from_sa,
                                       sdram_0_s1_waitrequest_from_sa,
                                       seven_seg_middle_pio_s1_readdata_from_sa,
                                       seven_seg_pio_s1_readdata_from_sa,
                                       seven_seg_right_pio_s1_readdata_from_sa,
                                       switch_pio_s1_readdata_from_sa,
                                       sysid_control_slave_readdata_from_sa,
                                       timer_0_s1_irq_from_sa,
                                       timer_0_s1_readdata_from_sa,
                                       timer_1_s1_irq_from_sa,
                                       timer_1_s1_readdata_from_sa,

                                      // outputs:
                                       cpu_0_data_master_address_to_slave,
                                       cpu_0_data_master_dbs_address,
                                       cpu_0_data_master_dbs_write_16,
                                       cpu_0_data_master_irq,
                                       cpu_0_data_master_no_byte_enables_and_last_term,
                                       cpu_0_data_master_readdata,
                                       cpu_0_data_master_waitrequest
                                    )
;

  output  [ 24: 0] cpu_0_data_master_address_to_slave;
  output  [  1: 0] cpu_0_data_master_dbs_address;
  output  [ 15: 0] cpu_0_data_master_dbs_write_16;
  output  [ 31: 0] cpu_0_data_master_irq;
  output           cpu_0_data_master_no_byte_enables_and_last_term;
  output  [ 31: 0] cpu_0_data_master_readdata;
  output           cpu_0_data_master_waitrequest;
  input            button_pio_s1_irq_from_sa;
  input   [  3: 0] button_pio_s1_readdata_from_sa;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address;
  input   [  1: 0] cpu_0_data_master_byteenable_sdram_0_s1;
  input            cpu_0_data_master_granted_button_pio_s1;
  input            cpu_0_data_master_granted_cpu_0_jtag_debug_module;
  input            cpu_0_data_master_granted_green_led_pio_s1;
  input            cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave;
  input            cpu_0_data_master_granted_lcd_display_control_slave;
  input            cpu_0_data_master_granted_led_pio_s1;
  input            cpu_0_data_master_granted_pio_dutycycle_s1;
  input            cpu_0_data_master_granted_pio_egmenable_s1;
  input            cpu_0_data_master_granted_pio_egmreset_s1;
  input            cpu_0_data_master_granted_pio_latency_s1;
  input            cpu_0_data_master_granted_pio_missed_s1;
  input            cpu_0_data_master_granted_pio_period_s1;
  input            cpu_0_data_master_granted_pio_pulse_s1;
  input            cpu_0_data_master_granted_pio_response_s1;
  input            cpu_0_data_master_granted_red_led_pio_s1;
  input            cpu_0_data_master_granted_sdram_0_s1;
  input            cpu_0_data_master_granted_seven_seg_middle_pio_s1;
  input            cpu_0_data_master_granted_seven_seg_pio_s1;
  input            cpu_0_data_master_granted_seven_seg_right_pio_s1;
  input            cpu_0_data_master_granted_switch_pio_s1;
  input            cpu_0_data_master_granted_sysid_control_slave;
  input            cpu_0_data_master_granted_timer_0_s1;
  input            cpu_0_data_master_granted_timer_1_s1;
  input            cpu_0_data_master_qualified_request_button_pio_s1;
  input            cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module;
  input            cpu_0_data_master_qualified_request_green_led_pio_s1;
  input            cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave;
  input            cpu_0_data_master_qualified_request_lcd_display_control_slave;
  input            cpu_0_data_master_qualified_request_led_pio_s1;
  input            cpu_0_data_master_qualified_request_pio_dutycycle_s1;
  input            cpu_0_data_master_qualified_request_pio_egmenable_s1;
  input            cpu_0_data_master_qualified_request_pio_egmreset_s1;
  input            cpu_0_data_master_qualified_request_pio_latency_s1;
  input            cpu_0_data_master_qualified_request_pio_missed_s1;
  input            cpu_0_data_master_qualified_request_pio_period_s1;
  input            cpu_0_data_master_qualified_request_pio_pulse_s1;
  input            cpu_0_data_master_qualified_request_pio_response_s1;
  input            cpu_0_data_master_qualified_request_red_led_pio_s1;
  input            cpu_0_data_master_qualified_request_sdram_0_s1;
  input            cpu_0_data_master_qualified_request_seven_seg_middle_pio_s1;
  input            cpu_0_data_master_qualified_request_seven_seg_pio_s1;
  input            cpu_0_data_master_qualified_request_seven_seg_right_pio_s1;
  input            cpu_0_data_master_qualified_request_switch_pio_s1;
  input            cpu_0_data_master_qualified_request_sysid_control_slave;
  input            cpu_0_data_master_qualified_request_timer_0_s1;
  input            cpu_0_data_master_qualified_request_timer_1_s1;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_read_data_valid_button_pio_s1;
  input            cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module;
  input            cpu_0_data_master_read_data_valid_green_led_pio_s1;
  input            cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave;
  input            cpu_0_data_master_read_data_valid_lcd_display_control_slave;
  input            cpu_0_data_master_read_data_valid_led_pio_s1;
  input            cpu_0_data_master_read_data_valid_pio_dutycycle_s1;
  input            cpu_0_data_master_read_data_valid_pio_egmenable_s1;
  input            cpu_0_data_master_read_data_valid_pio_egmreset_s1;
  input            cpu_0_data_master_read_data_valid_pio_latency_s1;
  input            cpu_0_data_master_read_data_valid_pio_missed_s1;
  input            cpu_0_data_master_read_data_valid_pio_period_s1;
  input            cpu_0_data_master_read_data_valid_pio_pulse_s1;
  input            cpu_0_data_master_read_data_valid_pio_response_s1;
  input            cpu_0_data_master_read_data_valid_red_led_pio_s1;
  input            cpu_0_data_master_read_data_valid_sdram_0_s1;
  input            cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register;
  input            cpu_0_data_master_read_data_valid_seven_seg_middle_pio_s1;
  input            cpu_0_data_master_read_data_valid_seven_seg_pio_s1;
  input            cpu_0_data_master_read_data_valid_seven_seg_right_pio_s1;
  input            cpu_0_data_master_read_data_valid_switch_pio_s1;
  input            cpu_0_data_master_read_data_valid_sysid_control_slave;
  input            cpu_0_data_master_read_data_valid_timer_0_s1;
  input            cpu_0_data_master_read_data_valid_timer_1_s1;
  input            cpu_0_data_master_requests_button_pio_s1;
  input            cpu_0_data_master_requests_cpu_0_jtag_debug_module;
  input            cpu_0_data_master_requests_green_led_pio_s1;
  input            cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave;
  input            cpu_0_data_master_requests_lcd_display_control_slave;
  input            cpu_0_data_master_requests_led_pio_s1;
  input            cpu_0_data_master_requests_pio_dutycycle_s1;
  input            cpu_0_data_master_requests_pio_egmenable_s1;
  input            cpu_0_data_master_requests_pio_egmreset_s1;
  input            cpu_0_data_master_requests_pio_latency_s1;
  input            cpu_0_data_master_requests_pio_missed_s1;
  input            cpu_0_data_master_requests_pio_period_s1;
  input            cpu_0_data_master_requests_pio_pulse_s1;
  input            cpu_0_data_master_requests_pio_response_s1;
  input            cpu_0_data_master_requests_red_led_pio_s1;
  input            cpu_0_data_master_requests_sdram_0_s1;
  input            cpu_0_data_master_requests_seven_seg_middle_pio_s1;
  input            cpu_0_data_master_requests_seven_seg_pio_s1;
  input            cpu_0_data_master_requests_seven_seg_right_pio_s1;
  input            cpu_0_data_master_requests_switch_pio_s1;
  input            cpu_0_data_master_requests_sysid_control_slave;
  input            cpu_0_data_master_requests_timer_0_s1;
  input            cpu_0_data_master_requests_timer_1_s1;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input   [ 31: 0] cpu_0_jtag_debug_module_readdata_from_sa;
  input            d1_button_pio_s1_end_xfer;
  input            d1_cpu_0_jtag_debug_module_end_xfer;
  input            d1_green_led_pio_s1_end_xfer;
  input            d1_jtag_uart_0_avalon_jtag_slave_end_xfer;
  input            d1_lcd_display_control_slave_end_xfer;
  input            d1_led_pio_s1_end_xfer;
  input            d1_pio_dutycycle_s1_end_xfer;
  input            d1_pio_egmenable_s1_end_xfer;
  input            d1_pio_egmreset_s1_end_xfer;
  input            d1_pio_latency_s1_end_xfer;
  input            d1_pio_missed_s1_end_xfer;
  input            d1_pio_period_s1_end_xfer;
  input            d1_pio_pulse_s1_end_xfer;
  input            d1_pio_response_s1_end_xfer;
  input            d1_red_led_pio_s1_end_xfer;
  input            d1_sdram_0_s1_end_xfer;
  input            d1_seven_seg_middle_pio_s1_end_xfer;
  input            d1_seven_seg_pio_s1_end_xfer;
  input            d1_seven_seg_right_pio_s1_end_xfer;
  input            d1_switch_pio_s1_end_xfer;
  input            d1_sysid_control_slave_end_xfer;
  input            d1_timer_0_s1_end_xfer;
  input            d1_timer_1_s1_end_xfer;
  input   [  7: 0] green_led_pio_s1_readdata_from_sa;
  input            jtag_uart_0_avalon_jtag_slave_irq_from_sa;
  input   [ 31: 0] jtag_uart_0_avalon_jtag_slave_readdata_from_sa;
  input            jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa;
  input   [  7: 0] lcd_display_control_slave_readdata_from_sa;
  input            lcd_display_control_slave_wait_counter_eq_0;
  input            lcd_display_control_slave_wait_counter_eq_1;
  input   [  7: 0] led_pio_s1_readdata_from_sa;
  input   [  3: 0] pio_dutycycle_s1_readdata_from_sa;
  input            pio_egmenable_s1_readdata_from_sa;
  input            pio_egmreset_s1_readdata_from_sa;
  input   [ 15: 0] pio_latency_s1_readdata_from_sa;
  input   [ 15: 0] pio_missed_s1_readdata_from_sa;
  input   [  3: 0] pio_period_s1_readdata_from_sa;
  input            pio_pulse_s1_irq_from_sa;
  input            pio_pulse_s1_readdata_from_sa;
  input            pio_response_s1_readdata_from_sa;
  input   [  7: 0] red_led_pio_s1_readdata_from_sa;
  input            reset_n;
  input   [ 15: 0] sdram_0_s1_readdata_from_sa;
  input            sdram_0_s1_waitrequest_from_sa;
  input   [ 15: 0] seven_seg_middle_pio_s1_readdata_from_sa;
  input   [ 15: 0] seven_seg_pio_s1_readdata_from_sa;
  input   [ 31: 0] seven_seg_right_pio_s1_readdata_from_sa;
  input   [ 15: 0] switch_pio_s1_readdata_from_sa;
  input   [ 31: 0] sysid_control_slave_readdata_from_sa;
  input            timer_0_s1_irq_from_sa;
  input   [ 15: 0] timer_0_s1_readdata_from_sa;
  input            timer_1_s1_irq_from_sa;
  input   [ 15: 0] timer_1_s1_readdata_from_sa;

  wire    [ 24: 0] cpu_0_data_master_address_to_slave;
  reg     [  1: 0] cpu_0_data_master_dbs_address;
  wire    [  1: 0] cpu_0_data_master_dbs_increment;
  wire    [ 15: 0] cpu_0_data_master_dbs_write_16;
  wire    [ 31: 0] cpu_0_data_master_irq;
  reg              cpu_0_data_master_no_byte_enables_and_last_term;
  wire    [ 31: 0] cpu_0_data_master_readdata;
  wire             cpu_0_data_master_run;
  reg              cpu_0_data_master_waitrequest;
  reg     [ 15: 0] dbs_16_reg_segment_0;
  wire             dbs_count_enable;
  wire             dbs_counter_overflow;
  wire             last_dbs_term_and_run;
  wire    [  1: 0] next_dbs_address;
  wire    [ 15: 0] p1_dbs_16_reg_segment_0;
  wire    [ 31: 0] p1_registered_cpu_0_data_master_readdata;
  wire             pre_dbs_count_enable;
  wire             r_0;
  wire             r_1;
  wire             r_2;
  wire             r_3;
  wire             r_4;
  reg     [ 31: 0] registered_cpu_0_data_master_readdata;
  //r_0 master_run cascaded wait assignment, which is an e_assign
  assign r_0 = 1 & (cpu_0_data_master_qualified_request_button_pio_s1 | ~cpu_0_data_master_requests_button_pio_s1) & ((~cpu_0_data_master_qualified_request_button_pio_s1 | ~cpu_0_data_master_read | (1 & 1 & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_button_pio_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module | ~cpu_0_data_master_requests_cpu_0_jtag_debug_module) & (cpu_0_data_master_granted_cpu_0_jtag_debug_module | ~cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module) & ((~cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module | ~cpu_0_data_master_read | (1 & 1 & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_green_led_pio_s1 | ~cpu_0_data_master_requests_green_led_pio_s1) & ((~cpu_0_data_master_qualified_request_green_led_pio_s1 | ~cpu_0_data_master_read | (1 & 1 & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_green_led_pio_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave | ~cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave) & ((~cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave | ~(cpu_0_data_master_read | cpu_0_data_master_write) | (1 & ~jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa & (cpu_0_data_master_read | cpu_0_data_master_write)))) & ((~cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave | ~(cpu_0_data_master_read | cpu_0_data_master_write) | (1 & ~jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa & (cpu_0_data_master_read | cpu_0_data_master_write)))) & 1 & ((~cpu_0_data_master_qualified_request_lcd_display_control_slave | ~cpu_0_data_master_read | (1 & lcd_display_control_slave_wait_counter_eq_1 & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_lcd_display_control_slave | ~cpu_0_data_master_write | (1 & lcd_display_control_slave_wait_counter_eq_1 & cpu_0_data_master_write)));

  //cascaded wait assignment, which is an e_assign
  assign cpu_0_data_master_run = r_0 & r_1 & r_2 & r_3 & r_4;

  //r_1 master_run cascaded wait assignment, which is an e_assign
  assign r_1 = 1 & (cpu_0_data_master_qualified_request_led_pio_s1 | ~cpu_0_data_master_requests_led_pio_s1) & ((~cpu_0_data_master_qualified_request_led_pio_s1 | ~cpu_0_data_master_read | (1 & 1 & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_led_pio_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_pio_dutycycle_s1 | ~cpu_0_data_master_requests_pio_dutycycle_s1) & ((~cpu_0_data_master_qualified_request_pio_dutycycle_s1 | ~cpu_0_data_master_read | (1 & 1 & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_pio_dutycycle_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_pio_egmenable_s1 | ~cpu_0_data_master_requests_pio_egmenable_s1) & ((~cpu_0_data_master_qualified_request_pio_egmenable_s1 | ~cpu_0_data_master_read | (1 & 1 & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_pio_egmenable_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_pio_egmreset_s1 | ~cpu_0_data_master_requests_pio_egmreset_s1) & ((~cpu_0_data_master_qualified_request_pio_egmreset_s1 | ~cpu_0_data_master_read | (1 & 1 & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_pio_egmreset_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & ((~cpu_0_data_master_qualified_request_pio_latency_s1 | ~cpu_0_data_master_read | (1 & 1 & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_pio_latency_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1;

  //r_2 master_run cascaded wait assignment, which is an e_assign
  assign r_2 = ((~cpu_0_data_master_qualified_request_pio_missed_s1 | ~cpu_0_data_master_read | (1 & 1 & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_pio_missed_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_pio_period_s1 | ~cpu_0_data_master_requests_pio_period_s1) & ((~cpu_0_data_master_qualified_request_pio_period_s1 | ~cpu_0_data_master_read | (1 & 1 & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_pio_period_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_pio_pulse_s1 | ~cpu_0_data_master_requests_pio_pulse_s1) & ((~cpu_0_data_master_qualified_request_pio_pulse_s1 | ~cpu_0_data_master_read | (1 & 1 & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_pio_pulse_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_pio_response_s1 | ~cpu_0_data_master_requests_pio_response_s1) & ((~cpu_0_data_master_qualified_request_pio_response_s1 | ~cpu_0_data_master_read | (1 & 1 & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_pio_response_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_red_led_pio_s1 | ~cpu_0_data_master_requests_red_led_pio_s1) & ((~cpu_0_data_master_qualified_request_red_led_pio_s1 | ~cpu_0_data_master_read | (1 & 1 & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_red_led_pio_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_sdram_0_s1 | (cpu_0_data_master_read_data_valid_sdram_0_s1 & cpu_0_data_master_dbs_address[1]) | (cpu_0_data_master_write & !cpu_0_data_master_byteenable_sdram_0_s1 & cpu_0_data_master_dbs_address[1]) | ~cpu_0_data_master_requests_sdram_0_s1);

  //r_3 master_run cascaded wait assignment, which is an e_assign
  assign r_3 = (cpu_0_data_master_granted_sdram_0_s1 | ~cpu_0_data_master_qualified_request_sdram_0_s1) & ((~cpu_0_data_master_qualified_request_sdram_0_s1 | ~cpu_0_data_master_read | (cpu_0_data_master_read_data_valid_sdram_0_s1 & (cpu_0_data_master_dbs_address[1]) & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_sdram_0_s1 | ~cpu_0_data_master_write | (1 & ~sdram_0_s1_waitrequest_from_sa & (cpu_0_data_master_dbs_address[1]) & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_seven_seg_middle_pio_s1 | ~cpu_0_data_master_requests_seven_seg_middle_pio_s1) & ((~cpu_0_data_master_qualified_request_seven_seg_middle_pio_s1 | ~cpu_0_data_master_read | (1 & 1 & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_seven_seg_middle_pio_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_seven_seg_pio_s1 | ~cpu_0_data_master_requests_seven_seg_pio_s1) & ((~cpu_0_data_master_qualified_request_seven_seg_pio_s1 | ~cpu_0_data_master_read | (1 & 1 & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_seven_seg_pio_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_seven_seg_right_pio_s1 | ~cpu_0_data_master_requests_seven_seg_right_pio_s1) & ((~cpu_0_data_master_qualified_request_seven_seg_right_pio_s1 | ~cpu_0_data_master_read | (1 & 1 & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_seven_seg_right_pio_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & ((~cpu_0_data_master_qualified_request_switch_pio_s1 | ~cpu_0_data_master_read | (1 & 1 & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_switch_pio_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & ((~cpu_0_data_master_qualified_request_sysid_control_slave | ~cpu_0_data_master_read | (1 & 1 & cpu_0_data_master_read)));

  //r_4 master_run cascaded wait assignment, which is an e_assign
  assign r_4 = ((~cpu_0_data_master_qualified_request_sysid_control_slave | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_timer_0_s1 | ~cpu_0_data_master_requests_timer_0_s1) & ((~cpu_0_data_master_qualified_request_timer_0_s1 | ~cpu_0_data_master_read | (1 & 1 & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_timer_0_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_timer_1_s1 | ~cpu_0_data_master_requests_timer_1_s1) & ((~cpu_0_data_master_qualified_request_timer_1_s1 | ~cpu_0_data_master_read | (1 & 1 & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_timer_1_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write)));

  //optimize select-logic by passing only those address bits which matter.
  assign cpu_0_data_master_address_to_slave = cpu_0_data_master_address[24 : 0];

  //cpu_0/data_master readdata mux, which is an e_mux
  assign cpu_0_data_master_readdata = ({32 {~cpu_0_data_master_requests_button_pio_s1}} | button_pio_s1_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_cpu_0_jtag_debug_module}} | cpu_0_jtag_debug_module_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_green_led_pio_s1}} | green_led_pio_s1_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave}} | registered_cpu_0_data_master_readdata) &
    ({32 {~cpu_0_data_master_requests_lcd_display_control_slave}} | lcd_display_control_slave_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_led_pio_s1}} | led_pio_s1_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_pio_dutycycle_s1}} | pio_dutycycle_s1_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_pio_egmenable_s1}} | pio_egmenable_s1_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_pio_egmreset_s1}} | pio_egmreset_s1_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_pio_latency_s1}} | pio_latency_s1_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_pio_missed_s1}} | pio_missed_s1_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_pio_period_s1}} | pio_period_s1_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_pio_pulse_s1}} | pio_pulse_s1_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_pio_response_s1}} | pio_response_s1_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_red_led_pio_s1}} | red_led_pio_s1_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_sdram_0_s1}} | registered_cpu_0_data_master_readdata) &
    ({32 {~cpu_0_data_master_requests_seven_seg_middle_pio_s1}} | seven_seg_middle_pio_s1_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_seven_seg_pio_s1}} | seven_seg_pio_s1_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_seven_seg_right_pio_s1}} | seven_seg_right_pio_s1_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_switch_pio_s1}} | switch_pio_s1_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_sysid_control_slave}} | sysid_control_slave_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_timer_0_s1}} | timer_0_s1_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_timer_1_s1}} | timer_1_s1_readdata_from_sa);

  //actual waitrequest port, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_data_master_waitrequest <= ~0;
      else 
        cpu_0_data_master_waitrequest <= ~((~(cpu_0_data_master_read | cpu_0_data_master_write))? 0: (cpu_0_data_master_run & cpu_0_data_master_waitrequest));
    end


  //irq assign, which is an e_assign
  assign cpu_0_data_master_irq = {1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    pio_pulse_s1_irq_from_sa,
    timer_1_s1_irq_from_sa,
    timer_0_s1_irq_from_sa,
    button_pio_s1_irq_from_sa,
    jtag_uart_0_avalon_jtag_slave_irq_from_sa};

  //unpredictable registered wait state incoming data, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          registered_cpu_0_data_master_readdata <= 0;
      else 
        registered_cpu_0_data_master_readdata <= p1_registered_cpu_0_data_master_readdata;
    end


  //registered readdata mux, which is an e_mux
  assign p1_registered_cpu_0_data_master_readdata = ({32 {~cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave}} | jtag_uart_0_avalon_jtag_slave_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_sdram_0_s1}} | {sdram_0_s1_readdata_from_sa[15 : 0],
    dbs_16_reg_segment_0});

  //no_byte_enables_and_last_term, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_data_master_no_byte_enables_and_last_term <= 0;
      else 
        cpu_0_data_master_no_byte_enables_and_last_term <= last_dbs_term_and_run;
    end


  //compute the last dbs term, which is an e_mux
  assign last_dbs_term_and_run = (cpu_0_data_master_dbs_address == 2'b10) & cpu_0_data_master_write & !cpu_0_data_master_byteenable_sdram_0_s1;

  //pre dbs count enable, which is an e_mux
  assign pre_dbs_count_enable = (((~cpu_0_data_master_no_byte_enables_and_last_term) & cpu_0_data_master_requests_sdram_0_s1 & cpu_0_data_master_write & !cpu_0_data_master_byteenable_sdram_0_s1)) |
    cpu_0_data_master_read_data_valid_sdram_0_s1 |
    (cpu_0_data_master_granted_sdram_0_s1 & cpu_0_data_master_write & 1 & 1 & ~sdram_0_s1_waitrequest_from_sa);

  //input to dbs-16 stored 0, which is an e_mux
  assign p1_dbs_16_reg_segment_0 = sdram_0_s1_readdata_from_sa;

  //dbs register for dbs-16 segment 0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          dbs_16_reg_segment_0 <= 0;
      else if (dbs_count_enable & ((cpu_0_data_master_dbs_address[1]) == 0))
          dbs_16_reg_segment_0 <= p1_dbs_16_reg_segment_0;
    end


  //mux write dbs 1, which is an e_mux
  assign cpu_0_data_master_dbs_write_16 = (cpu_0_data_master_dbs_address[1])? cpu_0_data_master_writedata[31 : 16] :
    cpu_0_data_master_writedata[15 : 0];

  //dbs count increment, which is an e_mux
  assign cpu_0_data_master_dbs_increment = (cpu_0_data_master_requests_sdram_0_s1)? 2 :
    0;

  //dbs counter overflow, which is an e_assign
  assign dbs_counter_overflow = cpu_0_data_master_dbs_address[1] & !(next_dbs_address[1]);

  //next master address, which is an e_assign
  assign next_dbs_address = cpu_0_data_master_dbs_address + cpu_0_data_master_dbs_increment;

  //dbs count enable, which is an e_mux
  assign dbs_count_enable = pre_dbs_count_enable &
    (~(cpu_0_data_master_requests_sdram_0_s1 & ~cpu_0_data_master_waitrequest));

  //dbs counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_data_master_dbs_address <= 0;
      else if (dbs_count_enable)
          cpu_0_data_master_dbs_address <= next_dbs_address;
    end



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpu_0_instruction_master_arbitrator (
                                             // inputs:
                                              clk,
                                              cpu_0_instruction_master_address,
                                              cpu_0_instruction_master_granted_cpu_0_jtag_debug_module,
                                              cpu_0_instruction_master_granted_sdram_0_s1,
                                              cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module,
                                              cpu_0_instruction_master_qualified_request_sdram_0_s1,
                                              cpu_0_instruction_master_read,
                                              cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module,
                                              cpu_0_instruction_master_read_data_valid_sdram_0_s1,
                                              cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register,
                                              cpu_0_instruction_master_requests_cpu_0_jtag_debug_module,
                                              cpu_0_instruction_master_requests_sdram_0_s1,
                                              cpu_0_jtag_debug_module_readdata_from_sa,
                                              d1_cpu_0_jtag_debug_module_end_xfer,
                                              d1_sdram_0_s1_end_xfer,
                                              reset_n,
                                              sdram_0_s1_readdata_from_sa,
                                              sdram_0_s1_waitrequest_from_sa,

                                             // outputs:
                                              cpu_0_instruction_master_address_to_slave,
                                              cpu_0_instruction_master_dbs_address,
                                              cpu_0_instruction_master_latency_counter,
                                              cpu_0_instruction_master_readdata,
                                              cpu_0_instruction_master_readdatavalid,
                                              cpu_0_instruction_master_waitrequest
                                           )
;

  output  [ 24: 0] cpu_0_instruction_master_address_to_slave;
  output  [  1: 0] cpu_0_instruction_master_dbs_address;
  output           cpu_0_instruction_master_latency_counter;
  output  [ 31: 0] cpu_0_instruction_master_readdata;
  output           cpu_0_instruction_master_readdatavalid;
  output           cpu_0_instruction_master_waitrequest;
  input            clk;
  input   [ 24: 0] cpu_0_instruction_master_address;
  input            cpu_0_instruction_master_granted_cpu_0_jtag_debug_module;
  input            cpu_0_instruction_master_granted_sdram_0_s1;
  input            cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module;
  input            cpu_0_instruction_master_qualified_request_sdram_0_s1;
  input            cpu_0_instruction_master_read;
  input            cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module;
  input            cpu_0_instruction_master_read_data_valid_sdram_0_s1;
  input            cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register;
  input            cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;
  input            cpu_0_instruction_master_requests_sdram_0_s1;
  input   [ 31: 0] cpu_0_jtag_debug_module_readdata_from_sa;
  input            d1_cpu_0_jtag_debug_module_end_xfer;
  input            d1_sdram_0_s1_end_xfer;
  input            reset_n;
  input   [ 15: 0] sdram_0_s1_readdata_from_sa;
  input            sdram_0_s1_waitrequest_from_sa;

  reg              active_and_waiting_last_time;
  reg     [ 24: 0] cpu_0_instruction_master_address_last_time;
  wire    [ 24: 0] cpu_0_instruction_master_address_to_slave;
  reg     [  1: 0] cpu_0_instruction_master_dbs_address;
  wire    [  1: 0] cpu_0_instruction_master_dbs_increment;
  reg     [  1: 0] cpu_0_instruction_master_dbs_rdv_counter;
  wire    [  1: 0] cpu_0_instruction_master_dbs_rdv_counter_inc;
  wire             cpu_0_instruction_master_is_granted_some_slave;
  reg              cpu_0_instruction_master_latency_counter;
  wire    [  1: 0] cpu_0_instruction_master_next_dbs_rdv_counter;
  reg              cpu_0_instruction_master_read_but_no_slave_selected;
  reg              cpu_0_instruction_master_read_last_time;
  wire    [ 31: 0] cpu_0_instruction_master_readdata;
  wire             cpu_0_instruction_master_readdatavalid;
  wire             cpu_0_instruction_master_run;
  wire             cpu_0_instruction_master_waitrequest;
  wire             dbs_count_enable;
  wire             dbs_counter_overflow;
  reg     [ 15: 0] dbs_latent_16_reg_segment_0;
  wire             dbs_rdv_count_enable;
  wire             dbs_rdv_counter_overflow;
  wire             latency_load_value;
  wire    [  1: 0] next_dbs_address;
  wire             p1_cpu_0_instruction_master_latency_counter;
  wire    [ 15: 0] p1_dbs_latent_16_reg_segment_0;
  wire             pre_dbs_count_enable;
  wire             pre_flush_cpu_0_instruction_master_readdatavalid;
  wire             r_0;
  wire             r_3;
  //r_0 master_run cascaded wait assignment, which is an e_assign
  assign r_0 = 1 & (cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module | ~cpu_0_instruction_master_requests_cpu_0_jtag_debug_module) & (cpu_0_instruction_master_granted_cpu_0_jtag_debug_module | ~cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module) & ((~cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module | ~cpu_0_instruction_master_read | (1 & ~d1_cpu_0_jtag_debug_module_end_xfer & cpu_0_instruction_master_read)));

  //cascaded wait assignment, which is an e_assign
  assign cpu_0_instruction_master_run = r_0 & r_3;

  //r_3 master_run cascaded wait assignment, which is an e_assign
  assign r_3 = 1 & (cpu_0_instruction_master_qualified_request_sdram_0_s1 | ~cpu_0_instruction_master_requests_sdram_0_s1) & (cpu_0_instruction_master_granted_sdram_0_s1 | ~cpu_0_instruction_master_qualified_request_sdram_0_s1) & ((~cpu_0_instruction_master_qualified_request_sdram_0_s1 | ~cpu_0_instruction_master_read | (1 & ~sdram_0_s1_waitrequest_from_sa & (cpu_0_instruction_master_dbs_address[1]) & cpu_0_instruction_master_read)));

  //optimize select-logic by passing only those address bits which matter.
  assign cpu_0_instruction_master_address_to_slave = cpu_0_instruction_master_address[24 : 0];

  //cpu_0_instruction_master_read_but_no_slave_selected assignment, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_instruction_master_read_but_no_slave_selected <= 0;
      else 
        cpu_0_instruction_master_read_but_no_slave_selected <= cpu_0_instruction_master_read & cpu_0_instruction_master_run & ~cpu_0_instruction_master_is_granted_some_slave;
    end


  //some slave is getting selected, which is an e_mux
  assign cpu_0_instruction_master_is_granted_some_slave = cpu_0_instruction_master_granted_cpu_0_jtag_debug_module |
    cpu_0_instruction_master_granted_sdram_0_s1;

  //latent slave read data valids which may be flushed, which is an e_mux
  assign pre_flush_cpu_0_instruction_master_readdatavalid = cpu_0_instruction_master_read_data_valid_sdram_0_s1 & dbs_rdv_counter_overflow;

  //latent slave read data valid which is not flushed, which is an e_mux
  assign cpu_0_instruction_master_readdatavalid = cpu_0_instruction_master_read_but_no_slave_selected |
    pre_flush_cpu_0_instruction_master_readdatavalid |
    cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module |
    cpu_0_instruction_master_read_but_no_slave_selected |
    pre_flush_cpu_0_instruction_master_readdatavalid;

  //cpu_0/instruction_master readdata mux, which is an e_mux
  assign cpu_0_instruction_master_readdata = ({32 {~(cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module & cpu_0_instruction_master_read)}} | cpu_0_jtag_debug_module_readdata_from_sa) &
    ({32 {~cpu_0_instruction_master_read_data_valid_sdram_0_s1}} | {sdram_0_s1_readdata_from_sa[15 : 0],
    dbs_latent_16_reg_segment_0});

  //actual waitrequest port, which is an e_assign
  assign cpu_0_instruction_master_waitrequest = ~cpu_0_instruction_master_run;

  //latent max counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_instruction_master_latency_counter <= 0;
      else 
        cpu_0_instruction_master_latency_counter <= p1_cpu_0_instruction_master_latency_counter;
    end


  //latency counter load mux, which is an e_mux
  assign p1_cpu_0_instruction_master_latency_counter = ((cpu_0_instruction_master_run & cpu_0_instruction_master_read))? latency_load_value :
    (cpu_0_instruction_master_latency_counter)? cpu_0_instruction_master_latency_counter - 1 :
    0;

  //read latency load values, which is an e_mux
  assign latency_load_value = 0;

  //input to latent dbs-16 stored 0, which is an e_mux
  assign p1_dbs_latent_16_reg_segment_0 = sdram_0_s1_readdata_from_sa;

  //dbs register for latent dbs-16 segment 0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          dbs_latent_16_reg_segment_0 <= 0;
      else if (dbs_rdv_count_enable & ((cpu_0_instruction_master_dbs_rdv_counter[1]) == 0))
          dbs_latent_16_reg_segment_0 <= p1_dbs_latent_16_reg_segment_0;
    end


  //dbs count increment, which is an e_mux
  assign cpu_0_instruction_master_dbs_increment = (cpu_0_instruction_master_requests_sdram_0_s1)? 2 :
    0;

  //dbs counter overflow, which is an e_assign
  assign dbs_counter_overflow = cpu_0_instruction_master_dbs_address[1] & !(next_dbs_address[1]);

  //next master address, which is an e_assign
  assign next_dbs_address = cpu_0_instruction_master_dbs_address + cpu_0_instruction_master_dbs_increment;

  //dbs count enable, which is an e_mux
  assign dbs_count_enable = pre_dbs_count_enable;

  //dbs counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_instruction_master_dbs_address <= 0;
      else if (dbs_count_enable)
          cpu_0_instruction_master_dbs_address <= next_dbs_address;
    end


  //p1 dbs rdv counter, which is an e_assign
  assign cpu_0_instruction_master_next_dbs_rdv_counter = cpu_0_instruction_master_dbs_rdv_counter + cpu_0_instruction_master_dbs_rdv_counter_inc;

  //cpu_0_instruction_master_rdv_inc_mux, which is an e_mux
  assign cpu_0_instruction_master_dbs_rdv_counter_inc = 2;

  //master any slave rdv, which is an e_mux
  assign dbs_rdv_count_enable = cpu_0_instruction_master_read_data_valid_sdram_0_s1;

  //dbs rdv counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_instruction_master_dbs_rdv_counter <= 0;
      else if (dbs_rdv_count_enable)
          cpu_0_instruction_master_dbs_rdv_counter <= cpu_0_instruction_master_next_dbs_rdv_counter;
    end


  //dbs rdv counter overflow, which is an e_assign
  assign dbs_rdv_counter_overflow = cpu_0_instruction_master_dbs_rdv_counter[1] & ~cpu_0_instruction_master_next_dbs_rdv_counter[1];

  //pre dbs count enable, which is an e_mux
  assign pre_dbs_count_enable = cpu_0_instruction_master_granted_sdram_0_s1 & cpu_0_instruction_master_read & 1 & 1 & ~sdram_0_s1_waitrequest_from_sa;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //cpu_0_instruction_master_address check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_instruction_master_address_last_time <= 0;
      else 
        cpu_0_instruction_master_address_last_time <= cpu_0_instruction_master_address;
    end


  //cpu_0/instruction_master waited last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          active_and_waiting_last_time <= 0;
      else 
        active_and_waiting_last_time <= cpu_0_instruction_master_waitrequest & (cpu_0_instruction_master_read);
    end


  //cpu_0_instruction_master_address matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_0_instruction_master_address != cpu_0_instruction_master_address_last_time))
        begin
          $write("%0d ns: cpu_0_instruction_master_address did not heed wait!!!", $time);
          $stop;
        end
    end


  //cpu_0_instruction_master_read check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_instruction_master_read_last_time <= 0;
      else 
        cpu_0_instruction_master_read_last_time <= cpu_0_instruction_master_read;
    end


  //cpu_0_instruction_master_read matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_0_instruction_master_read != cpu_0_instruction_master_read_last_time))
        begin
          $write("%0d ns: cpu_0_instruction_master_read did not heed wait!!!", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module green_led_pio_s1_arbitrator (
                                     // inputs:
                                      clk,
                                      cpu_0_data_master_address_to_slave,
                                      cpu_0_data_master_byteenable,
                                      cpu_0_data_master_read,
                                      cpu_0_data_master_waitrequest,
                                      cpu_0_data_master_write,
                                      cpu_0_data_master_writedata,
                                      green_led_pio_s1_readdata,
                                      reset_n,

                                     // outputs:
                                      cpu_0_data_master_granted_green_led_pio_s1,
                                      cpu_0_data_master_qualified_request_green_led_pio_s1,
                                      cpu_0_data_master_read_data_valid_green_led_pio_s1,
                                      cpu_0_data_master_requests_green_led_pio_s1,
                                      d1_green_led_pio_s1_end_xfer,
                                      green_led_pio_s1_address,
                                      green_led_pio_s1_chipselect,
                                      green_led_pio_s1_readdata_from_sa,
                                      green_led_pio_s1_reset_n,
                                      green_led_pio_s1_write_n,
                                      green_led_pio_s1_writedata
                                   )
;

  output           cpu_0_data_master_granted_green_led_pio_s1;
  output           cpu_0_data_master_qualified_request_green_led_pio_s1;
  output           cpu_0_data_master_read_data_valid_green_led_pio_s1;
  output           cpu_0_data_master_requests_green_led_pio_s1;
  output           d1_green_led_pio_s1_end_xfer;
  output  [  1: 0] green_led_pio_s1_address;
  output           green_led_pio_s1_chipselect;
  output  [  7: 0] green_led_pio_s1_readdata_from_sa;
  output           green_led_pio_s1_reset_n;
  output           green_led_pio_s1_write_n;
  output  [  7: 0] green_led_pio_s1_writedata;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input   [  3: 0] cpu_0_data_master_byteenable;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_waitrequest;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input   [  7: 0] green_led_pio_s1_readdata;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_green_led_pio_s1;
  wire             cpu_0_data_master_qualified_request_green_led_pio_s1;
  wire             cpu_0_data_master_read_data_valid_green_led_pio_s1;
  wire             cpu_0_data_master_requests_green_led_pio_s1;
  wire             cpu_0_data_master_saved_grant_green_led_pio_s1;
  reg              d1_green_led_pio_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_green_led_pio_s1;
  wire    [  1: 0] green_led_pio_s1_address;
  wire             green_led_pio_s1_allgrants;
  wire             green_led_pio_s1_allow_new_arb_cycle;
  wire             green_led_pio_s1_any_bursting_master_saved_grant;
  wire             green_led_pio_s1_any_continuerequest;
  wire             green_led_pio_s1_arb_counter_enable;
  reg     [  1: 0] green_led_pio_s1_arb_share_counter;
  wire    [  1: 0] green_led_pio_s1_arb_share_counter_next_value;
  wire    [  1: 0] green_led_pio_s1_arb_share_set_values;
  wire             green_led_pio_s1_beginbursttransfer_internal;
  wire             green_led_pio_s1_begins_xfer;
  wire             green_led_pio_s1_chipselect;
  wire             green_led_pio_s1_end_xfer;
  wire             green_led_pio_s1_firsttransfer;
  wire             green_led_pio_s1_grant_vector;
  wire             green_led_pio_s1_in_a_read_cycle;
  wire             green_led_pio_s1_in_a_write_cycle;
  wire             green_led_pio_s1_master_qreq_vector;
  wire             green_led_pio_s1_non_bursting_master_requests;
  wire             green_led_pio_s1_pretend_byte_enable;
  wire    [  7: 0] green_led_pio_s1_readdata_from_sa;
  reg              green_led_pio_s1_reg_firsttransfer;
  wire             green_led_pio_s1_reset_n;
  reg              green_led_pio_s1_slavearbiterlockenable;
  wire             green_led_pio_s1_slavearbiterlockenable2;
  wire             green_led_pio_s1_unreg_firsttransfer;
  wire             green_led_pio_s1_waits_for_read;
  wire             green_led_pio_s1_waits_for_write;
  wire             green_led_pio_s1_write_n;
  wire    [  7: 0] green_led_pio_s1_writedata;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 24: 0] shifted_address_to_green_led_pio_s1_from_cpu_0_data_master;
  wire             wait_for_green_led_pio_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~green_led_pio_s1_end_xfer;
    end


  assign green_led_pio_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_green_led_pio_s1));
  //assign green_led_pio_s1_readdata_from_sa = green_led_pio_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign green_led_pio_s1_readdata_from_sa = green_led_pio_s1_readdata;

  assign cpu_0_data_master_requests_green_led_pio_s1 = ({cpu_0_data_master_address_to_slave[24 : 4] , 4'b0} == 25'h1001080) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //green_led_pio_s1_arb_share_counter set values, which is an e_mux
  assign green_led_pio_s1_arb_share_set_values = 1;

  //green_led_pio_s1_non_bursting_master_requests mux, which is an e_mux
  assign green_led_pio_s1_non_bursting_master_requests = cpu_0_data_master_requests_green_led_pio_s1;

  //green_led_pio_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign green_led_pio_s1_any_bursting_master_saved_grant = 0;

  //green_led_pio_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign green_led_pio_s1_arb_share_counter_next_value = green_led_pio_s1_firsttransfer ? (green_led_pio_s1_arb_share_set_values - 1) : |green_led_pio_s1_arb_share_counter ? (green_led_pio_s1_arb_share_counter - 1) : 0;

  //green_led_pio_s1_allgrants all slave grants, which is an e_mux
  assign green_led_pio_s1_allgrants = |green_led_pio_s1_grant_vector;

  //green_led_pio_s1_end_xfer assignment, which is an e_assign
  assign green_led_pio_s1_end_xfer = ~(green_led_pio_s1_waits_for_read | green_led_pio_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_green_led_pio_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_green_led_pio_s1 = green_led_pio_s1_end_xfer & (~green_led_pio_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //green_led_pio_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign green_led_pio_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_green_led_pio_s1 & green_led_pio_s1_allgrants) | (end_xfer_arb_share_counter_term_green_led_pio_s1 & ~green_led_pio_s1_non_bursting_master_requests);

  //green_led_pio_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          green_led_pio_s1_arb_share_counter <= 0;
      else if (green_led_pio_s1_arb_counter_enable)
          green_led_pio_s1_arb_share_counter <= green_led_pio_s1_arb_share_counter_next_value;
    end


  //green_led_pio_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          green_led_pio_s1_slavearbiterlockenable <= 0;
      else if ((|green_led_pio_s1_master_qreq_vector & end_xfer_arb_share_counter_term_green_led_pio_s1) | (end_xfer_arb_share_counter_term_green_led_pio_s1 & ~green_led_pio_s1_non_bursting_master_requests))
          green_led_pio_s1_slavearbiterlockenable <= |green_led_pio_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master green_led_pio/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = green_led_pio_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //green_led_pio_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign green_led_pio_s1_slavearbiterlockenable2 = |green_led_pio_s1_arb_share_counter_next_value;

  //cpu_0/data_master green_led_pio/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = green_led_pio_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //green_led_pio_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign green_led_pio_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_green_led_pio_s1 = cpu_0_data_master_requests_green_led_pio_s1 & ~(((~cpu_0_data_master_waitrequest) & cpu_0_data_master_write));
  //green_led_pio_s1_writedata mux, which is an e_mux
  assign green_led_pio_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_green_led_pio_s1 = cpu_0_data_master_qualified_request_green_led_pio_s1;

  //cpu_0/data_master saved-grant green_led_pio/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_green_led_pio_s1 = cpu_0_data_master_requests_green_led_pio_s1;

  //allow new arb cycle for green_led_pio/s1, which is an e_assign
  assign green_led_pio_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign green_led_pio_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign green_led_pio_s1_master_qreq_vector = 1;

  //green_led_pio_s1_reset_n assignment, which is an e_assign
  assign green_led_pio_s1_reset_n = reset_n;

  assign green_led_pio_s1_chipselect = cpu_0_data_master_granted_green_led_pio_s1;
  //green_led_pio_s1_firsttransfer first transaction, which is an e_assign
  assign green_led_pio_s1_firsttransfer = green_led_pio_s1_begins_xfer ? green_led_pio_s1_unreg_firsttransfer : green_led_pio_s1_reg_firsttransfer;

  //green_led_pio_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign green_led_pio_s1_unreg_firsttransfer = ~(green_led_pio_s1_slavearbiterlockenable & green_led_pio_s1_any_continuerequest);

  //green_led_pio_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          green_led_pio_s1_reg_firsttransfer <= 1'b1;
      else if (green_led_pio_s1_begins_xfer)
          green_led_pio_s1_reg_firsttransfer <= green_led_pio_s1_unreg_firsttransfer;
    end


  //green_led_pio_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign green_led_pio_s1_beginbursttransfer_internal = green_led_pio_s1_begins_xfer;

  //~green_led_pio_s1_write_n assignment, which is an e_mux
  assign green_led_pio_s1_write_n = ~(((cpu_0_data_master_granted_green_led_pio_s1 & cpu_0_data_master_write)) & green_led_pio_s1_pretend_byte_enable);

  assign shifted_address_to_green_led_pio_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //green_led_pio_s1_address mux, which is an e_mux
  assign green_led_pio_s1_address = shifted_address_to_green_led_pio_s1_from_cpu_0_data_master >> 2;

  //d1_green_led_pio_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_green_led_pio_s1_end_xfer <= 1;
      else 
        d1_green_led_pio_s1_end_xfer <= green_led_pio_s1_end_xfer;
    end


  //green_led_pio_s1_waits_for_read in a cycle, which is an e_mux
  assign green_led_pio_s1_waits_for_read = green_led_pio_s1_in_a_read_cycle & green_led_pio_s1_begins_xfer;

  //green_led_pio_s1_in_a_read_cycle assignment, which is an e_assign
  assign green_led_pio_s1_in_a_read_cycle = cpu_0_data_master_granted_green_led_pio_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = green_led_pio_s1_in_a_read_cycle;

  //green_led_pio_s1_waits_for_write in a cycle, which is an e_mux
  assign green_led_pio_s1_waits_for_write = green_led_pio_s1_in_a_write_cycle & 0;

  //green_led_pio_s1_in_a_write_cycle assignment, which is an e_assign
  assign green_led_pio_s1_in_a_write_cycle = cpu_0_data_master_granted_green_led_pio_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = green_led_pio_s1_in_a_write_cycle;

  assign wait_for_green_led_pio_s1_counter = 0;
  //green_led_pio_s1_pretend_byte_enable byte enable port mux, which is an e_mux
  assign green_led_pio_s1_pretend_byte_enable = (cpu_0_data_master_granted_green_led_pio_s1)? cpu_0_data_master_byteenable :
    -1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //green_led_pio/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module jtag_uart_0_avalon_jtag_slave_arbitrator (
                                                  // inputs:
                                                   clk,
                                                   cpu_0_data_master_address_to_slave,
                                                   cpu_0_data_master_read,
                                                   cpu_0_data_master_waitrequest,
                                                   cpu_0_data_master_write,
                                                   cpu_0_data_master_writedata,
                                                   jtag_uart_0_avalon_jtag_slave_dataavailable,
                                                   jtag_uart_0_avalon_jtag_slave_irq,
                                                   jtag_uart_0_avalon_jtag_slave_readdata,
                                                   jtag_uart_0_avalon_jtag_slave_readyfordata,
                                                   jtag_uart_0_avalon_jtag_slave_waitrequest,
                                                   reset_n,

                                                  // outputs:
                                                   cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave,
                                                   cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave,
                                                   cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave,
                                                   cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave,
                                                   d1_jtag_uart_0_avalon_jtag_slave_end_xfer,
                                                   jtag_uart_0_avalon_jtag_slave_address,
                                                   jtag_uart_0_avalon_jtag_slave_chipselect,
                                                   jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa,
                                                   jtag_uart_0_avalon_jtag_slave_irq_from_sa,
                                                   jtag_uart_0_avalon_jtag_slave_read_n,
                                                   jtag_uart_0_avalon_jtag_slave_readdata_from_sa,
                                                   jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa,
                                                   jtag_uart_0_avalon_jtag_slave_reset_n,
                                                   jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa,
                                                   jtag_uart_0_avalon_jtag_slave_write_n,
                                                   jtag_uart_0_avalon_jtag_slave_writedata
                                                )
;

  output           cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave;
  output           cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave;
  output           cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave;
  output           cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave;
  output           d1_jtag_uart_0_avalon_jtag_slave_end_xfer;
  output           jtag_uart_0_avalon_jtag_slave_address;
  output           jtag_uart_0_avalon_jtag_slave_chipselect;
  output           jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa;
  output           jtag_uart_0_avalon_jtag_slave_irq_from_sa;
  output           jtag_uart_0_avalon_jtag_slave_read_n;
  output  [ 31: 0] jtag_uart_0_avalon_jtag_slave_readdata_from_sa;
  output           jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa;
  output           jtag_uart_0_avalon_jtag_slave_reset_n;
  output           jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa;
  output           jtag_uart_0_avalon_jtag_slave_write_n;
  output  [ 31: 0] jtag_uart_0_avalon_jtag_slave_writedata;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_waitrequest;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            jtag_uart_0_avalon_jtag_slave_dataavailable;
  input            jtag_uart_0_avalon_jtag_slave_irq;
  input   [ 31: 0] jtag_uart_0_avalon_jtag_slave_readdata;
  input            jtag_uart_0_avalon_jtag_slave_readyfordata;
  input            jtag_uart_0_avalon_jtag_slave_waitrequest;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_saved_grant_jtag_uart_0_avalon_jtag_slave;
  reg              d1_jtag_uart_0_avalon_jtag_slave_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire             jtag_uart_0_avalon_jtag_slave_address;
  wire             jtag_uart_0_avalon_jtag_slave_allgrants;
  wire             jtag_uart_0_avalon_jtag_slave_allow_new_arb_cycle;
  wire             jtag_uart_0_avalon_jtag_slave_any_bursting_master_saved_grant;
  wire             jtag_uart_0_avalon_jtag_slave_any_continuerequest;
  wire             jtag_uart_0_avalon_jtag_slave_arb_counter_enable;
  reg     [  1: 0] jtag_uart_0_avalon_jtag_slave_arb_share_counter;
  wire    [  1: 0] jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value;
  wire    [  1: 0] jtag_uart_0_avalon_jtag_slave_arb_share_set_values;
  wire             jtag_uart_0_avalon_jtag_slave_beginbursttransfer_internal;
  wire             jtag_uart_0_avalon_jtag_slave_begins_xfer;
  wire             jtag_uart_0_avalon_jtag_slave_chipselect;
  wire             jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_end_xfer;
  wire             jtag_uart_0_avalon_jtag_slave_firsttransfer;
  wire             jtag_uart_0_avalon_jtag_slave_grant_vector;
  wire             jtag_uart_0_avalon_jtag_slave_in_a_read_cycle;
  wire             jtag_uart_0_avalon_jtag_slave_in_a_write_cycle;
  wire             jtag_uart_0_avalon_jtag_slave_irq_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_master_qreq_vector;
  wire             jtag_uart_0_avalon_jtag_slave_non_bursting_master_requests;
  wire             jtag_uart_0_avalon_jtag_slave_read_n;
  wire    [ 31: 0] jtag_uart_0_avalon_jtag_slave_readdata_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa;
  reg              jtag_uart_0_avalon_jtag_slave_reg_firsttransfer;
  wire             jtag_uart_0_avalon_jtag_slave_reset_n;
  reg              jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable;
  wire             jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable2;
  wire             jtag_uart_0_avalon_jtag_slave_unreg_firsttransfer;
  wire             jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_waits_for_read;
  wire             jtag_uart_0_avalon_jtag_slave_waits_for_write;
  wire             jtag_uart_0_avalon_jtag_slave_write_n;
  wire    [ 31: 0] jtag_uart_0_avalon_jtag_slave_writedata;
  wire    [ 24: 0] shifted_address_to_jtag_uart_0_avalon_jtag_slave_from_cpu_0_data_master;
  wire             wait_for_jtag_uart_0_avalon_jtag_slave_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~jtag_uart_0_avalon_jtag_slave_end_xfer;
    end


  assign jtag_uart_0_avalon_jtag_slave_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave));
  //assign jtag_uart_0_avalon_jtag_slave_readdata_from_sa = jtag_uart_0_avalon_jtag_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_readdata_from_sa = jtag_uart_0_avalon_jtag_slave_readdata;

  assign cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave = ({cpu_0_data_master_address_to_slave[24 : 3] , 3'b0} == 25'h1001158) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //assign jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa = jtag_uart_0_avalon_jtag_slave_dataavailable so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa = jtag_uart_0_avalon_jtag_slave_dataavailable;

  //assign jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa = jtag_uart_0_avalon_jtag_slave_readyfordata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa = jtag_uart_0_avalon_jtag_slave_readyfordata;

  //assign jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa = jtag_uart_0_avalon_jtag_slave_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa = jtag_uart_0_avalon_jtag_slave_waitrequest;

  //jtag_uart_0_avalon_jtag_slave_arb_share_counter set values, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_arb_share_set_values = 1;

  //jtag_uart_0_avalon_jtag_slave_non_bursting_master_requests mux, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_non_bursting_master_requests = cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave;

  //jtag_uart_0_avalon_jtag_slave_any_bursting_master_saved_grant mux, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_any_bursting_master_saved_grant = 0;

  //jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value assignment, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value = jtag_uart_0_avalon_jtag_slave_firsttransfer ? (jtag_uart_0_avalon_jtag_slave_arb_share_set_values - 1) : |jtag_uart_0_avalon_jtag_slave_arb_share_counter ? (jtag_uart_0_avalon_jtag_slave_arb_share_counter - 1) : 0;

  //jtag_uart_0_avalon_jtag_slave_allgrants all slave grants, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_allgrants = |jtag_uart_0_avalon_jtag_slave_grant_vector;

  //jtag_uart_0_avalon_jtag_slave_end_xfer assignment, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_end_xfer = ~(jtag_uart_0_avalon_jtag_slave_waits_for_read | jtag_uart_0_avalon_jtag_slave_waits_for_write);

  //end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave = jtag_uart_0_avalon_jtag_slave_end_xfer & (~jtag_uart_0_avalon_jtag_slave_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //jtag_uart_0_avalon_jtag_slave_arb_share_counter arbitration counter enable, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_arb_counter_enable = (end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave & jtag_uart_0_avalon_jtag_slave_allgrants) | (end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave & ~jtag_uart_0_avalon_jtag_slave_non_bursting_master_requests);

  //jtag_uart_0_avalon_jtag_slave_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          jtag_uart_0_avalon_jtag_slave_arb_share_counter <= 0;
      else if (jtag_uart_0_avalon_jtag_slave_arb_counter_enable)
          jtag_uart_0_avalon_jtag_slave_arb_share_counter <= jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value;
    end


  //jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable <= 0;
      else if ((|jtag_uart_0_avalon_jtag_slave_master_qreq_vector & end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave) | (end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave & ~jtag_uart_0_avalon_jtag_slave_non_bursting_master_requests))
          jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable <= |jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value;
    end


  //cpu_0/data_master jtag_uart_0/avalon_jtag_slave arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable2 = |jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value;

  //cpu_0/data_master jtag_uart_0/avalon_jtag_slave arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //jtag_uart_0_avalon_jtag_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave = cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave & ~((cpu_0_data_master_read & (~cpu_0_data_master_waitrequest)) | ((~cpu_0_data_master_waitrequest) & cpu_0_data_master_write));
  //jtag_uart_0_avalon_jtag_slave_writedata mux, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave = cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave;

  //cpu_0/data_master saved-grant jtag_uart_0/avalon_jtag_slave, which is an e_assign
  assign cpu_0_data_master_saved_grant_jtag_uart_0_avalon_jtag_slave = cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave;

  //allow new arb cycle for jtag_uart_0/avalon_jtag_slave, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign jtag_uart_0_avalon_jtag_slave_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign jtag_uart_0_avalon_jtag_slave_master_qreq_vector = 1;

  //jtag_uart_0_avalon_jtag_slave_reset_n assignment, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_reset_n = reset_n;

  assign jtag_uart_0_avalon_jtag_slave_chipselect = cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave;
  //jtag_uart_0_avalon_jtag_slave_firsttransfer first transaction, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_firsttransfer = jtag_uart_0_avalon_jtag_slave_begins_xfer ? jtag_uart_0_avalon_jtag_slave_unreg_firsttransfer : jtag_uart_0_avalon_jtag_slave_reg_firsttransfer;

  //jtag_uart_0_avalon_jtag_slave_unreg_firsttransfer first transaction, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_unreg_firsttransfer = ~(jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable & jtag_uart_0_avalon_jtag_slave_any_continuerequest);

  //jtag_uart_0_avalon_jtag_slave_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          jtag_uart_0_avalon_jtag_slave_reg_firsttransfer <= 1'b1;
      else if (jtag_uart_0_avalon_jtag_slave_begins_xfer)
          jtag_uart_0_avalon_jtag_slave_reg_firsttransfer <= jtag_uart_0_avalon_jtag_slave_unreg_firsttransfer;
    end


  //jtag_uart_0_avalon_jtag_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_beginbursttransfer_internal = jtag_uart_0_avalon_jtag_slave_begins_xfer;

  //~jtag_uart_0_avalon_jtag_slave_read_n assignment, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_read_n = ~(cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave & cpu_0_data_master_read);

  //~jtag_uart_0_avalon_jtag_slave_write_n assignment, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_write_n = ~(cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave & cpu_0_data_master_write);

  assign shifted_address_to_jtag_uart_0_avalon_jtag_slave_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //jtag_uart_0_avalon_jtag_slave_address mux, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_address = shifted_address_to_jtag_uart_0_avalon_jtag_slave_from_cpu_0_data_master >> 2;

  //d1_jtag_uart_0_avalon_jtag_slave_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_jtag_uart_0_avalon_jtag_slave_end_xfer <= 1;
      else 
        d1_jtag_uart_0_avalon_jtag_slave_end_xfer <= jtag_uart_0_avalon_jtag_slave_end_xfer;
    end


  //jtag_uart_0_avalon_jtag_slave_waits_for_read in a cycle, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_waits_for_read = jtag_uart_0_avalon_jtag_slave_in_a_read_cycle & jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa;

  //jtag_uart_0_avalon_jtag_slave_in_a_read_cycle assignment, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_in_a_read_cycle = cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = jtag_uart_0_avalon_jtag_slave_in_a_read_cycle;

  //jtag_uart_0_avalon_jtag_slave_waits_for_write in a cycle, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_waits_for_write = jtag_uart_0_avalon_jtag_slave_in_a_write_cycle & jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa;

  //jtag_uart_0_avalon_jtag_slave_in_a_write_cycle assignment, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_in_a_write_cycle = cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = jtag_uart_0_avalon_jtag_slave_in_a_write_cycle;

  assign wait_for_jtag_uart_0_avalon_jtag_slave_counter = 0;
  //assign jtag_uart_0_avalon_jtag_slave_irq_from_sa = jtag_uart_0_avalon_jtag_slave_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_irq_from_sa = jtag_uart_0_avalon_jtag_slave_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //jtag_uart_0/avalon_jtag_slave enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module lcd_display_control_slave_arbitrator (
                                              // inputs:
                                               clk,
                                               cpu_0_data_master_address_to_slave,
                                               cpu_0_data_master_byteenable,
                                               cpu_0_data_master_read,
                                               cpu_0_data_master_write,
                                               cpu_0_data_master_writedata,
                                               lcd_display_control_slave_readdata,
                                               reset_n,

                                              // outputs:
                                               cpu_0_data_master_granted_lcd_display_control_slave,
                                               cpu_0_data_master_qualified_request_lcd_display_control_slave,
                                               cpu_0_data_master_read_data_valid_lcd_display_control_slave,
                                               cpu_0_data_master_requests_lcd_display_control_slave,
                                               d1_lcd_display_control_slave_end_xfer,
                                               lcd_display_control_slave_address,
                                               lcd_display_control_slave_begintransfer,
                                               lcd_display_control_slave_read,
                                               lcd_display_control_slave_readdata_from_sa,
                                               lcd_display_control_slave_wait_counter_eq_0,
                                               lcd_display_control_slave_wait_counter_eq_1,
                                               lcd_display_control_slave_write,
                                               lcd_display_control_slave_writedata
                                            )
;

  output           cpu_0_data_master_granted_lcd_display_control_slave;
  output           cpu_0_data_master_qualified_request_lcd_display_control_slave;
  output           cpu_0_data_master_read_data_valid_lcd_display_control_slave;
  output           cpu_0_data_master_requests_lcd_display_control_slave;
  output           d1_lcd_display_control_slave_end_xfer;
  output  [  1: 0] lcd_display_control_slave_address;
  output           lcd_display_control_slave_begintransfer;
  output           lcd_display_control_slave_read;
  output  [  7: 0] lcd_display_control_slave_readdata_from_sa;
  output           lcd_display_control_slave_wait_counter_eq_0;
  output           lcd_display_control_slave_wait_counter_eq_1;
  output           lcd_display_control_slave_write;
  output  [  7: 0] lcd_display_control_slave_writedata;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input   [  3: 0] cpu_0_data_master_byteenable;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input   [  7: 0] lcd_display_control_slave_readdata;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_lcd_display_control_slave;
  wire             cpu_0_data_master_qualified_request_lcd_display_control_slave;
  wire             cpu_0_data_master_read_data_valid_lcd_display_control_slave;
  wire             cpu_0_data_master_requests_lcd_display_control_slave;
  wire             cpu_0_data_master_saved_grant_lcd_display_control_slave;
  reg              d1_lcd_display_control_slave_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_lcd_display_control_slave;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] lcd_display_control_slave_address;
  wire             lcd_display_control_slave_allgrants;
  wire             lcd_display_control_slave_allow_new_arb_cycle;
  wire             lcd_display_control_slave_any_bursting_master_saved_grant;
  wire             lcd_display_control_slave_any_continuerequest;
  wire             lcd_display_control_slave_arb_counter_enable;
  reg     [  1: 0] lcd_display_control_slave_arb_share_counter;
  wire    [  1: 0] lcd_display_control_slave_arb_share_counter_next_value;
  wire    [  1: 0] lcd_display_control_slave_arb_share_set_values;
  wire             lcd_display_control_slave_beginbursttransfer_internal;
  wire             lcd_display_control_slave_begins_xfer;
  wire             lcd_display_control_slave_begintransfer;
  wire    [  5: 0] lcd_display_control_slave_counter_load_value;
  wire             lcd_display_control_slave_end_xfer;
  wire             lcd_display_control_slave_firsttransfer;
  wire             lcd_display_control_slave_grant_vector;
  wire             lcd_display_control_slave_in_a_read_cycle;
  wire             lcd_display_control_slave_in_a_write_cycle;
  wire             lcd_display_control_slave_master_qreq_vector;
  wire             lcd_display_control_slave_non_bursting_master_requests;
  wire             lcd_display_control_slave_pretend_byte_enable;
  wire             lcd_display_control_slave_read;
  wire    [  7: 0] lcd_display_control_slave_readdata_from_sa;
  reg              lcd_display_control_slave_reg_firsttransfer;
  reg              lcd_display_control_slave_slavearbiterlockenable;
  wire             lcd_display_control_slave_slavearbiterlockenable2;
  wire             lcd_display_control_slave_unreg_firsttransfer;
  reg     [  5: 0] lcd_display_control_slave_wait_counter;
  wire             lcd_display_control_slave_wait_counter_eq_0;
  wire             lcd_display_control_slave_wait_counter_eq_1;
  wire             lcd_display_control_slave_waits_for_read;
  wire             lcd_display_control_slave_waits_for_write;
  wire             lcd_display_control_slave_write;
  wire    [  7: 0] lcd_display_control_slave_writedata;
  wire    [ 24: 0] shifted_address_to_lcd_display_control_slave_from_cpu_0_data_master;
  wire             wait_for_lcd_display_control_slave_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~lcd_display_control_slave_end_xfer;
    end


  assign lcd_display_control_slave_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_lcd_display_control_slave));
  //assign lcd_display_control_slave_readdata_from_sa = lcd_display_control_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign lcd_display_control_slave_readdata_from_sa = lcd_display_control_slave_readdata;

  assign cpu_0_data_master_requests_lcd_display_control_slave = ({cpu_0_data_master_address_to_slave[24 : 4] , 4'b0} == 25'h1001040) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //lcd_display_control_slave_arb_share_counter set values, which is an e_mux
  assign lcd_display_control_slave_arb_share_set_values = 1;

  //lcd_display_control_slave_non_bursting_master_requests mux, which is an e_mux
  assign lcd_display_control_slave_non_bursting_master_requests = cpu_0_data_master_requests_lcd_display_control_slave;

  //lcd_display_control_slave_any_bursting_master_saved_grant mux, which is an e_mux
  assign lcd_display_control_slave_any_bursting_master_saved_grant = 0;

  //lcd_display_control_slave_arb_share_counter_next_value assignment, which is an e_assign
  assign lcd_display_control_slave_arb_share_counter_next_value = lcd_display_control_slave_firsttransfer ? (lcd_display_control_slave_arb_share_set_values - 1) : |lcd_display_control_slave_arb_share_counter ? (lcd_display_control_slave_arb_share_counter - 1) : 0;

  //lcd_display_control_slave_allgrants all slave grants, which is an e_mux
  assign lcd_display_control_slave_allgrants = |lcd_display_control_slave_grant_vector;

  //lcd_display_control_slave_end_xfer assignment, which is an e_assign
  assign lcd_display_control_slave_end_xfer = ~(lcd_display_control_slave_waits_for_read | lcd_display_control_slave_waits_for_write);

  //end_xfer_arb_share_counter_term_lcd_display_control_slave arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_lcd_display_control_slave = lcd_display_control_slave_end_xfer & (~lcd_display_control_slave_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //lcd_display_control_slave_arb_share_counter arbitration counter enable, which is an e_assign
  assign lcd_display_control_slave_arb_counter_enable = (end_xfer_arb_share_counter_term_lcd_display_control_slave & lcd_display_control_slave_allgrants) | (end_xfer_arb_share_counter_term_lcd_display_control_slave & ~lcd_display_control_slave_non_bursting_master_requests);

  //lcd_display_control_slave_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          lcd_display_control_slave_arb_share_counter <= 0;
      else if (lcd_display_control_slave_arb_counter_enable)
          lcd_display_control_slave_arb_share_counter <= lcd_display_control_slave_arb_share_counter_next_value;
    end


  //lcd_display_control_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          lcd_display_control_slave_slavearbiterlockenable <= 0;
      else if ((|lcd_display_control_slave_master_qreq_vector & end_xfer_arb_share_counter_term_lcd_display_control_slave) | (end_xfer_arb_share_counter_term_lcd_display_control_slave & ~lcd_display_control_slave_non_bursting_master_requests))
          lcd_display_control_slave_slavearbiterlockenable <= |lcd_display_control_slave_arb_share_counter_next_value;
    end


  //cpu_0/data_master lcd_display/control_slave arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = lcd_display_control_slave_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //lcd_display_control_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign lcd_display_control_slave_slavearbiterlockenable2 = |lcd_display_control_slave_arb_share_counter_next_value;

  //cpu_0/data_master lcd_display/control_slave arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = lcd_display_control_slave_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //lcd_display_control_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  assign lcd_display_control_slave_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_lcd_display_control_slave = cpu_0_data_master_requests_lcd_display_control_slave;
  //lcd_display_control_slave_writedata mux, which is an e_mux
  assign lcd_display_control_slave_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_lcd_display_control_slave = cpu_0_data_master_qualified_request_lcd_display_control_slave;

  //cpu_0/data_master saved-grant lcd_display/control_slave, which is an e_assign
  assign cpu_0_data_master_saved_grant_lcd_display_control_slave = cpu_0_data_master_requests_lcd_display_control_slave;

  //allow new arb cycle for lcd_display/control_slave, which is an e_assign
  assign lcd_display_control_slave_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign lcd_display_control_slave_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign lcd_display_control_slave_master_qreq_vector = 1;

  assign lcd_display_control_slave_begintransfer = lcd_display_control_slave_begins_xfer;
  //lcd_display_control_slave_firsttransfer first transaction, which is an e_assign
  assign lcd_display_control_slave_firsttransfer = lcd_display_control_slave_begins_xfer ? lcd_display_control_slave_unreg_firsttransfer : lcd_display_control_slave_reg_firsttransfer;

  //lcd_display_control_slave_unreg_firsttransfer first transaction, which is an e_assign
  assign lcd_display_control_slave_unreg_firsttransfer = ~(lcd_display_control_slave_slavearbiterlockenable & lcd_display_control_slave_any_continuerequest);

  //lcd_display_control_slave_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          lcd_display_control_slave_reg_firsttransfer <= 1'b1;
      else if (lcd_display_control_slave_begins_xfer)
          lcd_display_control_slave_reg_firsttransfer <= lcd_display_control_slave_unreg_firsttransfer;
    end


  //lcd_display_control_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign lcd_display_control_slave_beginbursttransfer_internal = lcd_display_control_slave_begins_xfer;

  //lcd_display_control_slave_read assignment, which is an e_mux
  assign lcd_display_control_slave_read = ((cpu_0_data_master_granted_lcd_display_control_slave & cpu_0_data_master_read))& ~lcd_display_control_slave_begins_xfer & (lcd_display_control_slave_wait_counter < 13);

  //lcd_display_control_slave_write assignment, which is an e_mux
  assign lcd_display_control_slave_write = ((cpu_0_data_master_granted_lcd_display_control_slave & cpu_0_data_master_write)) & ~lcd_display_control_slave_begins_xfer & (lcd_display_control_slave_wait_counter >= 13) & (lcd_display_control_slave_wait_counter < 26) & lcd_display_control_slave_pretend_byte_enable;

  assign shifted_address_to_lcd_display_control_slave_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //lcd_display_control_slave_address mux, which is an e_mux
  assign lcd_display_control_slave_address = shifted_address_to_lcd_display_control_slave_from_cpu_0_data_master >> 2;

  //d1_lcd_display_control_slave_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_lcd_display_control_slave_end_xfer <= 1;
      else 
        d1_lcd_display_control_slave_end_xfer <= lcd_display_control_slave_end_xfer;
    end


  //lcd_display_control_slave_wait_counter_eq_1 assignment, which is an e_assign
  assign lcd_display_control_slave_wait_counter_eq_1 = lcd_display_control_slave_wait_counter == 1;

  //lcd_display_control_slave_waits_for_read in a cycle, which is an e_mux
  assign lcd_display_control_slave_waits_for_read = lcd_display_control_slave_in_a_read_cycle & wait_for_lcd_display_control_slave_counter;

  //lcd_display_control_slave_in_a_read_cycle assignment, which is an e_assign
  assign lcd_display_control_slave_in_a_read_cycle = cpu_0_data_master_granted_lcd_display_control_slave & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = lcd_display_control_slave_in_a_read_cycle;

  //lcd_display_control_slave_waits_for_write in a cycle, which is an e_mux
  assign lcd_display_control_slave_waits_for_write = lcd_display_control_slave_in_a_write_cycle & wait_for_lcd_display_control_slave_counter;

  //lcd_display_control_slave_in_a_write_cycle assignment, which is an e_assign
  assign lcd_display_control_slave_in_a_write_cycle = cpu_0_data_master_granted_lcd_display_control_slave & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = lcd_display_control_slave_in_a_write_cycle;

  assign lcd_display_control_slave_wait_counter_eq_0 = lcd_display_control_slave_wait_counter == 0;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          lcd_display_control_slave_wait_counter <= 0;
      else 
        lcd_display_control_slave_wait_counter <= lcd_display_control_slave_counter_load_value;
    end


  assign lcd_display_control_slave_counter_load_value = ((lcd_display_control_slave_in_a_write_cycle & lcd_display_control_slave_begins_xfer))? 37 :
    ((lcd_display_control_slave_in_a_read_cycle & lcd_display_control_slave_begins_xfer))? 24 :
    (~lcd_display_control_slave_wait_counter_eq_0)? lcd_display_control_slave_wait_counter - 1 :
    0;

  assign wait_for_lcd_display_control_slave_counter = lcd_display_control_slave_begins_xfer | ~lcd_display_control_slave_wait_counter_eq_0;
  //lcd_display_control_slave_pretend_byte_enable byte enable port mux, which is an e_mux
  assign lcd_display_control_slave_pretend_byte_enable = (cpu_0_data_master_granted_lcd_display_control_slave)? cpu_0_data_master_byteenable :
    -1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //lcd_display/control_slave enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module led_pio_s1_arbitrator (
                               // inputs:
                                clk,
                                cpu_0_data_master_address_to_slave,
                                cpu_0_data_master_byteenable,
                                cpu_0_data_master_read,
                                cpu_0_data_master_waitrequest,
                                cpu_0_data_master_write,
                                cpu_0_data_master_writedata,
                                led_pio_s1_readdata,
                                reset_n,

                               // outputs:
                                cpu_0_data_master_granted_led_pio_s1,
                                cpu_0_data_master_qualified_request_led_pio_s1,
                                cpu_0_data_master_read_data_valid_led_pio_s1,
                                cpu_0_data_master_requests_led_pio_s1,
                                d1_led_pio_s1_end_xfer,
                                led_pio_s1_address,
                                led_pio_s1_chipselect,
                                led_pio_s1_readdata_from_sa,
                                led_pio_s1_reset_n,
                                led_pio_s1_write_n,
                                led_pio_s1_writedata
                             )
;

  output           cpu_0_data_master_granted_led_pio_s1;
  output           cpu_0_data_master_qualified_request_led_pio_s1;
  output           cpu_0_data_master_read_data_valid_led_pio_s1;
  output           cpu_0_data_master_requests_led_pio_s1;
  output           d1_led_pio_s1_end_xfer;
  output  [  1: 0] led_pio_s1_address;
  output           led_pio_s1_chipselect;
  output  [  7: 0] led_pio_s1_readdata_from_sa;
  output           led_pio_s1_reset_n;
  output           led_pio_s1_write_n;
  output  [  7: 0] led_pio_s1_writedata;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input   [  3: 0] cpu_0_data_master_byteenable;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_waitrequest;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input   [  7: 0] led_pio_s1_readdata;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_led_pio_s1;
  wire             cpu_0_data_master_qualified_request_led_pio_s1;
  wire             cpu_0_data_master_read_data_valid_led_pio_s1;
  wire             cpu_0_data_master_requests_led_pio_s1;
  wire             cpu_0_data_master_saved_grant_led_pio_s1;
  reg              d1_led_pio_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_led_pio_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] led_pio_s1_address;
  wire             led_pio_s1_allgrants;
  wire             led_pio_s1_allow_new_arb_cycle;
  wire             led_pio_s1_any_bursting_master_saved_grant;
  wire             led_pio_s1_any_continuerequest;
  wire             led_pio_s1_arb_counter_enable;
  reg     [  1: 0] led_pio_s1_arb_share_counter;
  wire    [  1: 0] led_pio_s1_arb_share_counter_next_value;
  wire    [  1: 0] led_pio_s1_arb_share_set_values;
  wire             led_pio_s1_beginbursttransfer_internal;
  wire             led_pio_s1_begins_xfer;
  wire             led_pio_s1_chipselect;
  wire             led_pio_s1_end_xfer;
  wire             led_pio_s1_firsttransfer;
  wire             led_pio_s1_grant_vector;
  wire             led_pio_s1_in_a_read_cycle;
  wire             led_pio_s1_in_a_write_cycle;
  wire             led_pio_s1_master_qreq_vector;
  wire             led_pio_s1_non_bursting_master_requests;
  wire             led_pio_s1_pretend_byte_enable;
  wire    [  7: 0] led_pio_s1_readdata_from_sa;
  reg              led_pio_s1_reg_firsttransfer;
  wire             led_pio_s1_reset_n;
  reg              led_pio_s1_slavearbiterlockenable;
  wire             led_pio_s1_slavearbiterlockenable2;
  wire             led_pio_s1_unreg_firsttransfer;
  wire             led_pio_s1_waits_for_read;
  wire             led_pio_s1_waits_for_write;
  wire             led_pio_s1_write_n;
  wire    [  7: 0] led_pio_s1_writedata;
  wire    [ 24: 0] shifted_address_to_led_pio_s1_from_cpu_0_data_master;
  wire             wait_for_led_pio_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~led_pio_s1_end_xfer;
    end


  assign led_pio_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_led_pio_s1));
  //assign led_pio_s1_readdata_from_sa = led_pio_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign led_pio_s1_readdata_from_sa = led_pio_s1_readdata;

  assign cpu_0_data_master_requests_led_pio_s1 = ({cpu_0_data_master_address_to_slave[24 : 4] , 4'b0} == 25'h1001050) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //led_pio_s1_arb_share_counter set values, which is an e_mux
  assign led_pio_s1_arb_share_set_values = 1;

  //led_pio_s1_non_bursting_master_requests mux, which is an e_mux
  assign led_pio_s1_non_bursting_master_requests = cpu_0_data_master_requests_led_pio_s1;

  //led_pio_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign led_pio_s1_any_bursting_master_saved_grant = 0;

  //led_pio_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign led_pio_s1_arb_share_counter_next_value = led_pio_s1_firsttransfer ? (led_pio_s1_arb_share_set_values - 1) : |led_pio_s1_arb_share_counter ? (led_pio_s1_arb_share_counter - 1) : 0;

  //led_pio_s1_allgrants all slave grants, which is an e_mux
  assign led_pio_s1_allgrants = |led_pio_s1_grant_vector;

  //led_pio_s1_end_xfer assignment, which is an e_assign
  assign led_pio_s1_end_xfer = ~(led_pio_s1_waits_for_read | led_pio_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_led_pio_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_led_pio_s1 = led_pio_s1_end_xfer & (~led_pio_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //led_pio_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign led_pio_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_led_pio_s1 & led_pio_s1_allgrants) | (end_xfer_arb_share_counter_term_led_pio_s1 & ~led_pio_s1_non_bursting_master_requests);

  //led_pio_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          led_pio_s1_arb_share_counter <= 0;
      else if (led_pio_s1_arb_counter_enable)
          led_pio_s1_arb_share_counter <= led_pio_s1_arb_share_counter_next_value;
    end


  //led_pio_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          led_pio_s1_slavearbiterlockenable <= 0;
      else if ((|led_pio_s1_master_qreq_vector & end_xfer_arb_share_counter_term_led_pio_s1) | (end_xfer_arb_share_counter_term_led_pio_s1 & ~led_pio_s1_non_bursting_master_requests))
          led_pio_s1_slavearbiterlockenable <= |led_pio_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master led_pio/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = led_pio_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //led_pio_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign led_pio_s1_slavearbiterlockenable2 = |led_pio_s1_arb_share_counter_next_value;

  //cpu_0/data_master led_pio/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = led_pio_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //led_pio_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign led_pio_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_led_pio_s1 = cpu_0_data_master_requests_led_pio_s1 & ~(((~cpu_0_data_master_waitrequest) & cpu_0_data_master_write));
  //led_pio_s1_writedata mux, which is an e_mux
  assign led_pio_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_led_pio_s1 = cpu_0_data_master_qualified_request_led_pio_s1;

  //cpu_0/data_master saved-grant led_pio/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_led_pio_s1 = cpu_0_data_master_requests_led_pio_s1;

  //allow new arb cycle for led_pio/s1, which is an e_assign
  assign led_pio_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign led_pio_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign led_pio_s1_master_qreq_vector = 1;

  //led_pio_s1_reset_n assignment, which is an e_assign
  assign led_pio_s1_reset_n = reset_n;

  assign led_pio_s1_chipselect = cpu_0_data_master_granted_led_pio_s1;
  //led_pio_s1_firsttransfer first transaction, which is an e_assign
  assign led_pio_s1_firsttransfer = led_pio_s1_begins_xfer ? led_pio_s1_unreg_firsttransfer : led_pio_s1_reg_firsttransfer;

  //led_pio_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign led_pio_s1_unreg_firsttransfer = ~(led_pio_s1_slavearbiterlockenable & led_pio_s1_any_continuerequest);

  //led_pio_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          led_pio_s1_reg_firsttransfer <= 1'b1;
      else if (led_pio_s1_begins_xfer)
          led_pio_s1_reg_firsttransfer <= led_pio_s1_unreg_firsttransfer;
    end


  //led_pio_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign led_pio_s1_beginbursttransfer_internal = led_pio_s1_begins_xfer;

  //~led_pio_s1_write_n assignment, which is an e_mux
  assign led_pio_s1_write_n = ~(((cpu_0_data_master_granted_led_pio_s1 & cpu_0_data_master_write)) & led_pio_s1_pretend_byte_enable);

  assign shifted_address_to_led_pio_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //led_pio_s1_address mux, which is an e_mux
  assign led_pio_s1_address = shifted_address_to_led_pio_s1_from_cpu_0_data_master >> 2;

  //d1_led_pio_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_led_pio_s1_end_xfer <= 1;
      else 
        d1_led_pio_s1_end_xfer <= led_pio_s1_end_xfer;
    end


  //led_pio_s1_waits_for_read in a cycle, which is an e_mux
  assign led_pio_s1_waits_for_read = led_pio_s1_in_a_read_cycle & led_pio_s1_begins_xfer;

  //led_pio_s1_in_a_read_cycle assignment, which is an e_assign
  assign led_pio_s1_in_a_read_cycle = cpu_0_data_master_granted_led_pio_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = led_pio_s1_in_a_read_cycle;

  //led_pio_s1_waits_for_write in a cycle, which is an e_mux
  assign led_pio_s1_waits_for_write = led_pio_s1_in_a_write_cycle & 0;

  //led_pio_s1_in_a_write_cycle assignment, which is an e_assign
  assign led_pio_s1_in_a_write_cycle = cpu_0_data_master_granted_led_pio_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = led_pio_s1_in_a_write_cycle;

  assign wait_for_led_pio_s1_counter = 0;
  //led_pio_s1_pretend_byte_enable byte enable port mux, which is an e_mux
  assign led_pio_s1_pretend_byte_enable = (cpu_0_data_master_granted_led_pio_s1)? cpu_0_data_master_byteenable :
    -1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //led_pio/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module pio_dutycycle_s1_arbitrator (
                                     // inputs:
                                      clk,
                                      cpu_0_data_master_address_to_slave,
                                      cpu_0_data_master_read,
                                      cpu_0_data_master_waitrequest,
                                      cpu_0_data_master_write,
                                      cpu_0_data_master_writedata,
                                      pio_dutycycle_s1_readdata,
                                      reset_n,

                                     // outputs:
                                      cpu_0_data_master_granted_pio_dutycycle_s1,
                                      cpu_0_data_master_qualified_request_pio_dutycycle_s1,
                                      cpu_0_data_master_read_data_valid_pio_dutycycle_s1,
                                      cpu_0_data_master_requests_pio_dutycycle_s1,
                                      d1_pio_dutycycle_s1_end_xfer,
                                      pio_dutycycle_s1_address,
                                      pio_dutycycle_s1_chipselect,
                                      pio_dutycycle_s1_readdata_from_sa,
                                      pio_dutycycle_s1_reset_n,
                                      pio_dutycycle_s1_write_n,
                                      pio_dutycycle_s1_writedata
                                   )
;

  output           cpu_0_data_master_granted_pio_dutycycle_s1;
  output           cpu_0_data_master_qualified_request_pio_dutycycle_s1;
  output           cpu_0_data_master_read_data_valid_pio_dutycycle_s1;
  output           cpu_0_data_master_requests_pio_dutycycle_s1;
  output           d1_pio_dutycycle_s1_end_xfer;
  output  [  1: 0] pio_dutycycle_s1_address;
  output           pio_dutycycle_s1_chipselect;
  output  [  3: 0] pio_dutycycle_s1_readdata_from_sa;
  output           pio_dutycycle_s1_reset_n;
  output           pio_dutycycle_s1_write_n;
  output  [  3: 0] pio_dutycycle_s1_writedata;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_waitrequest;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input   [  3: 0] pio_dutycycle_s1_readdata;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_pio_dutycycle_s1;
  wire             cpu_0_data_master_qualified_request_pio_dutycycle_s1;
  wire             cpu_0_data_master_read_data_valid_pio_dutycycle_s1;
  wire             cpu_0_data_master_requests_pio_dutycycle_s1;
  wire             cpu_0_data_master_saved_grant_pio_dutycycle_s1;
  reg              d1_pio_dutycycle_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_pio_dutycycle_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] pio_dutycycle_s1_address;
  wire             pio_dutycycle_s1_allgrants;
  wire             pio_dutycycle_s1_allow_new_arb_cycle;
  wire             pio_dutycycle_s1_any_bursting_master_saved_grant;
  wire             pio_dutycycle_s1_any_continuerequest;
  wire             pio_dutycycle_s1_arb_counter_enable;
  reg     [  1: 0] pio_dutycycle_s1_arb_share_counter;
  wire    [  1: 0] pio_dutycycle_s1_arb_share_counter_next_value;
  wire    [  1: 0] pio_dutycycle_s1_arb_share_set_values;
  wire             pio_dutycycle_s1_beginbursttransfer_internal;
  wire             pio_dutycycle_s1_begins_xfer;
  wire             pio_dutycycle_s1_chipselect;
  wire             pio_dutycycle_s1_end_xfer;
  wire             pio_dutycycle_s1_firsttransfer;
  wire             pio_dutycycle_s1_grant_vector;
  wire             pio_dutycycle_s1_in_a_read_cycle;
  wire             pio_dutycycle_s1_in_a_write_cycle;
  wire             pio_dutycycle_s1_master_qreq_vector;
  wire             pio_dutycycle_s1_non_bursting_master_requests;
  wire    [  3: 0] pio_dutycycle_s1_readdata_from_sa;
  reg              pio_dutycycle_s1_reg_firsttransfer;
  wire             pio_dutycycle_s1_reset_n;
  reg              pio_dutycycle_s1_slavearbiterlockenable;
  wire             pio_dutycycle_s1_slavearbiterlockenable2;
  wire             pio_dutycycle_s1_unreg_firsttransfer;
  wire             pio_dutycycle_s1_waits_for_read;
  wire             pio_dutycycle_s1_waits_for_write;
  wire             pio_dutycycle_s1_write_n;
  wire    [  3: 0] pio_dutycycle_s1_writedata;
  wire    [ 24: 0] shifted_address_to_pio_dutycycle_s1_from_cpu_0_data_master;
  wire             wait_for_pio_dutycycle_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~pio_dutycycle_s1_end_xfer;
    end


  assign pio_dutycycle_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_pio_dutycycle_s1));
  //assign pio_dutycycle_s1_readdata_from_sa = pio_dutycycle_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign pio_dutycycle_s1_readdata_from_sa = pio_dutycycle_s1_readdata;

  assign cpu_0_data_master_requests_pio_dutycycle_s1 = ({cpu_0_data_master_address_to_slave[24 : 4] , 4'b0} == 25'h1001100) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //pio_dutycycle_s1_arb_share_counter set values, which is an e_mux
  assign pio_dutycycle_s1_arb_share_set_values = 1;

  //pio_dutycycle_s1_non_bursting_master_requests mux, which is an e_mux
  assign pio_dutycycle_s1_non_bursting_master_requests = cpu_0_data_master_requests_pio_dutycycle_s1;

  //pio_dutycycle_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign pio_dutycycle_s1_any_bursting_master_saved_grant = 0;

  //pio_dutycycle_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign pio_dutycycle_s1_arb_share_counter_next_value = pio_dutycycle_s1_firsttransfer ? (pio_dutycycle_s1_arb_share_set_values - 1) : |pio_dutycycle_s1_arb_share_counter ? (pio_dutycycle_s1_arb_share_counter - 1) : 0;

  //pio_dutycycle_s1_allgrants all slave grants, which is an e_mux
  assign pio_dutycycle_s1_allgrants = |pio_dutycycle_s1_grant_vector;

  //pio_dutycycle_s1_end_xfer assignment, which is an e_assign
  assign pio_dutycycle_s1_end_xfer = ~(pio_dutycycle_s1_waits_for_read | pio_dutycycle_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_pio_dutycycle_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_pio_dutycycle_s1 = pio_dutycycle_s1_end_xfer & (~pio_dutycycle_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //pio_dutycycle_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign pio_dutycycle_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_pio_dutycycle_s1 & pio_dutycycle_s1_allgrants) | (end_xfer_arb_share_counter_term_pio_dutycycle_s1 & ~pio_dutycycle_s1_non_bursting_master_requests);

  //pio_dutycycle_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_dutycycle_s1_arb_share_counter <= 0;
      else if (pio_dutycycle_s1_arb_counter_enable)
          pio_dutycycle_s1_arb_share_counter <= pio_dutycycle_s1_arb_share_counter_next_value;
    end


  //pio_dutycycle_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_dutycycle_s1_slavearbiterlockenable <= 0;
      else if ((|pio_dutycycle_s1_master_qreq_vector & end_xfer_arb_share_counter_term_pio_dutycycle_s1) | (end_xfer_arb_share_counter_term_pio_dutycycle_s1 & ~pio_dutycycle_s1_non_bursting_master_requests))
          pio_dutycycle_s1_slavearbiterlockenable <= |pio_dutycycle_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master pio_dutycycle/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = pio_dutycycle_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //pio_dutycycle_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign pio_dutycycle_s1_slavearbiterlockenable2 = |pio_dutycycle_s1_arb_share_counter_next_value;

  //cpu_0/data_master pio_dutycycle/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = pio_dutycycle_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //pio_dutycycle_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign pio_dutycycle_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_pio_dutycycle_s1 = cpu_0_data_master_requests_pio_dutycycle_s1 & ~(((~cpu_0_data_master_waitrequest) & cpu_0_data_master_write));
  //pio_dutycycle_s1_writedata mux, which is an e_mux
  assign pio_dutycycle_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_pio_dutycycle_s1 = cpu_0_data_master_qualified_request_pio_dutycycle_s1;

  //cpu_0/data_master saved-grant pio_dutycycle/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_pio_dutycycle_s1 = cpu_0_data_master_requests_pio_dutycycle_s1;

  //allow new arb cycle for pio_dutycycle/s1, which is an e_assign
  assign pio_dutycycle_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign pio_dutycycle_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign pio_dutycycle_s1_master_qreq_vector = 1;

  //pio_dutycycle_s1_reset_n assignment, which is an e_assign
  assign pio_dutycycle_s1_reset_n = reset_n;

  assign pio_dutycycle_s1_chipselect = cpu_0_data_master_granted_pio_dutycycle_s1;
  //pio_dutycycle_s1_firsttransfer first transaction, which is an e_assign
  assign pio_dutycycle_s1_firsttransfer = pio_dutycycle_s1_begins_xfer ? pio_dutycycle_s1_unreg_firsttransfer : pio_dutycycle_s1_reg_firsttransfer;

  //pio_dutycycle_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign pio_dutycycle_s1_unreg_firsttransfer = ~(pio_dutycycle_s1_slavearbiterlockenable & pio_dutycycle_s1_any_continuerequest);

  //pio_dutycycle_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_dutycycle_s1_reg_firsttransfer <= 1'b1;
      else if (pio_dutycycle_s1_begins_xfer)
          pio_dutycycle_s1_reg_firsttransfer <= pio_dutycycle_s1_unreg_firsttransfer;
    end


  //pio_dutycycle_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign pio_dutycycle_s1_beginbursttransfer_internal = pio_dutycycle_s1_begins_xfer;

  //~pio_dutycycle_s1_write_n assignment, which is an e_mux
  assign pio_dutycycle_s1_write_n = ~(cpu_0_data_master_granted_pio_dutycycle_s1 & cpu_0_data_master_write);

  assign shifted_address_to_pio_dutycycle_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //pio_dutycycle_s1_address mux, which is an e_mux
  assign pio_dutycycle_s1_address = shifted_address_to_pio_dutycycle_s1_from_cpu_0_data_master >> 2;

  //d1_pio_dutycycle_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_pio_dutycycle_s1_end_xfer <= 1;
      else 
        d1_pio_dutycycle_s1_end_xfer <= pio_dutycycle_s1_end_xfer;
    end


  //pio_dutycycle_s1_waits_for_read in a cycle, which is an e_mux
  assign pio_dutycycle_s1_waits_for_read = pio_dutycycle_s1_in_a_read_cycle & pio_dutycycle_s1_begins_xfer;

  //pio_dutycycle_s1_in_a_read_cycle assignment, which is an e_assign
  assign pio_dutycycle_s1_in_a_read_cycle = cpu_0_data_master_granted_pio_dutycycle_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = pio_dutycycle_s1_in_a_read_cycle;

  //pio_dutycycle_s1_waits_for_write in a cycle, which is an e_mux
  assign pio_dutycycle_s1_waits_for_write = pio_dutycycle_s1_in_a_write_cycle & 0;

  //pio_dutycycle_s1_in_a_write_cycle assignment, which is an e_assign
  assign pio_dutycycle_s1_in_a_write_cycle = cpu_0_data_master_granted_pio_dutycycle_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = pio_dutycycle_s1_in_a_write_cycle;

  assign wait_for_pio_dutycycle_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //pio_dutycycle/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module pio_egmenable_s1_arbitrator (
                                     // inputs:
                                      clk,
                                      cpu_0_data_master_address_to_slave,
                                      cpu_0_data_master_read,
                                      cpu_0_data_master_waitrequest,
                                      cpu_0_data_master_write,
                                      cpu_0_data_master_writedata,
                                      pio_egmenable_s1_readdata,
                                      reset_n,

                                     // outputs:
                                      cpu_0_data_master_granted_pio_egmenable_s1,
                                      cpu_0_data_master_qualified_request_pio_egmenable_s1,
                                      cpu_0_data_master_read_data_valid_pio_egmenable_s1,
                                      cpu_0_data_master_requests_pio_egmenable_s1,
                                      d1_pio_egmenable_s1_end_xfer,
                                      pio_egmenable_s1_address,
                                      pio_egmenable_s1_chipselect,
                                      pio_egmenable_s1_readdata_from_sa,
                                      pio_egmenable_s1_reset_n,
                                      pio_egmenable_s1_write_n,
                                      pio_egmenable_s1_writedata
                                   )
;

  output           cpu_0_data_master_granted_pio_egmenable_s1;
  output           cpu_0_data_master_qualified_request_pio_egmenable_s1;
  output           cpu_0_data_master_read_data_valid_pio_egmenable_s1;
  output           cpu_0_data_master_requests_pio_egmenable_s1;
  output           d1_pio_egmenable_s1_end_xfer;
  output  [  1: 0] pio_egmenable_s1_address;
  output           pio_egmenable_s1_chipselect;
  output           pio_egmenable_s1_readdata_from_sa;
  output           pio_egmenable_s1_reset_n;
  output           pio_egmenable_s1_write_n;
  output           pio_egmenable_s1_writedata;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_waitrequest;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            pio_egmenable_s1_readdata;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_pio_egmenable_s1;
  wire             cpu_0_data_master_qualified_request_pio_egmenable_s1;
  wire             cpu_0_data_master_read_data_valid_pio_egmenable_s1;
  wire             cpu_0_data_master_requests_pio_egmenable_s1;
  wire             cpu_0_data_master_saved_grant_pio_egmenable_s1;
  reg              d1_pio_egmenable_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_pio_egmenable_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] pio_egmenable_s1_address;
  wire             pio_egmenable_s1_allgrants;
  wire             pio_egmenable_s1_allow_new_arb_cycle;
  wire             pio_egmenable_s1_any_bursting_master_saved_grant;
  wire             pio_egmenable_s1_any_continuerequest;
  wire             pio_egmenable_s1_arb_counter_enable;
  reg     [  1: 0] pio_egmenable_s1_arb_share_counter;
  wire    [  1: 0] pio_egmenable_s1_arb_share_counter_next_value;
  wire    [  1: 0] pio_egmenable_s1_arb_share_set_values;
  wire             pio_egmenable_s1_beginbursttransfer_internal;
  wire             pio_egmenable_s1_begins_xfer;
  wire             pio_egmenable_s1_chipselect;
  wire             pio_egmenable_s1_end_xfer;
  wire             pio_egmenable_s1_firsttransfer;
  wire             pio_egmenable_s1_grant_vector;
  wire             pio_egmenable_s1_in_a_read_cycle;
  wire             pio_egmenable_s1_in_a_write_cycle;
  wire             pio_egmenable_s1_master_qreq_vector;
  wire             pio_egmenable_s1_non_bursting_master_requests;
  wire             pio_egmenable_s1_readdata_from_sa;
  reg              pio_egmenable_s1_reg_firsttransfer;
  wire             pio_egmenable_s1_reset_n;
  reg              pio_egmenable_s1_slavearbiterlockenable;
  wire             pio_egmenable_s1_slavearbiterlockenable2;
  wire             pio_egmenable_s1_unreg_firsttransfer;
  wire             pio_egmenable_s1_waits_for_read;
  wire             pio_egmenable_s1_waits_for_write;
  wire             pio_egmenable_s1_write_n;
  wire             pio_egmenable_s1_writedata;
  wire    [ 24: 0] shifted_address_to_pio_egmenable_s1_from_cpu_0_data_master;
  wire             wait_for_pio_egmenable_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~pio_egmenable_s1_end_xfer;
    end


  assign pio_egmenable_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_pio_egmenable_s1));
  //assign pio_egmenable_s1_readdata_from_sa = pio_egmenable_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign pio_egmenable_s1_readdata_from_sa = pio_egmenable_s1_readdata;

  assign cpu_0_data_master_requests_pio_egmenable_s1 = ({cpu_0_data_master_address_to_slave[24 : 4] , 4'b0} == 25'h1001130) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //pio_egmenable_s1_arb_share_counter set values, which is an e_mux
  assign pio_egmenable_s1_arb_share_set_values = 1;

  //pio_egmenable_s1_non_bursting_master_requests mux, which is an e_mux
  assign pio_egmenable_s1_non_bursting_master_requests = cpu_0_data_master_requests_pio_egmenable_s1;

  //pio_egmenable_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign pio_egmenable_s1_any_bursting_master_saved_grant = 0;

  //pio_egmenable_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign pio_egmenable_s1_arb_share_counter_next_value = pio_egmenable_s1_firsttransfer ? (pio_egmenable_s1_arb_share_set_values - 1) : |pio_egmenable_s1_arb_share_counter ? (pio_egmenable_s1_arb_share_counter - 1) : 0;

  //pio_egmenable_s1_allgrants all slave grants, which is an e_mux
  assign pio_egmenable_s1_allgrants = |pio_egmenable_s1_grant_vector;

  //pio_egmenable_s1_end_xfer assignment, which is an e_assign
  assign pio_egmenable_s1_end_xfer = ~(pio_egmenable_s1_waits_for_read | pio_egmenable_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_pio_egmenable_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_pio_egmenable_s1 = pio_egmenable_s1_end_xfer & (~pio_egmenable_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //pio_egmenable_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign pio_egmenable_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_pio_egmenable_s1 & pio_egmenable_s1_allgrants) | (end_xfer_arb_share_counter_term_pio_egmenable_s1 & ~pio_egmenable_s1_non_bursting_master_requests);

  //pio_egmenable_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_egmenable_s1_arb_share_counter <= 0;
      else if (pio_egmenable_s1_arb_counter_enable)
          pio_egmenable_s1_arb_share_counter <= pio_egmenable_s1_arb_share_counter_next_value;
    end


  //pio_egmenable_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_egmenable_s1_slavearbiterlockenable <= 0;
      else if ((|pio_egmenable_s1_master_qreq_vector & end_xfer_arb_share_counter_term_pio_egmenable_s1) | (end_xfer_arb_share_counter_term_pio_egmenable_s1 & ~pio_egmenable_s1_non_bursting_master_requests))
          pio_egmenable_s1_slavearbiterlockenable <= |pio_egmenable_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master pio_egmenable/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = pio_egmenable_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //pio_egmenable_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign pio_egmenable_s1_slavearbiterlockenable2 = |pio_egmenable_s1_arb_share_counter_next_value;

  //cpu_0/data_master pio_egmenable/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = pio_egmenable_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //pio_egmenable_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign pio_egmenable_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_pio_egmenable_s1 = cpu_0_data_master_requests_pio_egmenable_s1 & ~(((~cpu_0_data_master_waitrequest) & cpu_0_data_master_write));
  //pio_egmenable_s1_writedata mux, which is an e_mux
  assign pio_egmenable_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_pio_egmenable_s1 = cpu_0_data_master_qualified_request_pio_egmenable_s1;

  //cpu_0/data_master saved-grant pio_egmenable/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_pio_egmenable_s1 = cpu_0_data_master_requests_pio_egmenable_s1;

  //allow new arb cycle for pio_egmenable/s1, which is an e_assign
  assign pio_egmenable_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign pio_egmenable_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign pio_egmenable_s1_master_qreq_vector = 1;

  //pio_egmenable_s1_reset_n assignment, which is an e_assign
  assign pio_egmenable_s1_reset_n = reset_n;

  assign pio_egmenable_s1_chipselect = cpu_0_data_master_granted_pio_egmenable_s1;
  //pio_egmenable_s1_firsttransfer first transaction, which is an e_assign
  assign pio_egmenable_s1_firsttransfer = pio_egmenable_s1_begins_xfer ? pio_egmenable_s1_unreg_firsttransfer : pio_egmenable_s1_reg_firsttransfer;

  //pio_egmenable_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign pio_egmenable_s1_unreg_firsttransfer = ~(pio_egmenable_s1_slavearbiterlockenable & pio_egmenable_s1_any_continuerequest);

  //pio_egmenable_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_egmenable_s1_reg_firsttransfer <= 1'b1;
      else if (pio_egmenable_s1_begins_xfer)
          pio_egmenable_s1_reg_firsttransfer <= pio_egmenable_s1_unreg_firsttransfer;
    end


  //pio_egmenable_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign pio_egmenable_s1_beginbursttransfer_internal = pio_egmenable_s1_begins_xfer;

  //~pio_egmenable_s1_write_n assignment, which is an e_mux
  assign pio_egmenable_s1_write_n = ~(cpu_0_data_master_granted_pio_egmenable_s1 & cpu_0_data_master_write);

  assign shifted_address_to_pio_egmenable_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //pio_egmenable_s1_address mux, which is an e_mux
  assign pio_egmenable_s1_address = shifted_address_to_pio_egmenable_s1_from_cpu_0_data_master >> 2;

  //d1_pio_egmenable_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_pio_egmenable_s1_end_xfer <= 1;
      else 
        d1_pio_egmenable_s1_end_xfer <= pio_egmenable_s1_end_xfer;
    end


  //pio_egmenable_s1_waits_for_read in a cycle, which is an e_mux
  assign pio_egmenable_s1_waits_for_read = pio_egmenable_s1_in_a_read_cycle & pio_egmenable_s1_begins_xfer;

  //pio_egmenable_s1_in_a_read_cycle assignment, which is an e_assign
  assign pio_egmenable_s1_in_a_read_cycle = cpu_0_data_master_granted_pio_egmenable_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = pio_egmenable_s1_in_a_read_cycle;

  //pio_egmenable_s1_waits_for_write in a cycle, which is an e_mux
  assign pio_egmenable_s1_waits_for_write = pio_egmenable_s1_in_a_write_cycle & 0;

  //pio_egmenable_s1_in_a_write_cycle assignment, which is an e_assign
  assign pio_egmenable_s1_in_a_write_cycle = cpu_0_data_master_granted_pio_egmenable_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = pio_egmenable_s1_in_a_write_cycle;

  assign wait_for_pio_egmenable_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //pio_egmenable/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module pio_egmreset_s1_arbitrator (
                                    // inputs:
                                     clk,
                                     cpu_0_data_master_address_to_slave,
                                     cpu_0_data_master_read,
                                     cpu_0_data_master_waitrequest,
                                     cpu_0_data_master_write,
                                     cpu_0_data_master_writedata,
                                     pio_egmreset_s1_readdata,
                                     reset_n,

                                    // outputs:
                                     cpu_0_data_master_granted_pio_egmreset_s1,
                                     cpu_0_data_master_qualified_request_pio_egmreset_s1,
                                     cpu_0_data_master_read_data_valid_pio_egmreset_s1,
                                     cpu_0_data_master_requests_pio_egmreset_s1,
                                     d1_pio_egmreset_s1_end_xfer,
                                     pio_egmreset_s1_address,
                                     pio_egmreset_s1_chipselect,
                                     pio_egmreset_s1_readdata_from_sa,
                                     pio_egmreset_s1_reset_n,
                                     pio_egmreset_s1_write_n,
                                     pio_egmreset_s1_writedata
                                  )
;

  output           cpu_0_data_master_granted_pio_egmreset_s1;
  output           cpu_0_data_master_qualified_request_pio_egmreset_s1;
  output           cpu_0_data_master_read_data_valid_pio_egmreset_s1;
  output           cpu_0_data_master_requests_pio_egmreset_s1;
  output           d1_pio_egmreset_s1_end_xfer;
  output  [  1: 0] pio_egmreset_s1_address;
  output           pio_egmreset_s1_chipselect;
  output           pio_egmreset_s1_readdata_from_sa;
  output           pio_egmreset_s1_reset_n;
  output           pio_egmreset_s1_write_n;
  output           pio_egmreset_s1_writedata;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_waitrequest;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            pio_egmreset_s1_readdata;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_pio_egmreset_s1;
  wire             cpu_0_data_master_qualified_request_pio_egmreset_s1;
  wire             cpu_0_data_master_read_data_valid_pio_egmreset_s1;
  wire             cpu_0_data_master_requests_pio_egmreset_s1;
  wire             cpu_0_data_master_saved_grant_pio_egmreset_s1;
  reg              d1_pio_egmreset_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_pio_egmreset_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] pio_egmreset_s1_address;
  wire             pio_egmreset_s1_allgrants;
  wire             pio_egmreset_s1_allow_new_arb_cycle;
  wire             pio_egmreset_s1_any_bursting_master_saved_grant;
  wire             pio_egmreset_s1_any_continuerequest;
  wire             pio_egmreset_s1_arb_counter_enable;
  reg     [  1: 0] pio_egmreset_s1_arb_share_counter;
  wire    [  1: 0] pio_egmreset_s1_arb_share_counter_next_value;
  wire    [  1: 0] pio_egmreset_s1_arb_share_set_values;
  wire             pio_egmreset_s1_beginbursttransfer_internal;
  wire             pio_egmreset_s1_begins_xfer;
  wire             pio_egmreset_s1_chipselect;
  wire             pio_egmreset_s1_end_xfer;
  wire             pio_egmreset_s1_firsttransfer;
  wire             pio_egmreset_s1_grant_vector;
  wire             pio_egmreset_s1_in_a_read_cycle;
  wire             pio_egmreset_s1_in_a_write_cycle;
  wire             pio_egmreset_s1_master_qreq_vector;
  wire             pio_egmreset_s1_non_bursting_master_requests;
  wire             pio_egmreset_s1_readdata_from_sa;
  reg              pio_egmreset_s1_reg_firsttransfer;
  wire             pio_egmreset_s1_reset_n;
  reg              pio_egmreset_s1_slavearbiterlockenable;
  wire             pio_egmreset_s1_slavearbiterlockenable2;
  wire             pio_egmreset_s1_unreg_firsttransfer;
  wire             pio_egmreset_s1_waits_for_read;
  wire             pio_egmreset_s1_waits_for_write;
  wire             pio_egmreset_s1_write_n;
  wire             pio_egmreset_s1_writedata;
  wire    [ 24: 0] shifted_address_to_pio_egmreset_s1_from_cpu_0_data_master;
  wire             wait_for_pio_egmreset_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~pio_egmreset_s1_end_xfer;
    end


  assign pio_egmreset_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_pio_egmreset_s1));
  //assign pio_egmreset_s1_readdata_from_sa = pio_egmreset_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign pio_egmreset_s1_readdata_from_sa = pio_egmreset_s1_readdata;

  assign cpu_0_data_master_requests_pio_egmreset_s1 = ({cpu_0_data_master_address_to_slave[24 : 4] , 4'b0} == 25'h1001140) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //pio_egmreset_s1_arb_share_counter set values, which is an e_mux
  assign pio_egmreset_s1_arb_share_set_values = 1;

  //pio_egmreset_s1_non_bursting_master_requests mux, which is an e_mux
  assign pio_egmreset_s1_non_bursting_master_requests = cpu_0_data_master_requests_pio_egmreset_s1;

  //pio_egmreset_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign pio_egmreset_s1_any_bursting_master_saved_grant = 0;

  //pio_egmreset_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign pio_egmreset_s1_arb_share_counter_next_value = pio_egmreset_s1_firsttransfer ? (pio_egmreset_s1_arb_share_set_values - 1) : |pio_egmreset_s1_arb_share_counter ? (pio_egmreset_s1_arb_share_counter - 1) : 0;

  //pio_egmreset_s1_allgrants all slave grants, which is an e_mux
  assign pio_egmreset_s1_allgrants = |pio_egmreset_s1_grant_vector;

  //pio_egmreset_s1_end_xfer assignment, which is an e_assign
  assign pio_egmreset_s1_end_xfer = ~(pio_egmreset_s1_waits_for_read | pio_egmreset_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_pio_egmreset_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_pio_egmreset_s1 = pio_egmreset_s1_end_xfer & (~pio_egmreset_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //pio_egmreset_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign pio_egmreset_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_pio_egmreset_s1 & pio_egmreset_s1_allgrants) | (end_xfer_arb_share_counter_term_pio_egmreset_s1 & ~pio_egmreset_s1_non_bursting_master_requests);

  //pio_egmreset_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_egmreset_s1_arb_share_counter <= 0;
      else if (pio_egmreset_s1_arb_counter_enable)
          pio_egmreset_s1_arb_share_counter <= pio_egmreset_s1_arb_share_counter_next_value;
    end


  //pio_egmreset_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_egmreset_s1_slavearbiterlockenable <= 0;
      else if ((|pio_egmreset_s1_master_qreq_vector & end_xfer_arb_share_counter_term_pio_egmreset_s1) | (end_xfer_arb_share_counter_term_pio_egmreset_s1 & ~pio_egmreset_s1_non_bursting_master_requests))
          pio_egmreset_s1_slavearbiterlockenable <= |pio_egmreset_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master pio_egmreset/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = pio_egmreset_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //pio_egmreset_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign pio_egmreset_s1_slavearbiterlockenable2 = |pio_egmreset_s1_arb_share_counter_next_value;

  //cpu_0/data_master pio_egmreset/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = pio_egmreset_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //pio_egmreset_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign pio_egmreset_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_pio_egmreset_s1 = cpu_0_data_master_requests_pio_egmreset_s1 & ~(((~cpu_0_data_master_waitrequest) & cpu_0_data_master_write));
  //pio_egmreset_s1_writedata mux, which is an e_mux
  assign pio_egmreset_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_pio_egmreset_s1 = cpu_0_data_master_qualified_request_pio_egmreset_s1;

  //cpu_0/data_master saved-grant pio_egmreset/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_pio_egmreset_s1 = cpu_0_data_master_requests_pio_egmreset_s1;

  //allow new arb cycle for pio_egmreset/s1, which is an e_assign
  assign pio_egmreset_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign pio_egmreset_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign pio_egmreset_s1_master_qreq_vector = 1;

  //pio_egmreset_s1_reset_n assignment, which is an e_assign
  assign pio_egmreset_s1_reset_n = reset_n;

  assign pio_egmreset_s1_chipselect = cpu_0_data_master_granted_pio_egmreset_s1;
  //pio_egmreset_s1_firsttransfer first transaction, which is an e_assign
  assign pio_egmreset_s1_firsttransfer = pio_egmreset_s1_begins_xfer ? pio_egmreset_s1_unreg_firsttransfer : pio_egmreset_s1_reg_firsttransfer;

  //pio_egmreset_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign pio_egmreset_s1_unreg_firsttransfer = ~(pio_egmreset_s1_slavearbiterlockenable & pio_egmreset_s1_any_continuerequest);

  //pio_egmreset_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_egmreset_s1_reg_firsttransfer <= 1'b1;
      else if (pio_egmreset_s1_begins_xfer)
          pio_egmreset_s1_reg_firsttransfer <= pio_egmreset_s1_unreg_firsttransfer;
    end


  //pio_egmreset_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign pio_egmreset_s1_beginbursttransfer_internal = pio_egmreset_s1_begins_xfer;

  //~pio_egmreset_s1_write_n assignment, which is an e_mux
  assign pio_egmreset_s1_write_n = ~(cpu_0_data_master_granted_pio_egmreset_s1 & cpu_0_data_master_write);

  assign shifted_address_to_pio_egmreset_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //pio_egmreset_s1_address mux, which is an e_mux
  assign pio_egmreset_s1_address = shifted_address_to_pio_egmreset_s1_from_cpu_0_data_master >> 2;

  //d1_pio_egmreset_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_pio_egmreset_s1_end_xfer <= 1;
      else 
        d1_pio_egmreset_s1_end_xfer <= pio_egmreset_s1_end_xfer;
    end


  //pio_egmreset_s1_waits_for_read in a cycle, which is an e_mux
  assign pio_egmreset_s1_waits_for_read = pio_egmreset_s1_in_a_read_cycle & pio_egmreset_s1_begins_xfer;

  //pio_egmreset_s1_in_a_read_cycle assignment, which is an e_assign
  assign pio_egmreset_s1_in_a_read_cycle = cpu_0_data_master_granted_pio_egmreset_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = pio_egmreset_s1_in_a_read_cycle;

  //pio_egmreset_s1_waits_for_write in a cycle, which is an e_mux
  assign pio_egmreset_s1_waits_for_write = pio_egmreset_s1_in_a_write_cycle & 0;

  //pio_egmreset_s1_in_a_write_cycle assignment, which is an e_assign
  assign pio_egmreset_s1_in_a_write_cycle = cpu_0_data_master_granted_pio_egmreset_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = pio_egmreset_s1_in_a_write_cycle;

  assign wait_for_pio_egmreset_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //pio_egmreset/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module pio_latency_s1_arbitrator (
                                   // inputs:
                                    clk,
                                    cpu_0_data_master_address_to_slave,
                                    cpu_0_data_master_read,
                                    cpu_0_data_master_write,
                                    pio_latency_s1_readdata,
                                    reset_n,

                                   // outputs:
                                    cpu_0_data_master_granted_pio_latency_s1,
                                    cpu_0_data_master_qualified_request_pio_latency_s1,
                                    cpu_0_data_master_read_data_valid_pio_latency_s1,
                                    cpu_0_data_master_requests_pio_latency_s1,
                                    d1_pio_latency_s1_end_xfer,
                                    pio_latency_s1_address,
                                    pio_latency_s1_readdata_from_sa,
                                    pio_latency_s1_reset_n
                                 )
;

  output           cpu_0_data_master_granted_pio_latency_s1;
  output           cpu_0_data_master_qualified_request_pio_latency_s1;
  output           cpu_0_data_master_read_data_valid_pio_latency_s1;
  output           cpu_0_data_master_requests_pio_latency_s1;
  output           d1_pio_latency_s1_end_xfer;
  output  [  1: 0] pio_latency_s1_address;
  output  [ 15: 0] pio_latency_s1_readdata_from_sa;
  output           pio_latency_s1_reset_n;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input   [ 15: 0] pio_latency_s1_readdata;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_pio_latency_s1;
  wire             cpu_0_data_master_qualified_request_pio_latency_s1;
  wire             cpu_0_data_master_read_data_valid_pio_latency_s1;
  wire             cpu_0_data_master_requests_pio_latency_s1;
  wire             cpu_0_data_master_saved_grant_pio_latency_s1;
  reg              d1_pio_latency_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_pio_latency_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] pio_latency_s1_address;
  wire             pio_latency_s1_allgrants;
  wire             pio_latency_s1_allow_new_arb_cycle;
  wire             pio_latency_s1_any_bursting_master_saved_grant;
  wire             pio_latency_s1_any_continuerequest;
  wire             pio_latency_s1_arb_counter_enable;
  reg     [  1: 0] pio_latency_s1_arb_share_counter;
  wire    [  1: 0] pio_latency_s1_arb_share_counter_next_value;
  wire    [  1: 0] pio_latency_s1_arb_share_set_values;
  wire             pio_latency_s1_beginbursttransfer_internal;
  wire             pio_latency_s1_begins_xfer;
  wire             pio_latency_s1_end_xfer;
  wire             pio_latency_s1_firsttransfer;
  wire             pio_latency_s1_grant_vector;
  wire             pio_latency_s1_in_a_read_cycle;
  wire             pio_latency_s1_in_a_write_cycle;
  wire             pio_latency_s1_master_qreq_vector;
  wire             pio_latency_s1_non_bursting_master_requests;
  wire    [ 15: 0] pio_latency_s1_readdata_from_sa;
  reg              pio_latency_s1_reg_firsttransfer;
  wire             pio_latency_s1_reset_n;
  reg              pio_latency_s1_slavearbiterlockenable;
  wire             pio_latency_s1_slavearbiterlockenable2;
  wire             pio_latency_s1_unreg_firsttransfer;
  wire             pio_latency_s1_waits_for_read;
  wire             pio_latency_s1_waits_for_write;
  wire    [ 24: 0] shifted_address_to_pio_latency_s1_from_cpu_0_data_master;
  wire             wait_for_pio_latency_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~pio_latency_s1_end_xfer;
    end


  assign pio_latency_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_pio_latency_s1));
  //assign pio_latency_s1_readdata_from_sa = pio_latency_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign pio_latency_s1_readdata_from_sa = pio_latency_s1_readdata;

  assign cpu_0_data_master_requests_pio_latency_s1 = (({cpu_0_data_master_address_to_slave[24 : 4] , 4'b0} == 25'h10010e0) & (cpu_0_data_master_read | cpu_0_data_master_write)) & cpu_0_data_master_read;
  //pio_latency_s1_arb_share_counter set values, which is an e_mux
  assign pio_latency_s1_arb_share_set_values = 1;

  //pio_latency_s1_non_bursting_master_requests mux, which is an e_mux
  assign pio_latency_s1_non_bursting_master_requests = cpu_0_data_master_requests_pio_latency_s1;

  //pio_latency_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign pio_latency_s1_any_bursting_master_saved_grant = 0;

  //pio_latency_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign pio_latency_s1_arb_share_counter_next_value = pio_latency_s1_firsttransfer ? (pio_latency_s1_arb_share_set_values - 1) : |pio_latency_s1_arb_share_counter ? (pio_latency_s1_arb_share_counter - 1) : 0;

  //pio_latency_s1_allgrants all slave grants, which is an e_mux
  assign pio_latency_s1_allgrants = |pio_latency_s1_grant_vector;

  //pio_latency_s1_end_xfer assignment, which is an e_assign
  assign pio_latency_s1_end_xfer = ~(pio_latency_s1_waits_for_read | pio_latency_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_pio_latency_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_pio_latency_s1 = pio_latency_s1_end_xfer & (~pio_latency_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //pio_latency_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign pio_latency_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_pio_latency_s1 & pio_latency_s1_allgrants) | (end_xfer_arb_share_counter_term_pio_latency_s1 & ~pio_latency_s1_non_bursting_master_requests);

  //pio_latency_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_latency_s1_arb_share_counter <= 0;
      else if (pio_latency_s1_arb_counter_enable)
          pio_latency_s1_arb_share_counter <= pio_latency_s1_arb_share_counter_next_value;
    end


  //pio_latency_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_latency_s1_slavearbiterlockenable <= 0;
      else if ((|pio_latency_s1_master_qreq_vector & end_xfer_arb_share_counter_term_pio_latency_s1) | (end_xfer_arb_share_counter_term_pio_latency_s1 & ~pio_latency_s1_non_bursting_master_requests))
          pio_latency_s1_slavearbiterlockenable <= |pio_latency_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master pio_latency/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = pio_latency_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //pio_latency_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign pio_latency_s1_slavearbiterlockenable2 = |pio_latency_s1_arb_share_counter_next_value;

  //cpu_0/data_master pio_latency/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = pio_latency_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //pio_latency_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign pio_latency_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_pio_latency_s1 = cpu_0_data_master_requests_pio_latency_s1;
  //master is always granted when requested
  assign cpu_0_data_master_granted_pio_latency_s1 = cpu_0_data_master_qualified_request_pio_latency_s1;

  //cpu_0/data_master saved-grant pio_latency/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_pio_latency_s1 = cpu_0_data_master_requests_pio_latency_s1;

  //allow new arb cycle for pio_latency/s1, which is an e_assign
  assign pio_latency_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign pio_latency_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign pio_latency_s1_master_qreq_vector = 1;

  //pio_latency_s1_reset_n assignment, which is an e_assign
  assign pio_latency_s1_reset_n = reset_n;

  //pio_latency_s1_firsttransfer first transaction, which is an e_assign
  assign pio_latency_s1_firsttransfer = pio_latency_s1_begins_xfer ? pio_latency_s1_unreg_firsttransfer : pio_latency_s1_reg_firsttransfer;

  //pio_latency_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign pio_latency_s1_unreg_firsttransfer = ~(pio_latency_s1_slavearbiterlockenable & pio_latency_s1_any_continuerequest);

  //pio_latency_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_latency_s1_reg_firsttransfer <= 1'b1;
      else if (pio_latency_s1_begins_xfer)
          pio_latency_s1_reg_firsttransfer <= pio_latency_s1_unreg_firsttransfer;
    end


  //pio_latency_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign pio_latency_s1_beginbursttransfer_internal = pio_latency_s1_begins_xfer;

  assign shifted_address_to_pio_latency_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //pio_latency_s1_address mux, which is an e_mux
  assign pio_latency_s1_address = shifted_address_to_pio_latency_s1_from_cpu_0_data_master >> 2;

  //d1_pio_latency_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_pio_latency_s1_end_xfer <= 1;
      else 
        d1_pio_latency_s1_end_xfer <= pio_latency_s1_end_xfer;
    end


  //pio_latency_s1_waits_for_read in a cycle, which is an e_mux
  assign pio_latency_s1_waits_for_read = pio_latency_s1_in_a_read_cycle & pio_latency_s1_begins_xfer;

  //pio_latency_s1_in_a_read_cycle assignment, which is an e_assign
  assign pio_latency_s1_in_a_read_cycle = cpu_0_data_master_granted_pio_latency_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = pio_latency_s1_in_a_read_cycle;

  //pio_latency_s1_waits_for_write in a cycle, which is an e_mux
  assign pio_latency_s1_waits_for_write = pio_latency_s1_in_a_write_cycle & 0;

  //pio_latency_s1_in_a_write_cycle assignment, which is an e_assign
  assign pio_latency_s1_in_a_write_cycle = cpu_0_data_master_granted_pio_latency_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = pio_latency_s1_in_a_write_cycle;

  assign wait_for_pio_latency_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //pio_latency/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module pio_missed_s1_arbitrator (
                                  // inputs:
                                   clk,
                                   cpu_0_data_master_address_to_slave,
                                   cpu_0_data_master_read,
                                   cpu_0_data_master_write,
                                   pio_missed_s1_readdata,
                                   reset_n,

                                  // outputs:
                                   cpu_0_data_master_granted_pio_missed_s1,
                                   cpu_0_data_master_qualified_request_pio_missed_s1,
                                   cpu_0_data_master_read_data_valid_pio_missed_s1,
                                   cpu_0_data_master_requests_pio_missed_s1,
                                   d1_pio_missed_s1_end_xfer,
                                   pio_missed_s1_address,
                                   pio_missed_s1_readdata_from_sa,
                                   pio_missed_s1_reset_n
                                )
;

  output           cpu_0_data_master_granted_pio_missed_s1;
  output           cpu_0_data_master_qualified_request_pio_missed_s1;
  output           cpu_0_data_master_read_data_valid_pio_missed_s1;
  output           cpu_0_data_master_requests_pio_missed_s1;
  output           d1_pio_missed_s1_end_xfer;
  output  [  1: 0] pio_missed_s1_address;
  output  [ 15: 0] pio_missed_s1_readdata_from_sa;
  output           pio_missed_s1_reset_n;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input   [ 15: 0] pio_missed_s1_readdata;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_pio_missed_s1;
  wire             cpu_0_data_master_qualified_request_pio_missed_s1;
  wire             cpu_0_data_master_read_data_valid_pio_missed_s1;
  wire             cpu_0_data_master_requests_pio_missed_s1;
  wire             cpu_0_data_master_saved_grant_pio_missed_s1;
  reg              d1_pio_missed_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_pio_missed_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] pio_missed_s1_address;
  wire             pio_missed_s1_allgrants;
  wire             pio_missed_s1_allow_new_arb_cycle;
  wire             pio_missed_s1_any_bursting_master_saved_grant;
  wire             pio_missed_s1_any_continuerequest;
  wire             pio_missed_s1_arb_counter_enable;
  reg     [  1: 0] pio_missed_s1_arb_share_counter;
  wire    [  1: 0] pio_missed_s1_arb_share_counter_next_value;
  wire    [  1: 0] pio_missed_s1_arb_share_set_values;
  wire             pio_missed_s1_beginbursttransfer_internal;
  wire             pio_missed_s1_begins_xfer;
  wire             pio_missed_s1_end_xfer;
  wire             pio_missed_s1_firsttransfer;
  wire             pio_missed_s1_grant_vector;
  wire             pio_missed_s1_in_a_read_cycle;
  wire             pio_missed_s1_in_a_write_cycle;
  wire             pio_missed_s1_master_qreq_vector;
  wire             pio_missed_s1_non_bursting_master_requests;
  wire    [ 15: 0] pio_missed_s1_readdata_from_sa;
  reg              pio_missed_s1_reg_firsttransfer;
  wire             pio_missed_s1_reset_n;
  reg              pio_missed_s1_slavearbiterlockenable;
  wire             pio_missed_s1_slavearbiterlockenable2;
  wire             pio_missed_s1_unreg_firsttransfer;
  wire             pio_missed_s1_waits_for_read;
  wire             pio_missed_s1_waits_for_write;
  wire    [ 24: 0] shifted_address_to_pio_missed_s1_from_cpu_0_data_master;
  wire             wait_for_pio_missed_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~pio_missed_s1_end_xfer;
    end


  assign pio_missed_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_pio_missed_s1));
  //assign pio_missed_s1_readdata_from_sa = pio_missed_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign pio_missed_s1_readdata_from_sa = pio_missed_s1_readdata;

  assign cpu_0_data_master_requests_pio_missed_s1 = (({cpu_0_data_master_address_to_slave[24 : 4] , 4'b0} == 25'h10010f0) & (cpu_0_data_master_read | cpu_0_data_master_write)) & cpu_0_data_master_read;
  //pio_missed_s1_arb_share_counter set values, which is an e_mux
  assign pio_missed_s1_arb_share_set_values = 1;

  //pio_missed_s1_non_bursting_master_requests mux, which is an e_mux
  assign pio_missed_s1_non_bursting_master_requests = cpu_0_data_master_requests_pio_missed_s1;

  //pio_missed_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign pio_missed_s1_any_bursting_master_saved_grant = 0;

  //pio_missed_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign pio_missed_s1_arb_share_counter_next_value = pio_missed_s1_firsttransfer ? (pio_missed_s1_arb_share_set_values - 1) : |pio_missed_s1_arb_share_counter ? (pio_missed_s1_arb_share_counter - 1) : 0;

  //pio_missed_s1_allgrants all slave grants, which is an e_mux
  assign pio_missed_s1_allgrants = |pio_missed_s1_grant_vector;

  //pio_missed_s1_end_xfer assignment, which is an e_assign
  assign pio_missed_s1_end_xfer = ~(pio_missed_s1_waits_for_read | pio_missed_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_pio_missed_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_pio_missed_s1 = pio_missed_s1_end_xfer & (~pio_missed_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //pio_missed_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign pio_missed_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_pio_missed_s1 & pio_missed_s1_allgrants) | (end_xfer_arb_share_counter_term_pio_missed_s1 & ~pio_missed_s1_non_bursting_master_requests);

  //pio_missed_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_missed_s1_arb_share_counter <= 0;
      else if (pio_missed_s1_arb_counter_enable)
          pio_missed_s1_arb_share_counter <= pio_missed_s1_arb_share_counter_next_value;
    end


  //pio_missed_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_missed_s1_slavearbiterlockenable <= 0;
      else if ((|pio_missed_s1_master_qreq_vector & end_xfer_arb_share_counter_term_pio_missed_s1) | (end_xfer_arb_share_counter_term_pio_missed_s1 & ~pio_missed_s1_non_bursting_master_requests))
          pio_missed_s1_slavearbiterlockenable <= |pio_missed_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master pio_missed/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = pio_missed_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //pio_missed_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign pio_missed_s1_slavearbiterlockenable2 = |pio_missed_s1_arb_share_counter_next_value;

  //cpu_0/data_master pio_missed/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = pio_missed_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //pio_missed_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign pio_missed_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_pio_missed_s1 = cpu_0_data_master_requests_pio_missed_s1;
  //master is always granted when requested
  assign cpu_0_data_master_granted_pio_missed_s1 = cpu_0_data_master_qualified_request_pio_missed_s1;

  //cpu_0/data_master saved-grant pio_missed/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_pio_missed_s1 = cpu_0_data_master_requests_pio_missed_s1;

  //allow new arb cycle for pio_missed/s1, which is an e_assign
  assign pio_missed_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign pio_missed_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign pio_missed_s1_master_qreq_vector = 1;

  //pio_missed_s1_reset_n assignment, which is an e_assign
  assign pio_missed_s1_reset_n = reset_n;

  //pio_missed_s1_firsttransfer first transaction, which is an e_assign
  assign pio_missed_s1_firsttransfer = pio_missed_s1_begins_xfer ? pio_missed_s1_unreg_firsttransfer : pio_missed_s1_reg_firsttransfer;

  //pio_missed_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign pio_missed_s1_unreg_firsttransfer = ~(pio_missed_s1_slavearbiterlockenable & pio_missed_s1_any_continuerequest);

  //pio_missed_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_missed_s1_reg_firsttransfer <= 1'b1;
      else if (pio_missed_s1_begins_xfer)
          pio_missed_s1_reg_firsttransfer <= pio_missed_s1_unreg_firsttransfer;
    end


  //pio_missed_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign pio_missed_s1_beginbursttransfer_internal = pio_missed_s1_begins_xfer;

  assign shifted_address_to_pio_missed_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //pio_missed_s1_address mux, which is an e_mux
  assign pio_missed_s1_address = shifted_address_to_pio_missed_s1_from_cpu_0_data_master >> 2;

  //d1_pio_missed_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_pio_missed_s1_end_xfer <= 1;
      else 
        d1_pio_missed_s1_end_xfer <= pio_missed_s1_end_xfer;
    end


  //pio_missed_s1_waits_for_read in a cycle, which is an e_mux
  assign pio_missed_s1_waits_for_read = pio_missed_s1_in_a_read_cycle & pio_missed_s1_begins_xfer;

  //pio_missed_s1_in_a_read_cycle assignment, which is an e_assign
  assign pio_missed_s1_in_a_read_cycle = cpu_0_data_master_granted_pio_missed_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = pio_missed_s1_in_a_read_cycle;

  //pio_missed_s1_waits_for_write in a cycle, which is an e_mux
  assign pio_missed_s1_waits_for_write = pio_missed_s1_in_a_write_cycle & 0;

  //pio_missed_s1_in_a_write_cycle assignment, which is an e_assign
  assign pio_missed_s1_in_a_write_cycle = cpu_0_data_master_granted_pio_missed_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = pio_missed_s1_in_a_write_cycle;

  assign wait_for_pio_missed_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //pio_missed/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module pio_period_s1_arbitrator (
                                  // inputs:
                                   clk,
                                   cpu_0_data_master_address_to_slave,
                                   cpu_0_data_master_read,
                                   cpu_0_data_master_waitrequest,
                                   cpu_0_data_master_write,
                                   cpu_0_data_master_writedata,
                                   pio_period_s1_readdata,
                                   reset_n,

                                  // outputs:
                                   cpu_0_data_master_granted_pio_period_s1,
                                   cpu_0_data_master_qualified_request_pio_period_s1,
                                   cpu_0_data_master_read_data_valid_pio_period_s1,
                                   cpu_0_data_master_requests_pio_period_s1,
                                   d1_pio_period_s1_end_xfer,
                                   pio_period_s1_address,
                                   pio_period_s1_chipselect,
                                   pio_period_s1_readdata_from_sa,
                                   pio_period_s1_reset_n,
                                   pio_period_s1_write_n,
                                   pio_period_s1_writedata
                                )
;

  output           cpu_0_data_master_granted_pio_period_s1;
  output           cpu_0_data_master_qualified_request_pio_period_s1;
  output           cpu_0_data_master_read_data_valid_pio_period_s1;
  output           cpu_0_data_master_requests_pio_period_s1;
  output           d1_pio_period_s1_end_xfer;
  output  [  1: 0] pio_period_s1_address;
  output           pio_period_s1_chipselect;
  output  [  3: 0] pio_period_s1_readdata_from_sa;
  output           pio_period_s1_reset_n;
  output           pio_period_s1_write_n;
  output  [  3: 0] pio_period_s1_writedata;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_waitrequest;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input   [  3: 0] pio_period_s1_readdata;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_pio_period_s1;
  wire             cpu_0_data_master_qualified_request_pio_period_s1;
  wire             cpu_0_data_master_read_data_valid_pio_period_s1;
  wire             cpu_0_data_master_requests_pio_period_s1;
  wire             cpu_0_data_master_saved_grant_pio_period_s1;
  reg              d1_pio_period_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_pio_period_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] pio_period_s1_address;
  wire             pio_period_s1_allgrants;
  wire             pio_period_s1_allow_new_arb_cycle;
  wire             pio_period_s1_any_bursting_master_saved_grant;
  wire             pio_period_s1_any_continuerequest;
  wire             pio_period_s1_arb_counter_enable;
  reg     [  1: 0] pio_period_s1_arb_share_counter;
  wire    [  1: 0] pio_period_s1_arb_share_counter_next_value;
  wire    [  1: 0] pio_period_s1_arb_share_set_values;
  wire             pio_period_s1_beginbursttransfer_internal;
  wire             pio_period_s1_begins_xfer;
  wire             pio_period_s1_chipselect;
  wire             pio_period_s1_end_xfer;
  wire             pio_period_s1_firsttransfer;
  wire             pio_period_s1_grant_vector;
  wire             pio_period_s1_in_a_read_cycle;
  wire             pio_period_s1_in_a_write_cycle;
  wire             pio_period_s1_master_qreq_vector;
  wire             pio_period_s1_non_bursting_master_requests;
  wire    [  3: 0] pio_period_s1_readdata_from_sa;
  reg              pio_period_s1_reg_firsttransfer;
  wire             pio_period_s1_reset_n;
  reg              pio_period_s1_slavearbiterlockenable;
  wire             pio_period_s1_slavearbiterlockenable2;
  wire             pio_period_s1_unreg_firsttransfer;
  wire             pio_period_s1_waits_for_read;
  wire             pio_period_s1_waits_for_write;
  wire             pio_period_s1_write_n;
  wire    [  3: 0] pio_period_s1_writedata;
  wire    [ 24: 0] shifted_address_to_pio_period_s1_from_cpu_0_data_master;
  wire             wait_for_pio_period_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~pio_period_s1_end_xfer;
    end


  assign pio_period_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_pio_period_s1));
  //assign pio_period_s1_readdata_from_sa = pio_period_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign pio_period_s1_readdata_from_sa = pio_period_s1_readdata;

  assign cpu_0_data_master_requests_pio_period_s1 = ({cpu_0_data_master_address_to_slave[24 : 4] , 4'b0} == 25'h1001110) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //pio_period_s1_arb_share_counter set values, which is an e_mux
  assign pio_period_s1_arb_share_set_values = 1;

  //pio_period_s1_non_bursting_master_requests mux, which is an e_mux
  assign pio_period_s1_non_bursting_master_requests = cpu_0_data_master_requests_pio_period_s1;

  //pio_period_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign pio_period_s1_any_bursting_master_saved_grant = 0;

  //pio_period_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign pio_period_s1_arb_share_counter_next_value = pio_period_s1_firsttransfer ? (pio_period_s1_arb_share_set_values - 1) : |pio_period_s1_arb_share_counter ? (pio_period_s1_arb_share_counter - 1) : 0;

  //pio_period_s1_allgrants all slave grants, which is an e_mux
  assign pio_period_s1_allgrants = |pio_period_s1_grant_vector;

  //pio_period_s1_end_xfer assignment, which is an e_assign
  assign pio_period_s1_end_xfer = ~(pio_period_s1_waits_for_read | pio_period_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_pio_period_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_pio_period_s1 = pio_period_s1_end_xfer & (~pio_period_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //pio_period_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign pio_period_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_pio_period_s1 & pio_period_s1_allgrants) | (end_xfer_arb_share_counter_term_pio_period_s1 & ~pio_period_s1_non_bursting_master_requests);

  //pio_period_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_period_s1_arb_share_counter <= 0;
      else if (pio_period_s1_arb_counter_enable)
          pio_period_s1_arb_share_counter <= pio_period_s1_arb_share_counter_next_value;
    end


  //pio_period_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_period_s1_slavearbiterlockenable <= 0;
      else if ((|pio_period_s1_master_qreq_vector & end_xfer_arb_share_counter_term_pio_period_s1) | (end_xfer_arb_share_counter_term_pio_period_s1 & ~pio_period_s1_non_bursting_master_requests))
          pio_period_s1_slavearbiterlockenable <= |pio_period_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master pio_period/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = pio_period_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //pio_period_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign pio_period_s1_slavearbiterlockenable2 = |pio_period_s1_arb_share_counter_next_value;

  //cpu_0/data_master pio_period/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = pio_period_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //pio_period_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign pio_period_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_pio_period_s1 = cpu_0_data_master_requests_pio_period_s1 & ~(((~cpu_0_data_master_waitrequest) & cpu_0_data_master_write));
  //pio_period_s1_writedata mux, which is an e_mux
  assign pio_period_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_pio_period_s1 = cpu_0_data_master_qualified_request_pio_period_s1;

  //cpu_0/data_master saved-grant pio_period/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_pio_period_s1 = cpu_0_data_master_requests_pio_period_s1;

  //allow new arb cycle for pio_period/s1, which is an e_assign
  assign pio_period_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign pio_period_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign pio_period_s1_master_qreq_vector = 1;

  //pio_period_s1_reset_n assignment, which is an e_assign
  assign pio_period_s1_reset_n = reset_n;

  assign pio_period_s1_chipselect = cpu_0_data_master_granted_pio_period_s1;
  //pio_period_s1_firsttransfer first transaction, which is an e_assign
  assign pio_period_s1_firsttransfer = pio_period_s1_begins_xfer ? pio_period_s1_unreg_firsttransfer : pio_period_s1_reg_firsttransfer;

  //pio_period_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign pio_period_s1_unreg_firsttransfer = ~(pio_period_s1_slavearbiterlockenable & pio_period_s1_any_continuerequest);

  //pio_period_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_period_s1_reg_firsttransfer <= 1'b1;
      else if (pio_period_s1_begins_xfer)
          pio_period_s1_reg_firsttransfer <= pio_period_s1_unreg_firsttransfer;
    end


  //pio_period_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign pio_period_s1_beginbursttransfer_internal = pio_period_s1_begins_xfer;

  //~pio_period_s1_write_n assignment, which is an e_mux
  assign pio_period_s1_write_n = ~(cpu_0_data_master_granted_pio_period_s1 & cpu_0_data_master_write);

  assign shifted_address_to_pio_period_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //pio_period_s1_address mux, which is an e_mux
  assign pio_period_s1_address = shifted_address_to_pio_period_s1_from_cpu_0_data_master >> 2;

  //d1_pio_period_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_pio_period_s1_end_xfer <= 1;
      else 
        d1_pio_period_s1_end_xfer <= pio_period_s1_end_xfer;
    end


  //pio_period_s1_waits_for_read in a cycle, which is an e_mux
  assign pio_period_s1_waits_for_read = pio_period_s1_in_a_read_cycle & pio_period_s1_begins_xfer;

  //pio_period_s1_in_a_read_cycle assignment, which is an e_assign
  assign pio_period_s1_in_a_read_cycle = cpu_0_data_master_granted_pio_period_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = pio_period_s1_in_a_read_cycle;

  //pio_period_s1_waits_for_write in a cycle, which is an e_mux
  assign pio_period_s1_waits_for_write = pio_period_s1_in_a_write_cycle & 0;

  //pio_period_s1_in_a_write_cycle assignment, which is an e_assign
  assign pio_period_s1_in_a_write_cycle = cpu_0_data_master_granted_pio_period_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = pio_period_s1_in_a_write_cycle;

  assign wait_for_pio_period_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //pio_period/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module pio_pulse_s1_arbitrator (
                                 // inputs:
                                  clk,
                                  cpu_0_data_master_address_to_slave,
                                  cpu_0_data_master_read,
                                  cpu_0_data_master_waitrequest,
                                  cpu_0_data_master_write,
                                  cpu_0_data_master_writedata,
                                  pio_pulse_s1_irq,
                                  pio_pulse_s1_readdata,
                                  reset_n,

                                 // outputs:
                                  cpu_0_data_master_granted_pio_pulse_s1,
                                  cpu_0_data_master_qualified_request_pio_pulse_s1,
                                  cpu_0_data_master_read_data_valid_pio_pulse_s1,
                                  cpu_0_data_master_requests_pio_pulse_s1,
                                  d1_pio_pulse_s1_end_xfer,
                                  pio_pulse_s1_address,
                                  pio_pulse_s1_chipselect,
                                  pio_pulse_s1_irq_from_sa,
                                  pio_pulse_s1_readdata_from_sa,
                                  pio_pulse_s1_reset_n,
                                  pio_pulse_s1_write_n,
                                  pio_pulse_s1_writedata
                               )
;

  output           cpu_0_data_master_granted_pio_pulse_s1;
  output           cpu_0_data_master_qualified_request_pio_pulse_s1;
  output           cpu_0_data_master_read_data_valid_pio_pulse_s1;
  output           cpu_0_data_master_requests_pio_pulse_s1;
  output           d1_pio_pulse_s1_end_xfer;
  output  [  1: 0] pio_pulse_s1_address;
  output           pio_pulse_s1_chipselect;
  output           pio_pulse_s1_irq_from_sa;
  output           pio_pulse_s1_readdata_from_sa;
  output           pio_pulse_s1_reset_n;
  output           pio_pulse_s1_write_n;
  output           pio_pulse_s1_writedata;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_waitrequest;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            pio_pulse_s1_irq;
  input            pio_pulse_s1_readdata;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_pio_pulse_s1;
  wire             cpu_0_data_master_qualified_request_pio_pulse_s1;
  wire             cpu_0_data_master_read_data_valid_pio_pulse_s1;
  wire             cpu_0_data_master_requests_pio_pulse_s1;
  wire             cpu_0_data_master_saved_grant_pio_pulse_s1;
  reg              d1_pio_pulse_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_pio_pulse_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] pio_pulse_s1_address;
  wire             pio_pulse_s1_allgrants;
  wire             pio_pulse_s1_allow_new_arb_cycle;
  wire             pio_pulse_s1_any_bursting_master_saved_grant;
  wire             pio_pulse_s1_any_continuerequest;
  wire             pio_pulse_s1_arb_counter_enable;
  reg     [  1: 0] pio_pulse_s1_arb_share_counter;
  wire    [  1: 0] pio_pulse_s1_arb_share_counter_next_value;
  wire    [  1: 0] pio_pulse_s1_arb_share_set_values;
  wire             pio_pulse_s1_beginbursttransfer_internal;
  wire             pio_pulse_s1_begins_xfer;
  wire             pio_pulse_s1_chipselect;
  wire             pio_pulse_s1_end_xfer;
  wire             pio_pulse_s1_firsttransfer;
  wire             pio_pulse_s1_grant_vector;
  wire             pio_pulse_s1_in_a_read_cycle;
  wire             pio_pulse_s1_in_a_write_cycle;
  wire             pio_pulse_s1_irq_from_sa;
  wire             pio_pulse_s1_master_qreq_vector;
  wire             pio_pulse_s1_non_bursting_master_requests;
  wire             pio_pulse_s1_readdata_from_sa;
  reg              pio_pulse_s1_reg_firsttransfer;
  wire             pio_pulse_s1_reset_n;
  reg              pio_pulse_s1_slavearbiterlockenable;
  wire             pio_pulse_s1_slavearbiterlockenable2;
  wire             pio_pulse_s1_unreg_firsttransfer;
  wire             pio_pulse_s1_waits_for_read;
  wire             pio_pulse_s1_waits_for_write;
  wire             pio_pulse_s1_write_n;
  wire             pio_pulse_s1_writedata;
  wire    [ 24: 0] shifted_address_to_pio_pulse_s1_from_cpu_0_data_master;
  wire             wait_for_pio_pulse_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~pio_pulse_s1_end_xfer;
    end


  assign pio_pulse_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_pio_pulse_s1));
  //assign pio_pulse_s1_readdata_from_sa = pio_pulse_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign pio_pulse_s1_readdata_from_sa = pio_pulse_s1_readdata;

  assign cpu_0_data_master_requests_pio_pulse_s1 = ({cpu_0_data_master_address_to_slave[24 : 4] , 4'b0} == 25'h10010d0) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //pio_pulse_s1_arb_share_counter set values, which is an e_mux
  assign pio_pulse_s1_arb_share_set_values = 1;

  //pio_pulse_s1_non_bursting_master_requests mux, which is an e_mux
  assign pio_pulse_s1_non_bursting_master_requests = cpu_0_data_master_requests_pio_pulse_s1;

  //pio_pulse_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign pio_pulse_s1_any_bursting_master_saved_grant = 0;

  //pio_pulse_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign pio_pulse_s1_arb_share_counter_next_value = pio_pulse_s1_firsttransfer ? (pio_pulse_s1_arb_share_set_values - 1) : |pio_pulse_s1_arb_share_counter ? (pio_pulse_s1_arb_share_counter - 1) : 0;

  //pio_pulse_s1_allgrants all slave grants, which is an e_mux
  assign pio_pulse_s1_allgrants = |pio_pulse_s1_grant_vector;

  //pio_pulse_s1_end_xfer assignment, which is an e_assign
  assign pio_pulse_s1_end_xfer = ~(pio_pulse_s1_waits_for_read | pio_pulse_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_pio_pulse_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_pio_pulse_s1 = pio_pulse_s1_end_xfer & (~pio_pulse_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //pio_pulse_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign pio_pulse_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_pio_pulse_s1 & pio_pulse_s1_allgrants) | (end_xfer_arb_share_counter_term_pio_pulse_s1 & ~pio_pulse_s1_non_bursting_master_requests);

  //pio_pulse_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_pulse_s1_arb_share_counter <= 0;
      else if (pio_pulse_s1_arb_counter_enable)
          pio_pulse_s1_arb_share_counter <= pio_pulse_s1_arb_share_counter_next_value;
    end


  //pio_pulse_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_pulse_s1_slavearbiterlockenable <= 0;
      else if ((|pio_pulse_s1_master_qreq_vector & end_xfer_arb_share_counter_term_pio_pulse_s1) | (end_xfer_arb_share_counter_term_pio_pulse_s1 & ~pio_pulse_s1_non_bursting_master_requests))
          pio_pulse_s1_slavearbiterlockenable <= |pio_pulse_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master pio_pulse/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = pio_pulse_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //pio_pulse_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign pio_pulse_s1_slavearbiterlockenable2 = |pio_pulse_s1_arb_share_counter_next_value;

  //cpu_0/data_master pio_pulse/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = pio_pulse_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //pio_pulse_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign pio_pulse_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_pio_pulse_s1 = cpu_0_data_master_requests_pio_pulse_s1 & ~(((~cpu_0_data_master_waitrequest) & cpu_0_data_master_write));
  //pio_pulse_s1_writedata mux, which is an e_mux
  assign pio_pulse_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_pio_pulse_s1 = cpu_0_data_master_qualified_request_pio_pulse_s1;

  //cpu_0/data_master saved-grant pio_pulse/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_pio_pulse_s1 = cpu_0_data_master_requests_pio_pulse_s1;

  //allow new arb cycle for pio_pulse/s1, which is an e_assign
  assign pio_pulse_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign pio_pulse_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign pio_pulse_s1_master_qreq_vector = 1;

  //pio_pulse_s1_reset_n assignment, which is an e_assign
  assign pio_pulse_s1_reset_n = reset_n;

  assign pio_pulse_s1_chipselect = cpu_0_data_master_granted_pio_pulse_s1;
  //pio_pulse_s1_firsttransfer first transaction, which is an e_assign
  assign pio_pulse_s1_firsttransfer = pio_pulse_s1_begins_xfer ? pio_pulse_s1_unreg_firsttransfer : pio_pulse_s1_reg_firsttransfer;

  //pio_pulse_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign pio_pulse_s1_unreg_firsttransfer = ~(pio_pulse_s1_slavearbiterlockenable & pio_pulse_s1_any_continuerequest);

  //pio_pulse_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_pulse_s1_reg_firsttransfer <= 1'b1;
      else if (pio_pulse_s1_begins_xfer)
          pio_pulse_s1_reg_firsttransfer <= pio_pulse_s1_unreg_firsttransfer;
    end


  //pio_pulse_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign pio_pulse_s1_beginbursttransfer_internal = pio_pulse_s1_begins_xfer;

  //~pio_pulse_s1_write_n assignment, which is an e_mux
  assign pio_pulse_s1_write_n = ~(cpu_0_data_master_granted_pio_pulse_s1 & cpu_0_data_master_write);

  assign shifted_address_to_pio_pulse_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //pio_pulse_s1_address mux, which is an e_mux
  assign pio_pulse_s1_address = shifted_address_to_pio_pulse_s1_from_cpu_0_data_master >> 2;

  //d1_pio_pulse_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_pio_pulse_s1_end_xfer <= 1;
      else 
        d1_pio_pulse_s1_end_xfer <= pio_pulse_s1_end_xfer;
    end


  //pio_pulse_s1_waits_for_read in a cycle, which is an e_mux
  assign pio_pulse_s1_waits_for_read = pio_pulse_s1_in_a_read_cycle & pio_pulse_s1_begins_xfer;

  //pio_pulse_s1_in_a_read_cycle assignment, which is an e_assign
  assign pio_pulse_s1_in_a_read_cycle = cpu_0_data_master_granted_pio_pulse_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = pio_pulse_s1_in_a_read_cycle;

  //pio_pulse_s1_waits_for_write in a cycle, which is an e_mux
  assign pio_pulse_s1_waits_for_write = pio_pulse_s1_in_a_write_cycle & 0;

  //pio_pulse_s1_in_a_write_cycle assignment, which is an e_assign
  assign pio_pulse_s1_in_a_write_cycle = cpu_0_data_master_granted_pio_pulse_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = pio_pulse_s1_in_a_write_cycle;

  assign wait_for_pio_pulse_s1_counter = 0;
  //assign pio_pulse_s1_irq_from_sa = pio_pulse_s1_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign pio_pulse_s1_irq_from_sa = pio_pulse_s1_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //pio_pulse/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module pio_response_s1_arbitrator (
                                    // inputs:
                                     clk,
                                     cpu_0_data_master_address_to_slave,
                                     cpu_0_data_master_read,
                                     cpu_0_data_master_waitrequest,
                                     cpu_0_data_master_write,
                                     cpu_0_data_master_writedata,
                                     pio_response_s1_readdata,
                                     reset_n,

                                    // outputs:
                                     cpu_0_data_master_granted_pio_response_s1,
                                     cpu_0_data_master_qualified_request_pio_response_s1,
                                     cpu_0_data_master_read_data_valid_pio_response_s1,
                                     cpu_0_data_master_requests_pio_response_s1,
                                     d1_pio_response_s1_end_xfer,
                                     pio_response_s1_address,
                                     pio_response_s1_chipselect,
                                     pio_response_s1_readdata_from_sa,
                                     pio_response_s1_reset_n,
                                     pio_response_s1_write_n,
                                     pio_response_s1_writedata
                                  )
;

  output           cpu_0_data_master_granted_pio_response_s1;
  output           cpu_0_data_master_qualified_request_pio_response_s1;
  output           cpu_0_data_master_read_data_valid_pio_response_s1;
  output           cpu_0_data_master_requests_pio_response_s1;
  output           d1_pio_response_s1_end_xfer;
  output  [  1: 0] pio_response_s1_address;
  output           pio_response_s1_chipselect;
  output           pio_response_s1_readdata_from_sa;
  output           pio_response_s1_reset_n;
  output           pio_response_s1_write_n;
  output           pio_response_s1_writedata;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_waitrequest;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            pio_response_s1_readdata;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_pio_response_s1;
  wire             cpu_0_data_master_qualified_request_pio_response_s1;
  wire             cpu_0_data_master_read_data_valid_pio_response_s1;
  wire             cpu_0_data_master_requests_pio_response_s1;
  wire             cpu_0_data_master_saved_grant_pio_response_s1;
  reg              d1_pio_response_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_pio_response_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] pio_response_s1_address;
  wire             pio_response_s1_allgrants;
  wire             pio_response_s1_allow_new_arb_cycle;
  wire             pio_response_s1_any_bursting_master_saved_grant;
  wire             pio_response_s1_any_continuerequest;
  wire             pio_response_s1_arb_counter_enable;
  reg     [  1: 0] pio_response_s1_arb_share_counter;
  wire    [  1: 0] pio_response_s1_arb_share_counter_next_value;
  wire    [  1: 0] pio_response_s1_arb_share_set_values;
  wire             pio_response_s1_beginbursttransfer_internal;
  wire             pio_response_s1_begins_xfer;
  wire             pio_response_s1_chipselect;
  wire             pio_response_s1_end_xfer;
  wire             pio_response_s1_firsttransfer;
  wire             pio_response_s1_grant_vector;
  wire             pio_response_s1_in_a_read_cycle;
  wire             pio_response_s1_in_a_write_cycle;
  wire             pio_response_s1_master_qreq_vector;
  wire             pio_response_s1_non_bursting_master_requests;
  wire             pio_response_s1_readdata_from_sa;
  reg              pio_response_s1_reg_firsttransfer;
  wire             pio_response_s1_reset_n;
  reg              pio_response_s1_slavearbiterlockenable;
  wire             pio_response_s1_slavearbiterlockenable2;
  wire             pio_response_s1_unreg_firsttransfer;
  wire             pio_response_s1_waits_for_read;
  wire             pio_response_s1_waits_for_write;
  wire             pio_response_s1_write_n;
  wire             pio_response_s1_writedata;
  wire    [ 24: 0] shifted_address_to_pio_response_s1_from_cpu_0_data_master;
  wire             wait_for_pio_response_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~pio_response_s1_end_xfer;
    end


  assign pio_response_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_pio_response_s1));
  //assign pio_response_s1_readdata_from_sa = pio_response_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign pio_response_s1_readdata_from_sa = pio_response_s1_readdata;

  assign cpu_0_data_master_requests_pio_response_s1 = ({cpu_0_data_master_address_to_slave[24 : 4] , 4'b0} == 25'h1001120) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //pio_response_s1_arb_share_counter set values, which is an e_mux
  assign pio_response_s1_arb_share_set_values = 1;

  //pio_response_s1_non_bursting_master_requests mux, which is an e_mux
  assign pio_response_s1_non_bursting_master_requests = cpu_0_data_master_requests_pio_response_s1;

  //pio_response_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign pio_response_s1_any_bursting_master_saved_grant = 0;

  //pio_response_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign pio_response_s1_arb_share_counter_next_value = pio_response_s1_firsttransfer ? (pio_response_s1_arb_share_set_values - 1) : |pio_response_s1_arb_share_counter ? (pio_response_s1_arb_share_counter - 1) : 0;

  //pio_response_s1_allgrants all slave grants, which is an e_mux
  assign pio_response_s1_allgrants = |pio_response_s1_grant_vector;

  //pio_response_s1_end_xfer assignment, which is an e_assign
  assign pio_response_s1_end_xfer = ~(pio_response_s1_waits_for_read | pio_response_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_pio_response_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_pio_response_s1 = pio_response_s1_end_xfer & (~pio_response_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //pio_response_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign pio_response_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_pio_response_s1 & pio_response_s1_allgrants) | (end_xfer_arb_share_counter_term_pio_response_s1 & ~pio_response_s1_non_bursting_master_requests);

  //pio_response_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_response_s1_arb_share_counter <= 0;
      else if (pio_response_s1_arb_counter_enable)
          pio_response_s1_arb_share_counter <= pio_response_s1_arb_share_counter_next_value;
    end


  //pio_response_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_response_s1_slavearbiterlockenable <= 0;
      else if ((|pio_response_s1_master_qreq_vector & end_xfer_arb_share_counter_term_pio_response_s1) | (end_xfer_arb_share_counter_term_pio_response_s1 & ~pio_response_s1_non_bursting_master_requests))
          pio_response_s1_slavearbiterlockenable <= |pio_response_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master pio_response/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = pio_response_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //pio_response_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign pio_response_s1_slavearbiterlockenable2 = |pio_response_s1_arb_share_counter_next_value;

  //cpu_0/data_master pio_response/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = pio_response_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //pio_response_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign pio_response_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_pio_response_s1 = cpu_0_data_master_requests_pio_response_s1 & ~(((~cpu_0_data_master_waitrequest) & cpu_0_data_master_write));
  //pio_response_s1_writedata mux, which is an e_mux
  assign pio_response_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_pio_response_s1 = cpu_0_data_master_qualified_request_pio_response_s1;

  //cpu_0/data_master saved-grant pio_response/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_pio_response_s1 = cpu_0_data_master_requests_pio_response_s1;

  //allow new arb cycle for pio_response/s1, which is an e_assign
  assign pio_response_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign pio_response_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign pio_response_s1_master_qreq_vector = 1;

  //pio_response_s1_reset_n assignment, which is an e_assign
  assign pio_response_s1_reset_n = reset_n;

  assign pio_response_s1_chipselect = cpu_0_data_master_granted_pio_response_s1;
  //pio_response_s1_firsttransfer first transaction, which is an e_assign
  assign pio_response_s1_firsttransfer = pio_response_s1_begins_xfer ? pio_response_s1_unreg_firsttransfer : pio_response_s1_reg_firsttransfer;

  //pio_response_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign pio_response_s1_unreg_firsttransfer = ~(pio_response_s1_slavearbiterlockenable & pio_response_s1_any_continuerequest);

  //pio_response_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_response_s1_reg_firsttransfer <= 1'b1;
      else if (pio_response_s1_begins_xfer)
          pio_response_s1_reg_firsttransfer <= pio_response_s1_unreg_firsttransfer;
    end


  //pio_response_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign pio_response_s1_beginbursttransfer_internal = pio_response_s1_begins_xfer;

  //~pio_response_s1_write_n assignment, which is an e_mux
  assign pio_response_s1_write_n = ~(cpu_0_data_master_granted_pio_response_s1 & cpu_0_data_master_write);

  assign shifted_address_to_pio_response_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //pio_response_s1_address mux, which is an e_mux
  assign pio_response_s1_address = shifted_address_to_pio_response_s1_from_cpu_0_data_master >> 2;

  //d1_pio_response_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_pio_response_s1_end_xfer <= 1;
      else 
        d1_pio_response_s1_end_xfer <= pio_response_s1_end_xfer;
    end


  //pio_response_s1_waits_for_read in a cycle, which is an e_mux
  assign pio_response_s1_waits_for_read = pio_response_s1_in_a_read_cycle & pio_response_s1_begins_xfer;

  //pio_response_s1_in_a_read_cycle assignment, which is an e_assign
  assign pio_response_s1_in_a_read_cycle = cpu_0_data_master_granted_pio_response_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = pio_response_s1_in_a_read_cycle;

  //pio_response_s1_waits_for_write in a cycle, which is an e_mux
  assign pio_response_s1_waits_for_write = pio_response_s1_in_a_write_cycle & 0;

  //pio_response_s1_in_a_write_cycle assignment, which is an e_assign
  assign pio_response_s1_in_a_write_cycle = cpu_0_data_master_granted_pio_response_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = pio_response_s1_in_a_write_cycle;

  assign wait_for_pio_response_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //pio_response/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module red_led_pio_s1_arbitrator (
                                   // inputs:
                                    clk,
                                    cpu_0_data_master_address_to_slave,
                                    cpu_0_data_master_byteenable,
                                    cpu_0_data_master_read,
                                    cpu_0_data_master_waitrequest,
                                    cpu_0_data_master_write,
                                    cpu_0_data_master_writedata,
                                    red_led_pio_s1_readdata,
                                    reset_n,

                                   // outputs:
                                    cpu_0_data_master_granted_red_led_pio_s1,
                                    cpu_0_data_master_qualified_request_red_led_pio_s1,
                                    cpu_0_data_master_read_data_valid_red_led_pio_s1,
                                    cpu_0_data_master_requests_red_led_pio_s1,
                                    d1_red_led_pio_s1_end_xfer,
                                    red_led_pio_s1_address,
                                    red_led_pio_s1_chipselect,
                                    red_led_pio_s1_readdata_from_sa,
                                    red_led_pio_s1_reset_n,
                                    red_led_pio_s1_write_n,
                                    red_led_pio_s1_writedata
                                 )
;

  output           cpu_0_data_master_granted_red_led_pio_s1;
  output           cpu_0_data_master_qualified_request_red_led_pio_s1;
  output           cpu_0_data_master_read_data_valid_red_led_pio_s1;
  output           cpu_0_data_master_requests_red_led_pio_s1;
  output           d1_red_led_pio_s1_end_xfer;
  output  [  1: 0] red_led_pio_s1_address;
  output           red_led_pio_s1_chipselect;
  output  [  7: 0] red_led_pio_s1_readdata_from_sa;
  output           red_led_pio_s1_reset_n;
  output           red_led_pio_s1_write_n;
  output  [  7: 0] red_led_pio_s1_writedata;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input   [  3: 0] cpu_0_data_master_byteenable;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_waitrequest;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input   [  7: 0] red_led_pio_s1_readdata;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_red_led_pio_s1;
  wire             cpu_0_data_master_qualified_request_red_led_pio_s1;
  wire             cpu_0_data_master_read_data_valid_red_led_pio_s1;
  wire             cpu_0_data_master_requests_red_led_pio_s1;
  wire             cpu_0_data_master_saved_grant_red_led_pio_s1;
  reg              d1_reasons_to_wait;
  reg              d1_red_led_pio_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_red_led_pio_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] red_led_pio_s1_address;
  wire             red_led_pio_s1_allgrants;
  wire             red_led_pio_s1_allow_new_arb_cycle;
  wire             red_led_pio_s1_any_bursting_master_saved_grant;
  wire             red_led_pio_s1_any_continuerequest;
  wire             red_led_pio_s1_arb_counter_enable;
  reg     [  1: 0] red_led_pio_s1_arb_share_counter;
  wire    [  1: 0] red_led_pio_s1_arb_share_counter_next_value;
  wire    [  1: 0] red_led_pio_s1_arb_share_set_values;
  wire             red_led_pio_s1_beginbursttransfer_internal;
  wire             red_led_pio_s1_begins_xfer;
  wire             red_led_pio_s1_chipselect;
  wire             red_led_pio_s1_end_xfer;
  wire             red_led_pio_s1_firsttransfer;
  wire             red_led_pio_s1_grant_vector;
  wire             red_led_pio_s1_in_a_read_cycle;
  wire             red_led_pio_s1_in_a_write_cycle;
  wire             red_led_pio_s1_master_qreq_vector;
  wire             red_led_pio_s1_non_bursting_master_requests;
  wire             red_led_pio_s1_pretend_byte_enable;
  wire    [  7: 0] red_led_pio_s1_readdata_from_sa;
  reg              red_led_pio_s1_reg_firsttransfer;
  wire             red_led_pio_s1_reset_n;
  reg              red_led_pio_s1_slavearbiterlockenable;
  wire             red_led_pio_s1_slavearbiterlockenable2;
  wire             red_led_pio_s1_unreg_firsttransfer;
  wire             red_led_pio_s1_waits_for_read;
  wire             red_led_pio_s1_waits_for_write;
  wire             red_led_pio_s1_write_n;
  wire    [  7: 0] red_led_pio_s1_writedata;
  wire    [ 24: 0] shifted_address_to_red_led_pio_s1_from_cpu_0_data_master;
  wire             wait_for_red_led_pio_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~red_led_pio_s1_end_xfer;
    end


  assign red_led_pio_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_red_led_pio_s1));
  //assign red_led_pio_s1_readdata_from_sa = red_led_pio_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign red_led_pio_s1_readdata_from_sa = red_led_pio_s1_readdata;

  assign cpu_0_data_master_requests_red_led_pio_s1 = ({cpu_0_data_master_address_to_slave[24 : 4] , 4'b0} == 25'h1001090) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //red_led_pio_s1_arb_share_counter set values, which is an e_mux
  assign red_led_pio_s1_arb_share_set_values = 1;

  //red_led_pio_s1_non_bursting_master_requests mux, which is an e_mux
  assign red_led_pio_s1_non_bursting_master_requests = cpu_0_data_master_requests_red_led_pio_s1;

  //red_led_pio_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign red_led_pio_s1_any_bursting_master_saved_grant = 0;

  //red_led_pio_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign red_led_pio_s1_arb_share_counter_next_value = red_led_pio_s1_firsttransfer ? (red_led_pio_s1_arb_share_set_values - 1) : |red_led_pio_s1_arb_share_counter ? (red_led_pio_s1_arb_share_counter - 1) : 0;

  //red_led_pio_s1_allgrants all slave grants, which is an e_mux
  assign red_led_pio_s1_allgrants = |red_led_pio_s1_grant_vector;

  //red_led_pio_s1_end_xfer assignment, which is an e_assign
  assign red_led_pio_s1_end_xfer = ~(red_led_pio_s1_waits_for_read | red_led_pio_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_red_led_pio_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_red_led_pio_s1 = red_led_pio_s1_end_xfer & (~red_led_pio_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //red_led_pio_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign red_led_pio_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_red_led_pio_s1 & red_led_pio_s1_allgrants) | (end_xfer_arb_share_counter_term_red_led_pio_s1 & ~red_led_pio_s1_non_bursting_master_requests);

  //red_led_pio_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          red_led_pio_s1_arb_share_counter <= 0;
      else if (red_led_pio_s1_arb_counter_enable)
          red_led_pio_s1_arb_share_counter <= red_led_pio_s1_arb_share_counter_next_value;
    end


  //red_led_pio_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          red_led_pio_s1_slavearbiterlockenable <= 0;
      else if ((|red_led_pio_s1_master_qreq_vector & end_xfer_arb_share_counter_term_red_led_pio_s1) | (end_xfer_arb_share_counter_term_red_led_pio_s1 & ~red_led_pio_s1_non_bursting_master_requests))
          red_led_pio_s1_slavearbiterlockenable <= |red_led_pio_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master red_led_pio/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = red_led_pio_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //red_led_pio_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign red_led_pio_s1_slavearbiterlockenable2 = |red_led_pio_s1_arb_share_counter_next_value;

  //cpu_0/data_master red_led_pio/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = red_led_pio_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //red_led_pio_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign red_led_pio_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_red_led_pio_s1 = cpu_0_data_master_requests_red_led_pio_s1 & ~(((~cpu_0_data_master_waitrequest) & cpu_0_data_master_write));
  //red_led_pio_s1_writedata mux, which is an e_mux
  assign red_led_pio_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_red_led_pio_s1 = cpu_0_data_master_qualified_request_red_led_pio_s1;

  //cpu_0/data_master saved-grant red_led_pio/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_red_led_pio_s1 = cpu_0_data_master_requests_red_led_pio_s1;

  //allow new arb cycle for red_led_pio/s1, which is an e_assign
  assign red_led_pio_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign red_led_pio_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign red_led_pio_s1_master_qreq_vector = 1;

  //red_led_pio_s1_reset_n assignment, which is an e_assign
  assign red_led_pio_s1_reset_n = reset_n;

  assign red_led_pio_s1_chipselect = cpu_0_data_master_granted_red_led_pio_s1;
  //red_led_pio_s1_firsttransfer first transaction, which is an e_assign
  assign red_led_pio_s1_firsttransfer = red_led_pio_s1_begins_xfer ? red_led_pio_s1_unreg_firsttransfer : red_led_pio_s1_reg_firsttransfer;

  //red_led_pio_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign red_led_pio_s1_unreg_firsttransfer = ~(red_led_pio_s1_slavearbiterlockenable & red_led_pio_s1_any_continuerequest);

  //red_led_pio_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          red_led_pio_s1_reg_firsttransfer <= 1'b1;
      else if (red_led_pio_s1_begins_xfer)
          red_led_pio_s1_reg_firsttransfer <= red_led_pio_s1_unreg_firsttransfer;
    end


  //red_led_pio_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign red_led_pio_s1_beginbursttransfer_internal = red_led_pio_s1_begins_xfer;

  //~red_led_pio_s1_write_n assignment, which is an e_mux
  assign red_led_pio_s1_write_n = ~(((cpu_0_data_master_granted_red_led_pio_s1 & cpu_0_data_master_write)) & red_led_pio_s1_pretend_byte_enable);

  assign shifted_address_to_red_led_pio_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //red_led_pio_s1_address mux, which is an e_mux
  assign red_led_pio_s1_address = shifted_address_to_red_led_pio_s1_from_cpu_0_data_master >> 2;

  //d1_red_led_pio_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_red_led_pio_s1_end_xfer <= 1;
      else 
        d1_red_led_pio_s1_end_xfer <= red_led_pio_s1_end_xfer;
    end


  //red_led_pio_s1_waits_for_read in a cycle, which is an e_mux
  assign red_led_pio_s1_waits_for_read = red_led_pio_s1_in_a_read_cycle & red_led_pio_s1_begins_xfer;

  //red_led_pio_s1_in_a_read_cycle assignment, which is an e_assign
  assign red_led_pio_s1_in_a_read_cycle = cpu_0_data_master_granted_red_led_pio_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = red_led_pio_s1_in_a_read_cycle;

  //red_led_pio_s1_waits_for_write in a cycle, which is an e_mux
  assign red_led_pio_s1_waits_for_write = red_led_pio_s1_in_a_write_cycle & 0;

  //red_led_pio_s1_in_a_write_cycle assignment, which is an e_assign
  assign red_led_pio_s1_in_a_write_cycle = cpu_0_data_master_granted_red_led_pio_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = red_led_pio_s1_in_a_write_cycle;

  assign wait_for_red_led_pio_s1_counter = 0;
  //red_led_pio_s1_pretend_byte_enable byte enable port mux, which is an e_mux
  assign red_led_pio_s1_pretend_byte_enable = (cpu_0_data_master_granted_red_led_pio_s1)? cpu_0_data_master_byteenable :
    -1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //red_led_pio/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module rdv_fifo_for_cpu_0_data_master_to_sdram_0_s1_module (
                                                             // inputs:
                                                              clear_fifo,
                                                              clk,
                                                              data_in,
                                                              read,
                                                              reset_n,
                                                              sync_reset,
                                                              write,

                                                             // outputs:
                                                              data_out,
                                                              empty,
                                                              fifo_contains_ones_n,
                                                              full
                                                           )
;

  output           data_out;
  output           empty;
  output           fifo_contains_ones_n;
  output           full;
  input            clear_fifo;
  input            clk;
  input            data_in;
  input            read;
  input            reset_n;
  input            sync_reset;
  input            write;

  wire             data_out;
  wire             empty;
  reg              fifo_contains_ones_n;
  wire             full;
  reg              full_0;
  reg              full_1;
  reg              full_2;
  reg              full_3;
  reg              full_4;
  reg              full_5;
  reg              full_6;
  wire             full_7;
  reg     [  3: 0] how_many_ones;
  wire    [  3: 0] one_count_minus_one;
  wire    [  3: 0] one_count_plus_one;
  wire             p0_full_0;
  wire             p0_stage_0;
  wire             p1_full_1;
  wire             p1_stage_1;
  wire             p2_full_2;
  wire             p2_stage_2;
  wire             p3_full_3;
  wire             p3_stage_3;
  wire             p4_full_4;
  wire             p4_stage_4;
  wire             p5_full_5;
  wire             p5_stage_5;
  wire             p6_full_6;
  wire             p6_stage_6;
  reg              stage_0;
  reg              stage_1;
  reg              stage_2;
  reg              stage_3;
  reg              stage_4;
  reg              stage_5;
  reg              stage_6;
  wire    [  3: 0] updated_one_count;
  assign data_out = stage_0;
  assign full = full_6;
  assign empty = !full_0;
  assign full_7 = 0;
  //data_6, which is an e_mux
  assign p6_stage_6 = ((full_7 & ~clear_fifo) == 0)? data_in :
    data_in;

  //data_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_6 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_6))
          if (sync_reset & full_6 & !((full_7 == 0) & read & write))
              stage_6 <= 0;
          else 
            stage_6 <= p6_stage_6;
    end


  //control_6, which is an e_mux
  assign p6_full_6 = ((read & !write) == 0)? full_5 :
    0;

  //control_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_6 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_6 <= 0;
          else 
            full_6 <= p6_full_6;
    end


  //data_5, which is an e_mux
  assign p5_stage_5 = ((full_6 & ~clear_fifo) == 0)? data_in :
    stage_6;

  //data_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_5 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_5))
          if (sync_reset & full_5 & !((full_6 == 0) & read & write))
              stage_5 <= 0;
          else 
            stage_5 <= p5_stage_5;
    end


  //control_5, which is an e_mux
  assign p5_full_5 = ((read & !write) == 0)? full_4 :
    full_6;

  //control_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_5 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_5 <= 0;
          else 
            full_5 <= p5_full_5;
    end


  //data_4, which is an e_mux
  assign p4_stage_4 = ((full_5 & ~clear_fifo) == 0)? data_in :
    stage_5;

  //data_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_4 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_4))
          if (sync_reset & full_4 & !((full_5 == 0) & read & write))
              stage_4 <= 0;
          else 
            stage_4 <= p4_stage_4;
    end


  //control_4, which is an e_mux
  assign p4_full_4 = ((read & !write) == 0)? full_3 :
    full_5;

  //control_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_4 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_4 <= 0;
          else 
            full_4 <= p4_full_4;
    end


  //data_3, which is an e_mux
  assign p3_stage_3 = ((full_4 & ~clear_fifo) == 0)? data_in :
    stage_4;

  //data_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_3 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_3))
          if (sync_reset & full_3 & !((full_4 == 0) & read & write))
              stage_3 <= 0;
          else 
            stage_3 <= p3_stage_3;
    end


  //control_3, which is an e_mux
  assign p3_full_3 = ((read & !write) == 0)? full_2 :
    full_4;

  //control_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_3 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_3 <= 0;
          else 
            full_3 <= p3_full_3;
    end


  //data_2, which is an e_mux
  assign p2_stage_2 = ((full_3 & ~clear_fifo) == 0)? data_in :
    stage_3;

  //data_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_2 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_2))
          if (sync_reset & full_2 & !((full_3 == 0) & read & write))
              stage_2 <= 0;
          else 
            stage_2 <= p2_stage_2;
    end


  //control_2, which is an e_mux
  assign p2_full_2 = ((read & !write) == 0)? full_1 :
    full_3;

  //control_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_2 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_2 <= 0;
          else 
            full_2 <= p2_full_2;
    end


  //data_1, which is an e_mux
  assign p1_stage_1 = ((full_2 & ~clear_fifo) == 0)? data_in :
    stage_2;

  //data_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_1 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_1))
          if (sync_reset & full_1 & !((full_2 == 0) & read & write))
              stage_1 <= 0;
          else 
            stage_1 <= p1_stage_1;
    end


  //control_1, which is an e_mux
  assign p1_full_1 = ((read & !write) == 0)? full_0 :
    full_2;

  //control_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_1 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_1 <= 0;
          else 
            full_1 <= p1_full_1;
    end


  //data_0, which is an e_mux
  assign p0_stage_0 = ((full_1 & ~clear_fifo) == 0)? data_in :
    stage_1;

  //data_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_0 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_0))
          if (sync_reset & full_0 & !((full_1 == 0) & read & write))
              stage_0 <= 0;
          else 
            stage_0 <= p0_stage_0;
    end


  //control_0, which is an e_mux
  assign p0_full_0 = ((read & !write) == 0)? 1 :
    full_1;

  //control_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_0 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo & ~write)
              full_0 <= 0;
          else 
            full_0 <= p0_full_0;
    end


  assign one_count_plus_one = how_many_ones + 1;
  assign one_count_minus_one = how_many_ones - 1;
  //updated_one_count, which is an e_mux
  assign updated_one_count = ((((clear_fifo | sync_reset) & !write)))? 0 :
    ((((clear_fifo | sync_reset) & write)))? |data_in :
    ((read & (|data_in) & write & (|stage_0)))? how_many_ones :
    ((write & (|data_in)))? one_count_plus_one :
    ((read & (|stage_0)))? one_count_minus_one :
    how_many_ones;

  //counts how many ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          how_many_ones <= 0;
      else if (clear_fifo | sync_reset | read | write)
          how_many_ones <= updated_one_count;
    end


  //this fifo contains ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          fifo_contains_ones_n <= 1;
      else if (clear_fifo | sync_reset | read | write)
          fifo_contains_ones_n <= ~(|updated_one_count);
    end



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module rdv_fifo_for_cpu_0_instruction_master_to_sdram_0_s1_module (
                                                                    // inputs:
                                                                     clear_fifo,
                                                                     clk,
                                                                     data_in,
                                                                     read,
                                                                     reset_n,
                                                                     sync_reset,
                                                                     write,

                                                                    // outputs:
                                                                     data_out,
                                                                     empty,
                                                                     fifo_contains_ones_n,
                                                                     full
                                                                  )
;

  output           data_out;
  output           empty;
  output           fifo_contains_ones_n;
  output           full;
  input            clear_fifo;
  input            clk;
  input            data_in;
  input            read;
  input            reset_n;
  input            sync_reset;
  input            write;

  wire             data_out;
  wire             empty;
  reg              fifo_contains_ones_n;
  wire             full;
  reg              full_0;
  reg              full_1;
  reg              full_2;
  reg              full_3;
  reg              full_4;
  reg              full_5;
  reg              full_6;
  wire             full_7;
  reg     [  3: 0] how_many_ones;
  wire    [  3: 0] one_count_minus_one;
  wire    [  3: 0] one_count_plus_one;
  wire             p0_full_0;
  wire             p0_stage_0;
  wire             p1_full_1;
  wire             p1_stage_1;
  wire             p2_full_2;
  wire             p2_stage_2;
  wire             p3_full_3;
  wire             p3_stage_3;
  wire             p4_full_4;
  wire             p4_stage_4;
  wire             p5_full_5;
  wire             p5_stage_5;
  wire             p6_full_6;
  wire             p6_stage_6;
  reg              stage_0;
  reg              stage_1;
  reg              stage_2;
  reg              stage_3;
  reg              stage_4;
  reg              stage_5;
  reg              stage_6;
  wire    [  3: 0] updated_one_count;
  assign data_out = stage_0;
  assign full = full_6;
  assign empty = !full_0;
  assign full_7 = 0;
  //data_6, which is an e_mux
  assign p6_stage_6 = ((full_7 & ~clear_fifo) == 0)? data_in :
    data_in;

  //data_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_6 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_6))
          if (sync_reset & full_6 & !((full_7 == 0) & read & write))
              stage_6 <= 0;
          else 
            stage_6 <= p6_stage_6;
    end


  //control_6, which is an e_mux
  assign p6_full_6 = ((read & !write) == 0)? full_5 :
    0;

  //control_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_6 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_6 <= 0;
          else 
            full_6 <= p6_full_6;
    end


  //data_5, which is an e_mux
  assign p5_stage_5 = ((full_6 & ~clear_fifo) == 0)? data_in :
    stage_6;

  //data_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_5 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_5))
          if (sync_reset & full_5 & !((full_6 == 0) & read & write))
              stage_5 <= 0;
          else 
            stage_5 <= p5_stage_5;
    end


  //control_5, which is an e_mux
  assign p5_full_5 = ((read & !write) == 0)? full_4 :
    full_6;

  //control_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_5 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_5 <= 0;
          else 
            full_5 <= p5_full_5;
    end


  //data_4, which is an e_mux
  assign p4_stage_4 = ((full_5 & ~clear_fifo) == 0)? data_in :
    stage_5;

  //data_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_4 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_4))
          if (sync_reset & full_4 & !((full_5 == 0) & read & write))
              stage_4 <= 0;
          else 
            stage_4 <= p4_stage_4;
    end


  //control_4, which is an e_mux
  assign p4_full_4 = ((read & !write) == 0)? full_3 :
    full_5;

  //control_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_4 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_4 <= 0;
          else 
            full_4 <= p4_full_4;
    end


  //data_3, which is an e_mux
  assign p3_stage_3 = ((full_4 & ~clear_fifo) == 0)? data_in :
    stage_4;

  //data_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_3 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_3))
          if (sync_reset & full_3 & !((full_4 == 0) & read & write))
              stage_3 <= 0;
          else 
            stage_3 <= p3_stage_3;
    end


  //control_3, which is an e_mux
  assign p3_full_3 = ((read & !write) == 0)? full_2 :
    full_4;

  //control_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_3 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_3 <= 0;
          else 
            full_3 <= p3_full_3;
    end


  //data_2, which is an e_mux
  assign p2_stage_2 = ((full_3 & ~clear_fifo) == 0)? data_in :
    stage_3;

  //data_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_2 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_2))
          if (sync_reset & full_2 & !((full_3 == 0) & read & write))
              stage_2 <= 0;
          else 
            stage_2 <= p2_stage_2;
    end


  //control_2, which is an e_mux
  assign p2_full_2 = ((read & !write) == 0)? full_1 :
    full_3;

  //control_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_2 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_2 <= 0;
          else 
            full_2 <= p2_full_2;
    end


  //data_1, which is an e_mux
  assign p1_stage_1 = ((full_2 & ~clear_fifo) == 0)? data_in :
    stage_2;

  //data_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_1 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_1))
          if (sync_reset & full_1 & !((full_2 == 0) & read & write))
              stage_1 <= 0;
          else 
            stage_1 <= p1_stage_1;
    end


  //control_1, which is an e_mux
  assign p1_full_1 = ((read & !write) == 0)? full_0 :
    full_2;

  //control_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_1 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_1 <= 0;
          else 
            full_1 <= p1_full_1;
    end


  //data_0, which is an e_mux
  assign p0_stage_0 = ((full_1 & ~clear_fifo) == 0)? data_in :
    stage_1;

  //data_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_0 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_0))
          if (sync_reset & full_0 & !((full_1 == 0) & read & write))
              stage_0 <= 0;
          else 
            stage_0 <= p0_stage_0;
    end


  //control_0, which is an e_mux
  assign p0_full_0 = ((read & !write) == 0)? 1 :
    full_1;

  //control_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_0 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo & ~write)
              full_0 <= 0;
          else 
            full_0 <= p0_full_0;
    end


  assign one_count_plus_one = how_many_ones + 1;
  assign one_count_minus_one = how_many_ones - 1;
  //updated_one_count, which is an e_mux
  assign updated_one_count = ((((clear_fifo | sync_reset) & !write)))? 0 :
    ((((clear_fifo | sync_reset) & write)))? |data_in :
    ((read & (|data_in) & write & (|stage_0)))? how_many_ones :
    ((write & (|data_in)))? one_count_plus_one :
    ((read & (|stage_0)))? one_count_minus_one :
    how_many_ones;

  //counts how many ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          how_many_ones <= 0;
      else if (clear_fifo | sync_reset | read | write)
          how_many_ones <= updated_one_count;
    end


  //this fifo contains ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          fifo_contains_ones_n <= 1;
      else if (clear_fifo | sync_reset | read | write)
          fifo_contains_ones_n <= ~(|updated_one_count);
    end



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module sdram_0_s1_arbitrator (
                               // inputs:
                                clk,
                                cpu_0_data_master_address_to_slave,
                                cpu_0_data_master_byteenable,
                                cpu_0_data_master_dbs_address,
                                cpu_0_data_master_dbs_write_16,
                                cpu_0_data_master_no_byte_enables_and_last_term,
                                cpu_0_data_master_read,
                                cpu_0_data_master_waitrequest,
                                cpu_0_data_master_write,
                                cpu_0_instruction_master_address_to_slave,
                                cpu_0_instruction_master_dbs_address,
                                cpu_0_instruction_master_latency_counter,
                                cpu_0_instruction_master_read,
                                reset_n,
                                sdram_0_s1_readdata,
                                sdram_0_s1_readdatavalid,
                                sdram_0_s1_waitrequest,

                               // outputs:
                                cpu_0_data_master_byteenable_sdram_0_s1,
                                cpu_0_data_master_granted_sdram_0_s1,
                                cpu_0_data_master_qualified_request_sdram_0_s1,
                                cpu_0_data_master_read_data_valid_sdram_0_s1,
                                cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register,
                                cpu_0_data_master_requests_sdram_0_s1,
                                cpu_0_instruction_master_granted_sdram_0_s1,
                                cpu_0_instruction_master_qualified_request_sdram_0_s1,
                                cpu_0_instruction_master_read_data_valid_sdram_0_s1,
                                cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register,
                                cpu_0_instruction_master_requests_sdram_0_s1,
                                d1_sdram_0_s1_end_xfer,
                                sdram_0_s1_address,
                                sdram_0_s1_byteenable_n,
                                sdram_0_s1_chipselect,
                                sdram_0_s1_read_n,
                                sdram_0_s1_readdata_from_sa,
                                sdram_0_s1_reset_n,
                                sdram_0_s1_waitrequest_from_sa,
                                sdram_0_s1_write_n,
                                sdram_0_s1_writedata
                             )
;

  output  [  1: 0] cpu_0_data_master_byteenable_sdram_0_s1;
  output           cpu_0_data_master_granted_sdram_0_s1;
  output           cpu_0_data_master_qualified_request_sdram_0_s1;
  output           cpu_0_data_master_read_data_valid_sdram_0_s1;
  output           cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register;
  output           cpu_0_data_master_requests_sdram_0_s1;
  output           cpu_0_instruction_master_granted_sdram_0_s1;
  output           cpu_0_instruction_master_qualified_request_sdram_0_s1;
  output           cpu_0_instruction_master_read_data_valid_sdram_0_s1;
  output           cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register;
  output           cpu_0_instruction_master_requests_sdram_0_s1;
  output           d1_sdram_0_s1_end_xfer;
  output  [ 21: 0] sdram_0_s1_address;
  output  [  1: 0] sdram_0_s1_byteenable_n;
  output           sdram_0_s1_chipselect;
  output           sdram_0_s1_read_n;
  output  [ 15: 0] sdram_0_s1_readdata_from_sa;
  output           sdram_0_s1_reset_n;
  output           sdram_0_s1_waitrequest_from_sa;
  output           sdram_0_s1_write_n;
  output  [ 15: 0] sdram_0_s1_writedata;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input   [  3: 0] cpu_0_data_master_byteenable;
  input   [  1: 0] cpu_0_data_master_dbs_address;
  input   [ 15: 0] cpu_0_data_master_dbs_write_16;
  input            cpu_0_data_master_no_byte_enables_and_last_term;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_waitrequest;
  input            cpu_0_data_master_write;
  input   [ 24: 0] cpu_0_instruction_master_address_to_slave;
  input   [  1: 0] cpu_0_instruction_master_dbs_address;
  input            cpu_0_instruction_master_latency_counter;
  input            cpu_0_instruction_master_read;
  input            reset_n;
  input   [ 15: 0] sdram_0_s1_readdata;
  input            sdram_0_s1_readdatavalid;
  input            sdram_0_s1_waitrequest;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire    [  1: 0] cpu_0_data_master_byteenable_sdram_0_s1;
  wire    [  1: 0] cpu_0_data_master_byteenable_sdram_0_s1_segment_0;
  wire    [  1: 0] cpu_0_data_master_byteenable_sdram_0_s1_segment_1;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_sdram_0_s1;
  wire             cpu_0_data_master_qualified_request_sdram_0_s1;
  wire             cpu_0_data_master_rdv_fifo_empty_sdram_0_s1;
  wire             cpu_0_data_master_rdv_fifo_output_from_sdram_0_s1;
  wire             cpu_0_data_master_read_data_valid_sdram_0_s1;
  wire             cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register;
  wire             cpu_0_data_master_requests_sdram_0_s1;
  wire             cpu_0_data_master_saved_grant_sdram_0_s1;
  wire             cpu_0_instruction_master_arbiterlock;
  wire             cpu_0_instruction_master_arbiterlock2;
  wire             cpu_0_instruction_master_continuerequest;
  wire             cpu_0_instruction_master_granted_sdram_0_s1;
  wire             cpu_0_instruction_master_qualified_request_sdram_0_s1;
  wire             cpu_0_instruction_master_rdv_fifo_empty_sdram_0_s1;
  wire             cpu_0_instruction_master_rdv_fifo_output_from_sdram_0_s1;
  wire             cpu_0_instruction_master_read_data_valid_sdram_0_s1;
  wire             cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register;
  wire             cpu_0_instruction_master_requests_sdram_0_s1;
  wire             cpu_0_instruction_master_saved_grant_sdram_0_s1;
  reg              d1_reasons_to_wait;
  reg              d1_sdram_0_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_sdram_0_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  reg              last_cycle_cpu_0_data_master_granted_slave_sdram_0_s1;
  reg              last_cycle_cpu_0_instruction_master_granted_slave_sdram_0_s1;
  wire    [ 21: 0] sdram_0_s1_address;
  wire             sdram_0_s1_allgrants;
  wire             sdram_0_s1_allow_new_arb_cycle;
  wire             sdram_0_s1_any_bursting_master_saved_grant;
  wire             sdram_0_s1_any_continuerequest;
  reg     [  1: 0] sdram_0_s1_arb_addend;
  wire             sdram_0_s1_arb_counter_enable;
  reg     [  1: 0] sdram_0_s1_arb_share_counter;
  wire    [  1: 0] sdram_0_s1_arb_share_counter_next_value;
  wire    [  1: 0] sdram_0_s1_arb_share_set_values;
  wire    [  1: 0] sdram_0_s1_arb_winner;
  wire             sdram_0_s1_arbitration_holdoff_internal;
  wire             sdram_0_s1_beginbursttransfer_internal;
  wire             sdram_0_s1_begins_xfer;
  wire    [  1: 0] sdram_0_s1_byteenable_n;
  wire             sdram_0_s1_chipselect;
  wire    [  3: 0] sdram_0_s1_chosen_master_double_vector;
  wire    [  1: 0] sdram_0_s1_chosen_master_rot_left;
  wire             sdram_0_s1_end_xfer;
  wire             sdram_0_s1_firsttransfer;
  wire    [  1: 0] sdram_0_s1_grant_vector;
  wire             sdram_0_s1_in_a_read_cycle;
  wire             sdram_0_s1_in_a_write_cycle;
  wire    [  1: 0] sdram_0_s1_master_qreq_vector;
  wire             sdram_0_s1_move_on_to_next_transaction;
  wire             sdram_0_s1_non_bursting_master_requests;
  wire             sdram_0_s1_read_n;
  wire    [ 15: 0] sdram_0_s1_readdata_from_sa;
  wire             sdram_0_s1_readdatavalid_from_sa;
  reg              sdram_0_s1_reg_firsttransfer;
  wire             sdram_0_s1_reset_n;
  reg     [  1: 0] sdram_0_s1_saved_chosen_master_vector;
  reg              sdram_0_s1_slavearbiterlockenable;
  wire             sdram_0_s1_slavearbiterlockenable2;
  wire             sdram_0_s1_unreg_firsttransfer;
  wire             sdram_0_s1_waitrequest_from_sa;
  wire             sdram_0_s1_waits_for_read;
  wire             sdram_0_s1_waits_for_write;
  wire             sdram_0_s1_write_n;
  wire    [ 15: 0] sdram_0_s1_writedata;
  wire    [ 24: 0] shifted_address_to_sdram_0_s1_from_cpu_0_data_master;
  wire    [ 24: 0] shifted_address_to_sdram_0_s1_from_cpu_0_instruction_master;
  wire             wait_for_sdram_0_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~sdram_0_s1_end_xfer;
    end


  assign sdram_0_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_sdram_0_s1 | cpu_0_instruction_master_qualified_request_sdram_0_s1));
  //assign sdram_0_s1_readdatavalid_from_sa = sdram_0_s1_readdatavalid so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sdram_0_s1_readdatavalid_from_sa = sdram_0_s1_readdatavalid;

  //assign sdram_0_s1_readdata_from_sa = sdram_0_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sdram_0_s1_readdata_from_sa = sdram_0_s1_readdata;

  assign cpu_0_data_master_requests_sdram_0_s1 = ({cpu_0_data_master_address_to_slave[24 : 23] , 23'b0} == 25'h800000) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //assign sdram_0_s1_waitrequest_from_sa = sdram_0_s1_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sdram_0_s1_waitrequest_from_sa = sdram_0_s1_waitrequest;

  //sdram_0_s1_arb_share_counter set values, which is an e_mux
  assign sdram_0_s1_arb_share_set_values = (cpu_0_data_master_granted_sdram_0_s1)? 2 :
    (cpu_0_instruction_master_granted_sdram_0_s1)? 2 :
    (cpu_0_data_master_granted_sdram_0_s1)? 2 :
    (cpu_0_instruction_master_granted_sdram_0_s1)? 2 :
    1;

  //sdram_0_s1_non_bursting_master_requests mux, which is an e_mux
  assign sdram_0_s1_non_bursting_master_requests = cpu_0_data_master_requests_sdram_0_s1 |
    cpu_0_instruction_master_requests_sdram_0_s1 |
    cpu_0_data_master_requests_sdram_0_s1 |
    cpu_0_instruction_master_requests_sdram_0_s1;

  //sdram_0_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign sdram_0_s1_any_bursting_master_saved_grant = 0;

  //sdram_0_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign sdram_0_s1_arb_share_counter_next_value = sdram_0_s1_firsttransfer ? (sdram_0_s1_arb_share_set_values - 1) : |sdram_0_s1_arb_share_counter ? (sdram_0_s1_arb_share_counter - 1) : 0;

  //sdram_0_s1_allgrants all slave grants, which is an e_mux
  assign sdram_0_s1_allgrants = (|sdram_0_s1_grant_vector) |
    (|sdram_0_s1_grant_vector) |
    (|sdram_0_s1_grant_vector) |
    (|sdram_0_s1_grant_vector);

  //sdram_0_s1_end_xfer assignment, which is an e_assign
  assign sdram_0_s1_end_xfer = ~(sdram_0_s1_waits_for_read | sdram_0_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_sdram_0_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_sdram_0_s1 = sdram_0_s1_end_xfer & (~sdram_0_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //sdram_0_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign sdram_0_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_sdram_0_s1 & sdram_0_s1_allgrants) | (end_xfer_arb_share_counter_term_sdram_0_s1 & ~sdram_0_s1_non_bursting_master_requests);

  //sdram_0_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_0_s1_arb_share_counter <= 0;
      else if (sdram_0_s1_arb_counter_enable)
          sdram_0_s1_arb_share_counter <= sdram_0_s1_arb_share_counter_next_value;
    end


  //sdram_0_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_0_s1_slavearbiterlockenable <= 0;
      else if ((|sdram_0_s1_master_qreq_vector & end_xfer_arb_share_counter_term_sdram_0_s1) | (end_xfer_arb_share_counter_term_sdram_0_s1 & ~sdram_0_s1_non_bursting_master_requests))
          sdram_0_s1_slavearbiterlockenable <= |sdram_0_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master sdram_0/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = sdram_0_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //sdram_0_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign sdram_0_s1_slavearbiterlockenable2 = |sdram_0_s1_arb_share_counter_next_value;

  //cpu_0/data_master sdram_0/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = sdram_0_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //cpu_0/instruction_master sdram_0/s1 arbiterlock, which is an e_assign
  assign cpu_0_instruction_master_arbiterlock = sdram_0_s1_slavearbiterlockenable & cpu_0_instruction_master_continuerequest;

  //cpu_0/instruction_master sdram_0/s1 arbiterlock2, which is an e_assign
  assign cpu_0_instruction_master_arbiterlock2 = sdram_0_s1_slavearbiterlockenable2 & cpu_0_instruction_master_continuerequest;

  //cpu_0/instruction_master granted sdram_0/s1 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_0_instruction_master_granted_slave_sdram_0_s1 <= 0;
      else 
        last_cycle_cpu_0_instruction_master_granted_slave_sdram_0_s1 <= cpu_0_instruction_master_saved_grant_sdram_0_s1 ? 1 : (sdram_0_s1_arbitration_holdoff_internal | ~cpu_0_instruction_master_requests_sdram_0_s1) ? 0 : last_cycle_cpu_0_instruction_master_granted_slave_sdram_0_s1;
    end


  //cpu_0_instruction_master_continuerequest continued request, which is an e_mux
  assign cpu_0_instruction_master_continuerequest = last_cycle_cpu_0_instruction_master_granted_slave_sdram_0_s1 & cpu_0_instruction_master_requests_sdram_0_s1;

  //sdram_0_s1_any_continuerequest at least one master continues requesting, which is an e_mux
  assign sdram_0_s1_any_continuerequest = cpu_0_instruction_master_continuerequest |
    cpu_0_data_master_continuerequest;

  assign cpu_0_data_master_qualified_request_sdram_0_s1 = cpu_0_data_master_requests_sdram_0_s1 & ~((cpu_0_data_master_read & (~cpu_0_data_master_waitrequest | (|cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register))) | ((~cpu_0_data_master_waitrequest | cpu_0_data_master_no_byte_enables_and_last_term | !cpu_0_data_master_byteenable_sdram_0_s1) & cpu_0_data_master_write) | cpu_0_instruction_master_arbiterlock);
  //unique name for sdram_0_s1_move_on_to_next_transaction, which is an e_assign
  assign sdram_0_s1_move_on_to_next_transaction = sdram_0_s1_readdatavalid_from_sa;

  //rdv_fifo_for_cpu_0_data_master_to_sdram_0_s1, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_cpu_0_data_master_to_sdram_0_s1_module rdv_fifo_for_cpu_0_data_master_to_sdram_0_s1
    (
      .clear_fifo           (1'b0),
      .clk                  (clk),
      .data_in              (cpu_0_data_master_granted_sdram_0_s1),
      .data_out             (cpu_0_data_master_rdv_fifo_output_from_sdram_0_s1),
      .empty                (),
      .fifo_contains_ones_n (cpu_0_data_master_rdv_fifo_empty_sdram_0_s1),
      .full                 (),
      .read                 (sdram_0_s1_move_on_to_next_transaction),
      .reset_n              (reset_n),
      .sync_reset           (1'b0),
      .write                (in_a_read_cycle & ~sdram_0_s1_waits_for_read)
    );

  assign cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register = ~cpu_0_data_master_rdv_fifo_empty_sdram_0_s1;
  //local readdatavalid cpu_0_data_master_read_data_valid_sdram_0_s1, which is an e_mux
  assign cpu_0_data_master_read_data_valid_sdram_0_s1 = (sdram_0_s1_readdatavalid_from_sa & cpu_0_data_master_rdv_fifo_output_from_sdram_0_s1) & ~ cpu_0_data_master_rdv_fifo_empty_sdram_0_s1;

  //sdram_0_s1_writedata mux, which is an e_mux
  assign sdram_0_s1_writedata = cpu_0_data_master_dbs_write_16;

  assign cpu_0_instruction_master_requests_sdram_0_s1 = (({cpu_0_instruction_master_address_to_slave[24 : 23] , 23'b0} == 25'h800000) & (cpu_0_instruction_master_read)) & cpu_0_instruction_master_read;
  //cpu_0/data_master granted sdram_0/s1 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_0_data_master_granted_slave_sdram_0_s1 <= 0;
      else 
        last_cycle_cpu_0_data_master_granted_slave_sdram_0_s1 <= cpu_0_data_master_saved_grant_sdram_0_s1 ? 1 : (sdram_0_s1_arbitration_holdoff_internal | ~cpu_0_data_master_requests_sdram_0_s1) ? 0 : last_cycle_cpu_0_data_master_granted_slave_sdram_0_s1;
    end


  //cpu_0_data_master_continuerequest continued request, which is an e_mux
  assign cpu_0_data_master_continuerequest = last_cycle_cpu_0_data_master_granted_slave_sdram_0_s1 & cpu_0_data_master_requests_sdram_0_s1;

  assign cpu_0_instruction_master_qualified_request_sdram_0_s1 = cpu_0_instruction_master_requests_sdram_0_s1 & ~((cpu_0_instruction_master_read & ((cpu_0_instruction_master_latency_counter != 0) | (1 < cpu_0_instruction_master_latency_counter))) | cpu_0_data_master_arbiterlock);
  //rdv_fifo_for_cpu_0_instruction_master_to_sdram_0_s1, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_cpu_0_instruction_master_to_sdram_0_s1_module rdv_fifo_for_cpu_0_instruction_master_to_sdram_0_s1
    (
      .clear_fifo           (1'b0),
      .clk                  (clk),
      .data_in              (cpu_0_instruction_master_granted_sdram_0_s1),
      .data_out             (cpu_0_instruction_master_rdv_fifo_output_from_sdram_0_s1),
      .empty                (),
      .fifo_contains_ones_n (cpu_0_instruction_master_rdv_fifo_empty_sdram_0_s1),
      .full                 (),
      .read                 (sdram_0_s1_move_on_to_next_transaction),
      .reset_n              (reset_n),
      .sync_reset           (1'b0),
      .write                (in_a_read_cycle & ~sdram_0_s1_waits_for_read)
    );

  assign cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register = ~cpu_0_instruction_master_rdv_fifo_empty_sdram_0_s1;
  //local readdatavalid cpu_0_instruction_master_read_data_valid_sdram_0_s1, which is an e_mux
  assign cpu_0_instruction_master_read_data_valid_sdram_0_s1 = (sdram_0_s1_readdatavalid_from_sa & cpu_0_instruction_master_rdv_fifo_output_from_sdram_0_s1) & ~ cpu_0_instruction_master_rdv_fifo_empty_sdram_0_s1;

  //allow new arb cycle for sdram_0/s1, which is an e_assign
  assign sdram_0_s1_allow_new_arb_cycle = ~cpu_0_data_master_arbiterlock & ~cpu_0_instruction_master_arbiterlock;

  //cpu_0/instruction_master assignment into master qualified-requests vector for sdram_0/s1, which is an e_assign
  assign sdram_0_s1_master_qreq_vector[0] = cpu_0_instruction_master_qualified_request_sdram_0_s1;

  //cpu_0/instruction_master grant sdram_0/s1, which is an e_assign
  assign cpu_0_instruction_master_granted_sdram_0_s1 = sdram_0_s1_grant_vector[0];

  //cpu_0/instruction_master saved-grant sdram_0/s1, which is an e_assign
  assign cpu_0_instruction_master_saved_grant_sdram_0_s1 = sdram_0_s1_arb_winner[0] && cpu_0_instruction_master_requests_sdram_0_s1;

  //cpu_0/data_master assignment into master qualified-requests vector for sdram_0/s1, which is an e_assign
  assign sdram_0_s1_master_qreq_vector[1] = cpu_0_data_master_qualified_request_sdram_0_s1;

  //cpu_0/data_master grant sdram_0/s1, which is an e_assign
  assign cpu_0_data_master_granted_sdram_0_s1 = sdram_0_s1_grant_vector[1];

  //cpu_0/data_master saved-grant sdram_0/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_sdram_0_s1 = sdram_0_s1_arb_winner[1] && cpu_0_data_master_requests_sdram_0_s1;

  //sdram_0/s1 chosen-master double-vector, which is an e_assign
  assign sdram_0_s1_chosen_master_double_vector = {sdram_0_s1_master_qreq_vector, sdram_0_s1_master_qreq_vector} & ({~sdram_0_s1_master_qreq_vector, ~sdram_0_s1_master_qreq_vector} + sdram_0_s1_arb_addend);

  //stable onehot encoding of arb winner
  assign sdram_0_s1_arb_winner = (sdram_0_s1_allow_new_arb_cycle & | sdram_0_s1_grant_vector) ? sdram_0_s1_grant_vector : sdram_0_s1_saved_chosen_master_vector;

  //saved sdram_0_s1_grant_vector, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_0_s1_saved_chosen_master_vector <= 0;
      else if (sdram_0_s1_allow_new_arb_cycle)
          sdram_0_s1_saved_chosen_master_vector <= |sdram_0_s1_grant_vector ? sdram_0_s1_grant_vector : sdram_0_s1_saved_chosen_master_vector;
    end


  //onehot encoding of chosen master
  assign sdram_0_s1_grant_vector = {(sdram_0_s1_chosen_master_double_vector[1] | sdram_0_s1_chosen_master_double_vector[3]),
    (sdram_0_s1_chosen_master_double_vector[0] | sdram_0_s1_chosen_master_double_vector[2])};

  //sdram_0/s1 chosen master rotated left, which is an e_assign
  assign sdram_0_s1_chosen_master_rot_left = (sdram_0_s1_arb_winner << 1) ? (sdram_0_s1_arb_winner << 1) : 1;

  //sdram_0/s1's addend for next-master-grant
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_0_s1_arb_addend <= 1;
      else if (|sdram_0_s1_grant_vector)
          sdram_0_s1_arb_addend <= sdram_0_s1_end_xfer? sdram_0_s1_chosen_master_rot_left : sdram_0_s1_grant_vector;
    end


  //sdram_0_s1_reset_n assignment, which is an e_assign
  assign sdram_0_s1_reset_n = reset_n;

  assign sdram_0_s1_chipselect = cpu_0_data_master_granted_sdram_0_s1 | cpu_0_instruction_master_granted_sdram_0_s1;
  //sdram_0_s1_firsttransfer first transaction, which is an e_assign
  assign sdram_0_s1_firsttransfer = sdram_0_s1_begins_xfer ? sdram_0_s1_unreg_firsttransfer : sdram_0_s1_reg_firsttransfer;

  //sdram_0_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign sdram_0_s1_unreg_firsttransfer = ~(sdram_0_s1_slavearbiterlockenable & sdram_0_s1_any_continuerequest);

  //sdram_0_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_0_s1_reg_firsttransfer <= 1'b1;
      else if (sdram_0_s1_begins_xfer)
          sdram_0_s1_reg_firsttransfer <= sdram_0_s1_unreg_firsttransfer;
    end


  //sdram_0_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign sdram_0_s1_beginbursttransfer_internal = sdram_0_s1_begins_xfer;

  //sdram_0_s1_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  assign sdram_0_s1_arbitration_holdoff_internal = sdram_0_s1_begins_xfer & sdram_0_s1_firsttransfer;

  //~sdram_0_s1_read_n assignment, which is an e_mux
  assign sdram_0_s1_read_n = ~((cpu_0_data_master_granted_sdram_0_s1 & cpu_0_data_master_read) | (cpu_0_instruction_master_granted_sdram_0_s1 & cpu_0_instruction_master_read));

  //~sdram_0_s1_write_n assignment, which is an e_mux
  assign sdram_0_s1_write_n = ~(cpu_0_data_master_granted_sdram_0_s1 & cpu_0_data_master_write);

  assign shifted_address_to_sdram_0_s1_from_cpu_0_data_master = {cpu_0_data_master_address_to_slave >> 2,
    cpu_0_data_master_dbs_address[1],
    {1 {1'b0}}};

  //sdram_0_s1_address mux, which is an e_mux
  assign sdram_0_s1_address = (cpu_0_data_master_granted_sdram_0_s1)? (shifted_address_to_sdram_0_s1_from_cpu_0_data_master >> 1) :
    (shifted_address_to_sdram_0_s1_from_cpu_0_instruction_master >> 1);

  assign shifted_address_to_sdram_0_s1_from_cpu_0_instruction_master = {cpu_0_instruction_master_address_to_slave >> 2,
    cpu_0_instruction_master_dbs_address[1],
    {1 {1'b0}}};

  //d1_sdram_0_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_sdram_0_s1_end_xfer <= 1;
      else 
        d1_sdram_0_s1_end_xfer <= sdram_0_s1_end_xfer;
    end


  //sdram_0_s1_waits_for_read in a cycle, which is an e_mux
  assign sdram_0_s1_waits_for_read = sdram_0_s1_in_a_read_cycle & sdram_0_s1_waitrequest_from_sa;

  //sdram_0_s1_in_a_read_cycle assignment, which is an e_assign
  assign sdram_0_s1_in_a_read_cycle = (cpu_0_data_master_granted_sdram_0_s1 & cpu_0_data_master_read) | (cpu_0_instruction_master_granted_sdram_0_s1 & cpu_0_instruction_master_read);

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = sdram_0_s1_in_a_read_cycle;

  //sdram_0_s1_waits_for_write in a cycle, which is an e_mux
  assign sdram_0_s1_waits_for_write = sdram_0_s1_in_a_write_cycle & sdram_0_s1_waitrequest_from_sa;

  //sdram_0_s1_in_a_write_cycle assignment, which is an e_assign
  assign sdram_0_s1_in_a_write_cycle = cpu_0_data_master_granted_sdram_0_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = sdram_0_s1_in_a_write_cycle;

  assign wait_for_sdram_0_s1_counter = 0;
  //~sdram_0_s1_byteenable_n byte enable port mux, which is an e_mux
  assign sdram_0_s1_byteenable_n = ~((cpu_0_data_master_granted_sdram_0_s1)? cpu_0_data_master_byteenable_sdram_0_s1 :
    -1);

  assign {cpu_0_data_master_byteenable_sdram_0_s1_segment_1,
cpu_0_data_master_byteenable_sdram_0_s1_segment_0} = cpu_0_data_master_byteenable;
  assign cpu_0_data_master_byteenable_sdram_0_s1 = ((cpu_0_data_master_dbs_address[1] == 0))? cpu_0_data_master_byteenable_sdram_0_s1_segment_0 :
    cpu_0_data_master_byteenable_sdram_0_s1_segment_1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //sdram_0/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end


  //grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_0_data_master_granted_sdram_0_s1 + cpu_0_instruction_master_granted_sdram_0_s1 > 1)
        begin
          $write("%0d ns: > 1 of grant signals are active simultaneously", $time);
          $stop;
        end
    end


  //saved_grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_0_data_master_saved_grant_sdram_0_s1 + cpu_0_instruction_master_saved_grant_sdram_0_s1 > 1)
        begin
          $write("%0d ns: > 1 of saved_grant signals are active simultaneously", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module seven_seg_middle_pio_s1_arbitrator (
                                            // inputs:
                                             clk,
                                             cpu_0_data_master_address_to_slave,
                                             cpu_0_data_master_read,
                                             cpu_0_data_master_waitrequest,
                                             cpu_0_data_master_write,
                                             cpu_0_data_master_writedata,
                                             reset_n,
                                             seven_seg_middle_pio_s1_readdata,

                                            // outputs:
                                             cpu_0_data_master_granted_seven_seg_middle_pio_s1,
                                             cpu_0_data_master_qualified_request_seven_seg_middle_pio_s1,
                                             cpu_0_data_master_read_data_valid_seven_seg_middle_pio_s1,
                                             cpu_0_data_master_requests_seven_seg_middle_pio_s1,
                                             d1_seven_seg_middle_pio_s1_end_xfer,
                                             seven_seg_middle_pio_s1_address,
                                             seven_seg_middle_pio_s1_chipselect,
                                             seven_seg_middle_pio_s1_readdata_from_sa,
                                             seven_seg_middle_pio_s1_reset_n,
                                             seven_seg_middle_pio_s1_write_n,
                                             seven_seg_middle_pio_s1_writedata
                                          )
;

  output           cpu_0_data_master_granted_seven_seg_middle_pio_s1;
  output           cpu_0_data_master_qualified_request_seven_seg_middle_pio_s1;
  output           cpu_0_data_master_read_data_valid_seven_seg_middle_pio_s1;
  output           cpu_0_data_master_requests_seven_seg_middle_pio_s1;
  output           d1_seven_seg_middle_pio_s1_end_xfer;
  output  [  1: 0] seven_seg_middle_pio_s1_address;
  output           seven_seg_middle_pio_s1_chipselect;
  output  [ 15: 0] seven_seg_middle_pio_s1_readdata_from_sa;
  output           seven_seg_middle_pio_s1_reset_n;
  output           seven_seg_middle_pio_s1_write_n;
  output  [ 15: 0] seven_seg_middle_pio_s1_writedata;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_waitrequest;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            reset_n;
  input   [ 15: 0] seven_seg_middle_pio_s1_readdata;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_seven_seg_middle_pio_s1;
  wire             cpu_0_data_master_qualified_request_seven_seg_middle_pio_s1;
  wire             cpu_0_data_master_read_data_valid_seven_seg_middle_pio_s1;
  wire             cpu_0_data_master_requests_seven_seg_middle_pio_s1;
  wire             cpu_0_data_master_saved_grant_seven_seg_middle_pio_s1;
  reg              d1_reasons_to_wait;
  reg              d1_seven_seg_middle_pio_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_seven_seg_middle_pio_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] seven_seg_middle_pio_s1_address;
  wire             seven_seg_middle_pio_s1_allgrants;
  wire             seven_seg_middle_pio_s1_allow_new_arb_cycle;
  wire             seven_seg_middle_pio_s1_any_bursting_master_saved_grant;
  wire             seven_seg_middle_pio_s1_any_continuerequest;
  wire             seven_seg_middle_pio_s1_arb_counter_enable;
  reg     [  1: 0] seven_seg_middle_pio_s1_arb_share_counter;
  wire    [  1: 0] seven_seg_middle_pio_s1_arb_share_counter_next_value;
  wire    [  1: 0] seven_seg_middle_pio_s1_arb_share_set_values;
  wire             seven_seg_middle_pio_s1_beginbursttransfer_internal;
  wire             seven_seg_middle_pio_s1_begins_xfer;
  wire             seven_seg_middle_pio_s1_chipselect;
  wire             seven_seg_middle_pio_s1_end_xfer;
  wire             seven_seg_middle_pio_s1_firsttransfer;
  wire             seven_seg_middle_pio_s1_grant_vector;
  wire             seven_seg_middle_pio_s1_in_a_read_cycle;
  wire             seven_seg_middle_pio_s1_in_a_write_cycle;
  wire             seven_seg_middle_pio_s1_master_qreq_vector;
  wire             seven_seg_middle_pio_s1_non_bursting_master_requests;
  wire    [ 15: 0] seven_seg_middle_pio_s1_readdata_from_sa;
  reg              seven_seg_middle_pio_s1_reg_firsttransfer;
  wire             seven_seg_middle_pio_s1_reset_n;
  reg              seven_seg_middle_pio_s1_slavearbiterlockenable;
  wire             seven_seg_middle_pio_s1_slavearbiterlockenable2;
  wire             seven_seg_middle_pio_s1_unreg_firsttransfer;
  wire             seven_seg_middle_pio_s1_waits_for_read;
  wire             seven_seg_middle_pio_s1_waits_for_write;
  wire             seven_seg_middle_pio_s1_write_n;
  wire    [ 15: 0] seven_seg_middle_pio_s1_writedata;
  wire    [ 24: 0] shifted_address_to_seven_seg_middle_pio_s1_from_cpu_0_data_master;
  wire             wait_for_seven_seg_middle_pio_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~seven_seg_middle_pio_s1_end_xfer;
    end


  assign seven_seg_middle_pio_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_seven_seg_middle_pio_s1));
  //assign seven_seg_middle_pio_s1_readdata_from_sa = seven_seg_middle_pio_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign seven_seg_middle_pio_s1_readdata_from_sa = seven_seg_middle_pio_s1_readdata;

  assign cpu_0_data_master_requests_seven_seg_middle_pio_s1 = ({cpu_0_data_master_address_to_slave[24 : 4] , 4'b0} == 25'h10010a0) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //seven_seg_middle_pio_s1_arb_share_counter set values, which is an e_mux
  assign seven_seg_middle_pio_s1_arb_share_set_values = 1;

  //seven_seg_middle_pio_s1_non_bursting_master_requests mux, which is an e_mux
  assign seven_seg_middle_pio_s1_non_bursting_master_requests = cpu_0_data_master_requests_seven_seg_middle_pio_s1;

  //seven_seg_middle_pio_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign seven_seg_middle_pio_s1_any_bursting_master_saved_grant = 0;

  //seven_seg_middle_pio_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign seven_seg_middle_pio_s1_arb_share_counter_next_value = seven_seg_middle_pio_s1_firsttransfer ? (seven_seg_middle_pio_s1_arb_share_set_values - 1) : |seven_seg_middle_pio_s1_arb_share_counter ? (seven_seg_middle_pio_s1_arb_share_counter - 1) : 0;

  //seven_seg_middle_pio_s1_allgrants all slave grants, which is an e_mux
  assign seven_seg_middle_pio_s1_allgrants = |seven_seg_middle_pio_s1_grant_vector;

  //seven_seg_middle_pio_s1_end_xfer assignment, which is an e_assign
  assign seven_seg_middle_pio_s1_end_xfer = ~(seven_seg_middle_pio_s1_waits_for_read | seven_seg_middle_pio_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_seven_seg_middle_pio_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_seven_seg_middle_pio_s1 = seven_seg_middle_pio_s1_end_xfer & (~seven_seg_middle_pio_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //seven_seg_middle_pio_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign seven_seg_middle_pio_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_seven_seg_middle_pio_s1 & seven_seg_middle_pio_s1_allgrants) | (end_xfer_arb_share_counter_term_seven_seg_middle_pio_s1 & ~seven_seg_middle_pio_s1_non_bursting_master_requests);

  //seven_seg_middle_pio_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          seven_seg_middle_pio_s1_arb_share_counter <= 0;
      else if (seven_seg_middle_pio_s1_arb_counter_enable)
          seven_seg_middle_pio_s1_arb_share_counter <= seven_seg_middle_pio_s1_arb_share_counter_next_value;
    end


  //seven_seg_middle_pio_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          seven_seg_middle_pio_s1_slavearbiterlockenable <= 0;
      else if ((|seven_seg_middle_pio_s1_master_qreq_vector & end_xfer_arb_share_counter_term_seven_seg_middle_pio_s1) | (end_xfer_arb_share_counter_term_seven_seg_middle_pio_s1 & ~seven_seg_middle_pio_s1_non_bursting_master_requests))
          seven_seg_middle_pio_s1_slavearbiterlockenable <= |seven_seg_middle_pio_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master seven_seg_middle_pio/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = seven_seg_middle_pio_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //seven_seg_middle_pio_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign seven_seg_middle_pio_s1_slavearbiterlockenable2 = |seven_seg_middle_pio_s1_arb_share_counter_next_value;

  //cpu_0/data_master seven_seg_middle_pio/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = seven_seg_middle_pio_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //seven_seg_middle_pio_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign seven_seg_middle_pio_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_seven_seg_middle_pio_s1 = cpu_0_data_master_requests_seven_seg_middle_pio_s1 & ~(((~cpu_0_data_master_waitrequest) & cpu_0_data_master_write));
  //seven_seg_middle_pio_s1_writedata mux, which is an e_mux
  assign seven_seg_middle_pio_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_seven_seg_middle_pio_s1 = cpu_0_data_master_qualified_request_seven_seg_middle_pio_s1;

  //cpu_0/data_master saved-grant seven_seg_middle_pio/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_seven_seg_middle_pio_s1 = cpu_0_data_master_requests_seven_seg_middle_pio_s1;

  //allow new arb cycle for seven_seg_middle_pio/s1, which is an e_assign
  assign seven_seg_middle_pio_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign seven_seg_middle_pio_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign seven_seg_middle_pio_s1_master_qreq_vector = 1;

  //seven_seg_middle_pio_s1_reset_n assignment, which is an e_assign
  assign seven_seg_middle_pio_s1_reset_n = reset_n;

  assign seven_seg_middle_pio_s1_chipselect = cpu_0_data_master_granted_seven_seg_middle_pio_s1;
  //seven_seg_middle_pio_s1_firsttransfer first transaction, which is an e_assign
  assign seven_seg_middle_pio_s1_firsttransfer = seven_seg_middle_pio_s1_begins_xfer ? seven_seg_middle_pio_s1_unreg_firsttransfer : seven_seg_middle_pio_s1_reg_firsttransfer;

  //seven_seg_middle_pio_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign seven_seg_middle_pio_s1_unreg_firsttransfer = ~(seven_seg_middle_pio_s1_slavearbiterlockenable & seven_seg_middle_pio_s1_any_continuerequest);

  //seven_seg_middle_pio_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          seven_seg_middle_pio_s1_reg_firsttransfer <= 1'b1;
      else if (seven_seg_middle_pio_s1_begins_xfer)
          seven_seg_middle_pio_s1_reg_firsttransfer <= seven_seg_middle_pio_s1_unreg_firsttransfer;
    end


  //seven_seg_middle_pio_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign seven_seg_middle_pio_s1_beginbursttransfer_internal = seven_seg_middle_pio_s1_begins_xfer;

  //~seven_seg_middle_pio_s1_write_n assignment, which is an e_mux
  assign seven_seg_middle_pio_s1_write_n = ~(cpu_0_data_master_granted_seven_seg_middle_pio_s1 & cpu_0_data_master_write);

  assign shifted_address_to_seven_seg_middle_pio_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //seven_seg_middle_pio_s1_address mux, which is an e_mux
  assign seven_seg_middle_pio_s1_address = shifted_address_to_seven_seg_middle_pio_s1_from_cpu_0_data_master >> 2;

  //d1_seven_seg_middle_pio_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_seven_seg_middle_pio_s1_end_xfer <= 1;
      else 
        d1_seven_seg_middle_pio_s1_end_xfer <= seven_seg_middle_pio_s1_end_xfer;
    end


  //seven_seg_middle_pio_s1_waits_for_read in a cycle, which is an e_mux
  assign seven_seg_middle_pio_s1_waits_for_read = seven_seg_middle_pio_s1_in_a_read_cycle & seven_seg_middle_pio_s1_begins_xfer;

  //seven_seg_middle_pio_s1_in_a_read_cycle assignment, which is an e_assign
  assign seven_seg_middle_pio_s1_in_a_read_cycle = cpu_0_data_master_granted_seven_seg_middle_pio_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = seven_seg_middle_pio_s1_in_a_read_cycle;

  //seven_seg_middle_pio_s1_waits_for_write in a cycle, which is an e_mux
  assign seven_seg_middle_pio_s1_waits_for_write = seven_seg_middle_pio_s1_in_a_write_cycle & 0;

  //seven_seg_middle_pio_s1_in_a_write_cycle assignment, which is an e_assign
  assign seven_seg_middle_pio_s1_in_a_write_cycle = cpu_0_data_master_granted_seven_seg_middle_pio_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = seven_seg_middle_pio_s1_in_a_write_cycle;

  assign wait_for_seven_seg_middle_pio_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //seven_seg_middle_pio/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module seven_seg_pio_s1_arbitrator (
                                     // inputs:
                                      clk,
                                      cpu_0_data_master_address_to_slave,
                                      cpu_0_data_master_read,
                                      cpu_0_data_master_waitrequest,
                                      cpu_0_data_master_write,
                                      cpu_0_data_master_writedata,
                                      reset_n,
                                      seven_seg_pio_s1_readdata,

                                     // outputs:
                                      cpu_0_data_master_granted_seven_seg_pio_s1,
                                      cpu_0_data_master_qualified_request_seven_seg_pio_s1,
                                      cpu_0_data_master_read_data_valid_seven_seg_pio_s1,
                                      cpu_0_data_master_requests_seven_seg_pio_s1,
                                      d1_seven_seg_pio_s1_end_xfer,
                                      seven_seg_pio_s1_address,
                                      seven_seg_pio_s1_chipselect,
                                      seven_seg_pio_s1_readdata_from_sa,
                                      seven_seg_pio_s1_reset_n,
                                      seven_seg_pio_s1_write_n,
                                      seven_seg_pio_s1_writedata
                                   )
;

  output           cpu_0_data_master_granted_seven_seg_pio_s1;
  output           cpu_0_data_master_qualified_request_seven_seg_pio_s1;
  output           cpu_0_data_master_read_data_valid_seven_seg_pio_s1;
  output           cpu_0_data_master_requests_seven_seg_pio_s1;
  output           d1_seven_seg_pio_s1_end_xfer;
  output  [  1: 0] seven_seg_pio_s1_address;
  output           seven_seg_pio_s1_chipselect;
  output  [ 15: 0] seven_seg_pio_s1_readdata_from_sa;
  output           seven_seg_pio_s1_reset_n;
  output           seven_seg_pio_s1_write_n;
  output  [ 15: 0] seven_seg_pio_s1_writedata;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_waitrequest;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            reset_n;
  input   [ 15: 0] seven_seg_pio_s1_readdata;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_seven_seg_pio_s1;
  wire             cpu_0_data_master_qualified_request_seven_seg_pio_s1;
  wire             cpu_0_data_master_read_data_valid_seven_seg_pio_s1;
  wire             cpu_0_data_master_requests_seven_seg_pio_s1;
  wire             cpu_0_data_master_saved_grant_seven_seg_pio_s1;
  reg              d1_reasons_to_wait;
  reg              d1_seven_seg_pio_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_seven_seg_pio_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] seven_seg_pio_s1_address;
  wire             seven_seg_pio_s1_allgrants;
  wire             seven_seg_pio_s1_allow_new_arb_cycle;
  wire             seven_seg_pio_s1_any_bursting_master_saved_grant;
  wire             seven_seg_pio_s1_any_continuerequest;
  wire             seven_seg_pio_s1_arb_counter_enable;
  reg     [  1: 0] seven_seg_pio_s1_arb_share_counter;
  wire    [  1: 0] seven_seg_pio_s1_arb_share_counter_next_value;
  wire    [  1: 0] seven_seg_pio_s1_arb_share_set_values;
  wire             seven_seg_pio_s1_beginbursttransfer_internal;
  wire             seven_seg_pio_s1_begins_xfer;
  wire             seven_seg_pio_s1_chipselect;
  wire             seven_seg_pio_s1_end_xfer;
  wire             seven_seg_pio_s1_firsttransfer;
  wire             seven_seg_pio_s1_grant_vector;
  wire             seven_seg_pio_s1_in_a_read_cycle;
  wire             seven_seg_pio_s1_in_a_write_cycle;
  wire             seven_seg_pio_s1_master_qreq_vector;
  wire             seven_seg_pio_s1_non_bursting_master_requests;
  wire    [ 15: 0] seven_seg_pio_s1_readdata_from_sa;
  reg              seven_seg_pio_s1_reg_firsttransfer;
  wire             seven_seg_pio_s1_reset_n;
  reg              seven_seg_pio_s1_slavearbiterlockenable;
  wire             seven_seg_pio_s1_slavearbiterlockenable2;
  wire             seven_seg_pio_s1_unreg_firsttransfer;
  wire             seven_seg_pio_s1_waits_for_read;
  wire             seven_seg_pio_s1_waits_for_write;
  wire             seven_seg_pio_s1_write_n;
  wire    [ 15: 0] seven_seg_pio_s1_writedata;
  wire    [ 24: 0] shifted_address_to_seven_seg_pio_s1_from_cpu_0_data_master;
  wire             wait_for_seven_seg_pio_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~seven_seg_pio_s1_end_xfer;
    end


  assign seven_seg_pio_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_seven_seg_pio_s1));
  //assign seven_seg_pio_s1_readdata_from_sa = seven_seg_pio_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign seven_seg_pio_s1_readdata_from_sa = seven_seg_pio_s1_readdata;

  assign cpu_0_data_master_requests_seven_seg_pio_s1 = ({cpu_0_data_master_address_to_slave[24 : 4] , 4'b0} == 25'h1001060) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //seven_seg_pio_s1_arb_share_counter set values, which is an e_mux
  assign seven_seg_pio_s1_arb_share_set_values = 1;

  //seven_seg_pio_s1_non_bursting_master_requests mux, which is an e_mux
  assign seven_seg_pio_s1_non_bursting_master_requests = cpu_0_data_master_requests_seven_seg_pio_s1;

  //seven_seg_pio_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign seven_seg_pio_s1_any_bursting_master_saved_grant = 0;

  //seven_seg_pio_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign seven_seg_pio_s1_arb_share_counter_next_value = seven_seg_pio_s1_firsttransfer ? (seven_seg_pio_s1_arb_share_set_values - 1) : |seven_seg_pio_s1_arb_share_counter ? (seven_seg_pio_s1_arb_share_counter - 1) : 0;

  //seven_seg_pio_s1_allgrants all slave grants, which is an e_mux
  assign seven_seg_pio_s1_allgrants = |seven_seg_pio_s1_grant_vector;

  //seven_seg_pio_s1_end_xfer assignment, which is an e_assign
  assign seven_seg_pio_s1_end_xfer = ~(seven_seg_pio_s1_waits_for_read | seven_seg_pio_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_seven_seg_pio_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_seven_seg_pio_s1 = seven_seg_pio_s1_end_xfer & (~seven_seg_pio_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //seven_seg_pio_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign seven_seg_pio_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_seven_seg_pio_s1 & seven_seg_pio_s1_allgrants) | (end_xfer_arb_share_counter_term_seven_seg_pio_s1 & ~seven_seg_pio_s1_non_bursting_master_requests);

  //seven_seg_pio_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          seven_seg_pio_s1_arb_share_counter <= 0;
      else if (seven_seg_pio_s1_arb_counter_enable)
          seven_seg_pio_s1_arb_share_counter <= seven_seg_pio_s1_arb_share_counter_next_value;
    end


  //seven_seg_pio_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          seven_seg_pio_s1_slavearbiterlockenable <= 0;
      else if ((|seven_seg_pio_s1_master_qreq_vector & end_xfer_arb_share_counter_term_seven_seg_pio_s1) | (end_xfer_arb_share_counter_term_seven_seg_pio_s1 & ~seven_seg_pio_s1_non_bursting_master_requests))
          seven_seg_pio_s1_slavearbiterlockenable <= |seven_seg_pio_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master seven_seg_pio/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = seven_seg_pio_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //seven_seg_pio_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign seven_seg_pio_s1_slavearbiterlockenable2 = |seven_seg_pio_s1_arb_share_counter_next_value;

  //cpu_0/data_master seven_seg_pio/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = seven_seg_pio_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //seven_seg_pio_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign seven_seg_pio_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_seven_seg_pio_s1 = cpu_0_data_master_requests_seven_seg_pio_s1 & ~(((~cpu_0_data_master_waitrequest) & cpu_0_data_master_write));
  //seven_seg_pio_s1_writedata mux, which is an e_mux
  assign seven_seg_pio_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_seven_seg_pio_s1 = cpu_0_data_master_qualified_request_seven_seg_pio_s1;

  //cpu_0/data_master saved-grant seven_seg_pio/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_seven_seg_pio_s1 = cpu_0_data_master_requests_seven_seg_pio_s1;

  //allow new arb cycle for seven_seg_pio/s1, which is an e_assign
  assign seven_seg_pio_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign seven_seg_pio_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign seven_seg_pio_s1_master_qreq_vector = 1;

  //seven_seg_pio_s1_reset_n assignment, which is an e_assign
  assign seven_seg_pio_s1_reset_n = reset_n;

  assign seven_seg_pio_s1_chipselect = cpu_0_data_master_granted_seven_seg_pio_s1;
  //seven_seg_pio_s1_firsttransfer first transaction, which is an e_assign
  assign seven_seg_pio_s1_firsttransfer = seven_seg_pio_s1_begins_xfer ? seven_seg_pio_s1_unreg_firsttransfer : seven_seg_pio_s1_reg_firsttransfer;

  //seven_seg_pio_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign seven_seg_pio_s1_unreg_firsttransfer = ~(seven_seg_pio_s1_slavearbiterlockenable & seven_seg_pio_s1_any_continuerequest);

  //seven_seg_pio_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          seven_seg_pio_s1_reg_firsttransfer <= 1'b1;
      else if (seven_seg_pio_s1_begins_xfer)
          seven_seg_pio_s1_reg_firsttransfer <= seven_seg_pio_s1_unreg_firsttransfer;
    end


  //seven_seg_pio_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign seven_seg_pio_s1_beginbursttransfer_internal = seven_seg_pio_s1_begins_xfer;

  //~seven_seg_pio_s1_write_n assignment, which is an e_mux
  assign seven_seg_pio_s1_write_n = ~(cpu_0_data_master_granted_seven_seg_pio_s1 & cpu_0_data_master_write);

  assign shifted_address_to_seven_seg_pio_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //seven_seg_pio_s1_address mux, which is an e_mux
  assign seven_seg_pio_s1_address = shifted_address_to_seven_seg_pio_s1_from_cpu_0_data_master >> 2;

  //d1_seven_seg_pio_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_seven_seg_pio_s1_end_xfer <= 1;
      else 
        d1_seven_seg_pio_s1_end_xfer <= seven_seg_pio_s1_end_xfer;
    end


  //seven_seg_pio_s1_waits_for_read in a cycle, which is an e_mux
  assign seven_seg_pio_s1_waits_for_read = seven_seg_pio_s1_in_a_read_cycle & seven_seg_pio_s1_begins_xfer;

  //seven_seg_pio_s1_in_a_read_cycle assignment, which is an e_assign
  assign seven_seg_pio_s1_in_a_read_cycle = cpu_0_data_master_granted_seven_seg_pio_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = seven_seg_pio_s1_in_a_read_cycle;

  //seven_seg_pio_s1_waits_for_write in a cycle, which is an e_mux
  assign seven_seg_pio_s1_waits_for_write = seven_seg_pio_s1_in_a_write_cycle & 0;

  //seven_seg_pio_s1_in_a_write_cycle assignment, which is an e_assign
  assign seven_seg_pio_s1_in_a_write_cycle = cpu_0_data_master_granted_seven_seg_pio_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = seven_seg_pio_s1_in_a_write_cycle;

  assign wait_for_seven_seg_pio_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //seven_seg_pio/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module seven_seg_right_pio_s1_arbitrator (
                                           // inputs:
                                            clk,
                                            cpu_0_data_master_address_to_slave,
                                            cpu_0_data_master_read,
                                            cpu_0_data_master_waitrequest,
                                            cpu_0_data_master_write,
                                            cpu_0_data_master_writedata,
                                            reset_n,
                                            seven_seg_right_pio_s1_readdata,

                                           // outputs:
                                            cpu_0_data_master_granted_seven_seg_right_pio_s1,
                                            cpu_0_data_master_qualified_request_seven_seg_right_pio_s1,
                                            cpu_0_data_master_read_data_valid_seven_seg_right_pio_s1,
                                            cpu_0_data_master_requests_seven_seg_right_pio_s1,
                                            d1_seven_seg_right_pio_s1_end_xfer,
                                            seven_seg_right_pio_s1_address,
                                            seven_seg_right_pio_s1_chipselect,
                                            seven_seg_right_pio_s1_readdata_from_sa,
                                            seven_seg_right_pio_s1_reset_n,
                                            seven_seg_right_pio_s1_write_n,
                                            seven_seg_right_pio_s1_writedata
                                         )
;

  output           cpu_0_data_master_granted_seven_seg_right_pio_s1;
  output           cpu_0_data_master_qualified_request_seven_seg_right_pio_s1;
  output           cpu_0_data_master_read_data_valid_seven_seg_right_pio_s1;
  output           cpu_0_data_master_requests_seven_seg_right_pio_s1;
  output           d1_seven_seg_right_pio_s1_end_xfer;
  output  [  1: 0] seven_seg_right_pio_s1_address;
  output           seven_seg_right_pio_s1_chipselect;
  output  [ 31: 0] seven_seg_right_pio_s1_readdata_from_sa;
  output           seven_seg_right_pio_s1_reset_n;
  output           seven_seg_right_pio_s1_write_n;
  output  [ 31: 0] seven_seg_right_pio_s1_writedata;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_waitrequest;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            reset_n;
  input   [ 31: 0] seven_seg_right_pio_s1_readdata;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_seven_seg_right_pio_s1;
  wire             cpu_0_data_master_qualified_request_seven_seg_right_pio_s1;
  wire             cpu_0_data_master_read_data_valid_seven_seg_right_pio_s1;
  wire             cpu_0_data_master_requests_seven_seg_right_pio_s1;
  wire             cpu_0_data_master_saved_grant_seven_seg_right_pio_s1;
  reg              d1_reasons_to_wait;
  reg              d1_seven_seg_right_pio_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_seven_seg_right_pio_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] seven_seg_right_pio_s1_address;
  wire             seven_seg_right_pio_s1_allgrants;
  wire             seven_seg_right_pio_s1_allow_new_arb_cycle;
  wire             seven_seg_right_pio_s1_any_bursting_master_saved_grant;
  wire             seven_seg_right_pio_s1_any_continuerequest;
  wire             seven_seg_right_pio_s1_arb_counter_enable;
  reg     [  1: 0] seven_seg_right_pio_s1_arb_share_counter;
  wire    [  1: 0] seven_seg_right_pio_s1_arb_share_counter_next_value;
  wire    [  1: 0] seven_seg_right_pio_s1_arb_share_set_values;
  wire             seven_seg_right_pio_s1_beginbursttransfer_internal;
  wire             seven_seg_right_pio_s1_begins_xfer;
  wire             seven_seg_right_pio_s1_chipselect;
  wire             seven_seg_right_pio_s1_end_xfer;
  wire             seven_seg_right_pio_s1_firsttransfer;
  wire             seven_seg_right_pio_s1_grant_vector;
  wire             seven_seg_right_pio_s1_in_a_read_cycle;
  wire             seven_seg_right_pio_s1_in_a_write_cycle;
  wire             seven_seg_right_pio_s1_master_qreq_vector;
  wire             seven_seg_right_pio_s1_non_bursting_master_requests;
  wire    [ 31: 0] seven_seg_right_pio_s1_readdata_from_sa;
  reg              seven_seg_right_pio_s1_reg_firsttransfer;
  wire             seven_seg_right_pio_s1_reset_n;
  reg              seven_seg_right_pio_s1_slavearbiterlockenable;
  wire             seven_seg_right_pio_s1_slavearbiterlockenable2;
  wire             seven_seg_right_pio_s1_unreg_firsttransfer;
  wire             seven_seg_right_pio_s1_waits_for_read;
  wire             seven_seg_right_pio_s1_waits_for_write;
  wire             seven_seg_right_pio_s1_write_n;
  wire    [ 31: 0] seven_seg_right_pio_s1_writedata;
  wire    [ 24: 0] shifted_address_to_seven_seg_right_pio_s1_from_cpu_0_data_master;
  wire             wait_for_seven_seg_right_pio_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~seven_seg_right_pio_s1_end_xfer;
    end


  assign seven_seg_right_pio_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_seven_seg_right_pio_s1));
  //assign seven_seg_right_pio_s1_readdata_from_sa = seven_seg_right_pio_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign seven_seg_right_pio_s1_readdata_from_sa = seven_seg_right_pio_s1_readdata;

  assign cpu_0_data_master_requests_seven_seg_right_pio_s1 = ({cpu_0_data_master_address_to_slave[24 : 4] , 4'b0} == 25'h10010b0) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //seven_seg_right_pio_s1_arb_share_counter set values, which is an e_mux
  assign seven_seg_right_pio_s1_arb_share_set_values = 1;

  //seven_seg_right_pio_s1_non_bursting_master_requests mux, which is an e_mux
  assign seven_seg_right_pio_s1_non_bursting_master_requests = cpu_0_data_master_requests_seven_seg_right_pio_s1;

  //seven_seg_right_pio_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign seven_seg_right_pio_s1_any_bursting_master_saved_grant = 0;

  //seven_seg_right_pio_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign seven_seg_right_pio_s1_arb_share_counter_next_value = seven_seg_right_pio_s1_firsttransfer ? (seven_seg_right_pio_s1_arb_share_set_values - 1) : |seven_seg_right_pio_s1_arb_share_counter ? (seven_seg_right_pio_s1_arb_share_counter - 1) : 0;

  //seven_seg_right_pio_s1_allgrants all slave grants, which is an e_mux
  assign seven_seg_right_pio_s1_allgrants = |seven_seg_right_pio_s1_grant_vector;

  //seven_seg_right_pio_s1_end_xfer assignment, which is an e_assign
  assign seven_seg_right_pio_s1_end_xfer = ~(seven_seg_right_pio_s1_waits_for_read | seven_seg_right_pio_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_seven_seg_right_pio_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_seven_seg_right_pio_s1 = seven_seg_right_pio_s1_end_xfer & (~seven_seg_right_pio_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //seven_seg_right_pio_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign seven_seg_right_pio_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_seven_seg_right_pio_s1 & seven_seg_right_pio_s1_allgrants) | (end_xfer_arb_share_counter_term_seven_seg_right_pio_s1 & ~seven_seg_right_pio_s1_non_bursting_master_requests);

  //seven_seg_right_pio_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          seven_seg_right_pio_s1_arb_share_counter <= 0;
      else if (seven_seg_right_pio_s1_arb_counter_enable)
          seven_seg_right_pio_s1_arb_share_counter <= seven_seg_right_pio_s1_arb_share_counter_next_value;
    end


  //seven_seg_right_pio_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          seven_seg_right_pio_s1_slavearbiterlockenable <= 0;
      else if ((|seven_seg_right_pio_s1_master_qreq_vector & end_xfer_arb_share_counter_term_seven_seg_right_pio_s1) | (end_xfer_arb_share_counter_term_seven_seg_right_pio_s1 & ~seven_seg_right_pio_s1_non_bursting_master_requests))
          seven_seg_right_pio_s1_slavearbiterlockenable <= |seven_seg_right_pio_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master seven_seg_right_pio/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = seven_seg_right_pio_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //seven_seg_right_pio_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign seven_seg_right_pio_s1_slavearbiterlockenable2 = |seven_seg_right_pio_s1_arb_share_counter_next_value;

  //cpu_0/data_master seven_seg_right_pio/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = seven_seg_right_pio_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //seven_seg_right_pio_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign seven_seg_right_pio_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_seven_seg_right_pio_s1 = cpu_0_data_master_requests_seven_seg_right_pio_s1 & ~(((~cpu_0_data_master_waitrequest) & cpu_0_data_master_write));
  //seven_seg_right_pio_s1_writedata mux, which is an e_mux
  assign seven_seg_right_pio_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_seven_seg_right_pio_s1 = cpu_0_data_master_qualified_request_seven_seg_right_pio_s1;

  //cpu_0/data_master saved-grant seven_seg_right_pio/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_seven_seg_right_pio_s1 = cpu_0_data_master_requests_seven_seg_right_pio_s1;

  //allow new arb cycle for seven_seg_right_pio/s1, which is an e_assign
  assign seven_seg_right_pio_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign seven_seg_right_pio_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign seven_seg_right_pio_s1_master_qreq_vector = 1;

  //seven_seg_right_pio_s1_reset_n assignment, which is an e_assign
  assign seven_seg_right_pio_s1_reset_n = reset_n;

  assign seven_seg_right_pio_s1_chipselect = cpu_0_data_master_granted_seven_seg_right_pio_s1;
  //seven_seg_right_pio_s1_firsttransfer first transaction, which is an e_assign
  assign seven_seg_right_pio_s1_firsttransfer = seven_seg_right_pio_s1_begins_xfer ? seven_seg_right_pio_s1_unreg_firsttransfer : seven_seg_right_pio_s1_reg_firsttransfer;

  //seven_seg_right_pio_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign seven_seg_right_pio_s1_unreg_firsttransfer = ~(seven_seg_right_pio_s1_slavearbiterlockenable & seven_seg_right_pio_s1_any_continuerequest);

  //seven_seg_right_pio_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          seven_seg_right_pio_s1_reg_firsttransfer <= 1'b1;
      else if (seven_seg_right_pio_s1_begins_xfer)
          seven_seg_right_pio_s1_reg_firsttransfer <= seven_seg_right_pio_s1_unreg_firsttransfer;
    end


  //seven_seg_right_pio_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign seven_seg_right_pio_s1_beginbursttransfer_internal = seven_seg_right_pio_s1_begins_xfer;

  //~seven_seg_right_pio_s1_write_n assignment, which is an e_mux
  assign seven_seg_right_pio_s1_write_n = ~(cpu_0_data_master_granted_seven_seg_right_pio_s1 & cpu_0_data_master_write);

  assign shifted_address_to_seven_seg_right_pio_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //seven_seg_right_pio_s1_address mux, which is an e_mux
  assign seven_seg_right_pio_s1_address = shifted_address_to_seven_seg_right_pio_s1_from_cpu_0_data_master >> 2;

  //d1_seven_seg_right_pio_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_seven_seg_right_pio_s1_end_xfer <= 1;
      else 
        d1_seven_seg_right_pio_s1_end_xfer <= seven_seg_right_pio_s1_end_xfer;
    end


  //seven_seg_right_pio_s1_waits_for_read in a cycle, which is an e_mux
  assign seven_seg_right_pio_s1_waits_for_read = seven_seg_right_pio_s1_in_a_read_cycle & seven_seg_right_pio_s1_begins_xfer;

  //seven_seg_right_pio_s1_in_a_read_cycle assignment, which is an e_assign
  assign seven_seg_right_pio_s1_in_a_read_cycle = cpu_0_data_master_granted_seven_seg_right_pio_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = seven_seg_right_pio_s1_in_a_read_cycle;

  //seven_seg_right_pio_s1_waits_for_write in a cycle, which is an e_mux
  assign seven_seg_right_pio_s1_waits_for_write = seven_seg_right_pio_s1_in_a_write_cycle & 0;

  //seven_seg_right_pio_s1_in_a_write_cycle assignment, which is an e_assign
  assign seven_seg_right_pio_s1_in_a_write_cycle = cpu_0_data_master_granted_seven_seg_right_pio_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = seven_seg_right_pio_s1_in_a_write_cycle;

  assign wait_for_seven_seg_right_pio_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //seven_seg_right_pio/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module switch_pio_s1_arbitrator (
                                  // inputs:
                                   clk,
                                   cpu_0_data_master_address_to_slave,
                                   cpu_0_data_master_read,
                                   cpu_0_data_master_write,
                                   reset_n,
                                   switch_pio_s1_readdata,

                                  // outputs:
                                   cpu_0_data_master_granted_switch_pio_s1,
                                   cpu_0_data_master_qualified_request_switch_pio_s1,
                                   cpu_0_data_master_read_data_valid_switch_pio_s1,
                                   cpu_0_data_master_requests_switch_pio_s1,
                                   d1_switch_pio_s1_end_xfer,
                                   switch_pio_s1_address,
                                   switch_pio_s1_readdata_from_sa,
                                   switch_pio_s1_reset_n
                                )
;

  output           cpu_0_data_master_granted_switch_pio_s1;
  output           cpu_0_data_master_qualified_request_switch_pio_s1;
  output           cpu_0_data_master_read_data_valid_switch_pio_s1;
  output           cpu_0_data_master_requests_switch_pio_s1;
  output           d1_switch_pio_s1_end_xfer;
  output  [  1: 0] switch_pio_s1_address;
  output  [ 15: 0] switch_pio_s1_readdata_from_sa;
  output           switch_pio_s1_reset_n;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input            reset_n;
  input   [ 15: 0] switch_pio_s1_readdata;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_switch_pio_s1;
  wire             cpu_0_data_master_qualified_request_switch_pio_s1;
  wire             cpu_0_data_master_read_data_valid_switch_pio_s1;
  wire             cpu_0_data_master_requests_switch_pio_s1;
  wire             cpu_0_data_master_saved_grant_switch_pio_s1;
  reg              d1_reasons_to_wait;
  reg              d1_switch_pio_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_switch_pio_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 24: 0] shifted_address_to_switch_pio_s1_from_cpu_0_data_master;
  wire    [  1: 0] switch_pio_s1_address;
  wire             switch_pio_s1_allgrants;
  wire             switch_pio_s1_allow_new_arb_cycle;
  wire             switch_pio_s1_any_bursting_master_saved_grant;
  wire             switch_pio_s1_any_continuerequest;
  wire             switch_pio_s1_arb_counter_enable;
  reg     [  1: 0] switch_pio_s1_arb_share_counter;
  wire    [  1: 0] switch_pio_s1_arb_share_counter_next_value;
  wire    [  1: 0] switch_pio_s1_arb_share_set_values;
  wire             switch_pio_s1_beginbursttransfer_internal;
  wire             switch_pio_s1_begins_xfer;
  wire             switch_pio_s1_end_xfer;
  wire             switch_pio_s1_firsttransfer;
  wire             switch_pio_s1_grant_vector;
  wire             switch_pio_s1_in_a_read_cycle;
  wire             switch_pio_s1_in_a_write_cycle;
  wire             switch_pio_s1_master_qreq_vector;
  wire             switch_pio_s1_non_bursting_master_requests;
  wire    [ 15: 0] switch_pio_s1_readdata_from_sa;
  reg              switch_pio_s1_reg_firsttransfer;
  wire             switch_pio_s1_reset_n;
  reg              switch_pio_s1_slavearbiterlockenable;
  wire             switch_pio_s1_slavearbiterlockenable2;
  wire             switch_pio_s1_unreg_firsttransfer;
  wire             switch_pio_s1_waits_for_read;
  wire             switch_pio_s1_waits_for_write;
  wire             wait_for_switch_pio_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~switch_pio_s1_end_xfer;
    end


  assign switch_pio_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_switch_pio_s1));
  //assign switch_pio_s1_readdata_from_sa = switch_pio_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign switch_pio_s1_readdata_from_sa = switch_pio_s1_readdata;

  assign cpu_0_data_master_requests_switch_pio_s1 = (({cpu_0_data_master_address_to_slave[24 : 4] , 4'b0} == 25'h10010c0) & (cpu_0_data_master_read | cpu_0_data_master_write)) & cpu_0_data_master_read;
  //switch_pio_s1_arb_share_counter set values, which is an e_mux
  assign switch_pio_s1_arb_share_set_values = 1;

  //switch_pio_s1_non_bursting_master_requests mux, which is an e_mux
  assign switch_pio_s1_non_bursting_master_requests = cpu_0_data_master_requests_switch_pio_s1;

  //switch_pio_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign switch_pio_s1_any_bursting_master_saved_grant = 0;

  //switch_pio_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign switch_pio_s1_arb_share_counter_next_value = switch_pio_s1_firsttransfer ? (switch_pio_s1_arb_share_set_values - 1) : |switch_pio_s1_arb_share_counter ? (switch_pio_s1_arb_share_counter - 1) : 0;

  //switch_pio_s1_allgrants all slave grants, which is an e_mux
  assign switch_pio_s1_allgrants = |switch_pio_s1_grant_vector;

  //switch_pio_s1_end_xfer assignment, which is an e_assign
  assign switch_pio_s1_end_xfer = ~(switch_pio_s1_waits_for_read | switch_pio_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_switch_pio_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_switch_pio_s1 = switch_pio_s1_end_xfer & (~switch_pio_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //switch_pio_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign switch_pio_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_switch_pio_s1 & switch_pio_s1_allgrants) | (end_xfer_arb_share_counter_term_switch_pio_s1 & ~switch_pio_s1_non_bursting_master_requests);

  //switch_pio_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          switch_pio_s1_arb_share_counter <= 0;
      else if (switch_pio_s1_arb_counter_enable)
          switch_pio_s1_arb_share_counter <= switch_pio_s1_arb_share_counter_next_value;
    end


  //switch_pio_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          switch_pio_s1_slavearbiterlockenable <= 0;
      else if ((|switch_pio_s1_master_qreq_vector & end_xfer_arb_share_counter_term_switch_pio_s1) | (end_xfer_arb_share_counter_term_switch_pio_s1 & ~switch_pio_s1_non_bursting_master_requests))
          switch_pio_s1_slavearbiterlockenable <= |switch_pio_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master switch_pio/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = switch_pio_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //switch_pio_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign switch_pio_s1_slavearbiterlockenable2 = |switch_pio_s1_arb_share_counter_next_value;

  //cpu_0/data_master switch_pio/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = switch_pio_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //switch_pio_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign switch_pio_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_switch_pio_s1 = cpu_0_data_master_requests_switch_pio_s1;
  //master is always granted when requested
  assign cpu_0_data_master_granted_switch_pio_s1 = cpu_0_data_master_qualified_request_switch_pio_s1;

  //cpu_0/data_master saved-grant switch_pio/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_switch_pio_s1 = cpu_0_data_master_requests_switch_pio_s1;

  //allow new arb cycle for switch_pio/s1, which is an e_assign
  assign switch_pio_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign switch_pio_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign switch_pio_s1_master_qreq_vector = 1;

  //switch_pio_s1_reset_n assignment, which is an e_assign
  assign switch_pio_s1_reset_n = reset_n;

  //switch_pio_s1_firsttransfer first transaction, which is an e_assign
  assign switch_pio_s1_firsttransfer = switch_pio_s1_begins_xfer ? switch_pio_s1_unreg_firsttransfer : switch_pio_s1_reg_firsttransfer;

  //switch_pio_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign switch_pio_s1_unreg_firsttransfer = ~(switch_pio_s1_slavearbiterlockenable & switch_pio_s1_any_continuerequest);

  //switch_pio_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          switch_pio_s1_reg_firsttransfer <= 1'b1;
      else if (switch_pio_s1_begins_xfer)
          switch_pio_s1_reg_firsttransfer <= switch_pio_s1_unreg_firsttransfer;
    end


  //switch_pio_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign switch_pio_s1_beginbursttransfer_internal = switch_pio_s1_begins_xfer;

  assign shifted_address_to_switch_pio_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //switch_pio_s1_address mux, which is an e_mux
  assign switch_pio_s1_address = shifted_address_to_switch_pio_s1_from_cpu_0_data_master >> 2;

  //d1_switch_pio_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_switch_pio_s1_end_xfer <= 1;
      else 
        d1_switch_pio_s1_end_xfer <= switch_pio_s1_end_xfer;
    end


  //switch_pio_s1_waits_for_read in a cycle, which is an e_mux
  assign switch_pio_s1_waits_for_read = switch_pio_s1_in_a_read_cycle & switch_pio_s1_begins_xfer;

  //switch_pio_s1_in_a_read_cycle assignment, which is an e_assign
  assign switch_pio_s1_in_a_read_cycle = cpu_0_data_master_granted_switch_pio_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = switch_pio_s1_in_a_read_cycle;

  //switch_pio_s1_waits_for_write in a cycle, which is an e_mux
  assign switch_pio_s1_waits_for_write = switch_pio_s1_in_a_write_cycle & 0;

  //switch_pio_s1_in_a_write_cycle assignment, which is an e_assign
  assign switch_pio_s1_in_a_write_cycle = cpu_0_data_master_granted_switch_pio_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = switch_pio_s1_in_a_write_cycle;

  assign wait_for_switch_pio_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //switch_pio/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module sysid_control_slave_arbitrator (
                                        // inputs:
                                         clk,
                                         cpu_0_data_master_address_to_slave,
                                         cpu_0_data_master_read,
                                         cpu_0_data_master_write,
                                         reset_n,
                                         sysid_control_slave_readdata,

                                        // outputs:
                                         cpu_0_data_master_granted_sysid_control_slave,
                                         cpu_0_data_master_qualified_request_sysid_control_slave,
                                         cpu_0_data_master_read_data_valid_sysid_control_slave,
                                         cpu_0_data_master_requests_sysid_control_slave,
                                         d1_sysid_control_slave_end_xfer,
                                         sysid_control_slave_address,
                                         sysid_control_slave_readdata_from_sa,
                                         sysid_control_slave_reset_n
                                      )
;

  output           cpu_0_data_master_granted_sysid_control_slave;
  output           cpu_0_data_master_qualified_request_sysid_control_slave;
  output           cpu_0_data_master_read_data_valid_sysid_control_slave;
  output           cpu_0_data_master_requests_sysid_control_slave;
  output           d1_sysid_control_slave_end_xfer;
  output           sysid_control_slave_address;
  output  [ 31: 0] sysid_control_slave_readdata_from_sa;
  output           sysid_control_slave_reset_n;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input            reset_n;
  input   [ 31: 0] sysid_control_slave_readdata;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_sysid_control_slave;
  wire             cpu_0_data_master_qualified_request_sysid_control_slave;
  wire             cpu_0_data_master_read_data_valid_sysid_control_slave;
  wire             cpu_0_data_master_requests_sysid_control_slave;
  wire             cpu_0_data_master_saved_grant_sysid_control_slave;
  reg              d1_reasons_to_wait;
  reg              d1_sysid_control_slave_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_sysid_control_slave;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 24: 0] shifted_address_to_sysid_control_slave_from_cpu_0_data_master;
  wire             sysid_control_slave_address;
  wire             sysid_control_slave_allgrants;
  wire             sysid_control_slave_allow_new_arb_cycle;
  wire             sysid_control_slave_any_bursting_master_saved_grant;
  wire             sysid_control_slave_any_continuerequest;
  wire             sysid_control_slave_arb_counter_enable;
  reg     [  1: 0] sysid_control_slave_arb_share_counter;
  wire    [  1: 0] sysid_control_slave_arb_share_counter_next_value;
  wire    [  1: 0] sysid_control_slave_arb_share_set_values;
  wire             sysid_control_slave_beginbursttransfer_internal;
  wire             sysid_control_slave_begins_xfer;
  wire             sysid_control_slave_end_xfer;
  wire             sysid_control_slave_firsttransfer;
  wire             sysid_control_slave_grant_vector;
  wire             sysid_control_slave_in_a_read_cycle;
  wire             sysid_control_slave_in_a_write_cycle;
  wire             sysid_control_slave_master_qreq_vector;
  wire             sysid_control_slave_non_bursting_master_requests;
  wire    [ 31: 0] sysid_control_slave_readdata_from_sa;
  reg              sysid_control_slave_reg_firsttransfer;
  wire             sysid_control_slave_reset_n;
  reg              sysid_control_slave_slavearbiterlockenable;
  wire             sysid_control_slave_slavearbiterlockenable2;
  wire             sysid_control_slave_unreg_firsttransfer;
  wire             sysid_control_slave_waits_for_read;
  wire             sysid_control_slave_waits_for_write;
  wire             wait_for_sysid_control_slave_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~sysid_control_slave_end_xfer;
    end


  assign sysid_control_slave_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_sysid_control_slave));
  //assign sysid_control_slave_readdata_from_sa = sysid_control_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sysid_control_slave_readdata_from_sa = sysid_control_slave_readdata;

  assign cpu_0_data_master_requests_sysid_control_slave = (({cpu_0_data_master_address_to_slave[24 : 3] , 3'b0} == 25'h1001150) & (cpu_0_data_master_read | cpu_0_data_master_write)) & cpu_0_data_master_read;
  //sysid_control_slave_arb_share_counter set values, which is an e_mux
  assign sysid_control_slave_arb_share_set_values = 1;

  //sysid_control_slave_non_bursting_master_requests mux, which is an e_mux
  assign sysid_control_slave_non_bursting_master_requests = cpu_0_data_master_requests_sysid_control_slave;

  //sysid_control_slave_any_bursting_master_saved_grant mux, which is an e_mux
  assign sysid_control_slave_any_bursting_master_saved_grant = 0;

  //sysid_control_slave_arb_share_counter_next_value assignment, which is an e_assign
  assign sysid_control_slave_arb_share_counter_next_value = sysid_control_slave_firsttransfer ? (sysid_control_slave_arb_share_set_values - 1) : |sysid_control_slave_arb_share_counter ? (sysid_control_slave_arb_share_counter - 1) : 0;

  //sysid_control_slave_allgrants all slave grants, which is an e_mux
  assign sysid_control_slave_allgrants = |sysid_control_slave_grant_vector;

  //sysid_control_slave_end_xfer assignment, which is an e_assign
  assign sysid_control_slave_end_xfer = ~(sysid_control_slave_waits_for_read | sysid_control_slave_waits_for_write);

  //end_xfer_arb_share_counter_term_sysid_control_slave arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_sysid_control_slave = sysid_control_slave_end_xfer & (~sysid_control_slave_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //sysid_control_slave_arb_share_counter arbitration counter enable, which is an e_assign
  assign sysid_control_slave_arb_counter_enable = (end_xfer_arb_share_counter_term_sysid_control_slave & sysid_control_slave_allgrants) | (end_xfer_arb_share_counter_term_sysid_control_slave & ~sysid_control_slave_non_bursting_master_requests);

  //sysid_control_slave_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sysid_control_slave_arb_share_counter <= 0;
      else if (sysid_control_slave_arb_counter_enable)
          sysid_control_slave_arb_share_counter <= sysid_control_slave_arb_share_counter_next_value;
    end


  //sysid_control_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sysid_control_slave_slavearbiterlockenable <= 0;
      else if ((|sysid_control_slave_master_qreq_vector & end_xfer_arb_share_counter_term_sysid_control_slave) | (end_xfer_arb_share_counter_term_sysid_control_slave & ~sysid_control_slave_non_bursting_master_requests))
          sysid_control_slave_slavearbiterlockenable <= |sysid_control_slave_arb_share_counter_next_value;
    end


  //cpu_0/data_master sysid/control_slave arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = sysid_control_slave_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //sysid_control_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign sysid_control_slave_slavearbiterlockenable2 = |sysid_control_slave_arb_share_counter_next_value;

  //cpu_0/data_master sysid/control_slave arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = sysid_control_slave_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //sysid_control_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  assign sysid_control_slave_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_sysid_control_slave = cpu_0_data_master_requests_sysid_control_slave;
  //master is always granted when requested
  assign cpu_0_data_master_granted_sysid_control_slave = cpu_0_data_master_qualified_request_sysid_control_slave;

  //cpu_0/data_master saved-grant sysid/control_slave, which is an e_assign
  assign cpu_0_data_master_saved_grant_sysid_control_slave = cpu_0_data_master_requests_sysid_control_slave;

  //allow new arb cycle for sysid/control_slave, which is an e_assign
  assign sysid_control_slave_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign sysid_control_slave_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign sysid_control_slave_master_qreq_vector = 1;

  //sysid_control_slave_reset_n assignment, which is an e_assign
  assign sysid_control_slave_reset_n = reset_n;

  //sysid_control_slave_firsttransfer first transaction, which is an e_assign
  assign sysid_control_slave_firsttransfer = sysid_control_slave_begins_xfer ? sysid_control_slave_unreg_firsttransfer : sysid_control_slave_reg_firsttransfer;

  //sysid_control_slave_unreg_firsttransfer first transaction, which is an e_assign
  assign sysid_control_slave_unreg_firsttransfer = ~(sysid_control_slave_slavearbiterlockenable & sysid_control_slave_any_continuerequest);

  //sysid_control_slave_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sysid_control_slave_reg_firsttransfer <= 1'b1;
      else if (sysid_control_slave_begins_xfer)
          sysid_control_slave_reg_firsttransfer <= sysid_control_slave_unreg_firsttransfer;
    end


  //sysid_control_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign sysid_control_slave_beginbursttransfer_internal = sysid_control_slave_begins_xfer;

  assign shifted_address_to_sysid_control_slave_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //sysid_control_slave_address mux, which is an e_mux
  assign sysid_control_slave_address = shifted_address_to_sysid_control_slave_from_cpu_0_data_master >> 2;

  //d1_sysid_control_slave_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_sysid_control_slave_end_xfer <= 1;
      else 
        d1_sysid_control_slave_end_xfer <= sysid_control_slave_end_xfer;
    end


  //sysid_control_slave_waits_for_read in a cycle, which is an e_mux
  assign sysid_control_slave_waits_for_read = sysid_control_slave_in_a_read_cycle & sysid_control_slave_begins_xfer;

  //sysid_control_slave_in_a_read_cycle assignment, which is an e_assign
  assign sysid_control_slave_in_a_read_cycle = cpu_0_data_master_granted_sysid_control_slave & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = sysid_control_slave_in_a_read_cycle;

  //sysid_control_slave_waits_for_write in a cycle, which is an e_mux
  assign sysid_control_slave_waits_for_write = sysid_control_slave_in_a_write_cycle & 0;

  //sysid_control_slave_in_a_write_cycle assignment, which is an e_assign
  assign sysid_control_slave_in_a_write_cycle = cpu_0_data_master_granted_sysid_control_slave & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = sysid_control_slave_in_a_write_cycle;

  assign wait_for_sysid_control_slave_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //sysid/control_slave enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module timer_0_s1_arbitrator (
                               // inputs:
                                clk,
                                cpu_0_data_master_address_to_slave,
                                cpu_0_data_master_read,
                                cpu_0_data_master_waitrequest,
                                cpu_0_data_master_write,
                                cpu_0_data_master_writedata,
                                reset_n,
                                timer_0_s1_irq,
                                timer_0_s1_readdata,

                               // outputs:
                                cpu_0_data_master_granted_timer_0_s1,
                                cpu_0_data_master_qualified_request_timer_0_s1,
                                cpu_0_data_master_read_data_valid_timer_0_s1,
                                cpu_0_data_master_requests_timer_0_s1,
                                d1_timer_0_s1_end_xfer,
                                timer_0_s1_address,
                                timer_0_s1_chipselect,
                                timer_0_s1_irq_from_sa,
                                timer_0_s1_readdata_from_sa,
                                timer_0_s1_reset_n,
                                timer_0_s1_write_n,
                                timer_0_s1_writedata
                             )
;

  output           cpu_0_data_master_granted_timer_0_s1;
  output           cpu_0_data_master_qualified_request_timer_0_s1;
  output           cpu_0_data_master_read_data_valid_timer_0_s1;
  output           cpu_0_data_master_requests_timer_0_s1;
  output           d1_timer_0_s1_end_xfer;
  output  [  2: 0] timer_0_s1_address;
  output           timer_0_s1_chipselect;
  output           timer_0_s1_irq_from_sa;
  output  [ 15: 0] timer_0_s1_readdata_from_sa;
  output           timer_0_s1_reset_n;
  output           timer_0_s1_write_n;
  output  [ 15: 0] timer_0_s1_writedata;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_waitrequest;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            reset_n;
  input            timer_0_s1_irq;
  input   [ 15: 0] timer_0_s1_readdata;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_timer_0_s1;
  wire             cpu_0_data_master_qualified_request_timer_0_s1;
  wire             cpu_0_data_master_read_data_valid_timer_0_s1;
  wire             cpu_0_data_master_requests_timer_0_s1;
  wire             cpu_0_data_master_saved_grant_timer_0_s1;
  reg              d1_reasons_to_wait;
  reg              d1_timer_0_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_timer_0_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 24: 0] shifted_address_to_timer_0_s1_from_cpu_0_data_master;
  wire    [  2: 0] timer_0_s1_address;
  wire             timer_0_s1_allgrants;
  wire             timer_0_s1_allow_new_arb_cycle;
  wire             timer_0_s1_any_bursting_master_saved_grant;
  wire             timer_0_s1_any_continuerequest;
  wire             timer_0_s1_arb_counter_enable;
  reg     [  1: 0] timer_0_s1_arb_share_counter;
  wire    [  1: 0] timer_0_s1_arb_share_counter_next_value;
  wire    [  1: 0] timer_0_s1_arb_share_set_values;
  wire             timer_0_s1_beginbursttransfer_internal;
  wire             timer_0_s1_begins_xfer;
  wire             timer_0_s1_chipselect;
  wire             timer_0_s1_end_xfer;
  wire             timer_0_s1_firsttransfer;
  wire             timer_0_s1_grant_vector;
  wire             timer_0_s1_in_a_read_cycle;
  wire             timer_0_s1_in_a_write_cycle;
  wire             timer_0_s1_irq_from_sa;
  wire             timer_0_s1_master_qreq_vector;
  wire             timer_0_s1_non_bursting_master_requests;
  wire    [ 15: 0] timer_0_s1_readdata_from_sa;
  reg              timer_0_s1_reg_firsttransfer;
  wire             timer_0_s1_reset_n;
  reg              timer_0_s1_slavearbiterlockenable;
  wire             timer_0_s1_slavearbiterlockenable2;
  wire             timer_0_s1_unreg_firsttransfer;
  wire             timer_0_s1_waits_for_read;
  wire             timer_0_s1_waits_for_write;
  wire             timer_0_s1_write_n;
  wire    [ 15: 0] timer_0_s1_writedata;
  wire             wait_for_timer_0_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~timer_0_s1_end_xfer;
    end


  assign timer_0_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_timer_0_s1));
  //assign timer_0_s1_readdata_from_sa = timer_0_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign timer_0_s1_readdata_from_sa = timer_0_s1_readdata;

  assign cpu_0_data_master_requests_timer_0_s1 = ({cpu_0_data_master_address_to_slave[24 : 5] , 5'b0} == 25'h1001000) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //timer_0_s1_arb_share_counter set values, which is an e_mux
  assign timer_0_s1_arb_share_set_values = 1;

  //timer_0_s1_non_bursting_master_requests mux, which is an e_mux
  assign timer_0_s1_non_bursting_master_requests = cpu_0_data_master_requests_timer_0_s1;

  //timer_0_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign timer_0_s1_any_bursting_master_saved_grant = 0;

  //timer_0_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign timer_0_s1_arb_share_counter_next_value = timer_0_s1_firsttransfer ? (timer_0_s1_arb_share_set_values - 1) : |timer_0_s1_arb_share_counter ? (timer_0_s1_arb_share_counter - 1) : 0;

  //timer_0_s1_allgrants all slave grants, which is an e_mux
  assign timer_0_s1_allgrants = |timer_0_s1_grant_vector;

  //timer_0_s1_end_xfer assignment, which is an e_assign
  assign timer_0_s1_end_xfer = ~(timer_0_s1_waits_for_read | timer_0_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_timer_0_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_timer_0_s1 = timer_0_s1_end_xfer & (~timer_0_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //timer_0_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign timer_0_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_timer_0_s1 & timer_0_s1_allgrants) | (end_xfer_arb_share_counter_term_timer_0_s1 & ~timer_0_s1_non_bursting_master_requests);

  //timer_0_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          timer_0_s1_arb_share_counter <= 0;
      else if (timer_0_s1_arb_counter_enable)
          timer_0_s1_arb_share_counter <= timer_0_s1_arb_share_counter_next_value;
    end


  //timer_0_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          timer_0_s1_slavearbiterlockenable <= 0;
      else if ((|timer_0_s1_master_qreq_vector & end_xfer_arb_share_counter_term_timer_0_s1) | (end_xfer_arb_share_counter_term_timer_0_s1 & ~timer_0_s1_non_bursting_master_requests))
          timer_0_s1_slavearbiterlockenable <= |timer_0_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master timer_0/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = timer_0_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //timer_0_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign timer_0_s1_slavearbiterlockenable2 = |timer_0_s1_arb_share_counter_next_value;

  //cpu_0/data_master timer_0/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = timer_0_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //timer_0_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign timer_0_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_timer_0_s1 = cpu_0_data_master_requests_timer_0_s1 & ~(((~cpu_0_data_master_waitrequest) & cpu_0_data_master_write));
  //timer_0_s1_writedata mux, which is an e_mux
  assign timer_0_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_timer_0_s1 = cpu_0_data_master_qualified_request_timer_0_s1;

  //cpu_0/data_master saved-grant timer_0/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_timer_0_s1 = cpu_0_data_master_requests_timer_0_s1;

  //allow new arb cycle for timer_0/s1, which is an e_assign
  assign timer_0_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign timer_0_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign timer_0_s1_master_qreq_vector = 1;

  //timer_0_s1_reset_n assignment, which is an e_assign
  assign timer_0_s1_reset_n = reset_n;

  assign timer_0_s1_chipselect = cpu_0_data_master_granted_timer_0_s1;
  //timer_0_s1_firsttransfer first transaction, which is an e_assign
  assign timer_0_s1_firsttransfer = timer_0_s1_begins_xfer ? timer_0_s1_unreg_firsttransfer : timer_0_s1_reg_firsttransfer;

  //timer_0_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign timer_0_s1_unreg_firsttransfer = ~(timer_0_s1_slavearbiterlockenable & timer_0_s1_any_continuerequest);

  //timer_0_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          timer_0_s1_reg_firsttransfer <= 1'b1;
      else if (timer_0_s1_begins_xfer)
          timer_0_s1_reg_firsttransfer <= timer_0_s1_unreg_firsttransfer;
    end


  //timer_0_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign timer_0_s1_beginbursttransfer_internal = timer_0_s1_begins_xfer;

  //~timer_0_s1_write_n assignment, which is an e_mux
  assign timer_0_s1_write_n = ~(cpu_0_data_master_granted_timer_0_s1 & cpu_0_data_master_write);

  assign shifted_address_to_timer_0_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //timer_0_s1_address mux, which is an e_mux
  assign timer_0_s1_address = shifted_address_to_timer_0_s1_from_cpu_0_data_master >> 2;

  //d1_timer_0_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_timer_0_s1_end_xfer <= 1;
      else 
        d1_timer_0_s1_end_xfer <= timer_0_s1_end_xfer;
    end


  //timer_0_s1_waits_for_read in a cycle, which is an e_mux
  assign timer_0_s1_waits_for_read = timer_0_s1_in_a_read_cycle & timer_0_s1_begins_xfer;

  //timer_0_s1_in_a_read_cycle assignment, which is an e_assign
  assign timer_0_s1_in_a_read_cycle = cpu_0_data_master_granted_timer_0_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = timer_0_s1_in_a_read_cycle;

  //timer_0_s1_waits_for_write in a cycle, which is an e_mux
  assign timer_0_s1_waits_for_write = timer_0_s1_in_a_write_cycle & 0;

  //timer_0_s1_in_a_write_cycle assignment, which is an e_assign
  assign timer_0_s1_in_a_write_cycle = cpu_0_data_master_granted_timer_0_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = timer_0_s1_in_a_write_cycle;

  assign wait_for_timer_0_s1_counter = 0;
  //assign timer_0_s1_irq_from_sa = timer_0_s1_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign timer_0_s1_irq_from_sa = timer_0_s1_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //timer_0/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module timer_1_s1_arbitrator (
                               // inputs:
                                clk,
                                cpu_0_data_master_address_to_slave,
                                cpu_0_data_master_read,
                                cpu_0_data_master_waitrequest,
                                cpu_0_data_master_write,
                                cpu_0_data_master_writedata,
                                reset_n,
                                timer_1_s1_irq,
                                timer_1_s1_readdata,

                               // outputs:
                                cpu_0_data_master_granted_timer_1_s1,
                                cpu_0_data_master_qualified_request_timer_1_s1,
                                cpu_0_data_master_read_data_valid_timer_1_s1,
                                cpu_0_data_master_requests_timer_1_s1,
                                d1_timer_1_s1_end_xfer,
                                timer_1_s1_address,
                                timer_1_s1_chipselect,
                                timer_1_s1_irq_from_sa,
                                timer_1_s1_readdata_from_sa,
                                timer_1_s1_reset_n,
                                timer_1_s1_write_n,
                                timer_1_s1_writedata
                             )
;

  output           cpu_0_data_master_granted_timer_1_s1;
  output           cpu_0_data_master_qualified_request_timer_1_s1;
  output           cpu_0_data_master_read_data_valid_timer_1_s1;
  output           cpu_0_data_master_requests_timer_1_s1;
  output           d1_timer_1_s1_end_xfer;
  output  [  2: 0] timer_1_s1_address;
  output           timer_1_s1_chipselect;
  output           timer_1_s1_irq_from_sa;
  output  [ 15: 0] timer_1_s1_readdata_from_sa;
  output           timer_1_s1_reset_n;
  output           timer_1_s1_write_n;
  output  [ 15: 0] timer_1_s1_writedata;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_waitrequest;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            reset_n;
  input            timer_1_s1_irq;
  input   [ 15: 0] timer_1_s1_readdata;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_timer_1_s1;
  wire             cpu_0_data_master_qualified_request_timer_1_s1;
  wire             cpu_0_data_master_read_data_valid_timer_1_s1;
  wire             cpu_0_data_master_requests_timer_1_s1;
  wire             cpu_0_data_master_saved_grant_timer_1_s1;
  reg              d1_reasons_to_wait;
  reg              d1_timer_1_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_timer_1_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 24: 0] shifted_address_to_timer_1_s1_from_cpu_0_data_master;
  wire    [  2: 0] timer_1_s1_address;
  wire             timer_1_s1_allgrants;
  wire             timer_1_s1_allow_new_arb_cycle;
  wire             timer_1_s1_any_bursting_master_saved_grant;
  wire             timer_1_s1_any_continuerequest;
  wire             timer_1_s1_arb_counter_enable;
  reg     [  1: 0] timer_1_s1_arb_share_counter;
  wire    [  1: 0] timer_1_s1_arb_share_counter_next_value;
  wire    [  1: 0] timer_1_s1_arb_share_set_values;
  wire             timer_1_s1_beginbursttransfer_internal;
  wire             timer_1_s1_begins_xfer;
  wire             timer_1_s1_chipselect;
  wire             timer_1_s1_end_xfer;
  wire             timer_1_s1_firsttransfer;
  wire             timer_1_s1_grant_vector;
  wire             timer_1_s1_in_a_read_cycle;
  wire             timer_1_s1_in_a_write_cycle;
  wire             timer_1_s1_irq_from_sa;
  wire             timer_1_s1_master_qreq_vector;
  wire             timer_1_s1_non_bursting_master_requests;
  wire    [ 15: 0] timer_1_s1_readdata_from_sa;
  reg              timer_1_s1_reg_firsttransfer;
  wire             timer_1_s1_reset_n;
  reg              timer_1_s1_slavearbiterlockenable;
  wire             timer_1_s1_slavearbiterlockenable2;
  wire             timer_1_s1_unreg_firsttransfer;
  wire             timer_1_s1_waits_for_read;
  wire             timer_1_s1_waits_for_write;
  wire             timer_1_s1_write_n;
  wire    [ 15: 0] timer_1_s1_writedata;
  wire             wait_for_timer_1_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~timer_1_s1_end_xfer;
    end


  assign timer_1_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_timer_1_s1));
  //assign timer_1_s1_readdata_from_sa = timer_1_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign timer_1_s1_readdata_from_sa = timer_1_s1_readdata;

  assign cpu_0_data_master_requests_timer_1_s1 = ({cpu_0_data_master_address_to_slave[24 : 5] , 5'b0} == 25'h1001020) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //timer_1_s1_arb_share_counter set values, which is an e_mux
  assign timer_1_s1_arb_share_set_values = 1;

  //timer_1_s1_non_bursting_master_requests mux, which is an e_mux
  assign timer_1_s1_non_bursting_master_requests = cpu_0_data_master_requests_timer_1_s1;

  //timer_1_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign timer_1_s1_any_bursting_master_saved_grant = 0;

  //timer_1_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign timer_1_s1_arb_share_counter_next_value = timer_1_s1_firsttransfer ? (timer_1_s1_arb_share_set_values - 1) : |timer_1_s1_arb_share_counter ? (timer_1_s1_arb_share_counter - 1) : 0;

  //timer_1_s1_allgrants all slave grants, which is an e_mux
  assign timer_1_s1_allgrants = |timer_1_s1_grant_vector;

  //timer_1_s1_end_xfer assignment, which is an e_assign
  assign timer_1_s1_end_xfer = ~(timer_1_s1_waits_for_read | timer_1_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_timer_1_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_timer_1_s1 = timer_1_s1_end_xfer & (~timer_1_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //timer_1_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign timer_1_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_timer_1_s1 & timer_1_s1_allgrants) | (end_xfer_arb_share_counter_term_timer_1_s1 & ~timer_1_s1_non_bursting_master_requests);

  //timer_1_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          timer_1_s1_arb_share_counter <= 0;
      else if (timer_1_s1_arb_counter_enable)
          timer_1_s1_arb_share_counter <= timer_1_s1_arb_share_counter_next_value;
    end


  //timer_1_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          timer_1_s1_slavearbiterlockenable <= 0;
      else if ((|timer_1_s1_master_qreq_vector & end_xfer_arb_share_counter_term_timer_1_s1) | (end_xfer_arb_share_counter_term_timer_1_s1 & ~timer_1_s1_non_bursting_master_requests))
          timer_1_s1_slavearbiterlockenable <= |timer_1_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master timer_1/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = timer_1_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //timer_1_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign timer_1_s1_slavearbiterlockenable2 = |timer_1_s1_arb_share_counter_next_value;

  //cpu_0/data_master timer_1/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = timer_1_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //timer_1_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign timer_1_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_timer_1_s1 = cpu_0_data_master_requests_timer_1_s1 & ~(((~cpu_0_data_master_waitrequest) & cpu_0_data_master_write));
  //timer_1_s1_writedata mux, which is an e_mux
  assign timer_1_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_timer_1_s1 = cpu_0_data_master_qualified_request_timer_1_s1;

  //cpu_0/data_master saved-grant timer_1/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_timer_1_s1 = cpu_0_data_master_requests_timer_1_s1;

  //allow new arb cycle for timer_1/s1, which is an e_assign
  assign timer_1_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign timer_1_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign timer_1_s1_master_qreq_vector = 1;

  //timer_1_s1_reset_n assignment, which is an e_assign
  assign timer_1_s1_reset_n = reset_n;

  assign timer_1_s1_chipselect = cpu_0_data_master_granted_timer_1_s1;
  //timer_1_s1_firsttransfer first transaction, which is an e_assign
  assign timer_1_s1_firsttransfer = timer_1_s1_begins_xfer ? timer_1_s1_unreg_firsttransfer : timer_1_s1_reg_firsttransfer;

  //timer_1_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign timer_1_s1_unreg_firsttransfer = ~(timer_1_s1_slavearbiterlockenable & timer_1_s1_any_continuerequest);

  //timer_1_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          timer_1_s1_reg_firsttransfer <= 1'b1;
      else if (timer_1_s1_begins_xfer)
          timer_1_s1_reg_firsttransfer <= timer_1_s1_unreg_firsttransfer;
    end


  //timer_1_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign timer_1_s1_beginbursttransfer_internal = timer_1_s1_begins_xfer;

  //~timer_1_s1_write_n assignment, which is an e_mux
  assign timer_1_s1_write_n = ~(cpu_0_data_master_granted_timer_1_s1 & cpu_0_data_master_write);

  assign shifted_address_to_timer_1_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //timer_1_s1_address mux, which is an e_mux
  assign timer_1_s1_address = shifted_address_to_timer_1_s1_from_cpu_0_data_master >> 2;

  //d1_timer_1_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_timer_1_s1_end_xfer <= 1;
      else 
        d1_timer_1_s1_end_xfer <= timer_1_s1_end_xfer;
    end


  //timer_1_s1_waits_for_read in a cycle, which is an e_mux
  assign timer_1_s1_waits_for_read = timer_1_s1_in_a_read_cycle & timer_1_s1_begins_xfer;

  //timer_1_s1_in_a_read_cycle assignment, which is an e_assign
  assign timer_1_s1_in_a_read_cycle = cpu_0_data_master_granted_timer_1_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = timer_1_s1_in_a_read_cycle;

  //timer_1_s1_waits_for_write in a cycle, which is an e_mux
  assign timer_1_s1_waits_for_write = timer_1_s1_in_a_write_cycle & 0;

  //timer_1_s1_in_a_write_cycle assignment, which is an e_assign
  assign timer_1_s1_in_a_write_cycle = cpu_0_data_master_granted_timer_1_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = timer_1_s1_in_a_write_cycle;

  assign wait_for_timer_1_s1_counter = 0;
  //assign timer_1_s1_irq_from_sa = timer_1_s1_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign timer_1_s1_irq_from_sa = timer_1_s1_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //timer_1/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module my_controller_reset_clk_0_domain_synch_module (
                                                       // inputs:
                                                        clk,
                                                        data_in,
                                                        reset_n,

                                                       // outputs:
                                                        data_out
                                                     )
;

  output           data_out;
  input            clk;
  input            data_in;
  input            reset_n;

  reg              data_in_d1 /* synthesis ALTERA_ATTRIBUTE = "{-from \"*\"} CUT=ON ; PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  reg              data_out /* synthesis ALTERA_ATTRIBUTE = "PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_in_d1 <= 0;
      else 
        data_in_d1 <= data_in;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_out <= 0;
      else 
        data_out <= data_in_d1;
    end



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module my_controller (
                       // 1) global signals:
                        clk_0,
                        reset_n,

                       // the_button_pio
                        in_port_to_the_button_pio,

                       // the_green_led_pio
                        out_port_from_the_green_led_pio,

                       // the_lcd_display
                        LCD_E_from_the_lcd_display,
                        LCD_RS_from_the_lcd_display,
                        LCD_RW_from_the_lcd_display,
                        LCD_data_to_and_from_the_lcd_display,

                       // the_led_pio
                        out_port_from_the_led_pio,

                       // the_pio_dutycycle
                        out_port_from_the_pio_dutycycle,

                       // the_pio_egmenable
                        out_port_from_the_pio_egmenable,

                       // the_pio_egmreset
                        out_port_from_the_pio_egmreset,

                       // the_pio_latency
                        in_port_to_the_pio_latency,

                       // the_pio_missed
                        in_port_to_the_pio_missed,

                       // the_pio_period
                        out_port_from_the_pio_period,

                       // the_pio_pulse
                        in_port_to_the_pio_pulse,

                       // the_pio_response
                        out_port_from_the_pio_response,

                       // the_red_led_pio
                        out_port_from_the_red_led_pio,

                       // the_sdram_0
                        zs_addr_from_the_sdram_0,
                        zs_ba_from_the_sdram_0,
                        zs_cas_n_from_the_sdram_0,
                        zs_cke_from_the_sdram_0,
                        zs_cs_n_from_the_sdram_0,
                        zs_dq_to_and_from_the_sdram_0,
                        zs_dqm_from_the_sdram_0,
                        zs_ras_n_from_the_sdram_0,
                        zs_we_n_from_the_sdram_0,

                       // the_seven_seg_middle_pio
                        out_port_from_the_seven_seg_middle_pio,

                       // the_seven_seg_pio
                        out_port_from_the_seven_seg_pio,

                       // the_seven_seg_right_pio
                        out_port_from_the_seven_seg_right_pio,

                       // the_switch_pio
                        in_port_to_the_switch_pio
                     )
;

  output           LCD_E_from_the_lcd_display;
  output           LCD_RS_from_the_lcd_display;
  output           LCD_RW_from_the_lcd_display;
  inout   [  7: 0] LCD_data_to_and_from_the_lcd_display;
  output  [  7: 0] out_port_from_the_green_led_pio;
  output  [  7: 0] out_port_from_the_led_pio;
  output  [  3: 0] out_port_from_the_pio_dutycycle;
  output           out_port_from_the_pio_egmenable;
  output           out_port_from_the_pio_egmreset;
  output  [  3: 0] out_port_from_the_pio_period;
  output           out_port_from_the_pio_response;
  output  [  7: 0] out_port_from_the_red_led_pio;
  output  [ 15: 0] out_port_from_the_seven_seg_middle_pio;
  output  [ 15: 0] out_port_from_the_seven_seg_pio;
  output  [ 31: 0] out_port_from_the_seven_seg_right_pio;
  output  [ 11: 0] zs_addr_from_the_sdram_0;
  output  [  1: 0] zs_ba_from_the_sdram_0;
  output           zs_cas_n_from_the_sdram_0;
  output           zs_cke_from_the_sdram_0;
  output           zs_cs_n_from_the_sdram_0;
  inout   [ 15: 0] zs_dq_to_and_from_the_sdram_0;
  output  [  1: 0] zs_dqm_from_the_sdram_0;
  output           zs_ras_n_from_the_sdram_0;
  output           zs_we_n_from_the_sdram_0;
  input            clk_0;
  input   [  3: 0] in_port_to_the_button_pio;
  input   [ 15: 0] in_port_to_the_pio_latency;
  input   [ 15: 0] in_port_to_the_pio_missed;
  input            in_port_to_the_pio_pulse;
  input   [ 15: 0] in_port_to_the_switch_pio;
  input            reset_n;

  wire             LCD_E_from_the_lcd_display;
  wire             LCD_RS_from_the_lcd_display;
  wire             LCD_RW_from_the_lcd_display;
  wire    [  7: 0] LCD_data_to_and_from_the_lcd_display;
  wire    [  1: 0] button_pio_s1_address;
  wire             button_pio_s1_chipselect;
  wire             button_pio_s1_irq;
  wire             button_pio_s1_irq_from_sa;
  wire    [  3: 0] button_pio_s1_readdata;
  wire    [  3: 0] button_pio_s1_readdata_from_sa;
  wire             button_pio_s1_reset_n;
  wire             button_pio_s1_write_n;
  wire    [  3: 0] button_pio_s1_writedata;
  wire             clk_0_reset_n;
  wire    [ 24: 0] cpu_0_data_master_address;
  wire    [ 24: 0] cpu_0_data_master_address_to_slave;
  wire    [  3: 0] cpu_0_data_master_byteenable;
  wire    [  1: 0] cpu_0_data_master_byteenable_sdram_0_s1;
  wire    [  1: 0] cpu_0_data_master_dbs_address;
  wire    [ 15: 0] cpu_0_data_master_dbs_write_16;
  wire             cpu_0_data_master_debugaccess;
  wire             cpu_0_data_master_granted_button_pio_s1;
  wire             cpu_0_data_master_granted_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_granted_green_led_pio_s1;
  wire             cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_granted_lcd_display_control_slave;
  wire             cpu_0_data_master_granted_led_pio_s1;
  wire             cpu_0_data_master_granted_pio_dutycycle_s1;
  wire             cpu_0_data_master_granted_pio_egmenable_s1;
  wire             cpu_0_data_master_granted_pio_egmreset_s1;
  wire             cpu_0_data_master_granted_pio_latency_s1;
  wire             cpu_0_data_master_granted_pio_missed_s1;
  wire             cpu_0_data_master_granted_pio_period_s1;
  wire             cpu_0_data_master_granted_pio_pulse_s1;
  wire             cpu_0_data_master_granted_pio_response_s1;
  wire             cpu_0_data_master_granted_red_led_pio_s1;
  wire             cpu_0_data_master_granted_sdram_0_s1;
  wire             cpu_0_data_master_granted_seven_seg_middle_pio_s1;
  wire             cpu_0_data_master_granted_seven_seg_pio_s1;
  wire             cpu_0_data_master_granted_seven_seg_right_pio_s1;
  wire             cpu_0_data_master_granted_switch_pio_s1;
  wire             cpu_0_data_master_granted_sysid_control_slave;
  wire             cpu_0_data_master_granted_timer_0_s1;
  wire             cpu_0_data_master_granted_timer_1_s1;
  wire    [ 31: 0] cpu_0_data_master_irq;
  wire             cpu_0_data_master_no_byte_enables_and_last_term;
  wire             cpu_0_data_master_qualified_request_button_pio_s1;
  wire             cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_qualified_request_green_led_pio_s1;
  wire             cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_qualified_request_lcd_display_control_slave;
  wire             cpu_0_data_master_qualified_request_led_pio_s1;
  wire             cpu_0_data_master_qualified_request_pio_dutycycle_s1;
  wire             cpu_0_data_master_qualified_request_pio_egmenable_s1;
  wire             cpu_0_data_master_qualified_request_pio_egmreset_s1;
  wire             cpu_0_data_master_qualified_request_pio_latency_s1;
  wire             cpu_0_data_master_qualified_request_pio_missed_s1;
  wire             cpu_0_data_master_qualified_request_pio_period_s1;
  wire             cpu_0_data_master_qualified_request_pio_pulse_s1;
  wire             cpu_0_data_master_qualified_request_pio_response_s1;
  wire             cpu_0_data_master_qualified_request_red_led_pio_s1;
  wire             cpu_0_data_master_qualified_request_sdram_0_s1;
  wire             cpu_0_data_master_qualified_request_seven_seg_middle_pio_s1;
  wire             cpu_0_data_master_qualified_request_seven_seg_pio_s1;
  wire             cpu_0_data_master_qualified_request_seven_seg_right_pio_s1;
  wire             cpu_0_data_master_qualified_request_switch_pio_s1;
  wire             cpu_0_data_master_qualified_request_sysid_control_slave;
  wire             cpu_0_data_master_qualified_request_timer_0_s1;
  wire             cpu_0_data_master_qualified_request_timer_1_s1;
  wire             cpu_0_data_master_read;
  wire             cpu_0_data_master_read_data_valid_button_pio_s1;
  wire             cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_read_data_valid_green_led_pio_s1;
  wire             cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_read_data_valid_lcd_display_control_slave;
  wire             cpu_0_data_master_read_data_valid_led_pio_s1;
  wire             cpu_0_data_master_read_data_valid_pio_dutycycle_s1;
  wire             cpu_0_data_master_read_data_valid_pio_egmenable_s1;
  wire             cpu_0_data_master_read_data_valid_pio_egmreset_s1;
  wire             cpu_0_data_master_read_data_valid_pio_latency_s1;
  wire             cpu_0_data_master_read_data_valid_pio_missed_s1;
  wire             cpu_0_data_master_read_data_valid_pio_period_s1;
  wire             cpu_0_data_master_read_data_valid_pio_pulse_s1;
  wire             cpu_0_data_master_read_data_valid_pio_response_s1;
  wire             cpu_0_data_master_read_data_valid_red_led_pio_s1;
  wire             cpu_0_data_master_read_data_valid_sdram_0_s1;
  wire             cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register;
  wire             cpu_0_data_master_read_data_valid_seven_seg_middle_pio_s1;
  wire             cpu_0_data_master_read_data_valid_seven_seg_pio_s1;
  wire             cpu_0_data_master_read_data_valid_seven_seg_right_pio_s1;
  wire             cpu_0_data_master_read_data_valid_switch_pio_s1;
  wire             cpu_0_data_master_read_data_valid_sysid_control_slave;
  wire             cpu_0_data_master_read_data_valid_timer_0_s1;
  wire             cpu_0_data_master_read_data_valid_timer_1_s1;
  wire    [ 31: 0] cpu_0_data_master_readdata;
  wire             cpu_0_data_master_requests_button_pio_s1;
  wire             cpu_0_data_master_requests_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_requests_green_led_pio_s1;
  wire             cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_requests_lcd_display_control_slave;
  wire             cpu_0_data_master_requests_led_pio_s1;
  wire             cpu_0_data_master_requests_pio_dutycycle_s1;
  wire             cpu_0_data_master_requests_pio_egmenable_s1;
  wire             cpu_0_data_master_requests_pio_egmreset_s1;
  wire             cpu_0_data_master_requests_pio_latency_s1;
  wire             cpu_0_data_master_requests_pio_missed_s1;
  wire             cpu_0_data_master_requests_pio_period_s1;
  wire             cpu_0_data_master_requests_pio_pulse_s1;
  wire             cpu_0_data_master_requests_pio_response_s1;
  wire             cpu_0_data_master_requests_red_led_pio_s1;
  wire             cpu_0_data_master_requests_sdram_0_s1;
  wire             cpu_0_data_master_requests_seven_seg_middle_pio_s1;
  wire             cpu_0_data_master_requests_seven_seg_pio_s1;
  wire             cpu_0_data_master_requests_seven_seg_right_pio_s1;
  wire             cpu_0_data_master_requests_switch_pio_s1;
  wire             cpu_0_data_master_requests_sysid_control_slave;
  wire             cpu_0_data_master_requests_timer_0_s1;
  wire             cpu_0_data_master_requests_timer_1_s1;
  wire             cpu_0_data_master_waitrequest;
  wire             cpu_0_data_master_write;
  wire    [ 31: 0] cpu_0_data_master_writedata;
  wire    [ 24: 0] cpu_0_instruction_master_address;
  wire    [ 24: 0] cpu_0_instruction_master_address_to_slave;
  wire    [  1: 0] cpu_0_instruction_master_dbs_address;
  wire             cpu_0_instruction_master_granted_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_granted_sdram_0_s1;
  wire             cpu_0_instruction_master_latency_counter;
  wire             cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_qualified_request_sdram_0_s1;
  wire             cpu_0_instruction_master_read;
  wire             cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_read_data_valid_sdram_0_s1;
  wire             cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register;
  wire    [ 31: 0] cpu_0_instruction_master_readdata;
  wire             cpu_0_instruction_master_readdatavalid;
  wire             cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_requests_sdram_0_s1;
  wire             cpu_0_instruction_master_waitrequest;
  wire    [  8: 0] cpu_0_jtag_debug_module_address;
  wire             cpu_0_jtag_debug_module_begintransfer;
  wire    [  3: 0] cpu_0_jtag_debug_module_byteenable;
  wire             cpu_0_jtag_debug_module_chipselect;
  wire             cpu_0_jtag_debug_module_debugaccess;
  wire    [ 31: 0] cpu_0_jtag_debug_module_readdata;
  wire    [ 31: 0] cpu_0_jtag_debug_module_readdata_from_sa;
  wire             cpu_0_jtag_debug_module_reset_n;
  wire             cpu_0_jtag_debug_module_resetrequest;
  wire             cpu_0_jtag_debug_module_resetrequest_from_sa;
  wire             cpu_0_jtag_debug_module_write;
  wire    [ 31: 0] cpu_0_jtag_debug_module_writedata;
  wire             d1_button_pio_s1_end_xfer;
  wire             d1_cpu_0_jtag_debug_module_end_xfer;
  wire             d1_green_led_pio_s1_end_xfer;
  wire             d1_jtag_uart_0_avalon_jtag_slave_end_xfer;
  wire             d1_lcd_display_control_slave_end_xfer;
  wire             d1_led_pio_s1_end_xfer;
  wire             d1_pio_dutycycle_s1_end_xfer;
  wire             d1_pio_egmenable_s1_end_xfer;
  wire             d1_pio_egmreset_s1_end_xfer;
  wire             d1_pio_latency_s1_end_xfer;
  wire             d1_pio_missed_s1_end_xfer;
  wire             d1_pio_period_s1_end_xfer;
  wire             d1_pio_pulse_s1_end_xfer;
  wire             d1_pio_response_s1_end_xfer;
  wire             d1_red_led_pio_s1_end_xfer;
  wire             d1_sdram_0_s1_end_xfer;
  wire             d1_seven_seg_middle_pio_s1_end_xfer;
  wire             d1_seven_seg_pio_s1_end_xfer;
  wire             d1_seven_seg_right_pio_s1_end_xfer;
  wire             d1_switch_pio_s1_end_xfer;
  wire             d1_sysid_control_slave_end_xfer;
  wire             d1_timer_0_s1_end_xfer;
  wire             d1_timer_1_s1_end_xfer;
  wire    [  1: 0] green_led_pio_s1_address;
  wire             green_led_pio_s1_chipselect;
  wire    [  7: 0] green_led_pio_s1_readdata;
  wire    [  7: 0] green_led_pio_s1_readdata_from_sa;
  wire             green_led_pio_s1_reset_n;
  wire             green_led_pio_s1_write_n;
  wire    [  7: 0] green_led_pio_s1_writedata;
  wire             jtag_uart_0_avalon_jtag_slave_address;
  wire             jtag_uart_0_avalon_jtag_slave_chipselect;
  wire             jtag_uart_0_avalon_jtag_slave_dataavailable;
  wire             jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_irq;
  wire             jtag_uart_0_avalon_jtag_slave_irq_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_read_n;
  wire    [ 31: 0] jtag_uart_0_avalon_jtag_slave_readdata;
  wire    [ 31: 0] jtag_uart_0_avalon_jtag_slave_readdata_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_readyfordata;
  wire             jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_reset_n;
  wire             jtag_uart_0_avalon_jtag_slave_waitrequest;
  wire             jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_write_n;
  wire    [ 31: 0] jtag_uart_0_avalon_jtag_slave_writedata;
  wire    [  1: 0] lcd_display_control_slave_address;
  wire             lcd_display_control_slave_begintransfer;
  wire             lcd_display_control_slave_read;
  wire    [  7: 0] lcd_display_control_slave_readdata;
  wire    [  7: 0] lcd_display_control_slave_readdata_from_sa;
  wire             lcd_display_control_slave_wait_counter_eq_0;
  wire             lcd_display_control_slave_wait_counter_eq_1;
  wire             lcd_display_control_slave_write;
  wire    [  7: 0] lcd_display_control_slave_writedata;
  wire    [  1: 0] led_pio_s1_address;
  wire             led_pio_s1_chipselect;
  wire    [  7: 0] led_pio_s1_readdata;
  wire    [  7: 0] led_pio_s1_readdata_from_sa;
  wire             led_pio_s1_reset_n;
  wire             led_pio_s1_write_n;
  wire    [  7: 0] led_pio_s1_writedata;
  wire    [  7: 0] out_port_from_the_green_led_pio;
  wire    [  7: 0] out_port_from_the_led_pio;
  wire    [  3: 0] out_port_from_the_pio_dutycycle;
  wire             out_port_from_the_pio_egmenable;
  wire             out_port_from_the_pio_egmreset;
  wire    [  3: 0] out_port_from_the_pio_period;
  wire             out_port_from_the_pio_response;
  wire    [  7: 0] out_port_from_the_red_led_pio;
  wire    [ 15: 0] out_port_from_the_seven_seg_middle_pio;
  wire    [ 15: 0] out_port_from_the_seven_seg_pio;
  wire    [ 31: 0] out_port_from_the_seven_seg_right_pio;
  wire    [  1: 0] pio_dutycycle_s1_address;
  wire             pio_dutycycle_s1_chipselect;
  wire    [  3: 0] pio_dutycycle_s1_readdata;
  wire    [  3: 0] pio_dutycycle_s1_readdata_from_sa;
  wire             pio_dutycycle_s1_reset_n;
  wire             pio_dutycycle_s1_write_n;
  wire    [  3: 0] pio_dutycycle_s1_writedata;
  wire    [  1: 0] pio_egmenable_s1_address;
  wire             pio_egmenable_s1_chipselect;
  wire             pio_egmenable_s1_readdata;
  wire             pio_egmenable_s1_readdata_from_sa;
  wire             pio_egmenable_s1_reset_n;
  wire             pio_egmenable_s1_write_n;
  wire             pio_egmenable_s1_writedata;
  wire    [  1: 0] pio_egmreset_s1_address;
  wire             pio_egmreset_s1_chipselect;
  wire             pio_egmreset_s1_readdata;
  wire             pio_egmreset_s1_readdata_from_sa;
  wire             pio_egmreset_s1_reset_n;
  wire             pio_egmreset_s1_write_n;
  wire             pio_egmreset_s1_writedata;
  wire    [  1: 0] pio_latency_s1_address;
  wire    [ 15: 0] pio_latency_s1_readdata;
  wire    [ 15: 0] pio_latency_s1_readdata_from_sa;
  wire             pio_latency_s1_reset_n;
  wire    [  1: 0] pio_missed_s1_address;
  wire    [ 15: 0] pio_missed_s1_readdata;
  wire    [ 15: 0] pio_missed_s1_readdata_from_sa;
  wire             pio_missed_s1_reset_n;
  wire    [  1: 0] pio_period_s1_address;
  wire             pio_period_s1_chipselect;
  wire    [  3: 0] pio_period_s1_readdata;
  wire    [  3: 0] pio_period_s1_readdata_from_sa;
  wire             pio_period_s1_reset_n;
  wire             pio_period_s1_write_n;
  wire    [  3: 0] pio_period_s1_writedata;
  wire    [  1: 0] pio_pulse_s1_address;
  wire             pio_pulse_s1_chipselect;
  wire             pio_pulse_s1_irq;
  wire             pio_pulse_s1_irq_from_sa;
  wire             pio_pulse_s1_readdata;
  wire             pio_pulse_s1_readdata_from_sa;
  wire             pio_pulse_s1_reset_n;
  wire             pio_pulse_s1_write_n;
  wire             pio_pulse_s1_writedata;
  wire    [  1: 0] pio_response_s1_address;
  wire             pio_response_s1_chipselect;
  wire             pio_response_s1_readdata;
  wire             pio_response_s1_readdata_from_sa;
  wire             pio_response_s1_reset_n;
  wire             pio_response_s1_write_n;
  wire             pio_response_s1_writedata;
  wire    [  1: 0] red_led_pio_s1_address;
  wire             red_led_pio_s1_chipselect;
  wire    [  7: 0] red_led_pio_s1_readdata;
  wire    [  7: 0] red_led_pio_s1_readdata_from_sa;
  wire             red_led_pio_s1_reset_n;
  wire             red_led_pio_s1_write_n;
  wire    [  7: 0] red_led_pio_s1_writedata;
  wire             reset_n_sources;
  wire    [ 21: 0] sdram_0_s1_address;
  wire    [  1: 0] sdram_0_s1_byteenable_n;
  wire             sdram_0_s1_chipselect;
  wire             sdram_0_s1_read_n;
  wire    [ 15: 0] sdram_0_s1_readdata;
  wire    [ 15: 0] sdram_0_s1_readdata_from_sa;
  wire             sdram_0_s1_readdatavalid;
  wire             sdram_0_s1_reset_n;
  wire             sdram_0_s1_waitrequest;
  wire             sdram_0_s1_waitrequest_from_sa;
  wire             sdram_0_s1_write_n;
  wire    [ 15: 0] sdram_0_s1_writedata;
  wire    [  1: 0] seven_seg_middle_pio_s1_address;
  wire             seven_seg_middle_pio_s1_chipselect;
  wire    [ 15: 0] seven_seg_middle_pio_s1_readdata;
  wire    [ 15: 0] seven_seg_middle_pio_s1_readdata_from_sa;
  wire             seven_seg_middle_pio_s1_reset_n;
  wire             seven_seg_middle_pio_s1_write_n;
  wire    [ 15: 0] seven_seg_middle_pio_s1_writedata;
  wire    [  1: 0] seven_seg_pio_s1_address;
  wire             seven_seg_pio_s1_chipselect;
  wire    [ 15: 0] seven_seg_pio_s1_readdata;
  wire    [ 15: 0] seven_seg_pio_s1_readdata_from_sa;
  wire             seven_seg_pio_s1_reset_n;
  wire             seven_seg_pio_s1_write_n;
  wire    [ 15: 0] seven_seg_pio_s1_writedata;
  wire    [  1: 0] seven_seg_right_pio_s1_address;
  wire             seven_seg_right_pio_s1_chipselect;
  wire    [ 31: 0] seven_seg_right_pio_s1_readdata;
  wire    [ 31: 0] seven_seg_right_pio_s1_readdata_from_sa;
  wire             seven_seg_right_pio_s1_reset_n;
  wire             seven_seg_right_pio_s1_write_n;
  wire    [ 31: 0] seven_seg_right_pio_s1_writedata;
  wire    [  1: 0] switch_pio_s1_address;
  wire    [ 15: 0] switch_pio_s1_readdata;
  wire    [ 15: 0] switch_pio_s1_readdata_from_sa;
  wire             switch_pio_s1_reset_n;
  wire             sysid_control_slave_address;
  wire             sysid_control_slave_clock;
  wire    [ 31: 0] sysid_control_slave_readdata;
  wire    [ 31: 0] sysid_control_slave_readdata_from_sa;
  wire             sysid_control_slave_reset_n;
  wire    [  2: 0] timer_0_s1_address;
  wire             timer_0_s1_chipselect;
  wire             timer_0_s1_irq;
  wire             timer_0_s1_irq_from_sa;
  wire    [ 15: 0] timer_0_s1_readdata;
  wire    [ 15: 0] timer_0_s1_readdata_from_sa;
  wire             timer_0_s1_reset_n;
  wire             timer_0_s1_write_n;
  wire    [ 15: 0] timer_0_s1_writedata;
  wire    [  2: 0] timer_1_s1_address;
  wire             timer_1_s1_chipselect;
  wire             timer_1_s1_irq;
  wire             timer_1_s1_irq_from_sa;
  wire    [ 15: 0] timer_1_s1_readdata;
  wire    [ 15: 0] timer_1_s1_readdata_from_sa;
  wire             timer_1_s1_reset_n;
  wire             timer_1_s1_write_n;
  wire    [ 15: 0] timer_1_s1_writedata;
  wire    [ 11: 0] zs_addr_from_the_sdram_0;
  wire    [  1: 0] zs_ba_from_the_sdram_0;
  wire             zs_cas_n_from_the_sdram_0;
  wire             zs_cke_from_the_sdram_0;
  wire             zs_cs_n_from_the_sdram_0;
  wire    [ 15: 0] zs_dq_to_and_from_the_sdram_0;
  wire    [  1: 0] zs_dqm_from_the_sdram_0;
  wire             zs_ras_n_from_the_sdram_0;
  wire             zs_we_n_from_the_sdram_0;
  button_pio_s1_arbitrator the_button_pio_s1
    (
      .button_pio_s1_address                             (button_pio_s1_address),
      .button_pio_s1_chipselect                          (button_pio_s1_chipselect),
      .button_pio_s1_irq                                 (button_pio_s1_irq),
      .button_pio_s1_irq_from_sa                         (button_pio_s1_irq_from_sa),
      .button_pio_s1_readdata                            (button_pio_s1_readdata),
      .button_pio_s1_readdata_from_sa                    (button_pio_s1_readdata_from_sa),
      .button_pio_s1_reset_n                             (button_pio_s1_reset_n),
      .button_pio_s1_write_n                             (button_pio_s1_write_n),
      .button_pio_s1_writedata                           (button_pio_s1_writedata),
      .clk                                               (clk_0),
      .cpu_0_data_master_address_to_slave                (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_button_pio_s1           (cpu_0_data_master_granted_button_pio_s1),
      .cpu_0_data_master_qualified_request_button_pio_s1 (cpu_0_data_master_qualified_request_button_pio_s1),
      .cpu_0_data_master_read                            (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_button_pio_s1   (cpu_0_data_master_read_data_valid_button_pio_s1),
      .cpu_0_data_master_requests_button_pio_s1          (cpu_0_data_master_requests_button_pio_s1),
      .cpu_0_data_master_waitrequest                     (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                           (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                       (cpu_0_data_master_writedata),
      .d1_button_pio_s1_end_xfer                         (d1_button_pio_s1_end_xfer),
      .reset_n                                           (clk_0_reset_n)
    );

  button_pio the_button_pio
    (
      .address    (button_pio_s1_address),
      .chipselect (button_pio_s1_chipselect),
      .clk        (clk_0),
      .in_port    (in_port_to_the_button_pio),
      .irq        (button_pio_s1_irq),
      .readdata   (button_pio_s1_readdata),
      .reset_n    (button_pio_s1_reset_n),
      .write_n    (button_pio_s1_write_n),
      .writedata  (button_pio_s1_writedata)
    );

  cpu_0_jtag_debug_module_arbitrator the_cpu_0_jtag_debug_module
    (
      .clk                                                                (clk_0),
      .cpu_0_data_master_address_to_slave                                 (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_byteenable                                       (cpu_0_data_master_byteenable),
      .cpu_0_data_master_debugaccess                                      (cpu_0_data_master_debugaccess),
      .cpu_0_data_master_granted_cpu_0_jtag_debug_module                  (cpu_0_data_master_granted_cpu_0_jtag_debug_module),
      .cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module        (cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module),
      .cpu_0_data_master_read                                             (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module          (cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module),
      .cpu_0_data_master_requests_cpu_0_jtag_debug_module                 (cpu_0_data_master_requests_cpu_0_jtag_debug_module),
      .cpu_0_data_master_waitrequest                                      (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                                            (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                                        (cpu_0_data_master_writedata),
      .cpu_0_instruction_master_address_to_slave                          (cpu_0_instruction_master_address_to_slave),
      .cpu_0_instruction_master_granted_cpu_0_jtag_debug_module           (cpu_0_instruction_master_granted_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_latency_counter                           (cpu_0_instruction_master_latency_counter),
      .cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module (cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_read                                      (cpu_0_instruction_master_read),
      .cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module   (cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register (cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register),
      .cpu_0_instruction_master_requests_cpu_0_jtag_debug_module          (cpu_0_instruction_master_requests_cpu_0_jtag_debug_module),
      .cpu_0_jtag_debug_module_address                                    (cpu_0_jtag_debug_module_address),
      .cpu_0_jtag_debug_module_begintransfer                              (cpu_0_jtag_debug_module_begintransfer),
      .cpu_0_jtag_debug_module_byteenable                                 (cpu_0_jtag_debug_module_byteenable),
      .cpu_0_jtag_debug_module_chipselect                                 (cpu_0_jtag_debug_module_chipselect),
      .cpu_0_jtag_debug_module_debugaccess                                (cpu_0_jtag_debug_module_debugaccess),
      .cpu_0_jtag_debug_module_readdata                                   (cpu_0_jtag_debug_module_readdata),
      .cpu_0_jtag_debug_module_readdata_from_sa                           (cpu_0_jtag_debug_module_readdata_from_sa),
      .cpu_0_jtag_debug_module_reset_n                                    (cpu_0_jtag_debug_module_reset_n),
      .cpu_0_jtag_debug_module_resetrequest                               (cpu_0_jtag_debug_module_resetrequest),
      .cpu_0_jtag_debug_module_resetrequest_from_sa                       (cpu_0_jtag_debug_module_resetrequest_from_sa),
      .cpu_0_jtag_debug_module_write                                      (cpu_0_jtag_debug_module_write),
      .cpu_0_jtag_debug_module_writedata                                  (cpu_0_jtag_debug_module_writedata),
      .d1_cpu_0_jtag_debug_module_end_xfer                                (d1_cpu_0_jtag_debug_module_end_xfer),
      .reset_n                                                            (clk_0_reset_n)
    );

  cpu_0_data_master_arbitrator the_cpu_0_data_master
    (
      .button_pio_s1_irq_from_sa                                         (button_pio_s1_irq_from_sa),
      .button_pio_s1_readdata_from_sa                                    (button_pio_s1_readdata_from_sa),
      .clk                                                               (clk_0),
      .cpu_0_data_master_address                                         (cpu_0_data_master_address),
      .cpu_0_data_master_address_to_slave                                (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_byteenable_sdram_0_s1                           (cpu_0_data_master_byteenable_sdram_0_s1),
      .cpu_0_data_master_dbs_address                                     (cpu_0_data_master_dbs_address),
      .cpu_0_data_master_dbs_write_16                                    (cpu_0_data_master_dbs_write_16),
      .cpu_0_data_master_granted_button_pio_s1                           (cpu_0_data_master_granted_button_pio_s1),
      .cpu_0_data_master_granted_cpu_0_jtag_debug_module                 (cpu_0_data_master_granted_cpu_0_jtag_debug_module),
      .cpu_0_data_master_granted_green_led_pio_s1                        (cpu_0_data_master_granted_green_led_pio_s1),
      .cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave           (cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_granted_lcd_display_control_slave               (cpu_0_data_master_granted_lcd_display_control_slave),
      .cpu_0_data_master_granted_led_pio_s1                              (cpu_0_data_master_granted_led_pio_s1),
      .cpu_0_data_master_granted_pio_dutycycle_s1                        (cpu_0_data_master_granted_pio_dutycycle_s1),
      .cpu_0_data_master_granted_pio_egmenable_s1                        (cpu_0_data_master_granted_pio_egmenable_s1),
      .cpu_0_data_master_granted_pio_egmreset_s1                         (cpu_0_data_master_granted_pio_egmreset_s1),
      .cpu_0_data_master_granted_pio_latency_s1                          (cpu_0_data_master_granted_pio_latency_s1),
      .cpu_0_data_master_granted_pio_missed_s1                           (cpu_0_data_master_granted_pio_missed_s1),
      .cpu_0_data_master_granted_pio_period_s1                           (cpu_0_data_master_granted_pio_period_s1),
      .cpu_0_data_master_granted_pio_pulse_s1                            (cpu_0_data_master_granted_pio_pulse_s1),
      .cpu_0_data_master_granted_pio_response_s1                         (cpu_0_data_master_granted_pio_response_s1),
      .cpu_0_data_master_granted_red_led_pio_s1                          (cpu_0_data_master_granted_red_led_pio_s1),
      .cpu_0_data_master_granted_sdram_0_s1                              (cpu_0_data_master_granted_sdram_0_s1),
      .cpu_0_data_master_granted_seven_seg_middle_pio_s1                 (cpu_0_data_master_granted_seven_seg_middle_pio_s1),
      .cpu_0_data_master_granted_seven_seg_pio_s1                        (cpu_0_data_master_granted_seven_seg_pio_s1),
      .cpu_0_data_master_granted_seven_seg_right_pio_s1                  (cpu_0_data_master_granted_seven_seg_right_pio_s1),
      .cpu_0_data_master_granted_switch_pio_s1                           (cpu_0_data_master_granted_switch_pio_s1),
      .cpu_0_data_master_granted_sysid_control_slave                     (cpu_0_data_master_granted_sysid_control_slave),
      .cpu_0_data_master_granted_timer_0_s1                              (cpu_0_data_master_granted_timer_0_s1),
      .cpu_0_data_master_granted_timer_1_s1                              (cpu_0_data_master_granted_timer_1_s1),
      .cpu_0_data_master_irq                                             (cpu_0_data_master_irq),
      .cpu_0_data_master_no_byte_enables_and_last_term                   (cpu_0_data_master_no_byte_enables_and_last_term),
      .cpu_0_data_master_qualified_request_button_pio_s1                 (cpu_0_data_master_qualified_request_button_pio_s1),
      .cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module       (cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module),
      .cpu_0_data_master_qualified_request_green_led_pio_s1              (cpu_0_data_master_qualified_request_green_led_pio_s1),
      .cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave (cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_qualified_request_lcd_display_control_slave     (cpu_0_data_master_qualified_request_lcd_display_control_slave),
      .cpu_0_data_master_qualified_request_led_pio_s1                    (cpu_0_data_master_qualified_request_led_pio_s1),
      .cpu_0_data_master_qualified_request_pio_dutycycle_s1              (cpu_0_data_master_qualified_request_pio_dutycycle_s1),
      .cpu_0_data_master_qualified_request_pio_egmenable_s1              (cpu_0_data_master_qualified_request_pio_egmenable_s1),
      .cpu_0_data_master_qualified_request_pio_egmreset_s1               (cpu_0_data_master_qualified_request_pio_egmreset_s1),
      .cpu_0_data_master_qualified_request_pio_latency_s1                (cpu_0_data_master_qualified_request_pio_latency_s1),
      .cpu_0_data_master_qualified_request_pio_missed_s1                 (cpu_0_data_master_qualified_request_pio_missed_s1),
      .cpu_0_data_master_qualified_request_pio_period_s1                 (cpu_0_data_master_qualified_request_pio_period_s1),
      .cpu_0_data_master_qualified_request_pio_pulse_s1                  (cpu_0_data_master_qualified_request_pio_pulse_s1),
      .cpu_0_data_master_qualified_request_pio_response_s1               (cpu_0_data_master_qualified_request_pio_response_s1),
      .cpu_0_data_master_qualified_request_red_led_pio_s1                (cpu_0_data_master_qualified_request_red_led_pio_s1),
      .cpu_0_data_master_qualified_request_sdram_0_s1                    (cpu_0_data_master_qualified_request_sdram_0_s1),
      .cpu_0_data_master_qualified_request_seven_seg_middle_pio_s1       (cpu_0_data_master_qualified_request_seven_seg_middle_pio_s1),
      .cpu_0_data_master_qualified_request_seven_seg_pio_s1              (cpu_0_data_master_qualified_request_seven_seg_pio_s1),
      .cpu_0_data_master_qualified_request_seven_seg_right_pio_s1        (cpu_0_data_master_qualified_request_seven_seg_right_pio_s1),
      .cpu_0_data_master_qualified_request_switch_pio_s1                 (cpu_0_data_master_qualified_request_switch_pio_s1),
      .cpu_0_data_master_qualified_request_sysid_control_slave           (cpu_0_data_master_qualified_request_sysid_control_slave),
      .cpu_0_data_master_qualified_request_timer_0_s1                    (cpu_0_data_master_qualified_request_timer_0_s1),
      .cpu_0_data_master_qualified_request_timer_1_s1                    (cpu_0_data_master_qualified_request_timer_1_s1),
      .cpu_0_data_master_read                                            (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_button_pio_s1                   (cpu_0_data_master_read_data_valid_button_pio_s1),
      .cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module         (cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module),
      .cpu_0_data_master_read_data_valid_green_led_pio_s1                (cpu_0_data_master_read_data_valid_green_led_pio_s1),
      .cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave   (cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_read_data_valid_lcd_display_control_slave       (cpu_0_data_master_read_data_valid_lcd_display_control_slave),
      .cpu_0_data_master_read_data_valid_led_pio_s1                      (cpu_0_data_master_read_data_valid_led_pio_s1),
      .cpu_0_data_master_read_data_valid_pio_dutycycle_s1                (cpu_0_data_master_read_data_valid_pio_dutycycle_s1),
      .cpu_0_data_master_read_data_valid_pio_egmenable_s1                (cpu_0_data_master_read_data_valid_pio_egmenable_s1),
      .cpu_0_data_master_read_data_valid_pio_egmreset_s1                 (cpu_0_data_master_read_data_valid_pio_egmreset_s1),
      .cpu_0_data_master_read_data_valid_pio_latency_s1                  (cpu_0_data_master_read_data_valid_pio_latency_s1),
      .cpu_0_data_master_read_data_valid_pio_missed_s1                   (cpu_0_data_master_read_data_valid_pio_missed_s1),
      .cpu_0_data_master_read_data_valid_pio_period_s1                   (cpu_0_data_master_read_data_valid_pio_period_s1),
      .cpu_0_data_master_read_data_valid_pio_pulse_s1                    (cpu_0_data_master_read_data_valid_pio_pulse_s1),
      .cpu_0_data_master_read_data_valid_pio_response_s1                 (cpu_0_data_master_read_data_valid_pio_response_s1),
      .cpu_0_data_master_read_data_valid_red_led_pio_s1                  (cpu_0_data_master_read_data_valid_red_led_pio_s1),
      .cpu_0_data_master_read_data_valid_sdram_0_s1                      (cpu_0_data_master_read_data_valid_sdram_0_s1),
      .cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register       (cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register),
      .cpu_0_data_master_read_data_valid_seven_seg_middle_pio_s1         (cpu_0_data_master_read_data_valid_seven_seg_middle_pio_s1),
      .cpu_0_data_master_read_data_valid_seven_seg_pio_s1                (cpu_0_data_master_read_data_valid_seven_seg_pio_s1),
      .cpu_0_data_master_read_data_valid_seven_seg_right_pio_s1          (cpu_0_data_master_read_data_valid_seven_seg_right_pio_s1),
      .cpu_0_data_master_read_data_valid_switch_pio_s1                   (cpu_0_data_master_read_data_valid_switch_pio_s1),
      .cpu_0_data_master_read_data_valid_sysid_control_slave             (cpu_0_data_master_read_data_valid_sysid_control_slave),
      .cpu_0_data_master_read_data_valid_timer_0_s1                      (cpu_0_data_master_read_data_valid_timer_0_s1),
      .cpu_0_data_master_read_data_valid_timer_1_s1                      (cpu_0_data_master_read_data_valid_timer_1_s1),
      .cpu_0_data_master_readdata                                        (cpu_0_data_master_readdata),
      .cpu_0_data_master_requests_button_pio_s1                          (cpu_0_data_master_requests_button_pio_s1),
      .cpu_0_data_master_requests_cpu_0_jtag_debug_module                (cpu_0_data_master_requests_cpu_0_jtag_debug_module),
      .cpu_0_data_master_requests_green_led_pio_s1                       (cpu_0_data_master_requests_green_led_pio_s1),
      .cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave          (cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_requests_lcd_display_control_slave              (cpu_0_data_master_requests_lcd_display_control_slave),
      .cpu_0_data_master_requests_led_pio_s1                             (cpu_0_data_master_requests_led_pio_s1),
      .cpu_0_data_master_requests_pio_dutycycle_s1                       (cpu_0_data_master_requests_pio_dutycycle_s1),
      .cpu_0_data_master_requests_pio_egmenable_s1                       (cpu_0_data_master_requests_pio_egmenable_s1),
      .cpu_0_data_master_requests_pio_egmreset_s1                        (cpu_0_data_master_requests_pio_egmreset_s1),
      .cpu_0_data_master_requests_pio_latency_s1                         (cpu_0_data_master_requests_pio_latency_s1),
      .cpu_0_data_master_requests_pio_missed_s1                          (cpu_0_data_master_requests_pio_missed_s1),
      .cpu_0_data_master_requests_pio_period_s1                          (cpu_0_data_master_requests_pio_period_s1),
      .cpu_0_data_master_requests_pio_pulse_s1                           (cpu_0_data_master_requests_pio_pulse_s1),
      .cpu_0_data_master_requests_pio_response_s1                        (cpu_0_data_master_requests_pio_response_s1),
      .cpu_0_data_master_requests_red_led_pio_s1                         (cpu_0_data_master_requests_red_led_pio_s1),
      .cpu_0_data_master_requests_sdram_0_s1                             (cpu_0_data_master_requests_sdram_0_s1),
      .cpu_0_data_master_requests_seven_seg_middle_pio_s1                (cpu_0_data_master_requests_seven_seg_middle_pio_s1),
      .cpu_0_data_master_requests_seven_seg_pio_s1                       (cpu_0_data_master_requests_seven_seg_pio_s1),
      .cpu_0_data_master_requests_seven_seg_right_pio_s1                 (cpu_0_data_master_requests_seven_seg_right_pio_s1),
      .cpu_0_data_master_requests_switch_pio_s1                          (cpu_0_data_master_requests_switch_pio_s1),
      .cpu_0_data_master_requests_sysid_control_slave                    (cpu_0_data_master_requests_sysid_control_slave),
      .cpu_0_data_master_requests_timer_0_s1                             (cpu_0_data_master_requests_timer_0_s1),
      .cpu_0_data_master_requests_timer_1_s1                             (cpu_0_data_master_requests_timer_1_s1),
      .cpu_0_data_master_waitrequest                                     (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                                           (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                                       (cpu_0_data_master_writedata),
      .cpu_0_jtag_debug_module_readdata_from_sa                          (cpu_0_jtag_debug_module_readdata_from_sa),
      .d1_button_pio_s1_end_xfer                                         (d1_button_pio_s1_end_xfer),
      .d1_cpu_0_jtag_debug_module_end_xfer                               (d1_cpu_0_jtag_debug_module_end_xfer),
      .d1_green_led_pio_s1_end_xfer                                      (d1_green_led_pio_s1_end_xfer),
      .d1_jtag_uart_0_avalon_jtag_slave_end_xfer                         (d1_jtag_uart_0_avalon_jtag_slave_end_xfer),
      .d1_lcd_display_control_slave_end_xfer                             (d1_lcd_display_control_slave_end_xfer),
      .d1_led_pio_s1_end_xfer                                            (d1_led_pio_s1_end_xfer),
      .d1_pio_dutycycle_s1_end_xfer                                      (d1_pio_dutycycle_s1_end_xfer),
      .d1_pio_egmenable_s1_end_xfer                                      (d1_pio_egmenable_s1_end_xfer),
      .d1_pio_egmreset_s1_end_xfer                                       (d1_pio_egmreset_s1_end_xfer),
      .d1_pio_latency_s1_end_xfer                                        (d1_pio_latency_s1_end_xfer),
      .d1_pio_missed_s1_end_xfer                                         (d1_pio_missed_s1_end_xfer),
      .d1_pio_period_s1_end_xfer                                         (d1_pio_period_s1_end_xfer),
      .d1_pio_pulse_s1_end_xfer                                          (d1_pio_pulse_s1_end_xfer),
      .d1_pio_response_s1_end_xfer                                       (d1_pio_response_s1_end_xfer),
      .d1_red_led_pio_s1_end_xfer                                        (d1_red_led_pio_s1_end_xfer),
      .d1_sdram_0_s1_end_xfer                                            (d1_sdram_0_s1_end_xfer),
      .d1_seven_seg_middle_pio_s1_end_xfer                               (d1_seven_seg_middle_pio_s1_end_xfer),
      .d1_seven_seg_pio_s1_end_xfer                                      (d1_seven_seg_pio_s1_end_xfer),
      .d1_seven_seg_right_pio_s1_end_xfer                                (d1_seven_seg_right_pio_s1_end_xfer),
      .d1_switch_pio_s1_end_xfer                                         (d1_switch_pio_s1_end_xfer),
      .d1_sysid_control_slave_end_xfer                                   (d1_sysid_control_slave_end_xfer),
      .d1_timer_0_s1_end_xfer                                            (d1_timer_0_s1_end_xfer),
      .d1_timer_1_s1_end_xfer                                            (d1_timer_1_s1_end_xfer),
      .green_led_pio_s1_readdata_from_sa                                 (green_led_pio_s1_readdata_from_sa),
      .jtag_uart_0_avalon_jtag_slave_irq_from_sa                         (jtag_uart_0_avalon_jtag_slave_irq_from_sa),
      .jtag_uart_0_avalon_jtag_slave_readdata_from_sa                    (jtag_uart_0_avalon_jtag_slave_readdata_from_sa),
      .jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa                 (jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa),
      .lcd_display_control_slave_readdata_from_sa                        (lcd_display_control_slave_readdata_from_sa),
      .lcd_display_control_slave_wait_counter_eq_0                       (lcd_display_control_slave_wait_counter_eq_0),
      .lcd_display_control_slave_wait_counter_eq_1                       (lcd_display_control_slave_wait_counter_eq_1),
      .led_pio_s1_readdata_from_sa                                       (led_pio_s1_readdata_from_sa),
      .pio_dutycycle_s1_readdata_from_sa                                 (pio_dutycycle_s1_readdata_from_sa),
      .pio_egmenable_s1_readdata_from_sa                                 (pio_egmenable_s1_readdata_from_sa),
      .pio_egmreset_s1_readdata_from_sa                                  (pio_egmreset_s1_readdata_from_sa),
      .pio_latency_s1_readdata_from_sa                                   (pio_latency_s1_readdata_from_sa),
      .pio_missed_s1_readdata_from_sa                                    (pio_missed_s1_readdata_from_sa),
      .pio_period_s1_readdata_from_sa                                    (pio_period_s1_readdata_from_sa),
      .pio_pulse_s1_irq_from_sa                                          (pio_pulse_s1_irq_from_sa),
      .pio_pulse_s1_readdata_from_sa                                     (pio_pulse_s1_readdata_from_sa),
      .pio_response_s1_readdata_from_sa                                  (pio_response_s1_readdata_from_sa),
      .red_led_pio_s1_readdata_from_sa                                   (red_led_pio_s1_readdata_from_sa),
      .reset_n                                                           (clk_0_reset_n),
      .sdram_0_s1_readdata_from_sa                                       (sdram_0_s1_readdata_from_sa),
      .sdram_0_s1_waitrequest_from_sa                                    (sdram_0_s1_waitrequest_from_sa),
      .seven_seg_middle_pio_s1_readdata_from_sa                          (seven_seg_middle_pio_s1_readdata_from_sa),
      .seven_seg_pio_s1_readdata_from_sa                                 (seven_seg_pio_s1_readdata_from_sa),
      .seven_seg_right_pio_s1_readdata_from_sa                           (seven_seg_right_pio_s1_readdata_from_sa),
      .switch_pio_s1_readdata_from_sa                                    (switch_pio_s1_readdata_from_sa),
      .sysid_control_slave_readdata_from_sa                              (sysid_control_slave_readdata_from_sa),
      .timer_0_s1_irq_from_sa                                            (timer_0_s1_irq_from_sa),
      .timer_0_s1_readdata_from_sa                                       (timer_0_s1_readdata_from_sa),
      .timer_1_s1_irq_from_sa                                            (timer_1_s1_irq_from_sa),
      .timer_1_s1_readdata_from_sa                                       (timer_1_s1_readdata_from_sa)
    );

  cpu_0_instruction_master_arbitrator the_cpu_0_instruction_master
    (
      .clk                                                                (clk_0),
      .cpu_0_instruction_master_address                                   (cpu_0_instruction_master_address),
      .cpu_0_instruction_master_address_to_slave                          (cpu_0_instruction_master_address_to_slave),
      .cpu_0_instruction_master_dbs_address                               (cpu_0_instruction_master_dbs_address),
      .cpu_0_instruction_master_granted_cpu_0_jtag_debug_module           (cpu_0_instruction_master_granted_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_granted_sdram_0_s1                        (cpu_0_instruction_master_granted_sdram_0_s1),
      .cpu_0_instruction_master_latency_counter                           (cpu_0_instruction_master_latency_counter),
      .cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module (cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_qualified_request_sdram_0_s1              (cpu_0_instruction_master_qualified_request_sdram_0_s1),
      .cpu_0_instruction_master_read                                      (cpu_0_instruction_master_read),
      .cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module   (cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_read_data_valid_sdram_0_s1                (cpu_0_instruction_master_read_data_valid_sdram_0_s1),
      .cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register (cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register),
      .cpu_0_instruction_master_readdata                                  (cpu_0_instruction_master_readdata),
      .cpu_0_instruction_master_readdatavalid                             (cpu_0_instruction_master_readdatavalid),
      .cpu_0_instruction_master_requests_cpu_0_jtag_debug_module          (cpu_0_instruction_master_requests_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_requests_sdram_0_s1                       (cpu_0_instruction_master_requests_sdram_0_s1),
      .cpu_0_instruction_master_waitrequest                               (cpu_0_instruction_master_waitrequest),
      .cpu_0_jtag_debug_module_readdata_from_sa                           (cpu_0_jtag_debug_module_readdata_from_sa),
      .d1_cpu_0_jtag_debug_module_end_xfer                                (d1_cpu_0_jtag_debug_module_end_xfer),
      .d1_sdram_0_s1_end_xfer                                             (d1_sdram_0_s1_end_xfer),
      .reset_n                                                            (clk_0_reset_n),
      .sdram_0_s1_readdata_from_sa                                        (sdram_0_s1_readdata_from_sa),
      .sdram_0_s1_waitrequest_from_sa                                     (sdram_0_s1_waitrequest_from_sa)
    );

  cpu_0 the_cpu_0
    (
      .clk                                   (clk_0),
      .d_address                             (cpu_0_data_master_address),
      .d_byteenable                          (cpu_0_data_master_byteenable),
      .d_irq                                 (cpu_0_data_master_irq),
      .d_read                                (cpu_0_data_master_read),
      .d_readdata                            (cpu_0_data_master_readdata),
      .d_waitrequest                         (cpu_0_data_master_waitrequest),
      .d_write                               (cpu_0_data_master_write),
      .d_writedata                           (cpu_0_data_master_writedata),
      .i_address                             (cpu_0_instruction_master_address),
      .i_read                                (cpu_0_instruction_master_read),
      .i_readdata                            (cpu_0_instruction_master_readdata),
      .i_readdatavalid                       (cpu_0_instruction_master_readdatavalid),
      .i_waitrequest                         (cpu_0_instruction_master_waitrequest),
      .jtag_debug_module_address             (cpu_0_jtag_debug_module_address),
      .jtag_debug_module_begintransfer       (cpu_0_jtag_debug_module_begintransfer),
      .jtag_debug_module_byteenable          (cpu_0_jtag_debug_module_byteenable),
      .jtag_debug_module_debugaccess         (cpu_0_jtag_debug_module_debugaccess),
      .jtag_debug_module_debugaccess_to_roms (cpu_0_data_master_debugaccess),
      .jtag_debug_module_readdata            (cpu_0_jtag_debug_module_readdata),
      .jtag_debug_module_resetrequest        (cpu_0_jtag_debug_module_resetrequest),
      .jtag_debug_module_select              (cpu_0_jtag_debug_module_chipselect),
      .jtag_debug_module_write               (cpu_0_jtag_debug_module_write),
      .jtag_debug_module_writedata           (cpu_0_jtag_debug_module_writedata),
      .reset_n                               (cpu_0_jtag_debug_module_reset_n)
    );

  green_led_pio_s1_arbitrator the_green_led_pio_s1
    (
      .clk                                                  (clk_0),
      .cpu_0_data_master_address_to_slave                   (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_byteenable                         (cpu_0_data_master_byteenable),
      .cpu_0_data_master_granted_green_led_pio_s1           (cpu_0_data_master_granted_green_led_pio_s1),
      .cpu_0_data_master_qualified_request_green_led_pio_s1 (cpu_0_data_master_qualified_request_green_led_pio_s1),
      .cpu_0_data_master_read                               (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_green_led_pio_s1   (cpu_0_data_master_read_data_valid_green_led_pio_s1),
      .cpu_0_data_master_requests_green_led_pio_s1          (cpu_0_data_master_requests_green_led_pio_s1),
      .cpu_0_data_master_waitrequest                        (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                              (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                          (cpu_0_data_master_writedata),
      .d1_green_led_pio_s1_end_xfer                         (d1_green_led_pio_s1_end_xfer),
      .green_led_pio_s1_address                             (green_led_pio_s1_address),
      .green_led_pio_s1_chipselect                          (green_led_pio_s1_chipselect),
      .green_led_pio_s1_readdata                            (green_led_pio_s1_readdata),
      .green_led_pio_s1_readdata_from_sa                    (green_led_pio_s1_readdata_from_sa),
      .green_led_pio_s1_reset_n                             (green_led_pio_s1_reset_n),
      .green_led_pio_s1_write_n                             (green_led_pio_s1_write_n),
      .green_led_pio_s1_writedata                           (green_led_pio_s1_writedata),
      .reset_n                                              (clk_0_reset_n)
    );

  green_led_pio the_green_led_pio
    (
      .address    (green_led_pio_s1_address),
      .chipselect (green_led_pio_s1_chipselect),
      .clk        (clk_0),
      .out_port   (out_port_from_the_green_led_pio),
      .readdata   (green_led_pio_s1_readdata),
      .reset_n    (green_led_pio_s1_reset_n),
      .write_n    (green_led_pio_s1_write_n),
      .writedata  (green_led_pio_s1_writedata)
    );

  jtag_uart_0_avalon_jtag_slave_arbitrator the_jtag_uart_0_avalon_jtag_slave
    (
      .clk                                                               (clk_0),
      .cpu_0_data_master_address_to_slave                                (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave           (cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave (cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_read                                            (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave   (cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave          (cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_waitrequest                                     (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                                           (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                                       (cpu_0_data_master_writedata),
      .d1_jtag_uart_0_avalon_jtag_slave_end_xfer                         (d1_jtag_uart_0_avalon_jtag_slave_end_xfer),
      .jtag_uart_0_avalon_jtag_slave_address                             (jtag_uart_0_avalon_jtag_slave_address),
      .jtag_uart_0_avalon_jtag_slave_chipselect                          (jtag_uart_0_avalon_jtag_slave_chipselect),
      .jtag_uart_0_avalon_jtag_slave_dataavailable                       (jtag_uart_0_avalon_jtag_slave_dataavailable),
      .jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa               (jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa),
      .jtag_uart_0_avalon_jtag_slave_irq                                 (jtag_uart_0_avalon_jtag_slave_irq),
      .jtag_uart_0_avalon_jtag_slave_irq_from_sa                         (jtag_uart_0_avalon_jtag_slave_irq_from_sa),
      .jtag_uart_0_avalon_jtag_slave_read_n                              (jtag_uart_0_avalon_jtag_slave_read_n),
      .jtag_uart_0_avalon_jtag_slave_readdata                            (jtag_uart_0_avalon_jtag_slave_readdata),
      .jtag_uart_0_avalon_jtag_slave_readdata_from_sa                    (jtag_uart_0_avalon_jtag_slave_readdata_from_sa),
      .jtag_uart_0_avalon_jtag_slave_readyfordata                        (jtag_uart_0_avalon_jtag_slave_readyfordata),
      .jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa                (jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa),
      .jtag_uart_0_avalon_jtag_slave_reset_n                             (jtag_uart_0_avalon_jtag_slave_reset_n),
      .jtag_uart_0_avalon_jtag_slave_waitrequest                         (jtag_uart_0_avalon_jtag_slave_waitrequest),
      .jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa                 (jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa),
      .jtag_uart_0_avalon_jtag_slave_write_n                             (jtag_uart_0_avalon_jtag_slave_write_n),
      .jtag_uart_0_avalon_jtag_slave_writedata                           (jtag_uart_0_avalon_jtag_slave_writedata),
      .reset_n                                                           (clk_0_reset_n)
    );

  jtag_uart_0 the_jtag_uart_0
    (
      .av_address     (jtag_uart_0_avalon_jtag_slave_address),
      .av_chipselect  (jtag_uart_0_avalon_jtag_slave_chipselect),
      .av_irq         (jtag_uart_0_avalon_jtag_slave_irq),
      .av_read_n      (jtag_uart_0_avalon_jtag_slave_read_n),
      .av_readdata    (jtag_uart_0_avalon_jtag_slave_readdata),
      .av_waitrequest (jtag_uart_0_avalon_jtag_slave_waitrequest),
      .av_write_n     (jtag_uart_0_avalon_jtag_slave_write_n),
      .av_writedata   (jtag_uart_0_avalon_jtag_slave_writedata),
      .clk            (clk_0),
      .dataavailable  (jtag_uart_0_avalon_jtag_slave_dataavailable),
      .readyfordata   (jtag_uart_0_avalon_jtag_slave_readyfordata),
      .rst_n          (jtag_uart_0_avalon_jtag_slave_reset_n)
    );

  lcd_display_control_slave_arbitrator the_lcd_display_control_slave
    (
      .clk                                                           (clk_0),
      .cpu_0_data_master_address_to_slave                            (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_byteenable                                  (cpu_0_data_master_byteenable),
      .cpu_0_data_master_granted_lcd_display_control_slave           (cpu_0_data_master_granted_lcd_display_control_slave),
      .cpu_0_data_master_qualified_request_lcd_display_control_slave (cpu_0_data_master_qualified_request_lcd_display_control_slave),
      .cpu_0_data_master_read                                        (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_lcd_display_control_slave   (cpu_0_data_master_read_data_valid_lcd_display_control_slave),
      .cpu_0_data_master_requests_lcd_display_control_slave          (cpu_0_data_master_requests_lcd_display_control_slave),
      .cpu_0_data_master_write                                       (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                                   (cpu_0_data_master_writedata),
      .d1_lcd_display_control_slave_end_xfer                         (d1_lcd_display_control_slave_end_xfer),
      .lcd_display_control_slave_address                             (lcd_display_control_slave_address),
      .lcd_display_control_slave_begintransfer                       (lcd_display_control_slave_begintransfer),
      .lcd_display_control_slave_read                                (lcd_display_control_slave_read),
      .lcd_display_control_slave_readdata                            (lcd_display_control_slave_readdata),
      .lcd_display_control_slave_readdata_from_sa                    (lcd_display_control_slave_readdata_from_sa),
      .lcd_display_control_slave_wait_counter_eq_0                   (lcd_display_control_slave_wait_counter_eq_0),
      .lcd_display_control_slave_wait_counter_eq_1                   (lcd_display_control_slave_wait_counter_eq_1),
      .lcd_display_control_slave_write                               (lcd_display_control_slave_write),
      .lcd_display_control_slave_writedata                           (lcd_display_control_slave_writedata),
      .reset_n                                                       (clk_0_reset_n)
    );

  lcd_display the_lcd_display
    (
      .LCD_E         (LCD_E_from_the_lcd_display),
      .LCD_RS        (LCD_RS_from_the_lcd_display),
      .LCD_RW        (LCD_RW_from_the_lcd_display),
      .LCD_data      (LCD_data_to_and_from_the_lcd_display),
      .address       (lcd_display_control_slave_address),
      .begintransfer (lcd_display_control_slave_begintransfer),
      .read          (lcd_display_control_slave_read),
      .readdata      (lcd_display_control_slave_readdata),
      .write         (lcd_display_control_slave_write),
      .writedata     (lcd_display_control_slave_writedata)
    );

  led_pio_s1_arbitrator the_led_pio_s1
    (
      .clk                                            (clk_0),
      .cpu_0_data_master_address_to_slave             (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_byteenable                   (cpu_0_data_master_byteenable),
      .cpu_0_data_master_granted_led_pio_s1           (cpu_0_data_master_granted_led_pio_s1),
      .cpu_0_data_master_qualified_request_led_pio_s1 (cpu_0_data_master_qualified_request_led_pio_s1),
      .cpu_0_data_master_read                         (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_led_pio_s1   (cpu_0_data_master_read_data_valid_led_pio_s1),
      .cpu_0_data_master_requests_led_pio_s1          (cpu_0_data_master_requests_led_pio_s1),
      .cpu_0_data_master_waitrequest                  (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                        (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                    (cpu_0_data_master_writedata),
      .d1_led_pio_s1_end_xfer                         (d1_led_pio_s1_end_xfer),
      .led_pio_s1_address                             (led_pio_s1_address),
      .led_pio_s1_chipselect                          (led_pio_s1_chipselect),
      .led_pio_s1_readdata                            (led_pio_s1_readdata),
      .led_pio_s1_readdata_from_sa                    (led_pio_s1_readdata_from_sa),
      .led_pio_s1_reset_n                             (led_pio_s1_reset_n),
      .led_pio_s1_write_n                             (led_pio_s1_write_n),
      .led_pio_s1_writedata                           (led_pio_s1_writedata),
      .reset_n                                        (clk_0_reset_n)
    );

  led_pio the_led_pio
    (
      .address    (led_pio_s1_address),
      .chipselect (led_pio_s1_chipselect),
      .clk        (clk_0),
      .out_port   (out_port_from_the_led_pio),
      .readdata   (led_pio_s1_readdata),
      .reset_n    (led_pio_s1_reset_n),
      .write_n    (led_pio_s1_write_n),
      .writedata  (led_pio_s1_writedata)
    );

  pio_dutycycle_s1_arbitrator the_pio_dutycycle_s1
    (
      .clk                                                  (clk_0),
      .cpu_0_data_master_address_to_slave                   (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_pio_dutycycle_s1           (cpu_0_data_master_granted_pio_dutycycle_s1),
      .cpu_0_data_master_qualified_request_pio_dutycycle_s1 (cpu_0_data_master_qualified_request_pio_dutycycle_s1),
      .cpu_0_data_master_read                               (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_pio_dutycycle_s1   (cpu_0_data_master_read_data_valid_pio_dutycycle_s1),
      .cpu_0_data_master_requests_pio_dutycycle_s1          (cpu_0_data_master_requests_pio_dutycycle_s1),
      .cpu_0_data_master_waitrequest                        (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                              (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                          (cpu_0_data_master_writedata),
      .d1_pio_dutycycle_s1_end_xfer                         (d1_pio_dutycycle_s1_end_xfer),
      .pio_dutycycle_s1_address                             (pio_dutycycle_s1_address),
      .pio_dutycycle_s1_chipselect                          (pio_dutycycle_s1_chipselect),
      .pio_dutycycle_s1_readdata                            (pio_dutycycle_s1_readdata),
      .pio_dutycycle_s1_readdata_from_sa                    (pio_dutycycle_s1_readdata_from_sa),
      .pio_dutycycle_s1_reset_n                             (pio_dutycycle_s1_reset_n),
      .pio_dutycycle_s1_write_n                             (pio_dutycycle_s1_write_n),
      .pio_dutycycle_s1_writedata                           (pio_dutycycle_s1_writedata),
      .reset_n                                              (clk_0_reset_n)
    );

  pio_dutycycle the_pio_dutycycle
    (
      .address    (pio_dutycycle_s1_address),
      .chipselect (pio_dutycycle_s1_chipselect),
      .clk        (clk_0),
      .out_port   (out_port_from_the_pio_dutycycle),
      .readdata   (pio_dutycycle_s1_readdata),
      .reset_n    (pio_dutycycle_s1_reset_n),
      .write_n    (pio_dutycycle_s1_write_n),
      .writedata  (pio_dutycycle_s1_writedata)
    );

  pio_egmenable_s1_arbitrator the_pio_egmenable_s1
    (
      .clk                                                  (clk_0),
      .cpu_0_data_master_address_to_slave                   (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_pio_egmenable_s1           (cpu_0_data_master_granted_pio_egmenable_s1),
      .cpu_0_data_master_qualified_request_pio_egmenable_s1 (cpu_0_data_master_qualified_request_pio_egmenable_s1),
      .cpu_0_data_master_read                               (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_pio_egmenable_s1   (cpu_0_data_master_read_data_valid_pio_egmenable_s1),
      .cpu_0_data_master_requests_pio_egmenable_s1          (cpu_0_data_master_requests_pio_egmenable_s1),
      .cpu_0_data_master_waitrequest                        (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                              (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                          (cpu_0_data_master_writedata),
      .d1_pio_egmenable_s1_end_xfer                         (d1_pio_egmenable_s1_end_xfer),
      .pio_egmenable_s1_address                             (pio_egmenable_s1_address),
      .pio_egmenable_s1_chipselect                          (pio_egmenable_s1_chipselect),
      .pio_egmenable_s1_readdata                            (pio_egmenable_s1_readdata),
      .pio_egmenable_s1_readdata_from_sa                    (pio_egmenable_s1_readdata_from_sa),
      .pio_egmenable_s1_reset_n                             (pio_egmenable_s1_reset_n),
      .pio_egmenable_s1_write_n                             (pio_egmenable_s1_write_n),
      .pio_egmenable_s1_writedata                           (pio_egmenable_s1_writedata),
      .reset_n                                              (clk_0_reset_n)
    );

  pio_egmenable the_pio_egmenable
    (
      .address    (pio_egmenable_s1_address),
      .chipselect (pio_egmenable_s1_chipselect),
      .clk        (clk_0),
      .out_port   (out_port_from_the_pio_egmenable),
      .readdata   (pio_egmenable_s1_readdata),
      .reset_n    (pio_egmenable_s1_reset_n),
      .write_n    (pio_egmenable_s1_write_n),
      .writedata  (pio_egmenable_s1_writedata)
    );

  pio_egmreset_s1_arbitrator the_pio_egmreset_s1
    (
      .clk                                                 (clk_0),
      .cpu_0_data_master_address_to_slave                  (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_pio_egmreset_s1           (cpu_0_data_master_granted_pio_egmreset_s1),
      .cpu_0_data_master_qualified_request_pio_egmreset_s1 (cpu_0_data_master_qualified_request_pio_egmreset_s1),
      .cpu_0_data_master_read                              (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_pio_egmreset_s1   (cpu_0_data_master_read_data_valid_pio_egmreset_s1),
      .cpu_0_data_master_requests_pio_egmreset_s1          (cpu_0_data_master_requests_pio_egmreset_s1),
      .cpu_0_data_master_waitrequest                       (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                             (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                         (cpu_0_data_master_writedata),
      .d1_pio_egmreset_s1_end_xfer                         (d1_pio_egmreset_s1_end_xfer),
      .pio_egmreset_s1_address                             (pio_egmreset_s1_address),
      .pio_egmreset_s1_chipselect                          (pio_egmreset_s1_chipselect),
      .pio_egmreset_s1_readdata                            (pio_egmreset_s1_readdata),
      .pio_egmreset_s1_readdata_from_sa                    (pio_egmreset_s1_readdata_from_sa),
      .pio_egmreset_s1_reset_n                             (pio_egmreset_s1_reset_n),
      .pio_egmreset_s1_write_n                             (pio_egmreset_s1_write_n),
      .pio_egmreset_s1_writedata                           (pio_egmreset_s1_writedata),
      .reset_n                                             (clk_0_reset_n)
    );

  pio_egmreset the_pio_egmreset
    (
      .address    (pio_egmreset_s1_address),
      .chipselect (pio_egmreset_s1_chipselect),
      .clk        (clk_0),
      .out_port   (out_port_from_the_pio_egmreset),
      .readdata   (pio_egmreset_s1_readdata),
      .reset_n    (pio_egmreset_s1_reset_n),
      .write_n    (pio_egmreset_s1_write_n),
      .writedata  (pio_egmreset_s1_writedata)
    );

  pio_latency_s1_arbitrator the_pio_latency_s1
    (
      .clk                                                (clk_0),
      .cpu_0_data_master_address_to_slave                 (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_pio_latency_s1           (cpu_0_data_master_granted_pio_latency_s1),
      .cpu_0_data_master_qualified_request_pio_latency_s1 (cpu_0_data_master_qualified_request_pio_latency_s1),
      .cpu_0_data_master_read                             (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_pio_latency_s1   (cpu_0_data_master_read_data_valid_pio_latency_s1),
      .cpu_0_data_master_requests_pio_latency_s1          (cpu_0_data_master_requests_pio_latency_s1),
      .cpu_0_data_master_write                            (cpu_0_data_master_write),
      .d1_pio_latency_s1_end_xfer                         (d1_pio_latency_s1_end_xfer),
      .pio_latency_s1_address                             (pio_latency_s1_address),
      .pio_latency_s1_readdata                            (pio_latency_s1_readdata),
      .pio_latency_s1_readdata_from_sa                    (pio_latency_s1_readdata_from_sa),
      .pio_latency_s1_reset_n                             (pio_latency_s1_reset_n),
      .reset_n                                            (clk_0_reset_n)
    );

  pio_latency the_pio_latency
    (
      .address  (pio_latency_s1_address),
      .clk      (clk_0),
      .in_port  (in_port_to_the_pio_latency),
      .readdata (pio_latency_s1_readdata),
      .reset_n  (pio_latency_s1_reset_n)
    );

  pio_missed_s1_arbitrator the_pio_missed_s1
    (
      .clk                                               (clk_0),
      .cpu_0_data_master_address_to_slave                (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_pio_missed_s1           (cpu_0_data_master_granted_pio_missed_s1),
      .cpu_0_data_master_qualified_request_pio_missed_s1 (cpu_0_data_master_qualified_request_pio_missed_s1),
      .cpu_0_data_master_read                            (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_pio_missed_s1   (cpu_0_data_master_read_data_valid_pio_missed_s1),
      .cpu_0_data_master_requests_pio_missed_s1          (cpu_0_data_master_requests_pio_missed_s1),
      .cpu_0_data_master_write                           (cpu_0_data_master_write),
      .d1_pio_missed_s1_end_xfer                         (d1_pio_missed_s1_end_xfer),
      .pio_missed_s1_address                             (pio_missed_s1_address),
      .pio_missed_s1_readdata                            (pio_missed_s1_readdata),
      .pio_missed_s1_readdata_from_sa                    (pio_missed_s1_readdata_from_sa),
      .pio_missed_s1_reset_n                             (pio_missed_s1_reset_n),
      .reset_n                                           (clk_0_reset_n)
    );

  pio_missed the_pio_missed
    (
      .address  (pio_missed_s1_address),
      .clk      (clk_0),
      .in_port  (in_port_to_the_pio_missed),
      .readdata (pio_missed_s1_readdata),
      .reset_n  (pio_missed_s1_reset_n)
    );

  pio_period_s1_arbitrator the_pio_period_s1
    (
      .clk                                               (clk_0),
      .cpu_0_data_master_address_to_slave                (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_pio_period_s1           (cpu_0_data_master_granted_pio_period_s1),
      .cpu_0_data_master_qualified_request_pio_period_s1 (cpu_0_data_master_qualified_request_pio_period_s1),
      .cpu_0_data_master_read                            (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_pio_period_s1   (cpu_0_data_master_read_data_valid_pio_period_s1),
      .cpu_0_data_master_requests_pio_period_s1          (cpu_0_data_master_requests_pio_period_s1),
      .cpu_0_data_master_waitrequest                     (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                           (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                       (cpu_0_data_master_writedata),
      .d1_pio_period_s1_end_xfer                         (d1_pio_period_s1_end_xfer),
      .pio_period_s1_address                             (pio_period_s1_address),
      .pio_period_s1_chipselect                          (pio_period_s1_chipselect),
      .pio_period_s1_readdata                            (pio_period_s1_readdata),
      .pio_period_s1_readdata_from_sa                    (pio_period_s1_readdata_from_sa),
      .pio_period_s1_reset_n                             (pio_period_s1_reset_n),
      .pio_period_s1_write_n                             (pio_period_s1_write_n),
      .pio_period_s1_writedata                           (pio_period_s1_writedata),
      .reset_n                                           (clk_0_reset_n)
    );

  pio_period the_pio_period
    (
      .address    (pio_period_s1_address),
      .chipselect (pio_period_s1_chipselect),
      .clk        (clk_0),
      .out_port   (out_port_from_the_pio_period),
      .readdata   (pio_period_s1_readdata),
      .reset_n    (pio_period_s1_reset_n),
      .write_n    (pio_period_s1_write_n),
      .writedata  (pio_period_s1_writedata)
    );

  pio_pulse_s1_arbitrator the_pio_pulse_s1
    (
      .clk                                              (clk_0),
      .cpu_0_data_master_address_to_slave               (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_pio_pulse_s1           (cpu_0_data_master_granted_pio_pulse_s1),
      .cpu_0_data_master_qualified_request_pio_pulse_s1 (cpu_0_data_master_qualified_request_pio_pulse_s1),
      .cpu_0_data_master_read                           (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_pio_pulse_s1   (cpu_0_data_master_read_data_valid_pio_pulse_s1),
      .cpu_0_data_master_requests_pio_pulse_s1          (cpu_0_data_master_requests_pio_pulse_s1),
      .cpu_0_data_master_waitrequest                    (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                          (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                      (cpu_0_data_master_writedata),
      .d1_pio_pulse_s1_end_xfer                         (d1_pio_pulse_s1_end_xfer),
      .pio_pulse_s1_address                             (pio_pulse_s1_address),
      .pio_pulse_s1_chipselect                          (pio_pulse_s1_chipselect),
      .pio_pulse_s1_irq                                 (pio_pulse_s1_irq),
      .pio_pulse_s1_irq_from_sa                         (pio_pulse_s1_irq_from_sa),
      .pio_pulse_s1_readdata                            (pio_pulse_s1_readdata),
      .pio_pulse_s1_readdata_from_sa                    (pio_pulse_s1_readdata_from_sa),
      .pio_pulse_s1_reset_n                             (pio_pulse_s1_reset_n),
      .pio_pulse_s1_write_n                             (pio_pulse_s1_write_n),
      .pio_pulse_s1_writedata                           (pio_pulse_s1_writedata),
      .reset_n                                          (clk_0_reset_n)
    );

  pio_pulse the_pio_pulse
    (
      .address    (pio_pulse_s1_address),
      .chipselect (pio_pulse_s1_chipselect),
      .clk        (clk_0),
      .in_port    (in_port_to_the_pio_pulse),
      .irq        (pio_pulse_s1_irq),
      .readdata   (pio_pulse_s1_readdata),
      .reset_n    (pio_pulse_s1_reset_n),
      .write_n    (pio_pulse_s1_write_n),
      .writedata  (pio_pulse_s1_writedata)
    );

  pio_response_s1_arbitrator the_pio_response_s1
    (
      .clk                                                 (clk_0),
      .cpu_0_data_master_address_to_slave                  (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_pio_response_s1           (cpu_0_data_master_granted_pio_response_s1),
      .cpu_0_data_master_qualified_request_pio_response_s1 (cpu_0_data_master_qualified_request_pio_response_s1),
      .cpu_0_data_master_read                              (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_pio_response_s1   (cpu_0_data_master_read_data_valid_pio_response_s1),
      .cpu_0_data_master_requests_pio_response_s1          (cpu_0_data_master_requests_pio_response_s1),
      .cpu_0_data_master_waitrequest                       (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                             (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                         (cpu_0_data_master_writedata),
      .d1_pio_response_s1_end_xfer                         (d1_pio_response_s1_end_xfer),
      .pio_response_s1_address                             (pio_response_s1_address),
      .pio_response_s1_chipselect                          (pio_response_s1_chipselect),
      .pio_response_s1_readdata                            (pio_response_s1_readdata),
      .pio_response_s1_readdata_from_sa                    (pio_response_s1_readdata_from_sa),
      .pio_response_s1_reset_n                             (pio_response_s1_reset_n),
      .pio_response_s1_write_n                             (pio_response_s1_write_n),
      .pio_response_s1_writedata                           (pio_response_s1_writedata),
      .reset_n                                             (clk_0_reset_n)
    );

  pio_response the_pio_response
    (
      .address    (pio_response_s1_address),
      .chipselect (pio_response_s1_chipselect),
      .clk        (clk_0),
      .out_port   (out_port_from_the_pio_response),
      .readdata   (pio_response_s1_readdata),
      .reset_n    (pio_response_s1_reset_n),
      .write_n    (pio_response_s1_write_n),
      .writedata  (pio_response_s1_writedata)
    );

  red_led_pio_s1_arbitrator the_red_led_pio_s1
    (
      .clk                                                (clk_0),
      .cpu_0_data_master_address_to_slave                 (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_byteenable                       (cpu_0_data_master_byteenable),
      .cpu_0_data_master_granted_red_led_pio_s1           (cpu_0_data_master_granted_red_led_pio_s1),
      .cpu_0_data_master_qualified_request_red_led_pio_s1 (cpu_0_data_master_qualified_request_red_led_pio_s1),
      .cpu_0_data_master_read                             (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_red_led_pio_s1   (cpu_0_data_master_read_data_valid_red_led_pio_s1),
      .cpu_0_data_master_requests_red_led_pio_s1          (cpu_0_data_master_requests_red_led_pio_s1),
      .cpu_0_data_master_waitrequest                      (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                            (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                        (cpu_0_data_master_writedata),
      .d1_red_led_pio_s1_end_xfer                         (d1_red_led_pio_s1_end_xfer),
      .red_led_pio_s1_address                             (red_led_pio_s1_address),
      .red_led_pio_s1_chipselect                          (red_led_pio_s1_chipselect),
      .red_led_pio_s1_readdata                            (red_led_pio_s1_readdata),
      .red_led_pio_s1_readdata_from_sa                    (red_led_pio_s1_readdata_from_sa),
      .red_led_pio_s1_reset_n                             (red_led_pio_s1_reset_n),
      .red_led_pio_s1_write_n                             (red_led_pio_s1_write_n),
      .red_led_pio_s1_writedata                           (red_led_pio_s1_writedata),
      .reset_n                                            (clk_0_reset_n)
    );

  red_led_pio the_red_led_pio
    (
      .address    (red_led_pio_s1_address),
      .chipselect (red_led_pio_s1_chipselect),
      .clk        (clk_0),
      .out_port   (out_port_from_the_red_led_pio),
      .readdata   (red_led_pio_s1_readdata),
      .reset_n    (red_led_pio_s1_reset_n),
      .write_n    (red_led_pio_s1_write_n),
      .writedata  (red_led_pio_s1_writedata)
    );

  sdram_0_s1_arbitrator the_sdram_0_s1
    (
      .clk                                                                (clk_0),
      .cpu_0_data_master_address_to_slave                                 (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_byteenable                                       (cpu_0_data_master_byteenable),
      .cpu_0_data_master_byteenable_sdram_0_s1                            (cpu_0_data_master_byteenable_sdram_0_s1),
      .cpu_0_data_master_dbs_address                                      (cpu_0_data_master_dbs_address),
      .cpu_0_data_master_dbs_write_16                                     (cpu_0_data_master_dbs_write_16),
      .cpu_0_data_master_granted_sdram_0_s1                               (cpu_0_data_master_granted_sdram_0_s1),
      .cpu_0_data_master_no_byte_enables_and_last_term                    (cpu_0_data_master_no_byte_enables_and_last_term),
      .cpu_0_data_master_qualified_request_sdram_0_s1                     (cpu_0_data_master_qualified_request_sdram_0_s1),
      .cpu_0_data_master_read                                             (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_sdram_0_s1                       (cpu_0_data_master_read_data_valid_sdram_0_s1),
      .cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register        (cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register),
      .cpu_0_data_master_requests_sdram_0_s1                              (cpu_0_data_master_requests_sdram_0_s1),
      .cpu_0_data_master_waitrequest                                      (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                                            (cpu_0_data_master_write),
      .cpu_0_instruction_master_address_to_slave                          (cpu_0_instruction_master_address_to_slave),
      .cpu_0_instruction_master_dbs_address                               (cpu_0_instruction_master_dbs_address),
      .cpu_0_instruction_master_granted_sdram_0_s1                        (cpu_0_instruction_master_granted_sdram_0_s1),
      .cpu_0_instruction_master_latency_counter                           (cpu_0_instruction_master_latency_counter),
      .cpu_0_instruction_master_qualified_request_sdram_0_s1              (cpu_0_instruction_master_qualified_request_sdram_0_s1),
      .cpu_0_instruction_master_read                                      (cpu_0_instruction_master_read),
      .cpu_0_instruction_master_read_data_valid_sdram_0_s1                (cpu_0_instruction_master_read_data_valid_sdram_0_s1),
      .cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register (cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register),
      .cpu_0_instruction_master_requests_sdram_0_s1                       (cpu_0_instruction_master_requests_sdram_0_s1),
      .d1_sdram_0_s1_end_xfer                                             (d1_sdram_0_s1_end_xfer),
      .reset_n                                                            (clk_0_reset_n),
      .sdram_0_s1_address                                                 (sdram_0_s1_address),
      .sdram_0_s1_byteenable_n                                            (sdram_0_s1_byteenable_n),
      .sdram_0_s1_chipselect                                              (sdram_0_s1_chipselect),
      .sdram_0_s1_read_n                                                  (sdram_0_s1_read_n),
      .sdram_0_s1_readdata                                                (sdram_0_s1_readdata),
      .sdram_0_s1_readdata_from_sa                                        (sdram_0_s1_readdata_from_sa),
      .sdram_0_s1_readdatavalid                                           (sdram_0_s1_readdatavalid),
      .sdram_0_s1_reset_n                                                 (sdram_0_s1_reset_n),
      .sdram_0_s1_waitrequest                                             (sdram_0_s1_waitrequest),
      .sdram_0_s1_waitrequest_from_sa                                     (sdram_0_s1_waitrequest_from_sa),
      .sdram_0_s1_write_n                                                 (sdram_0_s1_write_n),
      .sdram_0_s1_writedata                                               (sdram_0_s1_writedata)
    );

  sdram_0 the_sdram_0
    (
      .az_addr        (sdram_0_s1_address),
      .az_be_n        (sdram_0_s1_byteenable_n),
      .az_cs          (sdram_0_s1_chipselect),
      .az_data        (sdram_0_s1_writedata),
      .az_rd_n        (sdram_0_s1_read_n),
      .az_wr_n        (sdram_0_s1_write_n),
      .clk            (clk_0),
      .reset_n        (sdram_0_s1_reset_n),
      .za_data        (sdram_0_s1_readdata),
      .za_valid       (sdram_0_s1_readdatavalid),
      .za_waitrequest (sdram_0_s1_waitrequest),
      .zs_addr        (zs_addr_from_the_sdram_0),
      .zs_ba          (zs_ba_from_the_sdram_0),
      .zs_cas_n       (zs_cas_n_from_the_sdram_0),
      .zs_cke         (zs_cke_from_the_sdram_0),
      .zs_cs_n        (zs_cs_n_from_the_sdram_0),
      .zs_dq          (zs_dq_to_and_from_the_sdram_0),
      .zs_dqm         (zs_dqm_from_the_sdram_0),
      .zs_ras_n       (zs_ras_n_from_the_sdram_0),
      .zs_we_n        (zs_we_n_from_the_sdram_0)
    );

  seven_seg_middle_pio_s1_arbitrator the_seven_seg_middle_pio_s1
    (
      .clk                                                         (clk_0),
      .cpu_0_data_master_address_to_slave                          (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_seven_seg_middle_pio_s1           (cpu_0_data_master_granted_seven_seg_middle_pio_s1),
      .cpu_0_data_master_qualified_request_seven_seg_middle_pio_s1 (cpu_0_data_master_qualified_request_seven_seg_middle_pio_s1),
      .cpu_0_data_master_read                                      (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_seven_seg_middle_pio_s1   (cpu_0_data_master_read_data_valid_seven_seg_middle_pio_s1),
      .cpu_0_data_master_requests_seven_seg_middle_pio_s1          (cpu_0_data_master_requests_seven_seg_middle_pio_s1),
      .cpu_0_data_master_waitrequest                               (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                                     (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                                 (cpu_0_data_master_writedata),
      .d1_seven_seg_middle_pio_s1_end_xfer                         (d1_seven_seg_middle_pio_s1_end_xfer),
      .reset_n                                                     (clk_0_reset_n),
      .seven_seg_middle_pio_s1_address                             (seven_seg_middle_pio_s1_address),
      .seven_seg_middle_pio_s1_chipselect                          (seven_seg_middle_pio_s1_chipselect),
      .seven_seg_middle_pio_s1_readdata                            (seven_seg_middle_pio_s1_readdata),
      .seven_seg_middle_pio_s1_readdata_from_sa                    (seven_seg_middle_pio_s1_readdata_from_sa),
      .seven_seg_middle_pio_s1_reset_n                             (seven_seg_middle_pio_s1_reset_n),
      .seven_seg_middle_pio_s1_write_n                             (seven_seg_middle_pio_s1_write_n),
      .seven_seg_middle_pio_s1_writedata                           (seven_seg_middle_pio_s1_writedata)
    );

  seven_seg_middle_pio the_seven_seg_middle_pio
    (
      .address    (seven_seg_middle_pio_s1_address),
      .chipselect (seven_seg_middle_pio_s1_chipselect),
      .clk        (clk_0),
      .out_port   (out_port_from_the_seven_seg_middle_pio),
      .readdata   (seven_seg_middle_pio_s1_readdata),
      .reset_n    (seven_seg_middle_pio_s1_reset_n),
      .write_n    (seven_seg_middle_pio_s1_write_n),
      .writedata  (seven_seg_middle_pio_s1_writedata)
    );

  seven_seg_pio_s1_arbitrator the_seven_seg_pio_s1
    (
      .clk                                                  (clk_0),
      .cpu_0_data_master_address_to_slave                   (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_seven_seg_pio_s1           (cpu_0_data_master_granted_seven_seg_pio_s1),
      .cpu_0_data_master_qualified_request_seven_seg_pio_s1 (cpu_0_data_master_qualified_request_seven_seg_pio_s1),
      .cpu_0_data_master_read                               (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_seven_seg_pio_s1   (cpu_0_data_master_read_data_valid_seven_seg_pio_s1),
      .cpu_0_data_master_requests_seven_seg_pio_s1          (cpu_0_data_master_requests_seven_seg_pio_s1),
      .cpu_0_data_master_waitrequest                        (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                              (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                          (cpu_0_data_master_writedata),
      .d1_seven_seg_pio_s1_end_xfer                         (d1_seven_seg_pio_s1_end_xfer),
      .reset_n                                              (clk_0_reset_n),
      .seven_seg_pio_s1_address                             (seven_seg_pio_s1_address),
      .seven_seg_pio_s1_chipselect                          (seven_seg_pio_s1_chipselect),
      .seven_seg_pio_s1_readdata                            (seven_seg_pio_s1_readdata),
      .seven_seg_pio_s1_readdata_from_sa                    (seven_seg_pio_s1_readdata_from_sa),
      .seven_seg_pio_s1_reset_n                             (seven_seg_pio_s1_reset_n),
      .seven_seg_pio_s1_write_n                             (seven_seg_pio_s1_write_n),
      .seven_seg_pio_s1_writedata                           (seven_seg_pio_s1_writedata)
    );

  seven_seg_pio the_seven_seg_pio
    (
      .address    (seven_seg_pio_s1_address),
      .chipselect (seven_seg_pio_s1_chipselect),
      .clk        (clk_0),
      .out_port   (out_port_from_the_seven_seg_pio),
      .readdata   (seven_seg_pio_s1_readdata),
      .reset_n    (seven_seg_pio_s1_reset_n),
      .write_n    (seven_seg_pio_s1_write_n),
      .writedata  (seven_seg_pio_s1_writedata)
    );

  seven_seg_right_pio_s1_arbitrator the_seven_seg_right_pio_s1
    (
      .clk                                                        (clk_0),
      .cpu_0_data_master_address_to_slave                         (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_seven_seg_right_pio_s1           (cpu_0_data_master_granted_seven_seg_right_pio_s1),
      .cpu_0_data_master_qualified_request_seven_seg_right_pio_s1 (cpu_0_data_master_qualified_request_seven_seg_right_pio_s1),
      .cpu_0_data_master_read                                     (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_seven_seg_right_pio_s1   (cpu_0_data_master_read_data_valid_seven_seg_right_pio_s1),
      .cpu_0_data_master_requests_seven_seg_right_pio_s1          (cpu_0_data_master_requests_seven_seg_right_pio_s1),
      .cpu_0_data_master_waitrequest                              (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                                    (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                                (cpu_0_data_master_writedata),
      .d1_seven_seg_right_pio_s1_end_xfer                         (d1_seven_seg_right_pio_s1_end_xfer),
      .reset_n                                                    (clk_0_reset_n),
      .seven_seg_right_pio_s1_address                             (seven_seg_right_pio_s1_address),
      .seven_seg_right_pio_s1_chipselect                          (seven_seg_right_pio_s1_chipselect),
      .seven_seg_right_pio_s1_readdata                            (seven_seg_right_pio_s1_readdata),
      .seven_seg_right_pio_s1_readdata_from_sa                    (seven_seg_right_pio_s1_readdata_from_sa),
      .seven_seg_right_pio_s1_reset_n                             (seven_seg_right_pio_s1_reset_n),
      .seven_seg_right_pio_s1_write_n                             (seven_seg_right_pio_s1_write_n),
      .seven_seg_right_pio_s1_writedata                           (seven_seg_right_pio_s1_writedata)
    );

  seven_seg_right_pio the_seven_seg_right_pio
    (
      .address    (seven_seg_right_pio_s1_address),
      .chipselect (seven_seg_right_pio_s1_chipselect),
      .clk        (clk_0),
      .out_port   (out_port_from_the_seven_seg_right_pio),
      .readdata   (seven_seg_right_pio_s1_readdata),
      .reset_n    (seven_seg_right_pio_s1_reset_n),
      .write_n    (seven_seg_right_pio_s1_write_n),
      .writedata  (seven_seg_right_pio_s1_writedata)
    );

  switch_pio_s1_arbitrator the_switch_pio_s1
    (
      .clk                                               (clk_0),
      .cpu_0_data_master_address_to_slave                (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_switch_pio_s1           (cpu_0_data_master_granted_switch_pio_s1),
      .cpu_0_data_master_qualified_request_switch_pio_s1 (cpu_0_data_master_qualified_request_switch_pio_s1),
      .cpu_0_data_master_read                            (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_switch_pio_s1   (cpu_0_data_master_read_data_valid_switch_pio_s1),
      .cpu_0_data_master_requests_switch_pio_s1          (cpu_0_data_master_requests_switch_pio_s1),
      .cpu_0_data_master_write                           (cpu_0_data_master_write),
      .d1_switch_pio_s1_end_xfer                         (d1_switch_pio_s1_end_xfer),
      .reset_n                                           (clk_0_reset_n),
      .switch_pio_s1_address                             (switch_pio_s1_address),
      .switch_pio_s1_readdata                            (switch_pio_s1_readdata),
      .switch_pio_s1_readdata_from_sa                    (switch_pio_s1_readdata_from_sa),
      .switch_pio_s1_reset_n                             (switch_pio_s1_reset_n)
    );

  switch_pio the_switch_pio
    (
      .address  (switch_pio_s1_address),
      .clk      (clk_0),
      .in_port  (in_port_to_the_switch_pio),
      .readdata (switch_pio_s1_readdata),
      .reset_n  (switch_pio_s1_reset_n)
    );

  sysid_control_slave_arbitrator the_sysid_control_slave
    (
      .clk                                                     (clk_0),
      .cpu_0_data_master_address_to_slave                      (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_sysid_control_slave           (cpu_0_data_master_granted_sysid_control_slave),
      .cpu_0_data_master_qualified_request_sysid_control_slave (cpu_0_data_master_qualified_request_sysid_control_slave),
      .cpu_0_data_master_read                                  (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_sysid_control_slave   (cpu_0_data_master_read_data_valid_sysid_control_slave),
      .cpu_0_data_master_requests_sysid_control_slave          (cpu_0_data_master_requests_sysid_control_slave),
      .cpu_0_data_master_write                                 (cpu_0_data_master_write),
      .d1_sysid_control_slave_end_xfer                         (d1_sysid_control_slave_end_xfer),
      .reset_n                                                 (clk_0_reset_n),
      .sysid_control_slave_address                             (sysid_control_slave_address),
      .sysid_control_slave_readdata                            (sysid_control_slave_readdata),
      .sysid_control_slave_readdata_from_sa                    (sysid_control_slave_readdata_from_sa),
      .sysid_control_slave_reset_n                             (sysid_control_slave_reset_n)
    );

  sysid the_sysid
    (
      .address  (sysid_control_slave_address),
      .clock    (sysid_control_slave_clock),
      .readdata (sysid_control_slave_readdata),
      .reset_n  (sysid_control_slave_reset_n)
    );

  timer_0_s1_arbitrator the_timer_0_s1
    (
      .clk                                            (clk_0),
      .cpu_0_data_master_address_to_slave             (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_timer_0_s1           (cpu_0_data_master_granted_timer_0_s1),
      .cpu_0_data_master_qualified_request_timer_0_s1 (cpu_0_data_master_qualified_request_timer_0_s1),
      .cpu_0_data_master_read                         (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_timer_0_s1   (cpu_0_data_master_read_data_valid_timer_0_s1),
      .cpu_0_data_master_requests_timer_0_s1          (cpu_0_data_master_requests_timer_0_s1),
      .cpu_0_data_master_waitrequest                  (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                        (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                    (cpu_0_data_master_writedata),
      .d1_timer_0_s1_end_xfer                         (d1_timer_0_s1_end_xfer),
      .reset_n                                        (clk_0_reset_n),
      .timer_0_s1_address                             (timer_0_s1_address),
      .timer_0_s1_chipselect                          (timer_0_s1_chipselect),
      .timer_0_s1_irq                                 (timer_0_s1_irq),
      .timer_0_s1_irq_from_sa                         (timer_0_s1_irq_from_sa),
      .timer_0_s1_readdata                            (timer_0_s1_readdata),
      .timer_0_s1_readdata_from_sa                    (timer_0_s1_readdata_from_sa),
      .timer_0_s1_reset_n                             (timer_0_s1_reset_n),
      .timer_0_s1_write_n                             (timer_0_s1_write_n),
      .timer_0_s1_writedata                           (timer_0_s1_writedata)
    );

  timer_0 the_timer_0
    (
      .address    (timer_0_s1_address),
      .chipselect (timer_0_s1_chipselect),
      .clk        (clk_0),
      .irq        (timer_0_s1_irq),
      .readdata   (timer_0_s1_readdata),
      .reset_n    (timer_0_s1_reset_n),
      .write_n    (timer_0_s1_write_n),
      .writedata  (timer_0_s1_writedata)
    );

  timer_1_s1_arbitrator the_timer_1_s1
    (
      .clk                                            (clk_0),
      .cpu_0_data_master_address_to_slave             (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_timer_1_s1           (cpu_0_data_master_granted_timer_1_s1),
      .cpu_0_data_master_qualified_request_timer_1_s1 (cpu_0_data_master_qualified_request_timer_1_s1),
      .cpu_0_data_master_read                         (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_timer_1_s1   (cpu_0_data_master_read_data_valid_timer_1_s1),
      .cpu_0_data_master_requests_timer_1_s1          (cpu_0_data_master_requests_timer_1_s1),
      .cpu_0_data_master_waitrequest                  (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                        (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                    (cpu_0_data_master_writedata),
      .d1_timer_1_s1_end_xfer                         (d1_timer_1_s1_end_xfer),
      .reset_n                                        (clk_0_reset_n),
      .timer_1_s1_address                             (timer_1_s1_address),
      .timer_1_s1_chipselect                          (timer_1_s1_chipselect),
      .timer_1_s1_irq                                 (timer_1_s1_irq),
      .timer_1_s1_irq_from_sa                         (timer_1_s1_irq_from_sa),
      .timer_1_s1_readdata                            (timer_1_s1_readdata),
      .timer_1_s1_readdata_from_sa                    (timer_1_s1_readdata_from_sa),
      .timer_1_s1_reset_n                             (timer_1_s1_reset_n),
      .timer_1_s1_write_n                             (timer_1_s1_write_n),
      .timer_1_s1_writedata                           (timer_1_s1_writedata)
    );

  timer_1 the_timer_1
    (
      .address    (timer_1_s1_address),
      .chipselect (timer_1_s1_chipselect),
      .clk        (clk_0),
      .irq        (timer_1_s1_irq),
      .readdata   (timer_1_s1_readdata),
      .reset_n    (timer_1_s1_reset_n),
      .write_n    (timer_1_s1_write_n),
      .writedata  (timer_1_s1_writedata)
    );

  //reset is asserted asynchronously and deasserted synchronously
  my_controller_reset_clk_0_domain_synch_module my_controller_reset_clk_0_domain_synch
    (
      .clk      (clk_0),
      .data_in  (1'b1),
      .data_out (clk_0_reset_n),
      .reset_n  (reset_n_sources)
    );

  //reset sources mux, which is an e_mux
  assign reset_n_sources = ~(~reset_n |
    0 |
    cpu_0_jtag_debug_module_resetrequest_from_sa |
    cpu_0_jtag_debug_module_resetrequest_from_sa);

  //sysid_control_slave_clock of type clock does not connect to anything so wire it to default (0)
  assign sysid_control_slave_clock = 0;


endmodule


//synthesis translate_off



// <ALTERA_NOTE> CODE INSERTED BETWEEN HERE

// AND HERE WILL BE PRESERVED </ALTERA_NOTE>


// If user logic components use Altsync_Ram with convert_hex2ver.dll,
// set USE_convert_hex2ver in the user comments section above

// `ifdef USE_convert_hex2ver
// `else
// `define NO_PLI 1
// `endif

`include "c:/software/altera/10.1/quartus/eda/sim_lib/altera_mf.v"
`include "c:/software/altera/10.1/quartus/eda/sim_lib/220model.v"
`include "c:/software/altera/10.1/quartus/eda/sim_lib/sgate.v"
`include "pio_latency.v"
`include "seven_seg_right_pio.v"
`include "pio_period.v"
`include "pio_pulse.v"
`include "timer_0.v"
`include "lcd_display.v"
`include "sysid.v"
`include "cpu_0_test_bench.v"
`include "cpu_0_oci_test_bench.v"
`include "cpu_0_jtag_debug_module_tck.v"
`include "cpu_0_jtag_debug_module_sysclk.v"
`include "cpu_0_jtag_debug_module_wrapper.v"
`include "cpu_0.v"
`include "pio_egmenable.v"
`include "switch_pio.v"
`include "timer_1.v"
`include "button_pio.v"
`include "green_led_pio.v"
`include "seven_seg_middle_pio.v"
`include "led_pio.v"
`include "jtag_uart_0.v"
`include "pio_missed.v"
`include "red_led_pio.v"
`include "sdram_0.v"
`include "seven_seg_pio.v"
`include "pio_response.v"
`include "pio_egmreset.v"
`include "pio_dutycycle.v"

`timescale 1ns / 1ps

module test_bench 
;


  wire             LCD_E_from_the_lcd_display;
  wire             LCD_RS_from_the_lcd_display;
  wire             LCD_RW_from_the_lcd_display;
  wire    [  7: 0] LCD_data_to_and_from_the_lcd_display;
  wire             clk;
  reg              clk_0;
  wire    [  3: 0] in_port_to_the_button_pio;
  wire    [ 15: 0] in_port_to_the_pio_latency;
  wire    [ 15: 0] in_port_to_the_pio_missed;
  wire             in_port_to_the_pio_pulse;
  wire    [ 15: 0] in_port_to_the_switch_pio;
  wire             jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa;
  wire    [  7: 0] out_port_from_the_green_led_pio;
  wire    [  7: 0] out_port_from_the_led_pio;
  wire    [  3: 0] out_port_from_the_pio_dutycycle;
  wire             out_port_from_the_pio_egmenable;
  wire             out_port_from_the_pio_egmreset;
  wire    [  3: 0] out_port_from_the_pio_period;
  wire             out_port_from_the_pio_response;
  wire    [  7: 0] out_port_from_the_red_led_pio;
  wire    [ 15: 0] out_port_from_the_seven_seg_middle_pio;
  wire    [ 15: 0] out_port_from_the_seven_seg_pio;
  wire    [ 31: 0] out_port_from_the_seven_seg_right_pio;
  reg              reset_n;
  wire             sysid_control_slave_clock;
  wire    [ 11: 0] zs_addr_from_the_sdram_0;
  wire    [  1: 0] zs_ba_from_the_sdram_0;
  wire             zs_cas_n_from_the_sdram_0;
  wire             zs_cke_from_the_sdram_0;
  wire             zs_cs_n_from_the_sdram_0;
  wire    [ 15: 0] zs_dq_to_and_from_the_sdram_0;
  wire    [  1: 0] zs_dqm_from_the_sdram_0;
  wire             zs_ras_n_from_the_sdram_0;
  wire             zs_we_n_from_the_sdram_0;


// <ALTERA_NOTE> CODE INSERTED BETWEEN HERE
//  add your signals and additional architecture here
// AND HERE WILL BE PRESERVED </ALTERA_NOTE>

  //Set us up the Dut
  my_controller DUT
    (
      .LCD_E_from_the_lcd_display             (LCD_E_from_the_lcd_display),
      .LCD_RS_from_the_lcd_display            (LCD_RS_from_the_lcd_display),
      .LCD_RW_from_the_lcd_display            (LCD_RW_from_the_lcd_display),
      .LCD_data_to_and_from_the_lcd_display   (LCD_data_to_and_from_the_lcd_display),
      .clk_0                                  (clk_0),
      .in_port_to_the_button_pio              (in_port_to_the_button_pio),
      .in_port_to_the_pio_latency             (in_port_to_the_pio_latency),
      .in_port_to_the_pio_missed              (in_port_to_the_pio_missed),
      .in_port_to_the_pio_pulse               (in_port_to_the_pio_pulse),
      .in_port_to_the_switch_pio              (in_port_to_the_switch_pio),
      .out_port_from_the_green_led_pio        (out_port_from_the_green_led_pio),
      .out_port_from_the_led_pio              (out_port_from_the_led_pio),
      .out_port_from_the_pio_dutycycle        (out_port_from_the_pio_dutycycle),
      .out_port_from_the_pio_egmenable        (out_port_from_the_pio_egmenable),
      .out_port_from_the_pio_egmreset         (out_port_from_the_pio_egmreset),
      .out_port_from_the_pio_period           (out_port_from_the_pio_period),
      .out_port_from_the_pio_response         (out_port_from_the_pio_response),
      .out_port_from_the_red_led_pio          (out_port_from_the_red_led_pio),
      .out_port_from_the_seven_seg_middle_pio (out_port_from_the_seven_seg_middle_pio),
      .out_port_from_the_seven_seg_pio        (out_port_from_the_seven_seg_pio),
      .out_port_from_the_seven_seg_right_pio  (out_port_from_the_seven_seg_right_pio),
      .reset_n                                (reset_n),
      .zs_addr_from_the_sdram_0               (zs_addr_from_the_sdram_0),
      .zs_ba_from_the_sdram_0                 (zs_ba_from_the_sdram_0),
      .zs_cas_n_from_the_sdram_0              (zs_cas_n_from_the_sdram_0),
      .zs_cke_from_the_sdram_0                (zs_cke_from_the_sdram_0),
      .zs_cs_n_from_the_sdram_0               (zs_cs_n_from_the_sdram_0),
      .zs_dq_to_and_from_the_sdram_0          (zs_dq_to_and_from_the_sdram_0),
      .zs_dqm_from_the_sdram_0                (zs_dqm_from_the_sdram_0),
      .zs_ras_n_from_the_sdram_0              (zs_ras_n_from_the_sdram_0),
      .zs_we_n_from_the_sdram_0               (zs_we_n_from_the_sdram_0)
    );

  initial
    clk_0 = 1'b0;
  always
    #10 clk_0 <= ~clk_0;
  
  initial 
    begin
      reset_n <= 0;
      #200 reset_n <= 1;
    end

endmodule


//synthesis translate_on