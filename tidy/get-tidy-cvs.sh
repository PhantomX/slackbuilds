#!/bin/sh
# Copyright 2006  Patrick Volkerding, Sebeka, MN, USA
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

# Fetch the latest CVS of Tidy.
# Clean the download location:
rm -rf tidy
cvs -d:pserver:anonymous@tidy.cvs.sourceforge.net:/cvsroot/tidy login
CVS_VERSION=$(date +%Y%m%dT%R | tr -d :)
# Doubtful that these will exist, but...
rm -f tidy-${CVS_VERSION}.tar tidy-${CVS_VERSION}.tar.bz2
cvs -z3 -d:pserver:anonymous@tidy.cvs.sourceforge.net:/cvsroot/tidy co -P tidy
# Rid ourselves of cruft:
( cd tidy ; find . -type d -name CVS -exec rm -rf {} \; 2> /dev/null )
# Make tarball "release":
tar cf tidy-${CVS_VERSION}.tar tidy
bzip2 -9 tidy-${CVS_VERSION}.tar
# Clean up:
rm -rf tidy
