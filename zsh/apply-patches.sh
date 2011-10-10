
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/zsh-serial.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/zsh-4.3.6-8bit-prompts.patch

set +e +o pipefail
