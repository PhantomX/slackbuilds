
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/11mark_trashed_as_read.patch.gz | patch -p1 -E --backup --verbose
# http://www.thewildbeast.co.uk/claws-mail/bugzilla/attachment.cgi?id=960
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/claws-gnome-shell-dont-start-minimized.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/3.7.10cvs8
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/3.7.10cvs10
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/3.7.10cvs11
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/3.7.10cvs15
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/3.7.10cvs16
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/3.7.10cvs18

set +e +o pipefail
