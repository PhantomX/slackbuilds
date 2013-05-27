
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/wine-1.1.15-winegcc.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-winemenubuilder-silence-an-err.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/wine-1.5.17-osmesa-check.patch

# Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/wine-cjk.patch

# winepulse backend
# http://repo.or.cz/w/wine/multimedia.git
filterdiff -p1 -x configure -z ${SB_PATCHDIR}/wine-pulse-1.5.22.patch | patch -p1 -E --backup --verbose
# use winealsa for midi in the pa backend
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/wine-pulse-winmm-Load-winealsa-if-winepulse-is-found.patch
# bugfixes
# http://bugs.winehq.org/show_bug.cgi?id=7698
# http://bugs2.winehq.org/attachment.cgi?id=6853
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/wine-csd.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
