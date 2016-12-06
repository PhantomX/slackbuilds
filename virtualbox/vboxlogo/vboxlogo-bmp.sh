#!/bin/sh
#-- vboxlogo-bmp.sh --
# Script by Phantom X <megaphantomx@bol.com.brg>
# Suggested usage: $ vboxlogo-bmp.sh imagefile
#--
# Copyright 2010-2016 Phantom X, Goiania, Brazil.
#
# Redistribution and use of this script, with or without modification, is
# permitted provided that the following conditions are met:
#
# 1. Redistributions of this script must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
#  THIS SOFTWARE IS PROVIDED BY THE AUTHOR `AS IS'' AND ANY EXPRESS OR IMPLIED
#  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
#  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO
#  EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
#  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
#  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
#  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
#  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
#  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
#  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

cwd="$(pwd)"

imgfile="$1"
vboximage="${cwd}/vboxlogo.bmp"

if [ -z "${imgfile}" ] ;then
  echo "No image specified, using ${cwd}/vboxlogo.png..."
  imgfile="${cwd}/vboxlogo.png"
fi

for bin in convert ;do
  command="$(which ${bin} 2>/dev/null)"
  if [ -z "${command}" ] && [ ! -x "${command}" ] ;then
    echo "${bin} is missing. Please, install ImageMagick."
    exit 1
  fi
done

if [ -r "${imgfile}" ] ;then
  echo "Converting ${imgfile}"
  convert "${imgfile}" -colorspace RGB -filter Lanczos -resize 640x480 \
    -depth 24 BMP3:"${vboximage}" || exit 1
  xz -9 "${vboximage}" || exit 1
  echo "${vboximage}.xz created"
else
  echo "No ${imgfile}, exiting..."
  exit 1
fi
