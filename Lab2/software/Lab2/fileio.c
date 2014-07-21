//This file will contain higher-level functions for reading files from SD card

#include "fileio.h"

#include "wm8731.h"

#define NORMAL_SPEED	0
#define HALF_SPEED		1
#define DOUBLE_SPEED	2


/*********************************************************************
 * FILE IO
 *********************************************************************/


/*
 * Does all the initialization required to read *.wav files off the SD card.
 */
int init_fileio() {
	printf("Setting up communication with the SD card...\n");

	if (SD_card_init()) {
		printf("Failed to init SD card.\n");
		return 1;
	}

	printf("Initializing the file system...\n");
	if (init_mbr()) {
		printf("Failed to init MBR.\n");
		return 1;
	}
	if (init_bs()) {
		printf("Failed to init boot sector.\n");
		return 1;
	}

	info_bs();
	printf("\n\n");

	return 0;
}


void print_file_info(data_file* file) {
	printf("Filename: \"%s\"\n", file->Name);
	printf("Attr: %#x\n", file->Attr);
	printf("Start Cluster: %u\n", file->Clus);
	printf("File Size: %u\n", file->FileSize);
	printf("Start Sector: %u\n", file->Sector);
	printf("Absolute Byte Addr: %#x\n", file->Posn);
}


void list_all_files (BYTE* file_ext) {
	data_file df_buf;

	//look for files
	printf("Searching for .wav files...\n\n");
	while (!search_for_filetype(file_ext, &df_buf, 0, 1)) {
		print_file_info(&df_buf);
		printf("\n");
	}
}

/*********************************************************************
 * AUDIO PLAYBACK
 *********************************************************************/

void playback_file (data_file* file, int playback_mode) {
	int cluster_chain[3000];
	BYTE buffer[SECTOR_SIZE]; //set buffer size to sector size
	int sector_idx = 0; //start from sector zero

	UINT32 cc_length = 1 + ((UINT32) (ceil(file->FileSize / (BPB_BytsPerSec*BPB_SecPerClus)))); //describes the size of our cluster chain

	// Build cluster chain
	LCD_File_Buffering(file->Name);
	build_cluster_chain(cluster_chain, cc_length, file); //returns void

	if (playback_mode == HALF_SPEED)
		LCD_Display(file->Name, 2);
	else if (playback_mode == DOUBLE_SPEED)
		LCD_Display(file->Name, 1);
	else
		LCD_Display(file->Name, 0);

	int rs;	//check the return value from get_rel_sector
	while(!stop_playing) {
		rs = get_rel_sector(file, buffer, cluster_chain, sector_idx++);

		if (rs == -1) {
			printf ("DONE.\n\n");
			break;
		} else if (rs == 0) {

			if (playback_mode == HALF_SPEED) {
				write_to_codec_half_speed(buffer, SECTOR_SIZE);
			} else if (playback_mode == DOUBLE_SPEED) {
				write_to_codec_double_speed(buffer, SECTOR_SIZE);
			} else {
				write_to_codec(buffer, SECTOR_SIZE);
			}

		} else {

			if (playback_mode == HALF_SPEED) {
				write_to_codec_half_speed(buffer, rs);
			} else if (playback_mode == DOUBLE_SPEED) {
				write_to_codec_double_speed(buffer, rs);
			} else {
				write_to_codec(buffer, rs);
			}

		}
	}
}

void playback_file_reverse (data_file* file) {
	int cluster_chain[3000];
	BYTE buffer[SECTOR_SIZE]; //set buffer size to sector size
	int sector_idx = ceil(file->FileSize / BPB_BytsPerSec) - 1; //start from sector zero

	UINT32 cc_length = 1 + ((UINT32) (ceil(file->FileSize / (BPB_BytsPerSec*BPB_SecPerClus)))); //describes the size of our cluster chain

	// Build cluster chain
	LCD_File_Buffering(file->Name);
	build_cluster_chain(cluster_chain, cc_length, file); //returns void
	LCD_Display(file->Name, 4);

	int rs;	//check the return value from get_rel_sector
	while(!stop_playing) {
		rs = get_rel_sector(file, buffer, cluster_chain, sector_idx--);

		if (rs == -1) {
			printf ("DONE.\n\n");
			break;
		} else if (rs == 0) {
			write_to_codec_reverse(buffer, SECTOR_SIZE);
		} else {
			write_to_codec_reverse(buffer, rs);
		}
	}
}


