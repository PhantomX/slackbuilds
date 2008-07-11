#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define DEBUG 0
#define CHECK 0 /* don't bother checking bin for validity... */

//----------------Wave Stuff---------------------/
typedef unsigned char BYTE1 ;
typedef unsigned short int BYTE2 ;
typedef unsigned long int  BYTE4 ;

typedef struct wavHdr {
   BYTE1 riff[4];
   BYTE4 bytestoend;
   BYTE1 wavetxt[4];
   BYTE1 fmttxt[4];
   BYTE4 formatsize;  // 16 byte format specifier
   BYTE2 format;          // Windows PCM
   BYTE2 channels;             // 2 channels 
   BYTE4 samplerate;       // 44,100 Samples/sec
   BYTE4 avgbyterate;     // 176,400 Bytes/sec
   BYTE2 samplebytes;          // 4 bytes/sample
   BYTE2 channelbits;         // 16 bits/channel
   BYTE1 datatxt[4];
   BYTE4 blocksize;
} tWavHead;

#define HEADBYTES 36
#define WINDOWS_PCM 0x0001
//-------------------------------------------------/

/*  G L O B A L   D E F I N E S  */
#define byte    unsigned char
#define SIZERAW 2352
#define SIZEISO_MODE1 2048
#define SIZEISO_MODE2_RAW 2352
#define SIZEISO_MODE2_FORM1 2048
#define SIZEISO_MODE2_FORM2 2336
#define AUDIO 0
#define MODE1 1
#define MODE2 2
#define MODE1_2352 10
#define MODE2_2352 20
#define MODE1_2048 30
#define MODE2_2336 40

#define RAWDATA FF       // using this for leftover data when truncating for non-overburn

#define PROG_INTERVAL 1024
#define UNKNOWN -1
#define OFFSET 150                    
// got this from easycd pro by looking at a blank disk so it may be off...
#define CD74_MAX_SECTORS 334873 // 653.75 Mb 
         

unsigned long int Index(char m, char s, char f)
{
  unsigned long int temp;


  temp =  (((m>>4)*10) + (m&0xf)) * 60;
  temp = ( temp + (((s>>4)*10) + (s&0xf))) * 75;
  temp =  temp + (((f>>4)*10) + (f&0xf));
  
//  printf("\n%d%d %d%d %d%d = %06d", m>>4, m&f, s>>4, s&f, f>>4, f&f, temp);
  
  return temp;
}

void unIndex(unsigned long int index, char *ptr)
{
  char m, s, f;

  f = (char) (index % 75);
  s = (char) ((index/75) % 60);
  m = (char) (index/(75*60));
  sprintf(ptr, "%d%d:%d%d:%d%d", m/10, m%10, s/10, s%10, f/10, f%10);

}

// global variables
FILE* fdBinFile;
FILE* fdCueFile;
FILE* fdOutFile;
char sBinFilename[256];
char sOutFilename[256];

unsigned long int writepos = 0; // for inplace conversions...

   
#define OUTBUF_SIZE 4*1024*1024
#define INBUF_SIZE 4*1024*1024
unsigned char OUTBUF[OUTBUF_SIZE]; 
unsigned int OUTBUF_IDX = 0;
unsigned char INBUF[INBUF_SIZE]; 
unsigned int INBUF_RIDX = 0;
unsigned int INBUF_WIDX = 0;

int mode2to1 = 0;

typedef struct track
{
   unsigned short mode;
   unsigned long idx0;
   unsigned long idx1;
   unsigned char num[3];
   unsigned char name[80];
   unsigned long offset0;
   unsigned long offset1;
   unsigned long size; /* track size in bytes */
} tTrack;

buffered_fread(unsigned char *array, unsigned int size) {
   unsigned int i;
   
   if(INBUF_WIDX == 0) {    
      INBUF_WIDX += fread( INBUF, 1, (INBUF_SIZE/size)*size, fdBinFile );
   }
   if(INBUF_WIDX == 0) return 0; // read failed.
   
   for(i = 0; i< size; i++) 
   {

      array[i] = INBUF[INBUF_RIDX++];
      if((INBUF_RIDX == INBUF_WIDX) && (i < (size -1))) {
         printf("   Warning: Premature EOF\n");
         while(i++ < size) { array[i] == 0; }/* zero fill the rest */
         break;
      }
   }

   if(INBUF_RIDX == INBUF_WIDX) {
      INBUF_RIDX = 0;   
      INBUF_WIDX = 0;   
   }


   return 1; // read passed
     
}

