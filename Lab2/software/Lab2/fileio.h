#include <stdio.h>
#include <unistd.h>
#include <math.h>
#include "alt_types.h"
#include "system.h"
#include "sys/alt_irq.h"
#include "altera_avalon_pio_regs.h"

//FAT and SD card stuff
#include "SD_Card.h"
#include "basic_io.h"
#include "fat.h"
#include "LCD.h"


#define CLUSTER_SIZE	BPB_BytsPerSec*BPB_SecPerClus	//the number of bytes in a cluster
#define SECTOR_SIZE		BPB_BytsPerSec

//data_file* current_file;	//the file that is currently selected for playing



int init_fileio ( void );

void print_file_info ( data_file* file );

void print_lcd (char* line1, char* line2);
