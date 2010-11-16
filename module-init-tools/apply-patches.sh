
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Exclude *.{old,new,bak} files (and a few others that obviously aren't
# valid for this...  Thanks to Marco d'Itri for the patch that it's based on
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/modprobe.ignore_some_suffixes.diff
zcat ${SB_PATCHDIR}/${NAME}-3.11.1-multi_moddirs.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-3.11.1-pblacklists.patch.gz | patch -p1 --verbose || exit 1

set +e +o pipefail