void buffered_fwrite(unsigned char *array, unsigned int size) {
   unsigned int idx;
   unsigned long int readpos;
     
   if(OUTBUF_IDX+size >= OUTBUF_SIZE) {     

      if(fdOutFile == fdBinFile) {
         readpos = ftell(fdOutFile);
         if(0 != fseek(fdOutFile, writepos, SEEK_SET)) { 
            perror("\nbin2iso(fseek)"); exit(1);
         }         
      }

      //      printf("\nWriting            \n");
      if( 1 != fwrite( OUTBUF, OUTBUF_IDX, 1, fdOutFile )) {
         perror("\nbin2iso(fwrite)");
         fclose(fdOutFile);
         // remove(sOutFilename);
         exit(1);
      }
      if( 1 != fwrite( array, size, 1, fdOutFile )) {
         perror("\nbin2iso(fwrite)");
         fclose(fdOutFile);
         // remove(sOutFilename);
         exit(1);
      }
//      printf("\nWrote %d bytes            \n", OUTBUF_IDX+size);
      OUTBUF_IDX = 0;

      if(fdOutFile == fdBinFile) {
         writepos = ftell(fdOutFile);
         if(0 != fseek(fdOutFile, readpos, SEEK_SET)) { 
            perror("\nbin2iso(fseek)"); exit(1);
         }         
     }


   } else {
      for(idx = 0; idx < size; idx++) {
         OUTBUF[OUTBUF_IDX + idx] = array[idx];
      }
      OUTBUF_IDX+=size;
   }
     
}


void flush_buffers(void)
{
   unsigned long int readpos;

   if(fdOutFile == fdBinFile) {
      readpos = ftell(fdOutFile);
      if(0 != fseek(fdOutFile, writepos, SEEK_SET)) { 
         perror("\nbin2iso(fseek)"); exit(1);
      }         
   }

   if( 1 != fwrite( OUTBUF, OUTBUF_IDX, 1, fdOutFile )) {
      perror("\nbin2iso(fwrite)");
      fclose(fdOutFile);
      // remove(sOutFilename);
      exit(1);
   }

//   printf("\nWrote %d bytes          \n", OUTBUF_IDX);
   OUTBUF_IDX = 0;
   INBUF_RIDX = 0;
   INBUF_WIDX = 0;

   if(fdOutFile == fdBinFile) {
      writepos = ftell(fdOutFile);
      if(0 != fseek(fdOutFile, readpos, SEEK_SET)) { 
         perror("\nbin2iso(fseek)"); exit(1);
      }         
   }


}



// presumes Line is preloaded with the "current" line of the file
int getTrackinfo(char *Line, tTrack *track)
{
//   char tnum[3];
   char inum[3];
   char min;
   char sec;
   char block;
   
   track->idx0 = -1;
   track->idx1 = -1;
   
   // Get the 'mode'
   if (strncmp(&Line[2], "TRACK ", 6)==0) 
   {
      strncpy(track->num, &Line[8], 2); track->num[2] = '\0';

      track->mode = UNKNOWN;
      if(strncmp(&Line[11], "AUDIO", 5)==0) track->mode = AUDIO;
      if(strncmp(&Line[11], "MODE1/2352", 10)==0) track->mode = MODE1_2352;
      if(strncmp(&Line[11], "MODE1/2048", 10)==0) track->mode = MODE1_2048;
      if(strncmp(&Line[11], "MODE2/2352", 10)==0) track->mode = MODE2_2352;
      if(strncmp(&Line[11], "MODE2/2336", 10)==0) track->mode = MODE2_2336;
   }
   else return(1);
   
   // Set the name
   strcpy(track->name, sBinFilename);
   track->name[strlen(sBinFilename)-4] = '\0';
   strcat(track->name, "-");
   strcat(track->name, track->num);

   if( (track->mode == MODE1_2352) || 
       (track->mode == MODE1_2048) || 
       (track->mode == MODE2_2352) || 
       (track->mode == MODE2_2336)    )
   {
      strcat(track->name, ".iso");
   } else if(track->mode == AUDIO) {
      strcat(track->name, ".wav");
   } else {
      printf("Track %d Unsupported mode\n", track->num);
      return(1);
   }

   // Get the track indexes
   while(1) {
      if(! fgets( Line, 256, fdCueFile ) ) { break; }

      if (strncmp(&Line[2], "TRACK ", 6)==0) 
      {  
         break; // next track starting
      }

      if (strncmp(&Line[4], "INDEX ", 6)==0) 
      {
         strncpy(inum, &Line[10], 2); inum[2] = '\0';
         min = ((Line[13]-'0')<<4) | Line[14]-'0';
         sec = ((Line[16]-'0')<<4) | Line[17]-'0';
         block = ((Line[19]-'0')<<4) | Line[20]-'0';
         
         
         if(strcmp(inum, "00")==0) track->idx0 = Index(min, sec, block);
         else if(strcmp(inum, "01")==0) track->idx1 = Index(min, sec, block);
         else { printf("Unexpected Index number: %s\n", inum); exit(1); } 
           
      }
      else if (strncmp(&Line[4], "PREGAP ", 7)==0) { ; /* ignore, handled below */ }
      else if (strncmp(&Line[4], "FLAGS ", 6)==0)  { ; /* ignore */ }
      else { printf("Unexpected cuefile line: %s\n", Line); }
   }
   if(track->idx0 == -1) track->idx0 = track->idx1;
   if(track->idx1 == -1) track->idx1 = track->idx0;
   return(0);
} 


