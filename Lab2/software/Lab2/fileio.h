//Altera board stuff
#include "alt_types.h"
#include <stdio.h>
#include <unistd.h>
#include "system.h"
#include "sys/alt_irq.h"
#include "altera_avalon_pio_regs.h"

//FAT and SD card stuff
#include "SD_Card.h"
#include "basic_io.h"
#include "fat.h"


int init_fileio ( void );

void print_file_info ( data_file* file );
