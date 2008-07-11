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

#include <sys/types.h>
#include "endian.h"

inline uint16_t _bswap16(uint16_t a_int)
{
    return  (a_int >> 8) |
	    (a_int << 8);
}

inline uint32_t _bswap32(uint32_t a_int)
{
    return  ((a_int << 24) & 0xff000000 ) |
	    ((a_int <<  8) & 0x00ff0000 ) |
	    ((a_int >>  8) & 0x0000ff00 ) |
	    ((a_int >> 24) & 0x000000ff );
}

inline uint64_t _bswap64(uint64_t a_int)
{
    uint32_t l32, h32;

    h32 = bswap32((uint32_t)(a_int & 0x00000000ffffffffULL));
    l32 = bswap32((uint32_t)((a_int >> 32) & 0x00000000ffffffffULL));
    return ((uint64_t)h32 << 32) | l32;
}
