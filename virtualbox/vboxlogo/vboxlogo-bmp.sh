#!/bin/sh
#-- vboxlogo-bmp.sh --
# Script by Phantom X <megaphantomx@bol.com.brg>
# Suggested usage: $ vboxlogo-bmp.sh
#--
# Copyright 2010 Phantom X, Goiania, Brazil.
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

cwd=$(pwd)

for bin in pngtopnm ppmquant ppmtobmp ;do
  command="$(which ${bin} 2>/dev/null)"
  if [ -z "${command}" ] && [ ! -x "${command}" ] ;then
    echo "${bin} is missing. Please, install netbpm tools."
    exit 1
  fi
done

if [ -r ${cwd}/vboxlogo.png ] ;then
  echo "Coverting ${cwd}/vboxlogo.png"
  pngtopnm ${cwd}/vboxlogo.png | ppmquant -fs 256 | ppmtobmp \
    > ${cwd}/vboxlogo.bmp || exit 1
  xz -9 ${cwd}/vboxlogo.bmp || exit 1
  echo "${cwd}/vboxlogo.bmp.xz created"
else
  echo "No ${cwd}/vboxlogo.png"
  exit 1
fi
