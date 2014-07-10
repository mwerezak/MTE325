//This file will contain higher-level functions for reading files from SD card

#include "fileio.h"

#include "wm8731.h"

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

	for(i = 0; i+1 < length; i += 2)
	{
		while(IORD(AUD_FULL_BASE,0));	//wait until the CODEC FIFO is not full

		word = (buffer[i+1] << 8) | (buffer[i]);

		IOWR(AUDIO_0_BASE, 0, word);
	}
}


//Tests
int main () {
	data_file file;
	BYTE* file_ext = "WAV";
	int i;
	int is_full = 0;

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

		UINT32 cc_length = 1 + ((UINT32) (ceil(file.FileSize / (BPB_BytsPerSec*BPB_SecPerClus)))); //describes the size of our cluster chain
		printf("Cluster Chain Length: %d\n", cc_length);

		// Build cluster chain
		int cluster_chain[3000];
		build_cluster_chain(cluster_chain, cc_length, &file); //returns void

		int sector_idx = 0; //start from sector zero
		BYTE buffer[SECTOR_SIZE]; //set buffer size to sector size


		int rs;	//check the return value from get_rel_sector

		while(1) {

			rs = get_rel_sector(&file, buffer, cluster_chain, sector_idx++);

			if (rs == -1) {
				printf ("DONE.\n\n");
				break;
			} else if (rs == 0) {
				write_to_codec(buffer, SECTOR_SIZE);
			} else {
				write_to_codec(buffer, rs);
			}
		}

	}

	printf ("NO MORE FILES FOUND.\n");
	return 0;
}

