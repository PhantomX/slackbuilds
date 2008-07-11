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
#include <stdio.h>
#include <stdarg.h>
#include <fcntl.h>
#include <string.h>
#include <libgen.h>
#include <errno.h>

#include "iso.h"
#include "nrg.h"
#include "globals.h"

char* app_name = "nrg4iso";
int app_verhi = 1;
int app_verlo = 0;

int quietmode = false;

enum { BlockSize = 16384 };

void print(const char* a_format, ...)
{
    if (!quietmode)
    {
	va_list ap;
	va_start(ap, a_format);
	vprintf(a_format, ap);
	va_end(ap);
    }
}

int extend_data(int a_dst, int a_length)
{
    char dataBuff[BlockSize];
    void* voidBuff = (void*) &dataBuff;
    int bytes;
    int i = a_length;

    print("[1KEMExtending image..\n\n");

    // Clear the buffer
    memset(&dataBuff, 0, BlockSize);

    while  (i > 0)
    {
	if (i > BlockSize)
	{
	    bytes = BlockSize;
	}
	else
	{
	    bytes = i;
	}

	i -= bytes;

	if (ERROR == write(a_dst, voidBuff, bytes))
	{
	    return ERROR;
	}
    }

    return AOK;
}

int copy_data(int a_src, int a_dst, int a_length)
{
    int i = a_length;

    while (i > 0)
    {
	char dataBuff[BlockSize];
	void* voidBuff = (void*) &dataBuff;
	int bytes;

	print("[1KEMExtracting %i%%", (int ) (((float) (a_length - i) / (float) a_length) * 100));

	if (i > BlockSize)
	{
	    bytes = BlockSize;
	}
	else
	{
	    bytes = i;
	}

	i -= bytes;

	if (ERROR == read(a_src, voidBuff, bytes))
	{
	    return ERROR;
	}

	if (ERROR == write(a_dst, voidBuff, bytes))
	{
	    return ERROR;
	}
    }

    return AOK;
}

int main(int argc, char** argv)
{
    int argoffset = 1;
    char ch;

    NRG_t nrgimg;
    int isofile;

    while (-1 != (ch = getopt(argc, argv, "qv")))
    {
	switch (ch)
	{
	    case 'q':
		quietmode = true;
		break;
	    case 'v':
		printf("%s v%i.%i (%s)\n", app_name, app_verhi, app_verlo, __DATE__);
	}
	argoffset++;
    }

    if ((argc - argoffset) < 2)
    {
	printf("usage: %s [-qv] <nrg image> <iso image>\n", basename(argv[0]));
	exit(-1);
    }

    if (nrg_openimage(argv[argoffset], &nrgimg))
    {
	fprintf(stderr, "error: error reading source file (%s)\n", nrg_strerror(nrg_errno));
	exit(1);
    }

    argoffset++;
    isofile = open(argv[argoffset], O_WRONLY | O_CREAT | O_TRUNC, 0664);
    if (0 > isofile)
    {
	fprintf(stderr, "error: error creating target file (%s)\n", strerror(errno));
	exit(1);
    }

    print("[1mSource is a Nero %s image with %i session(s).[0m\n", nrg_imgtypename[nrgimg.img_type], nrgimg.img_sessions);

    // Disable buffering for stdout to enable use of progress bar
    setvbuf(stdout, NULL, _IONBF, 0);

    if (AOK == nrg_seek2header(&nrgimg))
    {
	PVD_t isopvd;
	uint64_t trk_offset;
	uint64_t nrg_length;
	uint32_t iso_length;
	int session = 1;
	int track = 1;

	// Get the offset and length of the first track os a session.
	// We currently only search the first track of the first session.
	nrg_trackdata(&nrgimg, session, track, &trk_offset, &nrg_length);

	// Seek to the offset of the track
	lseek(nrgimg.file_handle, trk_offset, SEEK_SET);

	// Seek to the offset of the PVD inside the current track and
	// read the PVD into a local buffer.
	iso_seek2pvd(nrgimg.file_handle);
	iso_readpvd(nrgimg.file_handle, &isopvd);

	// Verify that the PVD really is a valid PVD
	if (AOK == iso_verifypvd(&isopvd))
	{
	    uint32_t copy_length;
	    uint32_t fill_length;

	    // We have found a track with a valid ISO image inside.
	    // Reset the file pointer to the start of the track.
	    lseek(nrgimg.file_handle, trk_offset, SEEK_SET);

	    // Get the size of the iso from the PVD
	    iso_length = iso_volumesize(&isopvd);
	    print("\nVolume ID: %.32s\n", isopvd.volumeId);
	    print("ISO size: %u MB (%u B)\n",  iso_length >> 20, iso_length);

	    copy_length = iso_length;
	    fill_length = 0;

	    if (iso_length != nrg_length)
	    {
		print("NRG size: %llu MB (%llu B)\n",  (nrg_length >> 20), nrg_length);
		print("Inconsistent image size in ISO and NRG headers.  ISO size will be used.\n");

		if (iso_length > nrg_length)
		{
		    copy_length = nrg_length;
		    fill_length = (iso_length - nrg_length);
		}
	    }

	    if (copy_length)
	    {
		if (copy_data(nrgimg.file_handle, isofile, copy_length))
		{
		    print("[1KEMError copying data!\n\n");
		}
	    }

	    if (fill_length)
	    {
		if (extend_data(isofile, fill_length))
		{
		    print("[1KEMError extending data!\n\n");
		}
	    }

	    print("[1KEMFinished!\n\n");
	}
    }

    return 0;
}
