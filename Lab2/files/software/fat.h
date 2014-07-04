#ifndef _FAT_H_
#define _FAT_H_
//-------------------------------------------------------------------------
// data_file Data Structure
typedef struct {
  BYTE  Name[11];   //FileName
  BYTE  Attr;       //File attribute tag
  UINT32  Clus;     //First cluster of file data
  UINT32  FileSize;  //Size of the file in bytes
  UINT32  Sector;   //First sector of file data 
  UINT32  Posn;      //FilePtr byte absolute to the file
} data_file;
//-------------------------------------------------------------------------
UINT16 file_count=0;
UINT16 file_number=0;

//-------------------------------------------------------------------------
//MASTER BOOT RECORD
BYTE  MBR_Bootable;
BYTE  MBR_Start_Sector[3];
BYTE  MBR_End_End[3];
BYTE  MBR_Partition_Type;
UINT32  MBR_BS_Location;
UINT32  MBR_Partition_Len;

//FAT12, FAT16, FAT32
BYTE  BS_JmpBoot[3];
BYTE  BS_OEMName[8];
UINT16 BPB_BytsPerSec;
BYTE  BPB_SecPerClus;
UINT16  BPB_RsvdSecCnt;
BYTE  BPB_NumFATs;
UINT16  BPB_RootEntCnt;
UINT16  BPB_TotSec16;
BYTE  BPB_Media;
UINT16  BPB_FATSz16;
UINT16  BPB_SecPerTrk;
UINT16  BPB_NumHeads;
UINT32  BPB_HiddSec;
UINT32  BPB_TotSec32;
  
//FAT12, FAT16
BYTE BS_DrvNum_16;
BYTE BS_BootSig_16;
UINT32  BS_VOLID_16;
BYTE  BS_VOLLab_16[11];
BYTE  BS_FilSysType_16[8];

//FAT32
UINT32  BPB_FATSz32;
UINT16  BPB_ExtFlags;
UINT16  BPB_FSVer;
UINT32  BPB_RootClus;
UINT16  BPB_FSInfo;
UINT16  BPB_BkBootSec;
BYTE BS_DrvNum_32;
BYTE BS_BootSig_32;
UINT32  BS_VOLID_32;
BYTE  BS_VOLLab_32[11];
BYTE  BS_FilSysType_32[8];

