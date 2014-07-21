#include <stdio.h>
#include <unistd.h>
#include <math.h>
#include "alt_types.h"
#include "system.h"
#include "sys/alt_irq.h"
#include "altera_avalon_pio_regs.h"

//Timers
#include "altera_avalon_timer.h"
#include "altera_avalon_timer_regs.h"  // timer register constants
#include "sys/alt_alarm.h"	//for measuring elapsed time

//FAT and SD card stuff
#include "SD_Card.h"
#include "basic_io.h"
#include "fat.h"
#include "LCD.h"


#define CLUSTER_SIZE	BPB_BytsPerSec*BPB_SecPerClus	//the number of bytes in a cluster
#define SECTOR_SIZE		BPB_BytsPerSec

int stop_playing = 1;

/*************************************************
 *
 * Timers
 *
 *************************************************/

volatile int timer0, timer1;	//these become nonzero when timer has gone off

static void SetTimer0(alt_u32);
static void SetTimer1(alt_u32);
static void InitTimers(void);



int init_fileio ( void );

void print_file_info ( data_file* file );

void print_lcd (char* line1, char* line2);

void playback_file (data_file* file, int playback_mode);
void playback_file_reverse (data_file* file);
void playback_channel_offset (data_file* file);
void write_to_codec (BYTE* buffer, int length);
void write_to_codec_half_speed (BYTE* buffer, int length);
void write_to_codec_double_speed (BYTE* buffer, int length);
void write_to_codec_reverse (BYTE* buffer, int length);
