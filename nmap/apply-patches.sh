
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-4.03-mktemp.patch.gz | patch -p1 -E --backup --verbose
# rhbz#637403, workaround for rhbz#621887=gnome#623965
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/zenmap-621887-workaround.patch
# upstream provided patch for rhbz#845005, not yet in upstream repository
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ncat_reg_stdin.diff
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/nmap-6.25-displayerror.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
