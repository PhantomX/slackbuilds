
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://aur.archlinux.org/packages.php?ID=13112
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-args.patch

set +e +o pipefail
