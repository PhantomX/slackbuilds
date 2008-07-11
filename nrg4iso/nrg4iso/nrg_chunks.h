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

#ifndef __NRG_CHUNKS_H
#define __NRG_CHUNKS_H

typedef char chunkname_t[4];

typedef struct 
{
    chunkname_t id;
    uint32_t size;
} nrg_chunkheader_t;

// NERO chunk
typedef struct 
{
    chunkname_t id;
    uint32_t offset;
} nrg_nero_t;

// NER5 chunk
typedef struct 
{
    chunkname_t id;
    uint64_t offset;
} nrg_ner5_t;

// DAOI chunk track
typedef struct
{
    char     unknown1[10];
    uint32_t sector_size;
    uint32_t mode;
    uint32_t index0;
    uint32_t index1;
    uint32_t next_index;
} __attribute__((__packed__)) nrg_daoi_trk_t;

// DAOI chunk structure
typedef struct
{
    uint32_t length;
    uint32_t unknown1;
    char     unknown2[14];
    uint8_t  toc_type;
    uint8_t  unknown3;
    uint8_t  first_track;
    uint8_t  last_track;
    nrg_daoi_trk_t trackdata[];
} __attribute__((__packed__)) nrg_daoi_t;

// DAOX chunk track
typedef struct
{
    char     unknown1[10];
    uint32_t sector_size;
    uint32_t mode;
    uint64_t index0;
    uint64_t index1;
    uint64_t next_index;
} __attribute__((__packed__)) nrg_daox_trk_t;

// DAOX chunk
typedef struct
{
    uint32_t length;
    uint32_t unknown1;
    char     unknown2[14];
    uint8_t  toc_type;
    uint8_t  unknown3;
    uint8_t  first_track;
    uint8_t  last_track;
    nrg_daox_trk_t trackdata[];
} __attribute__((__packed__)) nrg_daox_t;

// ETNF chunk
typedef struct
{
    uint32_t offset;
    uint32_t length;
    uint32_t mode;
    uint32_t start_lba;
    uint32_t unknown1;
} nrg_etnf_t;

// ETN2 chunk
typedef struct
{
    uint64_t offset;
    uint64_t length;
    uint32_t mode;
    uint32_t start_lba;
    uint32_t unknown1;
} nrg_etn2_t;

#endif
