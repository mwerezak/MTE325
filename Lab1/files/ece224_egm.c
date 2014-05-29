// File: lab1.c
//
// Contents: Helper functions to complete lab 1

//int nr_printf(const char *fmt,...);

//#include "alt_types.h"
#include <stdio.h>
#include <unistd.h>
#include "system.h"
//#include "sys/alt_irq.h"
#include <io.h>

typedef volatile struct
	{
	int np_piodata;          // read/write, up to 32 bits
	int np_piodirection;     // write/readable, up to 32 bits, 1->output bit
	int np_piointerruptmask; // write/readable, up to 32 bits, 1->enable interrupt
	int np_pioedgecapture;   // read, up to 32 bits, cleared by any write
	} np_pio;

// test variables
int g_taskProcessed;	// units of the task completed

// the current test settings
int g_period;			// the period ( [n+1] * 122.88 uS ), 0 <= n <= 15
int g_dutyCycle;		// duty cycle (in 16ths of a period) for the pulse

// these should be declared in the user's nios design
/*extern np_pio* reset;
extern np_pio* enable;
extern np_pio* period;
extern np_pio* dutycycle;
extern np_pio* response;
extern np_pio* latency;
extern np_pio* missed;*/

// this function is called immediately upon entering your main program to setup the test conditions and reset the EGM
void init(int in_period, int in_dutyCycle)
{
	int nPeriod; // the period (in milliseconds)
	int nDutyCycle; // the duty cycle (in %)
	int nResolution; // the resolution of the latency tracker (in nanoseconds)

	g_taskProcessed = 0;
	g_period = in_period;
	g_dutyCycle = in_dutyCycle;

	// calculate the test conditions
	if(g_period == 0) nPeriod = 1000000;
	else nPeriod = (g_period + 1) * 82;
	nDutyCycle = 100 * g_dutyCycle / 16;
	nResolution = nPeriod * 1000 / 1024;

	// print out some friendly data for the user
	printf("Beginning test.\n");
	printf("Test specifications:\n  period = %d microseconds\n  duty cycle = %d%%\n  latency resolution = %d nanoseconds\n\n", nPeriod, nDutyCycle, nResolution);

	// make sure the 324EGM is disabled before we attempt to set it up
	IOWR(PIO_EGMENABLE_BASE, 0, 0);
	IOWR(PIO_RESPONSE_BASE, 0, 1);
  
//  int q1 = IORD(PIO_MISSED_BASE, 0);
//  printf("missed before reset = %d\n", q1);

	// reset the 324EGM (we wait 10 ms because of timing issues which you may have noticed in your compilation warnings)
	IOWR(PIO_EGMRESET_BASE, 0, 1);
	usleep(10000);

	// turn off the reset and setup the test conditions
	IOWR(PIO_EGMRESET_BASE, 0, 0);
  
//  int q2 = IORD(PIO_MISSED_BASE, 0);
//  printf("missed after reset = %d\n", q2);
  
	IOWR(PIO_PERIOD_BASE, 0, g_period);
	IOWR(PIO_DUTYCYCLE_BASE, 0, g_dutyCycle);
	IOWR(PIO_RESPONSE_BASE, 0, 0);
	usleep(10);

	// enable the 324EGM and return
	IOWR(PIO_EGMENABLE_BASE, 0, 1);
	return;
}

// this function is called immediately upon exiting your main program to softly shut down the 324EGM and report test details
void finalize(void)
{
	int nMissed; // missed events
	int nLatency; // maximum latency (in 1024ths of a period)
	int nLatency_ms; // maximum latency (in milliseconds)

	// immediately disable the 324EGM
	IOWR(PIO_EGMENABLE_BASE, 0, 0);
	IOWR(PIO_RESPONSE_BASE, 0, 1);
	usleep(10);

	// obtain the test results
	nLatency = IORD(PIO_LATENCY_BASE, 0);
	nMissed = IORD(PIO_MISSED_BASE, 0);

	// calculate the latency in milliseconds
	nLatency_ms = nLatency * (g_period + 1) * 3 / 25;

	// print the results
	printf("Test complete.\n");
	printf("Results:\n");
	printf("  missed = %d pulse(s)\n", nMissed);
	printf("  max latency = %d / 1024th(s) of a period\n", nLatency);
	printf("  max latency = %d microsecond(s)\n", nLatency_ms);
	printf("  task units processed = %d units\n\n", g_taskProcessed);
	printf("Exiting...\n");

	// this tells the program that we're done
	// removed to allow looping.
	// printf("\004");
	return;
}

// this is the background task that your program must call
int background(int grainSize)
{
	int x;
	int j;
	x = 0;
	for(j = 0; j < grainSize; j++)
	{
		x *= -1;
		x += j * j;
		g_taskProcessed++;
	}
	return x;
}
