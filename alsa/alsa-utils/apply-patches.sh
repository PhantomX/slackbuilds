
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-1.0.22-alsaconf.patch.gz | patch -p0 --verbose --backup --suffix=.orig
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-alsactl-Fix-a-typo-in-systemd-alsa-restore.service.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-alsactl-Fix-the-string-size-for-the-lock-file-conten.patch

set +e +o pipefail
