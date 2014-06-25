//Legal Notice: (C)2006 Altera Corporation. All rights reserved.  Your
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

module Audio (
                 // inputs:
                  iCLK_18_4,
                  iDATA,
                  iRST_N,
                  iWR,
                  iWR_CLK,

                 // outputs:
                  oAUD_BCK,
                  oAUD_DATA,
                  oAUD_LRCK,
                  oWR_FULL
               )
;

  output           oAUD_BCK;
  output           oAUD_DATA;
  output           oAUD_LRCK;
  output           oWR_FULL;
  input            iCLK_18_4;
  input   [ 15: 0] iDATA;
  input            iRST_N;
  input            iWR;
  input            iWR_CLK;

  wire             oAUD_BCK;
  wire             oAUD_DATA;
  wire             oAUD_LRCK;
  wire             oWR_FULL;
  //wrapper, which is an e_instance
  AUDIO_DAC_FIFO wrapper
    (
      .iCLK_18_4 (iCLK_18_4),
      .iDATA     (iDATA),
      .iRST_N    (iRST_N),
      .iWR       (iWR),
      .iWR_CLK   (iWR_CLK),
      .oAUD_BCK  (oAUD_BCK),
      .oAUD_DATA (oAUD_DATA),
      .oAUD_LRCK (oAUD_LRCK),
      .oWR_FULL  (oWR_FULL)
    );


endmodule

