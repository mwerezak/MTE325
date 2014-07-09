
#include "audio.h"


void test_audio () {
	UINT16 tmp = 0xFFFF;

	while (IORD( AUD_FULL_BASE, 0 ));

	IOWR ( AUDIO_0_BASE, 0, tmp );
}