void playback_channel_offset (data_file* file) {
	int i;
	int cluster_chain[3000];
	BYTE buffer[SECTOR_SIZE]; //set buffer size to sector size
	int sector_idx = 0; //start from sector zero
	int offset_counter = 0;

	BYTE temp;
	int delay_idx = 0;
	int end_idx = 0;
	int delay_buffer_size = 88200;
	BYTE delay_buffer[delay_buffer_size];

	//init the delay buffer
	for (i = 0; i < delay_buffer_size; i++)
		delay_buffer[i] = 0;

	UINT32 cc_length = 1 + ((UINT32) (ceil(file->FileSize / (BPB_BytsPerSec*BPB_SecPerClus)))); //describes the size of our cluster chain

	// Build cluster chain
	LCD_File_Buffering(file->Name);
	build_cluster_chain(cluster_chain, cc_length, file); //returns void
	LCD_Display(file->Name, 3);

	int rs;	//check the return value from get_rel_sector
	while(!stop_playing) {
		rs = get_rel_sector(file, buffer, cluster_chain, sector_idx++);

		if (rs == -1) {
			printf ("DONE.\n\n");
			break;
		} else if (rs == 0) {
			for (i = 0; i < SECTOR_SIZE; i += 4) {
				temp = delay_buffer[delay_idx];
				delay_buffer[delay_idx++] = buffer[i];
				buffer[i] = temp;

				temp = delay_buffer[delay_idx];
				delay_buffer[delay_idx++] = buffer[i+1];
				buffer[i+1] = temp;

				if (delay_idx >= delay_buffer_size) delay_idx = 0;
			}

			write_to_codec(buffer, SECTOR_SIZE);
			offset_counter += SECTOR_SIZE/4;
		} else {
			for (i = 0; i < rs; i += 4) {
				temp = delay_buffer[delay_idx];
				delay_buffer[delay_idx++] = buffer[i];
				buffer[i] = temp;

				temp = delay_buffer[delay_idx];
				delay_buffer[delay_idx++] = buffer[i+1];
				buffer[i+1] = temp;

				if (delay_idx >= delay_buffer_size) delay_idx = 0;
			}

			write_to_codec(buffer, rs);
		}
	}

	if (stop_playing) return;

	// Play out the rest of the buffer
	end_idx = delay_idx;
	int num_bytes;
	do {
		num_bytes = 0;
		for (i = 0; i < SECTOR_SIZE; i += 4) {
			buffer[i] = delay_buffer[delay_idx];
			delay_buffer[delay_idx++] = 0;

			buffer[i+1] = delay_buffer[delay_idx];
			delay_buffer[delay_idx++] = 0;
			num_bytes += 2;

			if (delay_idx >= delay_buffer_size) delay_idx = 0;

			if (delay_idx == end_idx) break;
		}

		write_to_codec(buffer, num_bytes);
	} while (delay_idx != end_idx && !stop_playing);
}


//writes length bytes from a buffer to the audio CODEC
void write_to_codec (BYTE* buffer, int length)
{
	UINT16 word;
	int i;

	for(i = 0; i+1 < length; i += 4)
	{
		while(IORD(AUD_FULL_BASE,0));	//wait until the CODEC FIFO is not full
		word = (buffer[i+1] << 8) | (buffer[i]);
		IOWR(AUDIO_0_BASE, 0, word);

		while(IORD(AUD_FULL_BASE,0));	//wait until the CODEC FIFO is not full
		word = (buffer[i+3] << 8) | (buffer[i+2]);
		IOWR(AUDIO_0_BASE, 0, word);

		if (stop_playing) return;
	}
}

void write_to_codec_half_speed (BYTE* buffer, int length) {
	UINT16 word;
	int i;
	int j;

	for(i = 0; i+1 < length; i += 4)
	{
		while(IORD(AUD_FULL_BASE,0));	//wait until the CODEC FIFO is not full
		word = (buffer[i+1] << 8) | (buffer[i]);
		IOWR(AUDIO_0_BASE, 0, word);

		while(IORD(AUD_FULL_BASE,0));	//wait until the CODEC FIFO is not full
		word = (buffer[i+3] << 8) | (buffer[i+2]);
		IOWR(AUDIO_0_BASE, 0, word);

		while(IORD(AUD_FULL_BASE,0));	//wait until the CODEC FIFO is not full
		word = (buffer[i+1] << 8) | (buffer[i]);
		IOWR(AUDIO_0_BASE, 0, word);

		while(IORD(AUD_FULL_BASE,0));	//wait until the CODEC FIFO is not full
		word = (buffer[i+3] << 8) | (buffer[i+2]);
		IOWR(AUDIO_0_BASE, 0, word);

		if (stop_playing) return;
	}
}


