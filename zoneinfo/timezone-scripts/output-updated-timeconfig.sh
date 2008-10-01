#!/bin/sh
# Copyright 2006  Patrick J. Volkerding, Sebeka, MN, USA.
# All rights reserved.
#
# Redistribution and use of this script, with or without modification, is
# permitted provided that the following conditions are met:
#
# 1. Redistributions of this script must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
#  THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED
#  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
#  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO
#  EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
#  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
#  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
#  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
#  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
#  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
#  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

if [ ! "$(basename "$1")" = "zoneinfo" -o ! -d "$1" ]; then
  echo "  Usage:  output-updated-timeconfig.sh <zoneinfo directory>"
  exit 1
fi

CWD=$(pwd)
cat $CWD/parts/00
# Sorry, I'd rather not be US-centric but some people here have a hard
# time finding things.  ;-)
( cd $1
  find . -type f | xargs file | grep "timezone data" | cut -f 1 -d : | cut -f 2- -d / | sort | grep "^US/" | while read zone ; do
    echo "\"${zone}\" \" \" \\"
  done
)
( cd $1
  find . -type f | xargs file | grep "timezone data" | cut -f 1 -d : | cut -f 2- -d / | sort | grep -v "^US/" | while read zone ; do
    echo "\"${zone}\" \" \" \\"
  done
)
cat $CWD/parts/02
( cd $1
  find . -type f | xargs file | grep "timezone data" | cut -f 1 -d : | cut -f 2- -d / | sort | grep "^US/" | while read zone ; do
    echo "${zone}"
  done
)
( cd $1
  find . -type f | xargs file | grep "timezone data" | cut -f 1 -d : | cut -f 2- -d / | sort | grep -v "^US/" | while read zone ; do
    echo "${zone}"
  done
)
cat $CWD/parts/04
