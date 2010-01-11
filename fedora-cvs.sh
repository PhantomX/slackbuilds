#!/bin/bash
# -- fedora-cvs.sh --
# Retrieve sources from Fedora cvs.
#
# Script by Phantom X <megaphantomx@bol.com.br>
# Suggested usage: $ fedora-cvs package dist
#
# Copyright 2008 Phantom X, Goiania, Brazil.
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

set -e

module="${1}"
dist="${2}"

[ -n "${3}" ] && sarchive="${3}"

fedoraroot=":pserver:anonymous@cvs.fedoraproject.org:/cvs/pkgs"

txt() {
  echo "Usage: $0 module dist"
  echo "module is package name"
  echo "dist is Fedora version (F-??/devel)"
  echo
  echo "In case of other errors, try to download in a Fedora mirror or change file format extension."
}

txt2() {
  echo "Select correct dist: F-8, F-9, F-10, F11, F-12 or devel"
}

if [ -z "${module}" ] ;then
  txt
  exit 1
fi

case "${2}" in
  F-8|F-9|F-10|F-11|F-12|devel)
    dist="${2}"
    ;;
  *)
    txt2
    exit 1
    ;;
esac

echo "Downloading from ${module}/${dist}"

tmp=$(mktemp -d)

trap cleanup EXIT
cleanup() {
  set +e
  [ -z "${tmp}" -o ! -d "${tmp}" ] || rm -rf "${tmp}"
}

unset CDPATH
pwd=$(pwd)

pushd "${tmp}"
  export CVSROOT="${fedoraroot}"
  cvs co ${module}/${dist}/
  cd ${module}/${dist}
  if [ -f "${sarchive}" ] ;then
    mv "${sarchive}" "${pwd}"/
  else
    if [ -n "${sarchive}" ] ;then
      mv sources sources.tmp
      grep "${sarchive}" sources.tmp > sources
    fi
    make sources
    for source in $(awk '{print $2}' sources) ;do
      mv "${source}" "${pwd}"/
    done
  fi
popd >/dev/null
