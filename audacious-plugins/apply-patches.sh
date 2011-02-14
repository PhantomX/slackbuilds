
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-2.0.1-xmms-skindir.patch.gz | patch -p1 -E --backup --verbose
# fix hardcoded libdir replacement
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.4-libdir.patch
# reported/mentioned upstream
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.4.3-adplug-invalid.patch
# post-2.4.3
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.4.3-psf-AUD-289.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.4.3-mtp-AUDPLUG-323.patch
#
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.4.2-libnotify07.patch

set +e +o pipefail