//Calculated Values
UINT16  RootDirSectors;
UINT32  FATSz;
UINT32  FirstDataSector;
UINT32  TotSec;
UINT32  DataSec;
UINT32  CountofClusters;
UINT32  FirstRootDirSecNum;
char    FATType[6];
UINT32  FATOffset;
UINT32  ThisFATSecNum;
UINT32  ThisFATEntOffset;
UINT16  FAT12ClusEntryVal;
UINT16  FAT16ClusEntryVal;
UINT32  FAT32ClusEntryVal;
UINT32  FATClusEntryVal;
//-------------------------------------------------------------------------
UINT32 FirstSectorofCluster(UINT32);
BYTE init_mbr(void);
BYTE init_bs(void);
void info_bs();
UINT32 FirstSectorofCluster(UINT32 N);
void CalcFATSecAndOffset(UINT32);
BYTE isEOF(UINT32);
void  build_cluster_chain(int cc[],UINT32 length, data_file *df);
UINT32  search_for_filetype(BYTE *extension, data_file *df, int sub_directory, int search_root);
//-------------------------------------------------------------------------
// Initialize the Master Boot Record
BYTE init_mbr(void)
{
  BYTE Buffer[512]={0};
  
  SD_read_lba(Buffer,0,1);  //Store master boot record in Buffer

  //Check the last 2 bytes of the buffer to ensure it is tagged as the MBR
  //buffer[510] should read 0x55 and buffer[511] should read 0xAA
  if(Buffer[510]==MASTER_BOOT_RECORD_ID1 && Buffer[511]==MASTER_BOOT_RECORD_ID2)
  {
    MBR_Bootable = Buffer[446];
    MBR_Start_Sector[0] = Buffer[447];
    MBR_Start_Sector[1] = Buffer[448];
    MBR_Start_Sector[2] = Buffer[449];
    MBR_Partition_Type = Buffer[450];
    MBR_End_End[0] = Buffer[451];
    MBR_End_End[1] = Buffer[452];
    MBR_End_End[2] = Buffer[453];
    MBR_BS_Location = Buffer[454] + (Buffer[455]<<8) + (Buffer[456]<<16) + (Buffer[457]<<24);
    MBR_Partition_Len = Buffer[458] + (Buffer[459]<<8) + (Buffer[460]<<16) + (Buffer[461]<<24);
    return 0; //OK
  }
  else
  {
    return 1; //Error
  }
}
//-------------------------------------------------------------------------
// Initialize the Boot Sector
BYTE init_bs(void)
{
  BYTE Buffer[512]={0};
  
  SD_read_lba(Buffer,MBR_BS_Location,1);  //Store boot sector in Buffer

  if(Buffer[510]==MASTER_BOOT_RECORD_ID1 && Buffer[511]==MASTER_BOOT_RECORD_ID2)
  {
    BS_JmpBoot[0] = Buffer[0];
    BS_JmpBoot[1] = Buffer[1];
    BS_JmpBoot[2] = Buffer[2];
    BS_OEMName[0] = Buffer[3];
    BS_OEMName[1] = Buffer[4];
    BS_OEMName[2] = Buffer[5];
    BS_OEMName[3] = Buffer[6];
    BS_OEMName[4] = Buffer[7];
    BS_OEMName[5] = Buffer[8];
    BS_OEMName[6] = Buffer[9];
    BS_OEMName[7] = Buffer[10];
    BPB_BytsPerSec = Buffer[11] + (Buffer[12]<<8);
    BPB_SecPerClus = Buffer[13];
    BPB_RsvdSecCnt = Buffer[14] + (Buffer[15]<<8);
    BPB_NumFATs = Buffer[16];
    BPB_RootEntCnt = Buffer[17] + (Buffer[18]<<8);
    BPB_TotSec16 = Buffer[19] + (Buffer[20]<<8);
    BPB_Media = Buffer[21];
    BPB_FATSz16 = Buffer[22] + (Buffer[23]<<8);
    BPB_SecPerTrk = Buffer[24] + (Buffer[25]<<8);
    BPB_NumHeads = Buffer[26] + (Buffer[27]<<8);
    BPB_HiddSec = Buffer[28] + (Buffer[29]<<8) + (Buffer[30]<<16) + (Buffer[31]<<24);
    BPB_TotSec32 = Buffer[32] + (Buffer[33]<<8) + (Buffer[34]<<16) + (Buffer[35]<<24);
    
    //count of sectors occupied by the root directory
    RootDirSectors = ((BPB_RootEntCnt*32) + (BPB_BytsPerSec - 1))/BPB_BytsPerSec;
    
    if(BPB_FATSz16 != 0)
    {
      FATSz = BPB_FATSz16;
      
      BS_DrvNum_16 = Buffer[36];
      BS_BootSig_16 = Buffer[38];
      BS_VOLID_16 = Buffer[39] + (Buffer[40]<<8) + (Buffer[41]<<16) + (Buffer[42]<<24);
      BS_VOLLab_16[0] = Buffer[43];
      BS_VOLLab_16[1] = Buffer[44];
      BS_VOLLab_16[2] = Buffer[45];
      BS_VOLLab_16[3] = Buffer[46];
      BS_VOLLab_16[4] = Buffer[47];
      BS_VOLLab_16[5] = Buffer[48];
      BS_VOLLab_16[6] = Buffer[49];
      BS_VOLLab_16[7] = Buffer[50];
      BS_VOLLab_16[8] = Buffer[51];
      BS_VOLLab_16[9] = Buffer[52];
      BS_VOLLab_16[10] = Buffer[53];
      BS_FilSysType_16[0] = Buffer[54];
      BS_FilSysType_16[1] = Buffer[55];
      BS_FilSysType_16[2] = Buffer[56];
      BS_FilSysType_16[3] = Buffer[57];
      BS_FilSysType_16[4] = Buffer[58];
      BS_FilSysType_16[5] = Buffer[59];
      BS_FilSysType_16[6] = Buffer[60];
      BS_FilSysType_16[6] = Buffer[61];
      
      //root directory LBA = FirstRootDirSecNum + MBR_BS_Location
      FirstRootDirSecNum = BPB_RsvdSecCnt + (BPB_NumFATs * BPB_FATSz16);
      FirstDataSector = BPB_RsvdSecCnt + (BPB_NumFATs * BPB_FATSz16) + RootDirSectors;
    }
    else
    {
      FATSz = BPB_FATSz32;
      
      BPB_FATSz32 = Buffer[36] + (Buffer[37]<<8) + (Buffer[38]<<16) + (Buffer[39]<<24);
      BPB_ExtFlags = Buffer[40] + (Buffer[41]<<8);
      BPB_FSVer = Buffer[42] + (Buffer[43]<<8);
      BPB_RootClus = Buffer[44] + (Buffer[45]<<8) + (Buffer[46]<<16) + (Buffer[47]<<24);
      BPB_FSInfo = Buffer[48] + (Buffer[49]<<8);
      BPB_BkBootSec = Buffer[50] + (Buffer[51]<<8);
      BS_DrvNum_32 = Buffer[64];
      BS_BootSig_32 = Buffer[66];
      BS_VOLID_32 = Buffer[67] + (Buffer[68]<<8) + (Buffer[69]<<16) + (Buffer[70]<<24);
      BS_VOLLab_32[0] = Buffer[71];
      BS_VOLLab_32[1] = Buffer[72];
      BS_VOLLab_32[2] = Buffer[73];
      BS_VOLLab_32[3] = Buffer[74];
      BS_VOLLab_32[4] = Buffer[75];
      BS_VOLLab_32[5] = Buffer[76];
      BS_VOLLab_32[6] = Buffer[77];
      BS_VOLLab_32[7] = Buffer[78];
      BS_VOLLab_32[8] = Buffer[79];
      BS_VOLLab_32[9] = Buffer[80];
      BS_VOLLab_32[10] = Buffer[81];
      BS_FilSysType_32[0] = Buffer[82];
      BS_FilSysType_32[1] = Buffer[83];
      BS_FilSysType_32[2] = Buffer[84];
      BS_FilSysType_32[3] = Buffer[85];
      BS_FilSysType_32[4] = Buffer[86];
      BS_FilSysType_32[5] = Buffer[87];
      BS_FilSysType_32[6] = Buffer[88];
      BS_FilSysType_32[7] = Buffer[89];
      
      //root directory LBA = FirstRootDirSecNum + MBR_BS_Location
      FirstRootDirSecNum = BPB_RsvdSecCnt + (BPB_NumFATs * BPB_FATSz32);
      FirstDataSector = BPB_RsvdSecCnt + (BPB_NumFATs * BPB_FATSz32) + RootDirSectors;
    }
    //The start of the data region, the first sector of cluster 2  
    

   if(BPB_TotSec16 != 0)
      TotSec = BPB_TotSec16;
   else
      TotSec = BPB_TotSec32;
    DataSec = TotSec - (BPB_RsvdSecCnt + (BPB_NumFATs * FATSz) + RootDirSectors);
    
    CountofClusters = DataSec / BPB_SecPerClus;
/*    
    if(CountofClusters < 4085)
    {
    // Volume is FAT12
      strcpy(FATType,"FAT12");
      printf("\nFile System: %s",FATType);
    }
    else if(CountofClusters < 65525)
    {
    // Volume is FAT16
      strcpy(FATType,"FAT16");
      printf("\nFile System: %s",FATType);
    }
    else
    {
    // Volume is FAT32
      strcpy(FATType,"FAT32");
      printf("\nFile System: %s",FATType);
    }
*/
    return 0; //OK
  }
  else
  {
    return 1; //error
  }
}
//-------------------------------------------------------------------------
// Prints Boot Sector information
void info_bs()
{
  //Stored in Boot Sector
  printf("\n\nBoot Sector Data Structure Summary:");
  printf("\nBS_JmpBoot: 0x%02X 0x%02X 0x%02X",BS_JmpBoot[0],BS_JmpBoot[1],
        BS_JmpBoot[2]);
  printf("\nBS_OEMName: %s",BS_OEMName);
  printf("\nBPB_BytsPerSec: %d",BPB_BytsPerSec);
  printf("\nBPB_SecPerClus: %d",BPB_SecPerClus);
  printf("\nBPB_RsvdSecCnt: %d",BPB_RsvdSecCnt);
  printf("\nBPB_NumFATs: %d",BPB_NumFATs);
  printf("\nBPB_RootEntCnt: %d",BPB_RootEntCnt);
  printf("\nBPB_TotSec16: %d",BPB_TotSec16);
  printf("\nBPB_Media: %d",BPB_Media);
  printf("\nBPB_FATSz16: %d",BPB_FATSz16);
  printf("\nBPB_SecPerTrk: %d",BPB_SecPerTrk);
  printf("\nBPB_NumHeads: %d",BPB_NumHeads);
  printf("\nBPB_HiddSec: %d",BPB_HiddSec);
  printf("\nBPB_TotSec32: %d",BPB_TotSec32);
  
  //Calculated based on Boot Sector Values
  printf("\nRootDirSectors: 0x%04X (%d)10",RootDirSectors,RootDirSectors);
  printf("\nFATSz: 0x%04X (%d)10",FATSz,FATSz);
  printf("\nFirstDataSector: 0x%04X (%d)10",FirstDataSector,FirstDataSector);
  printf("\nTotSec: 0x%04X (%d)10",TotSec,TotSec);
  printf("\nDataSec: 0x%04X (%d)10",DataSec,DataSec);
  printf("\nCountofClusters: 0x%04X (%d)10",CountofClusters,CountofClusters);
  printf("\nFirstRootDirSecNum: 0x%04X (%d)10",FirstRootDirSecNum,FirstRootDirSecNum);
}  
//-------------------------------------------------------------------------
// Calculates the First Sector of Cluster number 'N'
UINT32 FirstSectorofCluster(UINT32 N)
{
  return(((N-2) * BPB_SecPerClus) + FirstDataSector + MBR_BS_Location);
}

