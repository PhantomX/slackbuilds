#!/bin/sh
#
#-- fake-aaa_elflibs 0.4 --
# Generate a fake aaa_elflibs file list to use in /var/log/packages to fool
# pkgtools to not remove essential libraries.
#--
# Script by Phantom X <megaphantomx at bol.com.br>
#
# Copyright 2011-2015 Phantom X, Goiania, Brazil.
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

# Set arch - x86_64 sets lib64
ARCH=${ARCH:-x86_64}

if [ "${ARCH}" = "x86_64" ] ;then
  LIBDIRSUFFIX=64
else
  LIBDIRSUFFIX=""
fi
unset C32

txt() {
cat <<EOF
Usage :
        $0 [-c] -f <file>
        $0 -t <file>
  -c|--compat32   Set creation of compat32 file (must be set before -f|--file)
  -f|--file       Create /var/log/packages file from a compliant list (see template option).
  -t|--template   Create a template for use with create option.
  -h|--help       Show this message.
EOF
}

header(){
cat <<EOF
PACKAGE NAME:     $1
PACKAGE DESCRIPTION:
aaa_elflibs${C32}: aaa_elflibs${C32} (shared libraries needed by many programs)
aaa_elflibs${C32}:
aaa_elflibs${C32}: This is a collection of shared libraries needed to run Linux programs.
aaa_elflibs${C32}: ELF (Executable and Linking Format) is the standard Linux binary 
aaa_elflibs${C32}: format.  These libraries are gathered from other Slackware packages
aaa_elflibs${C32}: and are intended to give a fairly complete initial set of libraries.
aaa_elflibs${C32}: This package should be not upgraded or reinstalled (it could copy
aaa_elflibs${C32}: over newer library versions).
aaa_elflibs${C32}:
aaa_elflibs${C32}:
aaa_elflibs${C32}:
FILE LIST:
EOF
}

# Search .so first
testso(){
  libso=$1
  if [ -f /lib${LIBDIRSUFFIX}/${libso}.so ] ;then
    testsoname /lib${LIBDIRSUFFIX}/${libso}.so
  elif [ -f /usr/lib${LIBDIRSUFFIX}/${libso}.so ] ;then
    testsoname /usr/lib${LIBDIRSUFFIX}/${libso}.so
  fi
}

# Search for .so.*
testso2(){
  libso=$1
  if [ -f /lib${LIBDIRSUFFIX}/${libso} ] ;then
    testfullname /lib${LIBDIRSUFFIX}/${libso}
    echo lib${LIBDIRSUFFIX}/${libso}
  elif [ -f /usr/lib${LIBDIRSUFFIX}/${libso} ] ;then
    testfullname /usr/lib${LIBDIRSUFFIX}/${libso}
    echo usr/lib${LIBDIRSUFFIX}/${libso}
  fi
}

# Now soname
testsoname(){
  libsoname="$(objdump -p $1 | grep SONAME | awk '{print $2}' 2>/dev/null)"
  if [ -f /lib${LIBDIRSUFFIX}/${libsoname} ] ;then
    testfullname /lib${LIBDIRSUFFIX}/${libsoname}
    echo lib${LIBDIRSUFFIX}/${libsoname}
  elif [ -f /usr/lib${LIBDIRSUFFIX}/${libsoname} ] ;then
    testfullname /usr/lib${LIBDIRSUFFIX}/${libsoname}
    echo usr/lib${LIBDIRSUFFIX}/${libsoname}
  fi
}

# Now full file name
testfullname(){
  libfullname=$(basename $(readlink $1) 2>/dev/null)
  if [ -f /lib${LIBDIRSUFFIX}/${libfullname} ] ;then
    echo lib${LIBDIRSUFFIX}/${libfullname}
  elif [ -f /usr/lib${LIBDIRSUFFIX}/${libfullname} ] ;then
    echo usr/lib${LIBDIRSUFFIX}/${libfullname}
  fi
}

filetest(){
  if [ $1 -eq 0 ] ;then
    echo "${2} created"
  else
    echo "${2} not created"
    return 5
  fi
}

main(){
  tmp=$(mktemp -d)

  trap cleanup EXIT
  cleanup() {
  set +e
    [ -z "${tmp}" -o ! -d "${tmp}" ] || rm -rf "${tmp}"
  }

  libsfile=$1
  if [ -z "${libsfile}" ] || ! [ -r "${libsfile}" ] ;then
    echo 'No file entered or file not readable!'
    return 1
  else
    if head -n1 "${libsfile}" | grep -q -v '### fake-aaa_elflibs file ###' 2>/dev/null ;then
      echo "No header in ${libsfile}"
      return 2
    fi
    VERSION=$(grep ^VERSION= "${libsfile}" | cut -d= -f2)
    if [ -z "${VERSION}" ] ;then
      echo "No VERSION set in ${libsfile}"
      return 2
    fi
    BUILD=$(grep ^BUILD= "${libsfile}" | cut -d= -f2)
    if [ -z "${BUILD}" ] ;then
      echo "No BUILD set in ${libsfile}"
      return 2
    fi
    filename=aaa_elflibs${C32}-${VERSION}-"${ARCH}"-${BUILD}
    if [ -r "${tmp}/${filename}" ] ;then
      echo "A file ${tmp}/${filename} already exists"
      return 2
    else
      echo "${ARCH} - lib${LIBDIRSUFFIX}"
      echo -n "Searching libraries "
      for lib in $(sed -n '9,$p' "${libsfile}" | sed '/^#/d;/^$/d' ) ;do
        case ${lib} in
          *.so.*)
            testso2 ${lib} >> ${tmp}/${filename}.tmp
            ;;
          *)
            testso ${lib} >> ${tmp}/${filename}.tmp
            ;;
        esac
        echo -n .
      done
      echo
      echo
      header ${filename} > ${tmp}/${filename}
      sort ${tmp}/${filename}.tmp >> ${tmp}/${filename}
      filetest $? "./${filename}"
      cp -f ${tmp}/${filename} .
      echo
      echo "Now, put ${filename} in /var/log/packages and profit"
    fi
  fi
}

ctemplate(){
  tempfile=$1
  if [ -r "${tempfile}" ] ;then
    echo "A file ${tempfile} already exists"
    return 2
  elif [ -z "${tempfile}" ] ;then
    echo "No file entered"
    txt
    return 3
  else
    cat > "${tempfile}" <<'EOF'
### fake-aaa_elflibs file ###
# put version of resulted file
VERSION=
# put build of resulted file
BUILD=
#
#### Insert library names after this line. Lines starting with # or blank are ignored.
################################################################################
libacl
EOF
  filetest $? "${tempfile}"
  fi
}

case "$1" in
  -h|--help|-c|--compat32|-f|--file|-t|--template)
    ;;
  *)
    txt
    exit 0
  ;;
esac

while [ -n "$1" ] ;do
  case "$1" in
    -h|--help)
      txt
      exit 0
      ;;
    -c|--compat32)
      export C32='-compat32'
      export LIBDIRSUFFIX=""
      ;;
    -f|--file)
      main $2
      ;;
    -t|--template)
      ctemplate $2
      ;;
  esac
  shift
done