void dotrack(short mode, long preidx, long startidx, long endidx, unsigned long offset) 
{
   unsigned char buf[SIZERAW+100];
   unsigned long blockswritten = 0;
   unsigned int uiLastIndex;
#if CHECK
   unsigned int uiCurrentIndex;
#endif
   unsigned int write = 1;
   
   tWavHead wavhead = { "RIFF", 
                             0,      
                        "WAVE", 
                        "fmt ", 
                            16,       // 16 byte format specifier
                   WINDOWS_PCM,       // format
                             2,       // 2 Channels 
                         44100,       // 44,100 Samples/sec    
                        176400,       // 176,400 Bytes/sec
                             4,       // 4 bytes/sample
                            16,       // 16 bits/channel
                        "data",  
                             0 };
                             
   
   uiLastIndex = startidx-1;
   // Input -- process -- Output 
   if(startidx != 0) printf("\nNote: PreGap = %d frames\n", startidx-preidx);
   else printf("\nNote: PreGap = %d frames\n", OFFSET); // cd standard: starting offset
                                                       // - of course this isn't true for bootable cd's...

   if(sOutFilename[0] != '\0') {
      printf("Creating %s (%06d,%06d) ", sOutFilename, startidx, endidx-1);
   } else {
      printf("Converting (%06d,%06d) ", startidx, endidx-1);
   }
   switch(mode)
   {
      case AUDIO:
         printf("Audio");
         break;            
      case MODE1_2352:
         printf("Mode1/2048");
         break;
      case MODE2_2336:
         printf("Mode2/2352");
         break;
      case MODE2_2352:
         if(mode2to1 != 1) 
            printf("Mode2/2352");
         else 
            printf("Mode1/2048");
         break;
      case MODE1_2048:
         printf("Mode1/2048");
         break;
      default:
           printf("Huh? What's going on?");
           exit(1);
   }
   printf(" :       ");
   
   if(sOutFilename[0] != '\0') {
      if(NULL == (fdOutFile = fopen (sOutFilename, "wb"))) {
         perror("bin2iso(fopen)");
      }
// printf("\nOpened File %s: %d\n", sOutFilename, fdOutFile);

   } else {
      fdOutFile = fdBinFile;
   }
   if (fdOutFile == NULL)   { printf ("    Unable to create %s\n", sOutFilename); exit (1); }
   
   if(0 != fseek(fdBinFile, offset, SEEK_SET)) { 
      perror("\nbin2iso(fseek)"); exit(1);
   }         

#if (DEBUG == 0)
   if(mode == AUDIO) {
      if( 1 != fwrite( &wavhead, sizeof(wavhead), 1, fdOutFile ) ) { // write placeholder
         perror("\nbin2iso(fwrite)");
         fclose(fdOutFile);
         // remove(sOutFilename);
         exit(1);
      }
   }
#endif 
         
   memset( &buf[0], '\0', sizeof( buf ) );
   if(mode == MODE2_2336) {
      unsigned int M = 0, S = 2, F = 0;
      while( buffered_fread( &buf[16], SIZEISO_MODE2_FORM2) ) {
         //setup headed area (probably not necessary though...
         //buf[0] = 0;
         memset( &buf[1], 0xFF, sizeof(buf[0])*10 );
         //buf[11] = 0;
         buf[12] = M;
         buf[13] = S;
         buf[14] = F;
         buf[15] = MODE2;
         
         if((++F&0xF) == 0xA) F += 6;

         if(F == 0x75) { S++; F = 0; } 
         if((S&0xF) == 0xA) S += 6;
  
         if(S == 0x60) { M++; S = 0; }
         if((M&0xF) == 0xA) M += 6;
//         printf("\n%x:%x:%x", M, S, F);
         
         buffered_fwrite( buf, SIZERAW );   
         uiLastIndex++;
         memset( &buf[0], '\0', sizeof( buf ) );
         if (startidx%PROG_INTERVAL == 0) { printf("\b\b\b\b\b\b%06d", startidx); }
         if (++startidx == endidx) { printf("\b\b\b\b\b\bComplete\n"); break; }
      }
   } else if (mode == MODE1_2048) {
      while( buffered_fread( buf, SIZEISO_MODE1) ) {         
         buffered_fwrite( buf, SIZEISO_MODE1 );   
         uiLastIndex++;
         if (startidx%PROG_INTERVAL == 0) { printf("\b\b\b\b\b\b%06d", startidx); }
         if (++startidx == endidx) { printf("\b\b\b\b\b\bComplete\n"); break; }
      }
   } else {
      while( buffered_fread( buf, SIZERAW) ) {
         switch(mode) {
            case AUDIO:
#if (DEBUG == 0)
               buffered_fwrite( buf, SIZERAW );
#endif        
               uiLastIndex++;
               blockswritten++;
               break;
            case MODE1_2352:
               // should put a crc check in here...
#if CHECK
               if( buf[15] != MODE1) 
               { 
                  printf("\nWarning: Mode Error in bin file!\n"); 
                  printf("   %02x:%02x:%02x : mode %02x\n", buf[12], buf[13], buf[14], buf[15] ); 
                  //exit(1);
               }
             
               uiCurrentIndex = Index(buf[12], buf[13], buf[14]) - OFFSET;
              
               if(uiCurrentIndex != uiLastIndex+1)
               { 
                  printf("\nWarning: Frame Error in bin file!\n"); 
                  printf("Last      %02d:%02d:%02d (%d)\n", ((uiLastIndex+OFFSET)/75)/60, ((uiLastIndex+OFFSET)/75)%60, (uiLastIndex+OFFSET)%75, uiLastIndex ); 
                  printf("Current   %02x:%02x:%02x (%d)\n", buf[12], buf[13], buf[14], uiCurrentIndex ); 
                  printf("Expecting %02d:%02d:%02d (%d)\n", ((uiLastIndex+OFFSET+1)/75)/60, ((uiLastIndex+OFFSET+1)/75)%60, (uiLastIndex+OFFSET+1)%75, uiLastIndex+1 ); 
                
               }
#endif
#if (DEBUG == 0)
               buffered_fwrite( &buf[16], SIZEISO_MODE1 );
#endif
#if CHECK
               uiLastIndex = uiCurrentIndex;
#endif
               break;
            case MODE2_2352:
#if CHECK
               if( (buf[15]&0xf) != MODE2) 
               { 
                  printf("\nWarning: Mode Error in bin file!\n"); 
                  printf("   %02x:%02x:%02x : mode %02x\n", buf[12], buf[13], buf[14], buf[15] ); 
                  //exit(1);
               }

               uiCurrentIndex = Index(buf[12], buf[13], buf[14]) - OFFSET;

               if(uiCurrentIndex != uiLastIndex+1)
               { 
                  printf("\nWarning: Frame Error in bin file!\n"); 
                  printf("Last      %02d:%02d:%02d (%d)\n", ((uiLastIndex+OFFSET)/75)/60, ((uiLastIndex+OFFSET)/75)%60, (uiLastIndex+OFFSET)%75, uiLastIndex ); 
                  printf("Current   %02x:%02x:%02x (%d)\n", buf[12], buf[13], buf[14], uiCurrentIndex ); 
                  printf("Expecting %02d:%02d:%02d (%d)\n", ((uiLastIndex+OFFSET+1)/75)/60, ((uiLastIndex+OFFSET+1)/75)%60, (uiLastIndex+OFFSET+1)%75, uiLastIndex+1 ); 
               }
#endif
#if (DEBUG == 0)
               if(mode2to1) buffered_fwrite( &buf[16+8], SIZEISO_MODE1 );
               else if(write) buffered_fwrite( &buf[0], SIZEISO_MODE2_RAW );
#endif
#if CHECK
               uiLastIndex = uiCurrentIndex;
#endif
               break;
            default:
               printf("Unkown Mode\n"); exit(1);
               break;
         }         
            
         memset( &buf[0], '\0', sizeof( buf ) );
         if (startidx%PROG_INTERVAL == 0) { printf("\b\b\b\b\b\b%06d", startidx); }
         if (++startidx == endidx) { printf("\b\b\b\b\b\bComplete\n"); break; }
      }
   }
   flush_buffers(); // flushes write buffer
                    // and clears read buffer.
   if(mode == AUDIO) {
      wavhead.blocksize = blockswritten*SIZERAW;
      wavhead.bytestoend = wavhead.blocksize + HEADBYTES;
      // rewind to the beginning
      if(0 != fseek(fdOutFile, 0, SEEK_SET)) { 
         perror("\nbin2iso(fseek)"); exit(1);
      }         

#if (DEBUG == 0)
      fwrite( &wavhead, sizeof(wavhead), 1, fdOutFile );
#endif
   }      
   fclose(fdOutFile);
}


