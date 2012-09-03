
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/wine-1.1.15-winegcc.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-winemenubuilder-silence-an-err.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/wine-1.5.10-osmesa-check.patch

# Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/wine-cjk.patch

# winepulse backend
# http://repo.or.cz/w/wine/multimedia.git
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/wine-pulse-1.5.4.patch
# bugfixes
# http://bugs.winehq.org/show_bug.cgi?id=7698
# http://bugs2.winehq.org/attachment.cgi?id=6853
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/wine-csd.patch

set +e +o pipefail
