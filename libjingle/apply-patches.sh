
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Patches/comments from Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.5.1-build-sanity.patch
# talk/base/basictypes.h and talk/base/logging.h must be included 
# before any header with __BEGIN_DECLS, notably, sys/types.h
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.5.1-C-linkage-fix.patch
# We need <cstdlib> for NULL.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.5.1-NULL-fix.patch
# In file included from /usr/include/fcntl.h:41:0,
#                 from physicalsocketserver.cc:37:
#/usr/include/bits/stat.h:91:21: error: field 'st_atim' has incomplete type
#/usr/include/bits/stat.h:92:21: error: field 'st_mtim' has incomplete type
#/usr/include/bits/stat.h:93:21: error: field 'st_ctim' has incomplete type
# FIX: Include <time.h> first.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.5.1-statfix.patch
# md5.h had a typedef for uint32 that did not match the one in basictypes.h
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.5.1-uint32-fix.patch
# thread.cc: In static member function ‘static bool talk_base::Thread::SleepMs(int)’:
# thread.cc:199:19: error: aggregate ‘timespec ts’ has incomplete type and cannot be defined
# thread.cc:202:34: error: ‘nanosleep’ was not declared in this scope
# This happens because a local header is included before time.h
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.5.1-timefix.patch
# unixfilesystem.cc wouldn't compile.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.5.1-unixfilesystemfix.patch
# Google seems to love to be stupid with headers.
# Especially when they're in "third_party" code.
# Hardcoding paths in include files is dumb.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.5.1-system-expat.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.5.1-system-srtp.patch
# Fix devicemanager.cc to compile, alsa as linux default
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.5.1-devicemanager-alsafix.patch
# Fix v4llookup.cc to compile
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.5.1-v4llookup-fix.patch

set +e +o pipefail