void doCueFile(void) {
   int track = 1;
   unsigned long int binIndex = 0;
   unsigned long int trackIndex = 0;
   const int gapThreshold = 20; // look for 0.266 sec gap
   const int valueThreshold = 800; // look for samples < 700
   int count = 0;
   int i, blank;
   int gapon = 0;
   short value;
      
   char mode[12] = "AUDIO";
   char index0[9] = "00:00:00";
   char index1[9] = "00:00:00";
   unsigned char buf[SIZERAW+100];
    
   printf(            "FILE %s BINARY\n", sBinFilename);
   fprintf(fdCueFile, "FILE %s BINARY\n", sBinFilename);
   memset( buf, '\0', sizeof( buf ) );
   while( fread( buf, 1, SIZERAW, fdBinFile ) ) {
      if(trackIndex == 0) {
         if ( (buf[0] == 0x00) &&
              (buf[1] == 0xFF) &&
              (buf[2] == 0xFF) &&
              (buf[3] == 0xFF) &&
              (buf[4] == 0xFF) &&
              (buf[5] == 0xFF) &&
              (buf[6] == 0xFF) &&
              (buf[7] == 0xFF) &&
              (buf[8] == 0xFF) &&
              (buf[9] == 0xFF) &&
              (buf[10] == 0xFF) &&
              (buf[11] == 0x00) 
            ) {
            sprintf(mode, "MODE%d/2352", buf[15]);
         } else { 
            sprintf(mode, "AUDIO"); 
         }
      } 
      if(binIndex == 0) {
         printf(            "  TRACK %02d %s\n", track, mode);
         fprintf(fdCueFile, "  TRACK %02d %s\n", track, mode);
         printf(            "    INDEX 01 %s\n", index0);
         fprintf(fdCueFile, "    INDEX 01 %s\n", index0);
      }
      blank = 1;
      for(i = 0; i < SIZERAW; i+=2) {
         value = buf[i+1];
         value = ((value << 8) | buf[i]);
//         printf("%f %i\n",(1.0/75)*binIndex, value);
         if(abs(value) > valueThreshold) {
            blank = 0;
            break;
         }
      }
//      if(i == SIZERAW) printf("%f ~blank~\n", (1.0/75)*binIndex);
      if(blank == 1) count++;
      else if (gapon == 1) {
         gapon = 0; 
         unIndex(binIndex-count, index0);
         count = 0;
         unIndex(binIndex, index1);
         printf(            "  TRACK %02d %s\n", track, mode);
         fprintf(fdCueFile, "  TRACK %02d %s\n", track, mode);
         printf(            "    INDEX 00 %s\n", index0);
         fprintf(fdCueFile, "    INDEX 00 %s\n", index0);
         printf(            "    INDEX 01 %s\n", index1);
         fprintf(fdCueFile, "    INDEX 01 %s\n", index1);
      }
      
      if((count > gapThreshold) && (gapon == 0)) {
         gapon = 1; track++;
         trackIndex = -1;
      } 
      
      memset( buf, '\0', sizeof( buf ) );
      binIndex++;      
      trackIndex++;
   }
}