//-------------------------------------------------------------------------
// Calculates the Next Cluster after cluster 'N'
// Finds the cluster 'N' in the File Allocation Table
// Cluster 'N's data contains the Next Cluster number 
void CalcFATSecAndOffset(UINT32 N)
{
  BYTE  Buffer[512]={0};
  //Calculate The absolute FATOffset based on which File System is in use
  //Difference between FAT12, FAT16, FAT32 is based only on CountofClusters
  if(CountofClusters < 4085)
  {
    //FAT12
    // Multiply by 1.5 without using floating point, the divide by 2 rounds DOWN
    FATOffset = N + (N / 2);
  }
  else if(CountofClusters < 65525)
  {
    //FAT16
    FATOffset = N * 2;
  }
  else
  {
    //FAT32
    FATOffset = N * 4;
  }

  //FAT Sector
  ThisFATSecNum = BPB_RsvdSecCnt + (FATOffset / BPB_BytsPerSec);
  //FAT Offset
  ThisFATEntOffset = FATOffset % BPB_BytsPerSec;
  
  //Store the FAT Sector into Buffer[512]
  SD_read_lba(Buffer,MBR_BS_Location + ThisFATSecNum,1);

//FATClusEntryVal is the next cluster for cluster 'N'
if(CountofClusters < 4085)
  {
    //FAT12
    if(ThisFATEntOffset != 511)
    {
      if(N & 0x0001)
      {
        // Cluster number is ODD
        FAT12ClusEntryVal = (((Buffer[ThisFATEntOffset] & 0xF0) |
            (Buffer[ThisFATEntOffset+1]<<8))>>4); 
      }
      else
      {
        // Cluster number is EVEN
        FAT12ClusEntryVal = ((Buffer[ThisFATEntOffset] |
            (Buffer[ThisFATEntOffset+1]<<8)) & 0x0FFF); 
      }
    }
    else
    {
      FAT12ClusEntryVal = (Buffer[511] & 0xFF);
      SD_read_lba(Buffer,MBR_BS_Location + ThisFATSecNum + 1,1);
      FAT12ClusEntryVal = (FAT12ClusEntryVal | ((Buffer[0] & 0x0F)<<8));
    }
    FATClusEntryVal = FAT12ClusEntryVal;
  }
  else if(CountofClusters < 65525)
  {
    //FAT16
    FAT16ClusEntryVal = (Buffer[ThisFATEntOffset] |
        (Buffer[ThisFATEntOffset+1]<<8));
    FATClusEntryVal = FAT16ClusEntryVal;
  }
  else
  {
    //FAT32
    FAT32ClusEntryVal = (Buffer[ThisFATEntOffset] |
                        (Buffer[ThisFATEntOffset+1]<<8) |
                        (Buffer[ThisFATEntOffset+2]<<16) |
                        (Buffer[ThisFATEntOffset+3]<<24)) & 0x0FFFFFFF;
    FATClusEntryVal = FAT32ClusEntryVal;
  }
  
}

