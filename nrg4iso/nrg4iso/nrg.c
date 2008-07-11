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

#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <errno.h>
#include <assert.h>

#include "nrg.h"
#include "nrg_chunks.h"
#include "globals.h"
#include "endian.h"

// The Nero image header is located at the very end of the file and
// is a variation of the Interchange File Format (IFF).
// Header data is stored in named chunks with integer values in big
// endian byte order.
// The offset to the first chunk in the header is stored in the
// last chunk.  This chunk is referred to as the file header.
// The file header can be read from the last 8 or 12 bytes of the
// file depending on the version of the image.

chunkname_t nrg_chunknames[][NRG_NUMV] =
{
    { "NERO", "NER5" },
    { "CUES", "CUEX" },
    { "ETNF", "ETN2" },
    { "DAOI", "DAOX" },
    { "SINF", "SINF" },
    { "END!", "END!" }
};

char* nrg_imgtypename[] =
{
    "DAO (Disc at once)",
    "TAO (Track at once)"
};

enum NRG_Error { NRG_ERROK, NRG_ERRIMG, NRG_ERRSYS };
char* nrg_errortxt[] =
{
    "No error",
    "Not a Nero image file"
};

int nrg_errno = 0;

inline int _nrg_matchchunk(chunkname_t* a_name1, chunkname_t* a_name2)
{
    assert(a_name1 && a_name2);

    return (*(uint32_t*)a_name1) == (*(uint32_t*)a_name2);
}

int _nrg_getchunktype(chunkname_t* a_name, int* a_type)
{
    int ver;

    for (*a_type = NRG_NEROB; *a_type < NRG_NUMB; (*a_type)++)
    {
	for (ver = NRG_V1; ver < NRG_NUMV; ver++)
	{
	    if (_nrg_matchchunk(a_name, &nrg_chunknames[*a_type][ver]))
	    {
		return AOK;
	    }
	}
    }

    return ERROR;
}

int _nrg_ischunktype(chunkname_t* a_name, int a_type)
{
    int type;
    _nrg_getchunktype(a_name, &type);
    return (type == a_type);
}

inline int _nrg_getversion(chunkname_t* a_nero, int* a_version)
{
    assert(a_nero && a_version);

    // Chunk identifier should be 'NERO' for any image
    // made by pre 5.5 Nero, this is referred to as v1.
    // From 5.5 and on 'NER5' is used to identify the
    // new format referred to as v2.

    int i;

    for (i = 0; i < NRG_NUMV; i++)
    {
	if (_nrg_matchchunk(a_nero, &nrg_chunknames[NRG_NEROB][i]))
	{
	    *a_version = i;
	    return AOK;
	}
    }

    return ERROR;
}

int _nrg_initialize(NRG_t* a_nrg)
{
    char data[sizeof(nrg_ner5_t)];
    //nrg_nero_t* v1header = (nrg_nero_t*) &data[4];
    nrg_ner5_t* v2header = (nrg_ner5_t*) &data[0];

    assert(a_nrg);

    // Read the last 12 bytes of the file into header struct
    lseek(a_nrg->file_handle, (int) (0 - sizeof(data)), SEEK_END);
    if (sizeof(data) == read(a_nrg->file_handle, &data, sizeof(data)))
    {
	a_nrg->hdr_offset = be64toh(v2header->offset);

	// Get chunk version
	if ((_nrg_getversion(&v2header->id, &a_nrg->img_version)) && (_nrg_getversion(&v2header->id, &a_nrg->img_version)))
	{
	    // Unsupported version or not a Nero image
	    return ERROR;
	}

	// Seek to the first chunk in the Nero header
	if (!nrg_seek2header(a_nrg))
	{
	    int size = 4096;
	    char chunk[size];
	    int type;

	    // Get the type of the first chunk in order
	    // to determine if this is a disk- or track
	    // at once image.
	    type = NRG_ANYB;
	    if (!nrg_readchunk(a_nrg, &type, (void*) &chunk, &size))
	    {
		switch (type)
		{
		    case NRG_CUESB:
			// Disk at once
			a_nrg->img_type = NRG_DAO;
			break;
		    case NRG_ETNFB:
			// Track at once
			a_nrg->img_type = NRG_TAO;
			break;
		    default:
			// Unsupported version
			return ERROR;
		}

		// Count the number of SINFB block to get
		// the number of disk sessions present
		type = NRG_SINFB;
		while (!nrg_readchunk(a_nrg, &type, (void*) &chunk, &size))
		{
		    a_nrg->img_sessions++;
		}

		return AOK;
	    }
	}
    }

    return ERROR;
}

char* nrg_strerror(const int a_errno)
{
    if ((a_errno >= NRG_ERROK) && (a_errno < NRG_ERRSYS))
    {
	return nrg_errortxt[a_errno];
    }

    if (a_errno == NRG_ERRSYS)
    {
	return strerror(errno);
    }

    return NULL;
}

