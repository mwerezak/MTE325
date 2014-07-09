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


//reads a file to data_buf and returns the number of bytes read.
int read_file (data_file* file, BYTE* data_buf, int start_idx) {
	int sector_idx = 0;
	int byte_count;
	int bytes_read = 0;

	UINT32 ccount = cluster_count(file);
	int cluster_chain[ccount];

	build_cluster_chain( cluster_chain, ccount, file );

	//read the ENTIRE file
	while (1) {
		byte_count = get_rel_sector( file, data_buf[sector_idx + start_idx], cluster_chain, sector_idx);
		sector_idx++;

		if (byte_count == -1)
			return -1;
		else if (byte_count == 0)
			bytes_read += SECTOR_SIZE;
		else {
			bytes_read += byte_count;
			return bytes_read;
		}
	}
}


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

//returns 1 if a file was found, 0 otherwise
int next_file (BYTE* file_ext, data_file* file) {
	return !search_for_filetype(file_ext, file, 0, 1);
}


//Tests
int main () {
	data_file file;
	BYTE* file_ext = "WAV";
	BYTE file_data[6000000];
	int bytes_read;
	int i;

	if(init_fileio()) {
		printf("Failed to init file I/O.\n");
		return 1;
	}


	if (next_file(file_ext, &file)) {
		printf("Reading from file \"%s\"...\n", file.Name);

		bytes_read = read_file(&file, &file_data, 0);

		/*
		printf("Read %d bytes of data:\n\n", bytes_read);

		for (i = 0; i <= 200; i += 4){
			printf(
				"%#x %#x %#x %#x\n",
				file_data[i], file_data[i+1], file_data[i+2], file_data[i+3]
			);
		}
		*/
	}

	return 0;
}

