#include "alt_types.h"
#include <stdio.h>
#include <unistd.h>
#include "system.h"
#include "sys/alt_irq.h"
#include "altera_avalon_pio_regs.h"


static alt_u16 ReadDIPSwitches(void) {
	return IORD_ALTERA_AVALON_PIO_DATA(SWITCH_PIO_BASE);
}