int nrg_openimage(const char* a_path, NRG_t* a_nrg)
{
    assert(a_path && a_nrg);

    memset(a_nrg, 0, sizeof(NRG_t));
    a_nrg->file_path = strdup(a_path);
    a_nrg->file_handle = open(a_path, O_RDONLY, 0);

    if (ERROR != a_nrg->file_handle)
    {
	nrg_errno = NRG_ERRIMG;
	return _nrg_initialize(a_nrg);
    }

    nrg_errno = NRG_ERRSYS;
    return ERROR;
}

int nrg_closeimage(NRG_t* a_nrg)
{
    assert(a_nrg);

    if (a_nrg->file_path)
    {
	free(a_nrg->file_path);
    }

    close(a_nrg->file_handle);

    return AOK;
}

int nrg_seek2header(NRG_t* a_nrg)
{
    assert(a_nrg);

    nrg_errno = NRG_ERRSYS;
    return (a_nrg->hdr_offset != lseek(a_nrg->file_handle, a_nrg->hdr_offset, SEEK_SET));
}

int nrg_readchunk(NRG_t* a_nrg, int* a_type, void* a_chunk, int* a_size)
{
    assert(a_nrg);
    assert(a_type);
    assert(a_size);

    nrg_chunkheader_t blkhead;
    int offset;

    nrg_errno = NRG_ERRSYS;
    offset = lseek(a_nrg->file_handle, 0, SEEK_CUR);
    
searchloop:
    if (sizeof(blkhead) == read(a_nrg->file_handle, (void*) &blkhead, sizeof(blkhead)))
    {
	blkhead.size = be32toh(blkhead.size);
	if ((*a_type != NRG_ANYB) && (!_nrg_ischunktype(&blkhead.id, *a_type)))
	{
	    // Not the chunk being searched for.  Skip file pointer
	    // forward to point to the nect chunk in chain.
	    offset = lseek(a_nrg->file_handle, blkhead.size, SEEK_CUR);
	    goto searchloop;
	}
	nrg_errno = NRG_ERROK;

	// Set the chunk type
	_nrg_getchunktype(&blkhead.id, a_type);

	// If the supplied buffer size is smaller than
	// the chunk size we must fail the call.
	// The only exeption is when the supplied size
	// is set to zero in which case we return the
	// size required to satisfy the call.
	if (*a_size < blkhead.size || !a_chunk)
	{
	    // Reset the filepointer so that a subsequent
	    // call will still address this chunk.
	    lseek(a_nrg->file_handle, offset, SEEK_SET);
	    if (*a_size)
	    {
		// Supplied buffer is too small
		return ERROR;
	    }

	    // Return the required buffer size
	    *a_size = blkhead.size;
	    return AOK;
	}
	else
	{
	    if (blkhead.size == read(a_nrg->file_handle, a_chunk, blkhead.size))
	    {
		return AOK;
	    }
	}
    }

    return ERROR;
}

int nrg_trackdata(NRG_t* a_nrg, int a_session, int a_track, uint64_t* a_offset, uint64_t* a_length)
{
    int size = 4096;
    char chunk[size];
    int type;

    assert(a_nrg);
    assert(a_offset);
    assert(a_length);

    // Currently only the first session and
    // first track is supported
    assert((a_session == 1) && (a_track == 1));

    switch (a_nrg->img_type)
    {
	case NRG_DAO:
	    {
		type = NRG_DAOIB;
		if (!nrg_readchunk(a_nrg, &type, (void*) &chunk, &size))
		{
		    switch (a_nrg->img_version)
		    {
			case NRG_V1:
			    *a_offset = be32toh(*((uint32_t*) &chunk[44]));
			    *a_length = be32toh(*((uint32_t*) &chunk[48])) - *a_offset;
			    break;
			case NRG_V2:
			    *a_offset = be64toh(*((uint64_t*) &chunk[48]));
			    *a_length = be64toh(*((uint64_t*) &chunk[56])) - *a_offset;
			    break;
		    }
		}
		break;
	    }
	case NRG_TAO:
	    {
		type = NRG_ETNFB;
		if (!nrg_readchunk(a_nrg, &type, (void*) &chunk, &size))
		{
		    switch (a_nrg->img_version)
		    {
			case NRG_V1:
			    *a_offset = be32toh(*((uint32_t*) &chunk[0]));
			    *a_length = be32toh(*((uint32_t*) &chunk[4]));
			    break;
			case NRG_V2:
			    *a_offset = be64toh(*((uint64_t*) &chunk[0]));
			    *a_length = be64toh(*((uint64_t*) &chunk[8]));
			    break;
		    }
		}
		break;
	    }
    }

    return AOK;
}
