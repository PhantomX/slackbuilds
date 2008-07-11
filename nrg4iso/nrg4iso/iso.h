/*
Copyright (c) 2007, Martin Akesson, Placid.TV

All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

  * Redistributions of source code must retain the above copyright
    notice, this list of conditions and the following disclaimer. 
  * Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in
    the documentation and/or other materials provided with the
    distribution. 

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#ifndef __ISO_H
#define __ISO_H

#include <sys/types.h>
#include "globals.h"

enum { ISOBlockSize = 2048 };
enum { PVDOffset = 16 };
enum VolumeDescriptors { VDBoot= 0, VDPrimary  = 1, VDSupplementary  = 2, VDPartition  = 3, VDTermination  = 255 };

extern const char* ISO_STD_ID;

typedef struct
{
    uint8_t  VDType;
    char     VSStdId[5];
    uint8_t  Version;
    uint8_t  volumeFlags;
    char     systemId[32];
    char     volumeId[32];
    char     reserved2[8];
    uint32_t lsbVolumeSpaceSize;
    uint32_t msbVolumeSpaceSize;
    char     escapeSequences[32];
    uint16_t lsbVolumeSetSize;
    uint16_t msbVolumeSetSize;
    uint16_t lsbVolumeSetSequenceNumber;
    uint16_t msbVolumeSetSequenceNumber;
    uint16_t lsbLogicalBlockSize;
    uint16_t msbLogicalBlockSize;
    uint32_t lsbPathTableSize;
    uint32_t msbPathTableSize;
    uint32_t lsbPathTable1;
    uint32_t lsbPathTable2;
    uint32_t msbPathTable1;
    uint32_t msbPathTable2;
    char     rootDirectoryRecord[34];
    char     volumeSetId[128];
    char     publisherId[128];
    char     dataPreparerId[128];
    char     applicationId[128];
    char     copyrightFileId[37];
    char     abstractFileId[37];
    char     bibliographicFileId[37];
    char     volumeCreation[17];
    char     volumeModification[17];
    char     volumeExpiration[17];
    char     volumeEffective[17];
    char     FileStructureStandardVersion;
    char     Reserved4;
    char     ApplicationUse[512];
    char     FutureStandardization[653];
} PVD_t;

int iso_seek2pvd(int a_file);
int iso_readpvd(int a_file, PVD_t* a_pvd);
int iso_verifypvd(PVD_t* a_pvd);

inline int iso_blocksize(PVD_t* a_pvd);
inline int iso_volumesize(PVD_t* a_pvd);

#endif