// return 0 to when no data found, 1 when there is.
int checkGaps(FILE *fdBinFile, tTrack tracks[], int nTracks) {
   int i, k;
   unsigned long int j;
   unsigned char buf[SIZERAW];
   int c = 0;
   int writegap = 0;
   short value;
   int count;

   if(nTracks == 2) { return 0; }; // don't need to bother with single track images

   printf("Checking gap data:\n");

   for (i = 0; i < nTracks; i++) {
      if((tracks[i].offset0 != tracks[i].offset1) && (tracks[i-1].mode == AUDIO)) {
         if(0 != fseek(fdBinFile, tracks[i].offset0, SEEK_SET)) { 
            perror("\nbin2iso(fseek)"); exit(1);
         }
         count = 0;
         for(j = tracks[i].idx0; j < tracks[i].idx1; j++) {
            if(0 == fread( buf, SIZERAW, 1, fdBinFile ) ) {
               perror("bin2iso(fread)");
               exit(1);
            }
            for(k = 0; k < SIZERAW; k+=2) {
               value = buf[k+1];
               value = ((value << 8) | buf[k]);
               if(value != 0) { 
                  count++;

                // printf("%10d: %2x\n", count ,value );
               }
            }
         }
         if(count != 0) {
            printf("   Track%02d - %d values of Non-Zero gap data encountered\n", i-1, count);
            if((count > SIZERAW/2/2) && (writegap == 0)) {
               printf("   -->Threashold reached\n"); writegap = 1;
            }
         }
      }
   }
   return writegap; 
}   

/* /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/ */

