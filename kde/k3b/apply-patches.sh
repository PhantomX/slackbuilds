
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/k3b-2.0.1-sndfile-inc.patch

# From Debian
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/113_initial_preference.diff
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/114_bug587996_bdr_capacity_fix.diff

## upstream patches
# wodim(cdrecord) doesnt work for dvds, use growisofs instead
# http://bugzilla.redhat.com/610976
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/k3b-2.0.2-use_growisofs_instead_of_wodim.patch
# increase overburning tolerance from 1/10 to 1/4 for CD-R90/99 media
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/k3b-2.0.2-overburn-cdr90.patch
# fix overburning check to not count the used capacity twice
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/k3b-2.0.2-overburn-usedcapacity.patch
# http://mail.kde.org/pipermail/k3b/2011-April/000227.html
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/k3b-2.0.2-ffmpeg.patch

set +e +o pipefail
