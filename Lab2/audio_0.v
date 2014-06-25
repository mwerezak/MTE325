// audio_0.v

// This file was auto-generated as part of a SOPC Builder generate operation.
// If you edit it your changes will probably be lost.

module audio_0 (
		input  wire        iWR_CLK,   //       avalon_slave_0_clock.clk
		input  wire        iRST_N,    // avalon_slave_0_clock_reset.reset_n
		output wire        oAUD_BCK,  //      avalon_slave_0_export.export
		output wire        oAUD_DATA, //                           .export
		output wire        oAUD_LRCK, //                           .export
		output wire        oWR_FULL,  //                           .export
		input  wire        iCLK_18_4, //                           .export
		input  wire [15:0] iDATA,     //             avalon_slave_0.writedata
		input  wire        iWR        //                           .write
	);

	Audio audio_0 (
		.iWR_CLK   (iWR_CLK),   //       avalon_slave_0_clock.clk
		.iRST_N    (iRST_N),    // avalon_slave_0_clock_reset.reset_n
		.oAUD_BCK  (oAUD_BCK),  //      avalon_slave_0_export.export
		.oAUD_DATA (oAUD_DATA), //                           .export
		.oAUD_LRCK (oAUD_LRCK), //                           .export
		.oWR_FULL  (oWR_FULL),  //                           .export
		.iCLK_18_4 (iCLK_18_4), //                           .export
		.iDATA     (iDATA),     //             avalon_slave_0.writedata
		.iWR       (iWR)        //                           .write
	);

endmodule
