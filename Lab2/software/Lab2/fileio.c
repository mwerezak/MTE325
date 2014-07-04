//This file will contain higher-level functions for reading files from SD card

#include "fileio.h"

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

	return 0;
}

void print_file_info(data_file* file) {
	printf("Filename: %s\n", file->Name);
	printf("Attr: %X\n", file->Attr);
	printf("Start Sluster: %d\n", file->Clus);
	printf("File Size: %d\n", file->FileSize);
	printf("Start Sector: %d\n", file->Sector);
	printf("Absolute Byte Addr: %X\n", file->Posn);
}

//Tests
int main () {
	BYTE* file_ext = "WAV";
	data_file df_buf;

	if(init_fileio()) {
		printf("Failed to init file I/O.");
		return 1;
	}
	printf("\n\n");

	//look for files
	if (!search_for_filetype(file_ext, &df_buf, 0, 1)) {
		printf("Found a .wav file!\n");
		print_file_info(&df_buf);
	} else {
		printf("No .wav files were found.\n");
	}

}
