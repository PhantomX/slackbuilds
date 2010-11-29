
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-1.4.11-cflags.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-1.4.11-header.patch
# http://bugs.gentoo.org/200661
patch -p1 -E --backup -z .pkgconfig --verbose -i ${SB_PATCHDIR}/${PNAME}-1.4.11-pkgconfig.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-1.4.11-libv4l.patch
zcat ${SB_PATCHDIR}/${PNAME}-1.2.8-tweak.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
