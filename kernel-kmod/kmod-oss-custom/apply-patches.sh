
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Arch Linux
patch -p0 -E --backup --verbose -d ${RSRCDIR} -i ${SB_PATCHDIR}/linux-3.8.patch
# http://4front-tech.com/forum/viewtopic.php?f=3&t=5247
patch -p0 -E --backup --verbose -d ${RSRCDIR} -i ${SB_PATCHDIR}/linux-3.10.patch
# http://opensound.com/forum/download/file.php?id=129
patch -p0 -E --backup --verbose -d ${RSRCDIR} -i ${SB_PATCHDIR}/linux-3.10.7.patch
# https://github.com/l29ah/booboo/tree/master/media-sound/oss
patch -p1 -E --backup --verbose -d ${RSRCDIR} -i ${SB_PATCHDIR}/oss-4.2.2008-linux-3.12.patch

set +e +o pipefail
