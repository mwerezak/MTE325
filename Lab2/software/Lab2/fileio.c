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

//returns the length of the cluster chain for a given file
UINT32 cluster_count (data_file* file) {
	return 1 + ceil(file->FileSize / CLUSTER_SIZE);
}


//reads a file to data_buf and returns the number of bytes read.
int read_file (data_file* file, BYTE* data_buf, int start_idx) {
	int sector_idx = 0;
	int byte_count;
	int bytes_read = 0;

	int progress_step;
	int progress;

	UINT32 ccount = cluster_count(file);
	int cluster_chain[ccount];

	printf("Reading from file \"%s\" ...\n", file->Name);

	build_cluster_chain( cluster_chain, ccount, file );

	//read the ENTIRE file
	progress_step = floor(file->FileSize/10);
	progress = progress_step;
	while (1) {
		byte_count = get_rel_sector( file, data_buf[bytes_read + start_idx], cluster_chain, sector_idx);
		sector_idx++;

		if (byte_count == -1)
			return -1;
		else if (byte_count == 0) {
			bytes_read += SECTOR_SIZE;


			if (bytes_read >= progress) {
				printf("... %d bytes read ...\n", bytes_read);
				progress += progress_step;
			}
		} else {
			bytes_read += byte_count;
			printf("... done! Read %d bytes.\n\n", bytes_read);
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

	//Returns 1 if success
	if (search_for_filetype(file_ext, &file, 0, 1)) {
		printf("Failed to find a file\n");
	}
	if (search_for_filetype(file_ext, &file, 0, 1)) {
		printf("Failed to find a file\n");
	}

	// Sanity Check on the file
	print_file_info(&file);

	// Get byte from the file
	// First, create the cluster chain
	UINT32 ccount = cluster_count(&file); //describes the size of our cluster chain
	int cluster_chain[3000]; //kindof correct maybe sortof?
	// Sanity check on build_cluster_chain parameters
	printf("ccount: %d\n cluster_chain: %d\n", ccount, cluster_chain);
	// Build cluster chain
	build_cluster_chain(cluster_chain, ccount, &file); //returns void
	// TODO: Inspect cluster chain!

	// Send data to the audio codec
	// 1. Get data
	// 2. Send data to audio codec
	// 3. Rinse and repeat

	int sector_idx = 0; //start from sector zero
	BYTE buffer[SECTOR_SIZE]; //set buffer size to sector size
	//int i = 0; //for for loop. but already exists
	//UINT16 tmp = 0; //already declared

	// get_rel_sector
	// return -1 if we fucked up
	// return 0 if we didn't fuck up
	// return >0 if complete
	while(1) {
		if (get_rel_sector(&file, buffer, cluster_chain, sector_idx) == -1) {
			printf ("FAIL.\n");
			return 0;
		}
		for(i = 0; i < SECTOR_SIZE; i += 2) {
			// Send data to the FIFO queue
			while(IORD(AUD_FULL_BASE,0)) {
				printf("FIFO queue full\n");
			}
			printf("FIFO queue not full\n");
			tmp = (buffer[i+1] << 8) | (buffer[i]);
			IOWR(AUDIO_0_BASE, 0, tmp);
		}
		sector_idx++;
	}

	/*if (next_file(file_ext, &file)) {

		bytes_read = read_file(&file, &file_data, 0);

		printf("Read %d bytes of data:\n\n", bytes_read);

		for (i = 0; i <= 200; i += 4){
			printf(
				"%#x %#x %#x %#x\n",
				file_data[i], file_data[i+1], file_data[i+2], file_data[i+3]
			);
		}

		printf("\n\n");
		printf("Initializing audio codec...\n");
		init_audio_codec();

		//write stuff to codec
		for (i = 0; i < bytes_read; i += 2) {
			is_full = 0;
			while(IORD( AUD_FULL_BASE, 0 ) ) {
				//if (!is_full) {
				//	printf ("Codec FIFO is full!\n");
				//	is_full = 1;
				//}
			}

			tmp = ( file_data[ i + 1 ] << 8 ) | ( file_data[ i ] );

			IOWR( AUDIO_0_BASE, 0, tmp );
		}


	}*/



	return 0;
}

