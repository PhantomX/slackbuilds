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

#include <unistd.h>
#include <string.h>
#include <assert.h>

#include "iso.h"
#include "endian.h"

const char* ISO_STD_ID = "CD001";

// Seek to Primary Volume Descriptor from current file position
int iso_seek2pvd(int a_file)
{
    assert(a_file >= 0);

    if (ERROR == lseek(a_file, (ISOBlockSize * PVDOffset), SEEK_CUR))
    {
	return ERROR;
    }

    return AOK;
}

int iso_readpvd(int a_file, PVD_t* a_pvd)
{
    assert(a_file >= 0);
    assert(a_pvd);

    // Read Primary Volume Descriptor
    if (ISOBlockSize != read(a_file, (void*) a_pvd, ISOBlockSize))
    {
	return ERROR;
    }

    return AOK;
}


int iso_verifypvd(PVD_t* a_pvd)
{
    assert(a_pvd);
    if ((VDPrimary != a_pvd->VDType) || (strncmp(a_pvd->VSStdId, ISO_STD_ID, sizeof(ISO_STD_ID))) || (1 != a_pvd->Version))
    {
	return ERROR;
    }

    return AOK;
}

inline int iso_blocksize(PVD_t* a_pvd)
{
    assert(a_pvd);
    return be16toh(a_pvd->msbLogicalBlockSize);
}

inline int iso_volumesize(PVD_t* a_pvd)
{
    assert(a_pvd);
    return (be32toh(a_pvd->msbVolumeSpaceSize) * be16toh(a_pvd->msbLogicalBlockSize));
}