//-------------------------------------------------------------------------
// Determines if the Cluster is the last cluster in the file's cluster chain
// Returns 1 if FATContent is the last cluster in the cluster chain
// Returns 0 if there are more clusters
BYTE  isEOF(UINT32  FATContent)
{
  BYTE IsEOF = 0;
  
  if(CountofClusters < 4085)
  {
    //FAT12
    if(FATContent >= 0x0FF8)
    IsEOF = 1;
  }
  else if(CountofClusters < 65525)
  {
    //FAT16
    if(FATContent >= 0xFFF8)
    IsEOF = 1;
  }
  else
  {
    //FAT32
    if(FATContent >= 0x0FFFFFF8)
    IsEOF = 1;
  }
  return IsEOF;
}
//-------------------------------------------------------------------------
// Buffers the cluster chain of a file so that it can be streamed
void build_cluster_chain(int cc[],UINT32 length, data_file *df)
{
  int i=1;
  cc[0] = df->Clus;
  CalcFATSecAndOffset(df->Clus);

  while(i<length)
  {
    cc[i]=FATClusEntryVal;
    
    if(!isEOF(FATClusEntryVal))
      {CalcFATSecAndOffset(FATClusEntryVal);}
    i++;
  }
}
//-------------------------------------------------------------------------
// Searches for a particular file extension specified by "extension"
// To browse from the start of the file system use
// search_for_filetye("extension",0,1);
UINT32  search_for_filetype(BYTE *extension, data_file *df, int sub_directory, int search_root)
{
  UINT16  directory;
  BYTE  Buffer[512]={0};
  BYTE  attribute_offset = 11;   //first attribute offset
  BYTE  FstClusHi_offset = 20;   //first cluster high offset
  BYTE  FstClusLo_offset = 26;   //first cluster offset
  BYTE  FileSize_offset = 28;   //file size offset
  BYTE  attribute;
  BYTE  entry_num = 0; 
  char filename[12];
  char fileext[4];
  char longname[255] = {0};
  int i,root_sector_count=0,longname_blocks,ATTR_LONG_NAME,ATTR_LONG_NAME_MASK;
  
  
  if(search_root)
  {
    //Search the root directory
    directory = (MBR_BS_Location + FirstRootDirSecNum);
    SD_read_lba(Buffer,directory,1);
  }
  else
  {
    //Search the sub directory
    SD_read_lba(Buffer,sub_directory,1);
    directory = sub_directory;
    // start from entry number 2 to skip over the
    // ./ Current directory Entry and the ../ Parent directory entry
    entry_num = 2;
  }
  
  //Browse while there are still entries to browse
  while((Buffer[entry_num*32] != 0x00))
  {
   ATTR_LONG_NAME_MASK = Buffer[entry_num*32+attribute_offset] &0x3F;
   ATTR_LONG_NAME = Buffer[entry_num*32+attribute_offset] &0x0F;
    
    //Determine if the entry contains a long file name
    if (((Buffer[entry_num*32+attribute_offset] & ATTR_LONG_NAME_MASK) == ATTR_LONG_NAME) && (Buffer[entry_num*32+attribute_offset] != 0x08) && (Buffer[entry_num*32] != 0xE5)) //long filename
    {
      //longname_blocks is the amount of entrys that contain the long filename
      longname_blocks = (Buffer[entry_num*32] & 0xBF);
      if(longname_blocks < 20)
      {
        longname[(longname_blocks-1)*13+13] = '\0';
      }
      
      //read the file name from the buffer and store it into longname[]
      while(longname_blocks > 0)
      {
        longname[(longname_blocks-1)*13+0] = Buffer[entry_num*32+1];
        longname[(longname_blocks-1)*13+1] = Buffer[entry_num*32+3];
        longname[(longname_blocks-1)*13+2] = Buffer[entry_num*32+5];
        longname[(longname_blocks-1)*13+3] = Buffer[entry_num*32+7];
        longname[(longname_blocks-1)*13+4] = Buffer[entry_num*32+9];
        longname[(longname_blocks-1)*13+5] = Buffer[entry_num*32+14];
        longname[(longname_blocks-1)*13+6] = Buffer[entry_num*32+16];
        longname[(longname_blocks-1)*13+7] = Buffer[entry_num*32+18];
        longname[(longname_blocks-1)*13+8] = Buffer[entry_num*32+20];
        longname[(longname_blocks-1)*13+9] = Buffer[entry_num*32+22];
        longname[(longname_blocks-1)*13+10] = Buffer[entry_num*32+24];
        longname[(longname_blocks-1)*13+11] = Buffer[entry_num*32+28];
        longname[(longname_blocks-1)*13+12] = Buffer[entry_num*32+30];
      
        longname_blocks--;
        entry_num++;
        
        //if the entry number spans beyond the current sector, grab the next one
        if(entry_num*32 >= BPB_BytsPerSec)
        {
          root_sector_count++;
          SD_read_lba(Buffer,directory + root_sector_count,1);
          entry_num=0;
        }
      }
    }

    //Read the attribute tag of the current entry
    //0x00 Indicates the end of the FAT entries
    //0x08 Indicates Volume ID
    //0xE5 Indicates and empty entry
    //0x10 Indicates a Directory
    //anything else indicates a file
    
    attribute = Buffer[entry_num*32 + attribute_offset];
    
    if((attribute & 0x08)||(Buffer[entry_num*32] == 0xE5))
    {
      //0x08 Indicates Volume ID
      //0xE5 Indicates and empty entry
      //Either case increment to next entry
    }   
    else if(attribute & 0x10)
    {
      //Indicates a Directory, search the directory
      sub_directory = (Buffer[entry_num*32 + FstClusLo_offset]) + 
            (Buffer[entry_num*32 + FstClusLo_offset + 1]<<8) +
            (Buffer[entry_num*32 + FstClusHi_offset]) + 
            (Buffer[entry_num*32 + FstClusHi_offset + 1]<<8);
      sub_directory = FirstSectorofCluster(sub_directory);
      if(!search_for_filetype(extension, df, sub_directory,0))
      {
        return 0;
      }
    }
    else
    {
      //Indicates a file
      for(i=0;i<11;i++)
      {
        filename[i]=Buffer[entry_num*32 + i];
      }
      filename[11] = '\0';
      
      //Grab the current entry numbers file extension
      fileext[0]=Buffer[entry_num*32 + 8];
      fileext[1]=Buffer[entry_num*32 + 9];
      fileext[2]=Buffer[entry_num*32 + 10];
      fileext[3] = '\0';
      
      //compare the current file's file extension to the extension to search for
      if(!strcmp(extension,fileext))
      {
        if(file_count == file_number)
        {
          strcpy(df->Name, filename);
          df->Attr = attribute;
          df->Clus = (Buffer[entry_num*32 + FstClusLo_offset]) + 
              (Buffer[entry_num*32 + FstClusLo_offset + 1]<<8) +
              (Buffer[entry_num*32 + FstClusHi_offset]) + 
              (Buffer[entry_num*32 + FstClusHi_offset + 1]<<8);
          df->FileSize = (Buffer[entry_num*32 + FileSize_offset]) | 
              (Buffer[entry_num*32 + FileSize_offset + 1]<<8) |
              (Buffer[entry_num*32 + FileSize_offset + 2]<<16) |
              (Buffer[entry_num*32 + FileSize_offset + 3]<<24);
          df->Sector = FirstSectorofCluster(df->Clus);
          df->Posn = 0;
          file_count = 0;
          file_number = file_number + 1;
          return 0; //file found
        }
        file_count++;
      } 
    }
    entry_num++;
    //if the entry number spans beyond the current sector, grab the next one
    if(entry_num*32 >= BPB_BytsPerSec)
    {
      root_sector_count++;
      SD_read_lba(Buffer,directory + root_sector_count,1);
      entry_num=0;    
    }
  }
  
  //The Buffer[entry_num*32] is 0x00
  if(search_root)
  {
    //The entire volume has been searched
    if(file_number == 0)
    {
      //No files matching the file extension have been found
      printf("\nFile Extension %s not found",extension);
    }
    else
    {
      //Wrap around and find the first file
      file_number = 0;
      file_count = 0;
      search_for_filetype(extension, df, 0,1);
    }
  }
  else
  {
    //The subdirectory doesn't contain any more entries
    return 1;//entry not found
  }
}
//-------------------------------------------------------------------------
int get_rel_sector(data_file *df, BYTE *buffer, int cc[], int sector)
{
  //relative sector address start from sector 0 not 1!!!
  //return 0 valid sector
  //return -1 sector is out of range
  //return <bytes in last sector> valid/last sector
  
  int Total_Sectors = ceil(df->FileSize / BPB_BytsPerSec);
  int Return_Sector;
  
  if( ( sector >= Total_Sectors ) || ( sector < 0 ) )
  {
    return -1; //sector is out of range
  }
  else
  {
    //get sector
    Return_Sector = (sector % BPB_SecPerClus) + FirstSectorofCluster(cc[(int)(floor(sector / BPB_SecPerClus))]);
    SD_read_lba(buffer,Return_Sector,1);
    
    if(sector == (Total_Sectors - 1) )
    {
      return (df->FileSize - ((sector+1) * BPB_BytsPerSec));
    }
    else
    {
      return 0; //valid sector
    }
  }
}
#endif //_FAT_H_
