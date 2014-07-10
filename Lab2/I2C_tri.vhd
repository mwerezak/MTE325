-- ECE324 Lab 2 I2C Tristate Buffers
--
-- ECE 324 - Lab 2
-- VHDL Specification for the I2C Tristate Buffers
--
-- Jason Shirtliff, 12/12/2006
-- Department of Electrical and Computer Engineering
-- University of Waterloo, Waterloo, Ontario, CANADA
-- N2L 3G1

-- The following lines include the definitions necessary to use
-- the STD_LOGIC and STD_LOGIC_VECTOR types that are commonly used
-- in VHDL.
LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- The entity declaration defines the INTERFACE to the design.  It 
-- specifies the PORTS (pins) and the GENERICS (parameters) to 
-- the design.  The I2C Tristate buffer design has six pins organized into four
-- 1-bit inputs and two 1-bit outputs, as shown below.
-- This design does not require any GENERICS.
ENTITY I2C_tri IS

	PORT
	(
		SCL 		:	IN		STD_LOGIC;
		SCL_OE_N 	:	IN		STD_LOGIC;
		SDA			:	IN		STD_LOGIC;
		SDA_OE_N 	:	IN		STD_LOGIC;
		I2C_CLK 	: 	OUT		STD_LOGIC;
		I2C_DATA 	:	OUT		STD_LOGIC
	);

END I2C_tri;


-- The architecture declaration defines the IMPLEMENTATION of the
-- design.  You can have multiple architecture declarations for
-- complex VHDL designs.  For example, you might have an 
-- architecture optimized for performance and another optimized
-- for efficient device utilization.
ARCHITECTURE lab2 OF I2C_tri IS
	
BEGIN

tristate:

-- The WHEN ... ELSE statement allows you to conditionally assign a
-- signal to one or any number of other signals. In this case, we are
-- assigning the input data and clock signals to the outputs when the
-- output enables are low, otherwise we connect the output to high 
-- impedance, or 'Z'.

	I2C_CLK <= SCL WHEN (SCL_OE_N = '0') ELSE 'Z';
	I2C_DATA <= SDA WHEN (SDA_OE_N = '0') ELSE 'Z';
	
END lab2;