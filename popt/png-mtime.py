#! /usr/bin/python -tt

#  This script takes a PNG file, and parses the GMT timestamp information from
# it. You can then print and/or alter the timestamp, and finally save the new
# timestamp information back to the PNG file.
#  See the __main__ section for API usage.
#
#  CMD line usage:
#      png-mtime.py <png-file> [reference-file]
#
#  If the reference file isn't there, it just prints the old timestamp.
#
#  Author: James Antill <james@fedoraproject.org>
#  Copyright: 2008
#  License: MIT, LGPL, new style BSD ... take your pick

import os
import sys
import binascii
import struct
import time
import calendar

_PNG_HEADER = "\x89PNG\r\n\x1A\n"

class PNG_time:
    """ For reading, displaying and setting a PNG's modification time. """

    _time_chunk = None
    year   = None
    month  = None
    day    = None
    hour   = None
    minute = None
    second = None

    def _read_header(self, fo):
        """ read header, and make sure this is a png """
        header = fo.read(8)
        if header != _PNG_HEADER:
            print >>sys.stderr, " Bad HEADER:", header
            sys.exit(1)
        self.chunks = 0
        self.off    = 0

    def _read_chunk(self, fo):
        """ read a chunk, and check the CRC. Then return tuple. """
        length    = struct.unpack(">I",  fo.read(4))[0]
        rawtype   = fo.read(4)
        chunktype = struct.unpack(">4s", rawtype)[0]
        rawdata   = fo.read(length)
        data      = struct.unpack(">%ss" % length, rawdata)[0]
        CRC       = struct.unpack(">i",  fo.read(4))[0]
        # Check the CRC
        chk_CRC = binascii.crc32(rawtype + rawdata)
        if CRC != chk_CRC:
            print >>sys.stderr, " Bad CRC: %d %d" % (CRC, chk_CRC)
            sys.exit(1)
        # print "JDBG: Chunk[%s] = %d %d" % (chunktype, length, CRC)
        self.chunks += 1
        self.off    += (4 * 3) + length
        return (chunktype, length, data, CRC)

    def _get_time(self, chunktype, length, data):
        """ Convert a tIME chunk into a time dict. """
        if chunktype != "tIME" or length != 7:
            return False
        if self._time_chunk is not None:
            print >>sys.stderr, " Mulitple tIME Chunks %d %d" % (self._time_chunk, self.chunks)
            sys.exit(1)
        self._time_chunk = self.chunks
        self._time_off   = self.off - length
        vals = struct.unpack(">Hbbbbb", data)
        self.year   = vals[0]
        self.month  = vals[1]
        self.day    = vals[2]
        self.hour   = vals[3]
        self.minute = vals[4]
        self.second = vals[5]
        return True

    def __init__(self, fname):
        self.fname = fname
        fo = open(fname)
        self._read_header(fo)
        T = "blah"
        while T != "IEND":
            (T,l,d,c) = self._read_chunk(fo)
            self._get_time(T, l, d)
        if self._time_chunk is None:
            print >>sys.stderr, " No tIME Chunks"
            sys.exit(1)

    def ymdhms(self):
        """ Returns a tuple of: year, month, day, hour, minute, second.
            Note that this is all that's stored in the file, and so should
            be in UTC time. """
        return (self.year, self.month,  self.day,
                self.hour, self.minute, self.second)

    def tm(self):
        """ Returns a tm tuple for the PNG timestamp data. 
            Note that this is in UTC, as though it's from time.gmtime(). """
        return (self.year, self.month,  self.day,
                self.hour, self.minute, self.second, 0, 0, 0)

    def time(self):
        """ Returns an Epoch time for the PNG timestamp data. """
        return calendar.timegm(self.tm())

    def save(self):
        """ Save the new timestamp information over the old in the PNG file. """
        fo = open(self.fname, "r+")

        fo.seek(self._time_off)

        ymdhms = self.ymdhms()
        rawdata = struct.pack(">4sHbbbbb", "tIME", *ymdhms)
        CRC = binascii.crc32(rawdata)
        rawCRC = struct.pack(">i", CRC)

        fo.write(rawdata)
        fo.write(rawCRC)
        fo.close()

    def utime(self):
        """ Set the st_mtime of the file to the timestamp in the PNG file. """
        os.utime(self.fname, (time.time(), self.time()))

    def set_time_from_file(self, fname):
        """ Set the PNG timestamp data based on a reference file. """
        tm = time.gmtime(os.stat(fname).st_mtime)
        self.year   = tm.tm_year
        self.month  = tm.tm_mon
        self.day    = tm.tm_mday
        self.hour   = tm.tm_hour
        self.minute = tm.tm_min
        self.second = tm.tm_sec

if __name__ == '__main__':
    png = PNG_time(sys.argv[1])
    # print "JDBG: chunks=%d" % png.chunks
    print "orig time =", time.ctime(png.time())
    if len(sys.argv) > 2:
        png.set_time_from_file(sys.argv[2])
        print "new  time =", time.ctime(png.time())
        png.save()
    # Reset the mtime of the file to the modified time of the PNG file.
    # People might consider it evil to always utime here, but hey!
    png.utime()
