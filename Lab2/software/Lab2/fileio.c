//This file will contain higher-level functions for reading files from SD card

#include "fileio.h"

#include "wm8731.h"

#define NORMAL_SPEED	0
#define HALF_SPEED		1
#define DOUBLE_SPEED	2


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
	}
}

void playback_file (data_file* file, int playback_mode) {
	int cluster_chain[3000];
	BYTE buffer[SECTOR_SIZE]; //set buffer size to sector size
	int sector_idx = 0; //start from sector zero

	UINT32 cc_length = 1 + ((UINT32) (ceil(file->FileSize / (BPB_BytsPerSec*BPB_SecPerClus)))); //describes the size of our cluster chain

	// Build cluster chain
	build_cluster_chain(cluster_chain, cc_length, file); //returns void

	int rs;	//check the return value from get_rel_sector
	while(1) {
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
	build_cluster_chain(cluster_chain, cc_length, file); //returns void

	int rs;	//check the return value from get_rel_sector
	while(1) {
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
	int delay_buffer_size = 88200;
	BYTE delay_buffer[delay_buffer_size];

	//init the delay buffer
	for (i = 0; i < delay_buffer_size; i++)
		delay_buffer[i] = 0;

	UINT32 cc_length = 1 + ((UINT32) (ceil(file->FileSize / (BPB_BytsPerSec*BPB_SecPerClus)))); //describes the size of our cluster chain

	// Build cluster chain
	build_cluster_chain(cluster_chain, cc_length, file); //returns void

	int rs;	//check the return value from get_rel_sector
	while(1) {
		rs = get_rel_sector(file, buffer, cluster_chain, sector_idx++);

		if (rs == -1) {
			printf ("DONE.\n\n");
			break;
		} else if (rs == 0) {
			for (i = 2; i < SECTOR_SIZE; i += 4) {
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
			for (i = 2; i < rs; i += 4) {
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
}


// If we wanted to be fancy, we can have a playback speed option in the original function

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
	}
}



//Tests
int main () {
	data_file file;
	BYTE* file_ext = "WAV";
	int i;
	int is_full = 0;
	int playback_mode = NORMAL_SPEED;

	UINT16 tmp;

	if(init_fileio()) {
		printf("Failed to init file I/O.\n");
		return 1;
	}

	// init audio codec. this call doesn't return anything so... i guess it works?
	init_audio_codec();
	printf("\n");

	//Returns 1 if success
	while (!search_for_filetype(file_ext, &file, 0, 1)) {

		// Sanity Check on the file
		print_file_info(&file);

		playback_mode = IORD(SWITCH_PIO_BASE, 0) & 0x7;
		if (playback_mode == 0x4)
			playback_file_reverse(&file);
		else if (playback_mode == 0x5)
			playback_channel_offset(&file);
		else
			playback_file(&file, playback_mode);
	}

	printf ("NO MORE FILES FOUND.\n");
	return 0;
}

