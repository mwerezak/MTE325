/*************************************************************************
* Copyright (c) 2006 Altera Corporation, San Jose, California, USA.      *
* All rights reserved. All use of this software and documentation is     *
* subject to the License Agreement located at the end of this file below.*
*************************************************************************/

/* Includes */

#include "alt_types.h"
#include <stdio.h>
#include <unistd.h>
#include "system.h"
#include "sys/alt_irq.h"
#include "altera_avalon_pio_regs.h"
#include "altera_avalon_timer.h"
#include "altera_avalon_timer_regs.h"  // timer register constants
#include "sys/alt_alarm.h"	//for measuring elapsed time
#include "ece324_egm.h"

/*  Macros to clear the LCD screen. */

#define ESC 27
#define CLEAR_LCD_STRING "[2J"

/* One nice define for going to menu entry functions. */

#define MenuCase(letter,proc) case letter:proc(); break;

/* Board Diagnositics Peripheral Function prototypes */

/* UART Related Prototypes */
#ifdef JTAG_UART_NAME
static void UARTSendLots( void );
static void UARTReceiveChars( void );
#endif

/* Seven Segment Related Prototypes */
#ifdef SEVEN_SEG_PIO_NAME
static void SevenSegCount( void );
static void SevenSegControl( void );
#endif

/* LED Related Prototype */
#ifdef LED_PIO_NAME
static void TestLEDs( void );
#endif

/* Button/Switch (SW0-SW3) Related Prototype */
#ifdef BUTTON_PIO_NAME
static void TestButtons( void );
#endif

/* LCD Related Prototype */
#ifdef LCD_DISPLAY_NAME
static void TestLCD( void );
#endif

/* Define the EOT character to terminate nios2-terminal
 * upon exiting the Main Menu.
 */

/*************************************************
 *
 * Timers
 *
 *************************************************/

volatile int timer0, timer1;	//these become nonzero when timer has gone off

static void SetTimer0(alt_u32);
static void SetTimer1(alt_u32);
static void InitTimers(void);

/*************************************************
 *
 * EGM Pulse Edge-Trigger
 *
 *************************************************/

volatile alt_u8 egm_pulse;
//volatile alt_u8 egm_pulse_trigger;	//is non-zero if egm_pulse has changed

static void InitEGMPulseEdgeTrigger (void);
static void handle_egm_pulse_interrupt(void*, alt_u32);

static void InitEGMPulseEdgeTriggerTest (void);
static void handle_egm_pulse_interrupt_test(void*, alt_u32);

/*************************************************
 *
 * Lab 1 Phase 1
 *
 *************************************************/

typedef struct BitTicker {
	alt_u8 bit_sequence;
	alt_u8 counter;	//when zero there are no bits left
} BitTicker;

static void init_ticker(volatile BitTicker* t) {
	t->counter = 0;
}

static void start_ticker(volatile BitTicker* t, alt_u8 new_sequence) {
	t->bit_sequence = new_sequence;
	t->counter = 8;
}

static void update_ticker(volatile BitTicker* t) {
	if (t->counter > 0){
		t->bit_sequence = (t->bit_sequence) >> 1;
		(t->counter)--;
	}
}


static void TestDIPSwitches( void );
static void Lab1Phase1Main( void );

/*************************************************
 *
 * Lab 1 Phase 2
 *
 *************************************************/

static void TestEGM( void );
static void RunTightPolling( void );
static void RunPeriodicPolling( void );
static void RunInterruptSynchro( void );

#define EOT 0x4

/******************************************************************************
*                                                                             *
* License Agreement                                                           *
*                                                                             *
* Copyright (c) 2006 Altera Corporation, San Jose, California, USA.           *
* All rights reserved.                                                        *
*                                                                             *
* Permission is hereby granted, free of charge, to any person obtaining a     *
* copy of this software and associated documentation files (the "Software"),  *
* to deal in the Software without restriction, including without limitation   *
* the rights to use, copy, modify, merge, publish, distribute, sublicense,    *
* and/or sell copies of the Software, and to permit persons to whom the       *
* Software is furnished to do so, subject to the following conditions:        *
*                                                                             *
* The above copyright notice and this permission notice shall be included in  *
* all copies or substantial portions of the Software.                         *
*                                                                             *
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  *
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,    *
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE *
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER      *
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING     *
* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER         *
* DEALINGS IN THE SOFTWARE.                                                   *
*                                                                             *
* This agreement shall be governed in all respects by the laws of the State   *
* of California and by the laws of the United States of America.              *
* Altera does not recommend, suggest or require that this reference design    *
* file be used in conjunction or combination with any other product.          *
******************************************************************************/