void write_to_codec_double_speed (BYTE* buffer, int length) {
	UINT16 word;
	int i;

	for(i = 0; i+1 < length; i += 8)
	{
		while(IORD(AUD_FULL_BASE, 0));	//wait until the CODEC FIFO is not full
		word = (buffer[i+1] << 8) | (buffer[i]);
		IOWR(AUDIO_0_BASE, 0, word);

		while(IORD(AUD_FULL_BASE, 0));	//wait until the CODEC FIFO is not full
		word = (buffer[i+3] << 8) | (buffer[i+2]);
		IOWR(AUDIO_0_BASE, 0, word);

		if (stop_playing) return;
	}
}


void write_to_codec_reverse (BYTE* buffer, int length)
{
	UINT16 word;
	int i;

	for (i = length-4; i >= 0; i -= 4)
	{
		while(IORD(AUD_FULL_BASE,0));	//wait until the CODEC FIFO is not full
		word = (buffer[i+1] << 8) | (buffer[i]);
		IOWR(AUDIO_0_BASE, 0, word);

		while(IORD(AUD_FULL_BASE,0));	//wait until the CODEC FIFO is not full
		word = (buffer[i+3] << 8) | (buffer[i+2]);
		IOWR(AUDIO_0_BASE, 0, word);

		if (stop_playing) return;
	}
}

/*********************************************************************
 * MEDIA PLAYER
 *********************************************************************/

void print_lcd (char* line1, char* line2) {
	LCD_Init();
	LCD_Show_Text(line1);
	LCD_Line2();
	LCD_Show_Text(line2);
}

void seek_next_file(data_file* file, char* file_ext) {
	file_number++;	//select the next file.
	search_for_filetype(file_ext, file, 0, 1);
	print_lcd(file->Name, "");
}

void seek_previous_file(data_file* file, char* file_ext) {
	if (file_number == 0)
		return;	//too bad

	file_number--;
	search_for_filetype(file_ext, file, 0, 1);
	print_lcd(file->Name, "");
}

void play_file(data_file* file) {
	int playback_mode = NORMAL_SPEED;
	char* file_name = file->Name;

	// Sanity Check on the file
	print_file_info(file);

	playback_mode = IORD(SWITCH_PIO_BASE, 0) & 0x7;

	if (playback_mode == 0x4) {
		playback_file_reverse(file);
	} else if (playback_mode == 0x5) {
		playback_channel_offset(file);
	} else {
		playback_file(file, playback_mode);
	}
}

/*********************************************************************
 * PUSH BUTTONS
 *********************************************************************/

volatile int edge_capture;

static void handle_button_interrupts(void* context, alt_u32 id)
{
	/* Cast context to edge_capture's type.
	* It is important to keep this volatile,
	* to avoid compiler optimization issues.
	*/
	volatile int* edge_capture_ptr = (volatile int*) context;

	volatile int transition = IORD_ALTERA_AVALON_PIO_EDGE_CAP(BUTTON_PIO_BASE);
	volatile int pushbutton = (*edge_capture_ptr) ^ transition;

	IOWR_ALTERA_AVALON_PIO_DATA(LED_PIO_BASE, pushbutton);	//LED debug

	//handle stop
	if (transition == 0x1)	//PB0: Stop playback
	{
		stop_playing = 1;
	}


	/* Store the value in the Button's edge capture register in *context. */
	*edge_capture_ptr = pushbutton;
	/* Reset the Button's edge capture register. */
	IOWR_ALTERA_AVALON_PIO_EDGE_CAP(BUTTON_PIO_BASE, 0);

	/*
	* Read the PIO to delay ISR exit. This is done to prevent a spurious
	* interrupt in systems with high processor -> pio latency and fast
	* interrupts.
	*/
	IORD_ALTERA_AVALON_PIO_EDGE_CAP(BUTTON_PIO_BASE);
}


static void init_button_pio()
{
	/* Recast the edge_capture pointer to match the alt_irq_register() function
	* prototype. */
	void* edge_capture_ptr = (void*) &edge_capture;
	/* Enable all 4 button interrupts. */
	IOWR_ALTERA_AVALON_PIO_IRQ_MASK(BUTTON_PIO_BASE, 0xf);
	/* Reset the edge capture register. */
	IOWR_ALTERA_AVALON_PIO_EDGE_CAP(BUTTON_PIO_BASE, 0x0);

	alt_irq_register( BUTTON_PIO_IRQ, edge_capture_ptr, handle_button_interrupts);
}

static void disable_button_pio()
{
	/* Disable interrupts from the button_pio PIO component. */
	IOWR_ALTERA_AVALON_PIO_IRQ_MASK(BUTTON_PIO_BASE, 0x0);
	/* Un-register the IRQ handler by passing a null handler. */
	alt_irq_register( BUTTON_PIO_IRQ, NULL, NULL );
}

