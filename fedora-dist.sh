#!/bin/bash
# -- fedora-dist.sh --
# Retrieve sources from Fedora VCS.
#
# Script by Phantom X <megaphantomx@bol.com.br>
# Suggested usage: $ fedora-dist package dist
#
# Copyright 2008, 2010 Phantom X, Goiania, Brazil.
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

fedoraroot="git://pkgs.fedoraproject.org"
fedorapkgroot="http://pkgs.fedoraproject.org/repo/pkgs"


txt() {
  echo "Usage: $0 module dist <file>"
  echo "module is package name"
  echo "dist is Fedora version (f??/devel)"
  echo "file is optional"
  echo
  echo "In case of other errors, try to download in a Fedora mirror or change file format extension."
}

txt2() {
  echo "Select correct dist: f8, f9, f10, f11, f12, f13, f14 or devel"
}

if [ -z "${module}" ] ;then
  txt
  exit 1
fi

case "${2}" in
  f8|f9|f10|f11|f12|f13|f14|master)
    dist="${2}"
    ;;
  devel)
    dist=master
    ;;
  *)
    txt2
    exit 1
    ;;
esac

unset sarchive
while [ -n "${3}" ] ;do
  case "$3" in
    *)
      sarchive="${sarchive} ${3}"
      ;;
  esac
  shift
done

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
  git clone --depth 1 ${fedoraroot}/${module}
  cd ${module}
  [ "${dist}" = "master" ] || git checkout -q origin/${dist}/master
  if [ -n "${sarchive}" ] ; then
    mv sources sources.tmp
    for file in ${sarchive} ;do
      if [ -f "${file}" ] && [ ! -f "${pwd}/${file}" ] ;then
        mv "${file}" "${pwd}"/
      else
        if grep -Eq "^.*  .*${file}$" sources.tmp ;then
          grep "${file}" sources.tmp >> sources
        else
          echo "File \"${file}\" not found"
          exit 1
        fi
      fi
    done
  else
    echo "Downloading all sources"
  fi
  sed -e 's/  /__/' -i sources
  for source in $(< sources) ;do
    file="$(echo ${source} | awk -F'__' '{print $2}')"
    md5="$(echo ${source} | awk -F'__' '{print $1}')"
    if [ ! -f "${pwd}/${file}" ] ;then
      wget ${fedorapkgroot}/${module}/${file}/${md5}/${file}
      [ "$(md5sum ${file} | awk -F'  ' '{print $1}')" = "${md5}" ]
      mv "${file}" "${pwd}"/
    fi
  done
popd >/dev/null