int   main(int argc, char **argv) {
   unsigned long int count = 0;
//   int printon = 0;

   char sLine[256];
   int i,j,q;
   
//   int writegap = -1;   // auto detect pregap data action by default. 
   int writegap = 1;   // keep pregap data by default. 
   int no_overburn = 0; 
   int createCue = 0; 
   char sTrack[3] = "00"; 
   int doOneTrack = 0;
   int doInPlace = 0;
         
   tTrack trackA;
   tTrack trackB;
   
   tTrack tracks[100];
   int nTracks = 0;
   
   char sOutdir[192];

   sOutFilename[0] = '\0';

   /* Tell them what I am. */
   printf ("\n%s, %s", __DATE__, __TIME__);
   printf ("\nbin2iso V1.9b - Converts RAW format (.bin) files to ISO/WAV format"); 
   printf ("\n               Bob Doiron, ICQ#280251                     \n");
   printf ("\nCheck for updates at http://users.andara.com/~doiron\n\n");
   if(argc < 2) {
      printf("Usage: bin2iso <cuefile> [<output dir>] [-[a]wg] [-t XX] [-i] [-nob]\n");
      printf("or   : bin2iso <cuefile> -c <binfile>\n");
      printf("\n");
      printf("Where:\n");
      printf("   <cuefile>    - the .cue file that belongs to the .bin file to \n");
      printf("                  be converted\n");
      printf("   <output dir> - the output directory (defaults to current dir) \n");
      printf("   -nwg         - indicates that audio data found in the track   \n");
      printf("                  'gaps' shouldn't be appended to the audio tracks\n");
      printf("   -awg         - looks for non-zero data in the 'gaps', if found\n");
      printf("                  then gaps are appended to audio tracks. Looks  \n");
      printf("                  for more than 1/2 of a sector of non-zero values\n");
      printf("                  (%d values),                                   \n", SIZERAW/2/2);
      printf("   -t XX        - Extracts the XX'th track.                      \n");
      printf("   -i           - Performs the conversion 'in place'. Meaning it \n");
      printf("                  truncates the binfile after each track is      \n");
      printf("                  created to minimize diskspace requirements.    \n");
      printf("                  [not valid with -t]                            \n");
      printf("   -nob         - Doesn't use overburn data past %ld sectors.    \n", CD74_MAX_SECTORS);
      printf("                  This of course presumes that the data is not   \n");
      printf("                  useful.                                        \n");
      printf("   -c           - Attempts to create a <cuefile> from an existing\n");
      printf("                  <binfile>                                      \n");
      exit (1);
   }

   strcpy(sOutdir, "./"); // default path

   printf("\n");
   for (i=2; i < argc; i++) {
      if (argv[i][0] == '-') {
         /* if (strncmp(&(argv[i][1]), "wg", 2)==0) {
            writegap = 1; 
         } else */ 
         
         if (strncmp(&(argv[i][1]), "awg", 3)==0) {
            writegap = -1; 
            printf("Note: Auto-detecting pregap data\n");         
         } else if (strncmp(&(argv[i][1]), "nwg", 3)==0) {
            writegap = 0;          
         } else if (strncmp(&(argv[i][1]), "m2to1", 5)==0) {
            mode2to1 = 1;
            printf("Note: Converting Mode2 ISO to Mode1\n");
         } else if (strncmp(&(argv[i][1]), "t", 1)==0) {
            strcpy(sTrack, argv[i+1]);
            doOneTrack = 1;
            i++;
         } else if (strncmp(&(argv[i][1]), "i", 1)==0) {
            if(doOneTrack == 1) { printf("Invalid combination of options...\n"); exit(1); }
            printf("Bin file will be truncated after each track created\n");
            doInPlace = 1;
         } else if (strncmp(&(argv[i][1]), "c", 1)==0) {
            createCue = 1;
            strcpy(sBinFilename, argv[i+1]);
            i++;
         } else if (strncmp(&(argv[i][1]), "nob", 3)==0) {
            no_overburn = 1;
         }
      } else {
         strcpy(sOutdir, argv[2]);
      }
   }
   
   if(createCue == 1) {
      fdBinFile = fopen (sBinFilename, "rb");
      if (fdBinFile == NULL) {
         printf ("Unable to open %s\n", sBinFilename);
         exit (1);
      } 
      fdCueFile = fopen (argv[1], "w");
      if (fdCueFile == NULL) {
         printf ("Unable to create %s\n", argv[1]);
         exit (1);
      } 

      if((strcmp(&sBinFilename[strlen(sBinFilename)-4], ".wav")==0) ||
         (strcmp(&sBinFilename[strlen(sBinFilename)-4], ".WAV")==0) ) {
         printf(".wav binfile - Skipping wav header\n");
         fread( sLine, 1, sizeof(tWavHead), fdBinFile );
      }

      doCueFile();

   } else {   
      fdCueFile = fopen (argv[1], "r");      
      if (fdCueFile == NULL) {
         printf ("Unable to open %s\n", argv[1]);
         exit (1);
      } 

      // get bin filename from cuefile... why? why not.
      if(! fgets( sLine, 256, fdCueFile ) ) {
         printf ("Error Reading Cuefile\n");
         exit (1);
      }
      if (strncmp(sLine, "FILE ", 5)==0) {
         i = 0;
         j = 0;
         q = 0; // track open and closed quotes
         do { 
            sBinFilename[j] = sLine[5+i]; 
            i++;
            j++;
            if ((sBinFilename[j-1] == '\\') || (sBinFilename[j-1] == '/')) { j = 0; } //strip out path info
            if (sBinFilename[j-1] == '"') { j--; q++;} // strip out quotes
         } while ((sLine[5+i-1] != ' ') || (q == 1));
         sBinFilename[j] = '\0';
         //bug?? Why did a trailing space show up??
         while(sBinFilename[--j] == ' ') sBinFilename[j] = '\0';

// do not need to convert to lower case on unix system
//         strlwr(sBinFilename);

      } else {
         printf ("Error: Filename not found on first line of cuefile.\n", argv[1]);
         exit (1);
      }
   
      // Open the bin file
      if(doInPlace == 1) {
         fdBinFile = fopen (sBinFilename, "rb+");
      } else {
         fdBinFile = fopen (sBinFilename, "rb");
      }
      if (fdBinFile == NULL) {
         printf ("Unable to open %s\n", sBinFilename);
         perror("\nbin2iso(fopen)");
         exit(1);
      }

      // Get next line
      if(! fgets( sLine, 256, fdCueFile ) ) {
         printf ("Error Reading Cuefile\n");
         exit (1);
      } 
   
      if(strlen(sOutdir) > 0) {
         if((sOutdir[strlen(sOutdir)-1] != '/' ) && (sOutdir[strlen(sOutdir)-1] != ':' ) ) {
            strcat(sOutdir, "/");
         }
      }
   
      while(!feof(fdCueFile)) {
         getTrackinfo(sLine, &tracks[nTracks++]);
      }
      tracks[nTracks].idx0 = tracks[nTracks].idx1 = -1;

      switch (tracks[0].mode) {
         case MODE1_2048:
            tracks[0].offset0 = tracks[0].idx0*SIZEISO_MODE1;
            break;
         case MODE2_2336:
            tracks[0].offset0 = tracks[0].idx0*SIZEISO_MODE2_FORM2;
            break;
         default:  // AUDIO, MODE1_2352, MODE2_2352:
            tracks[0].offset0 = tracks[0].idx0*SIZERAW;
            break;
      }               
      /* set offsets */

      
      if(0 != fseek(fdBinFile, 0, SEEK_END)) { 
         perror("\nbin2iso(fseek)"); exit(1);
      }

      tracks[nTracks].offset0 = tracks[nTracks].offset1 = ftell(fdBinFile);

      for(i = 0; i < nTracks; i++) {
         switch (tracks[i].mode) {
            case MODE1_2048:
               tracks[i].offset1 = tracks[i].offset0   + (tracks[i].idx1-tracks[i].idx0)*SIZEISO_MODE1;
               if(tracks[i+1].idx0 != -1)
                  tracks[i+1].offset0 = tracks[i].offset1 + (tracks[i+1].idx0 - tracks[i].idx1)*SIZEISO_MODE1;
               else {
                  tracks[i+1].idx0 = tracks[i+1].idx1 = (tracks[i+1].offset0 - tracks[i].offset1)/SIZEISO_MODE1 + tracks[i].idx1;
                  if(((tracks[i+1].offset0 - tracks[i].offset1)%SIZEISO_MODE1) != 0) printf("Warning: Bin file has invalid byte count for cuefile.\n");
               }
               break;
            case MODE2_2336:
               tracks[i].offset1 = tracks[i].offset0   + (tracks[i].idx1-tracks[i].idx0)*SIZEISO_MODE2_FORM2;
               if(tracks[i+1].idx0 != -1)
                  tracks[i+1].offset0 = tracks[i].offset1 + (tracks[i+1].idx0 - tracks[i].idx1)*SIZEISO_MODE2_FORM2;
               else {
                  tracks[i+1].idx0 = tracks[i+1].idx1 = (tracks[i+1].offset0 - tracks[i].offset1)/SIZEISO_MODE2_FORM2 + tracks[i].idx1;
                  if(((tracks[i+1].offset0 - tracks[i].offset1)%SIZEISO_MODE2_FORM2) != 0) printf("Warning: Bin file has invalid byte count for cuefile.\n");
               }
               break;
            default:  // AUDIO, MODE1_2352, MODE2_2352:
               tracks[i].offset1 = tracks[i].offset0   + (tracks[i].idx1-tracks[i].idx0)*SIZERAW;
               if(tracks[i+1].idx0 != -1)
                  tracks[i+1].offset0 = tracks[i].offset1 + (tracks[i+1].idx0 - tracks[i].idx1)*SIZERAW;
               else {
                  tracks[i+1].idx0 = tracks[i+1].idx1 = (tracks[i+1].offset0 - tracks[i].offset1)/SIZERAW + tracks[i].idx1;
                  if(((tracks[i+1].offset0 - tracks[i].offset1)%SIZERAW) != 0) printf("Warning: Bin file has invalid byte count for cuefile.\n");
               }
               break;
         }
      }

      // if not allowing overburn, then create a new track to hold extra data...
      if(no_overburn == 1) {
         i = nTracks;
         if(tracks[i].idx0 > CD74_MAX_SECTORS) {
            tracks[i+1] = tracks[nTracks];
            strcpy(tracks[i].name, "obdatatemp.bin");
            tracks[i].idx0 = CD74_MAX_SECTORS;
            tracks[i].idx1 = CD74_MAX_SECTORS;
            switch (tracks[i-1].mode) {
               case MODE1_2048:
                  tracks[i].offset0 = tracks[i-1].offset1 + (tracks[i].idx0 - tracks[i-1].idx1)*SIZEISO_MODE1;
                  break;
               case MODE2_2336:
                  tracks[i].offset0 = tracks[i-1].offset1 + (tracks[i].idx0 - tracks[i-1].idx1)*SIZEISO_MODE2_FORM2;
                  break;
               default:  // AUDIO, MODE1_2352, MODE2_2352:
                  tracks[i].offset0 = tracks[i-1].offset1 + (tracks[i].idx0 - tracks[i-1].idx1)*SIZERAW;
                  break;
            }
            tracks[i].offset1 = tracks[i].offset0;
            tracks[i].mode = tracks[i-1].mode;
            nTracks++;
         }
      }

      
      /* set sizes */
      for(i = 0; i < nTracks; i++) {
         switch (tracks[i].mode) {
            case MODE1_2352:
               tracks[i].size = ((tracks[i+1].offset1 - tracks[i].offset1) / SIZERAW ) * SIZEISO_MODE1;
               break;
            case MODE2_2336:
               tracks[i].size = ((tracks[i+1].offset1 - tracks[i].offset1) / SIZEISO_MODE2_FORM2 ) * SIZERAW;
               break;
            default: // MODE1_2048, MODE2_2352, AUDIO
              tracks[i].size = tracks[i+1].offset1 - tracks[i].offset1;
              break;
         }
      }

      if(writegap == -1)  { writegap = checkGaps(fdBinFile, tracks, nTracks); }

      if(writegap == 1) 
         printf("Note: Appending pregap data to end of audio tracks\n");
      else 
         printf("Note: Discarding pregap data\n");

      printf("\n");
      for(i = 0; i <= nTracks-1; i++) {
         printf("%s (%3d Mb) - sectors %06ld:%06ld (offset %09ld:%09ld)\n", 
            tracks[i].name, 
            tracks[i].size/(1024*1024), 
            tracks[i].idx1, 
            ( ((writegap == 0) || (tracks[i].mode != AUDIO)) ? tracks[i+1].idx0 : tracks[i+1].idx1)-1, 
            tracks[i].offset1, 
            ( ((writegap == 0) || (tracks[i].mode != AUDIO)) ? tracks[i+1].offset0 : tracks[i+1].offset1)-1 
         );
      }
      printf("\n");

      if( (((mode2to1 != 1) && (tracks[0].mode == MODE2_2352)) || (tracks[0].mode == MODE1_2048)) && (nTracks == 1) ) {
         if(tracks[0].mode == MODE2_2352) { printf("Mode2/2352"); }
         if(tracks[0].mode == MODE1_2048) { printf("Mode1/2048"); }
         printf(" single track bin file indicated by cue file\n");   
         fclose(fdBinFile);
         if( 0 != rename(sBinFilename, tracks[0].name) ) {
            perror("\nbin2iso(rename)");
            exit(1);
         }
         printf("%s renamed to %s\n", sBinFilename, tracks[0].name);
         fclose(fdCueFile);
         return(0);
      }

      for(i=nTracks-1; i>=0; i--) {
         trackA = tracks[i];         
         trackB = tracks[i+1];
         // audio can't be done in the bin file due to header.
         // 2336 can't either because it's expanded to 2352
         if((doInPlace == 1) && (i == 0) && (trackA.mode != AUDIO) && (trackA.mode != MODE2_2336) ) {
            sOutFilename[0] = '\0';
         } else {
            strcpy(sOutFilename, sOutdir); 
            strcat(sOutFilename, trackA.name);
         }
         if ( ((doOneTrack == 1) && strcmp(trackA.num, sTrack)==0) || (doOneTrack == 0) ) {

            if(!((i == 0) && ((trackA.mode == MODE2_2352)||(trackA.mode == MODE1_2048)) && (doInPlace == 1) )){
               if (!writegap || (trackA.mode != AUDIO)) { // when not Audio, don't append.
                  dotrack(trackA.mode, trackA.idx0, trackA.idx1, trackB.idx0, trackA.offset1);
               } else {
                  /* if(trackA.idx0 == 0) // handles first track with pregap.
                     dotrack(trackA.mode,           0, trackA.idx1, trackB.idx1, trackA.offset1);
                  else
                  */
                  dotrack(trackA.mode, trackA.idx1, trackA.idx1, trackB.idx1, trackA.offset1);
               }
            }
         } /*else {
            fclose(fdBinFile); // just close bin file. Already MODE1_2048 or MODE2_2352
         }*/
         if( (doOneTrack == 0) && (doInPlace == 1) ) {
            if( (i != 0) || ( (i == 0) && ((trackA.mode == AUDIO)||(trackA.mode == MODE2_2336)) ) ) {
               printf("Truncating bin file to %ld bytes\n", trackA.offset1);
               if( -1 == ftruncate(fileno(fdBinFile), trackA.offset1) ) {
                  perror("\nbin2iso(_chsize)");
                  exit(1);
               }
            } else {
               printf("Renaming %s to %s\n", sBinFilename, trackA.name);
               fclose(fdBinFile);
               if( 0 != rename(sBinFilename, trackA.name) ) {
                  perror("\nbin2iso(rename)");
                  exit(1);
               }
            
               // fix writepos for case when simply truncating...
               if((trackA.mode == MODE2_2352) || (trackA.mode == MODE1_2048)){ writepos = trackB.offset0; }

               printf("Truncating to %ld bytes\n", writepos);
            
               fdBinFile = fopen(trackA.name, "rb+"); // gets closed in doTrack...
               if(fdBinFile == NULL) { perror("bin2iso(fopen)"); exit(1); }

               if( -1 == ftruncate(fileno(fdBinFile), writepos) ) {
                  perror("\nbin2iso(_chsize)");
                  exit(1);
               }
            }
         }
      }   
   }
   fclose(fdCueFile);
   fclose(fdBinFile);
   return(0);  
}