/*************************************************
 *
 * 	Timer crap
 *
 *************************************************/

static void SetTimer0(alt_u32 milliseconds) {
	alt_u32 timer_period = milliseconds*(TIMER_0_FREQ/1000);

	//clear the timer done flag
	timer0 = 0;

	//write the duration to the timer
	IOWR(TIMER_0_BASE, 2, (alt_u16)timer_period);			//low bits
	IOWR(TIMER_0_BASE, 3, (alt_u16)(timer_period >> 16));	//high bits

	// clear timer interrupt bit in status register
	IOWR_ALTERA_AVALON_TIMER_STATUS(TIMER_0_BASE, 0x0);

	IOWR_ALTERA_AVALON_TIMER_CONTROL(TIMER_0_BASE, ALTERA_AVALON_TIMER_CONTROL_ITO_MSK
											      | ALTERA_AVALON_TIMER_CONTROL_CONT_MSK
												  | ALTERA_AVALON_TIMER_CONTROL_START_MSK);
}

static void SetTimer1(alt_u32 microseconds) {
	alt_u32 timer_period = microseconds*(TIMER_1_FREQ/1000000);

	//clear the timer done flag
	timer1 = 0;

	//write the duration to the timer
	IOWR(TIMER_1_BASE, 2, (alt_u16)timer_period);			//low bits
	IOWR(TIMER_1_BASE, 3, (alt_u16)(timer_period >> 16));	//high bits

	// clear timer interrupt bit in status register
	IOWR_ALTERA_AVALON_TIMER_STATUS(TIMER_1_BASE, 0x0);

	IOWR_ALTERA_AVALON_TIMER_CONTROL(TIMER_1_BASE, ALTERA_AVALON_TIMER_CONTROL_ITO_MSK
											      | ALTERA_AVALON_TIMER_CONTROL_CONT_MSK
												  | ALTERA_AVALON_TIMER_CONTROL_START_MSK);
}


//Timer ISRs
static void handle_timer0_interrupt (void* context, alt_u32 id) {
	// acknowledge the interrupt by clearing the TO bit in the status register
	IOWR_ALTERA_AVALON_TIMER_STATUS(TIMER_0_BASE, 0x0);

	// set the flag with a non zero value
	timer0 = 0xf;
}

static void handle_timer1_interrupt (void* context, alt_u32 id) {
	// acknowledge the interrupt by clearing the TO bit in the status register
	IOWR_ALTERA_AVALON_TIMER_STATUS(TIMER_1_BASE, 0x0);

	// set the flag with a non zero value
	timer1 = 0xf;
}

static void init_timers(void) {
	timer0 = 0;
	timer1 = 0;

	alt_irq_register(TIMER_0_IRQ, (void*)0, handle_timer0_interrupt);
	alt_irq_register(TIMER_1_IRQ, (void*)0, handle_timer1_interrupt);
}

/*********************************************************************
 * MAIN
 *********************************************************************/

int main () {
	data_file file;
	BYTE* file_ext = "WAV";
	int play = 0;

	printf("\n");
	LCD_Init();
	printf("\n");

	print_lcd("Initializing...","SD Card");
	if(init_fileio()) {
		print_lcd("Could not load","SD card");
		return 1;
	}

	// init audio codec. this call doesn't return anything so... i guess it works?
	print_lcd("Initializing...","audio codec");
	init_audio_codec();

	// seek to the first file
	file_number = 0;
	if (search_for_filetype(file_ext, &file, 0, 1)){
		print_lcd("No *.wav files","found on card");
		while(1);	//wait until restart
	}
	print_lcd(file.Name, "");


	init_timers();		//timers
	init_button_pio();	//enable interrupts

	while (1) {
		if (stop_playing) {
			edge_capture = 0;
			timer0 = 0;
			while(1) {
				if (edge_capture & 0x2) {	//PB1: play the selected file
					break;
				}

				if (edge_capture & 0x4) {	//PB2: seek to next file
					seek_next_file(&file, file_ext);

					//debounce
					SetTimer0(500);
					while(!timer0);	//wait for timer before looping.
					edge_capture = 0;
				}


				if (edge_capture & 0x8) { //PB3: seek to previous file
					seek_previous_file(&file, file_ext);

					//debounce
					SetTimer0(500);
					while(!timer0);	//wait for timer before looping.
					edge_capture = 0;
				}
			}
		} else {
			seek_next_file(&file, file_ext);
		}

		stop_playing = 0;
		play_file(&file);
	}

	return 0;
}

