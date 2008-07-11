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

#ifndef __NRG_H
#define __NRG_H

#include "iso.h"
#include "globals.h"

enum NRG_Version { NRG_V1 = 0, NRG_V2, NRG_NUMV };
enum NRG_ImgType { NRG_DAO = 0, NRG_TAO };
enum NRG_ChunkType { NRG_ANYB = 0, NRG_NEROB = 0, NRG_CUESB, NRG_ETNFB, NRG_DAOIB, NRG_SINFB, NRG_ENDB, NRG_NUMB };

extern int nrg_errno;
extern char* nrg_imgversion[];
extern char* nrg_imgtypename[];

typedef struct
{
    char* file_path;
    int file_handle;
    int img_version;
    int img_type;
    int img_sessions;
    uint64_t hdr_offset;
} NRG_t;

char* nrg_strerror(const int a_errno);
int nrg_openimage(const char* a_path, NRG_t* a_nrg);
int nrg_seek2header(NRG_t* a_nrg);
int nrg_readchunk(NRG_t* a_nrg, int* a_type, void* a_chunk, int* a_size);

int nrg_trackdata(NRG_t* a_nrg, int a_session, int a_track, uint64_t* a_offset, uint64_t* a_length);

#endif
