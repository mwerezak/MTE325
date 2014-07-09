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
	printf("\n\n");

	return 0;
}

//returns the length of the cluster chain for a given file
UINT32 cluster_count (data_file* file) {
	return 1 + ceil(file->FileSize / CLUSTER_SIZE);
}

/*
void read_file (data_file* file, BYTE* data_buf) {
	UINT32 ccount = cluster_count(file);
	int cluster_chain[ccount];

	build_cluster_chain( cluster_chain, ccount, file );
}
*/


void print_file_info(data_file* file) {
	printf("Filename: %s\n", file->Name);
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

//Tests
int main () {
	BYTE* file_ext = "WAV";

	if(init_fileio()) {
		printf("Failed to init file I/O.\n");
		return 1;
	}

	list_all_files(file_ext);

	return 0;
}

