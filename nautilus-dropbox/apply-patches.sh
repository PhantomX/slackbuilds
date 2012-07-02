
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
sed -e "s|_LIBDIR_|/usr/lib${LIBDIRSUFFIX}|g" ${SB_PATCHDIR}/${NAME}-1.4.0-system-daemon.patch \
  | patch -p0 -E --backup --verbose
# Disable nautilus extension
# Yes, it's nautilus-dropbox, but I need only the script.
patch -p1 -E --backup -z .nognome --verbose -i ${SB_PATCHDIR}/${NAME}-1.4.0-nognome.patch

set +e +o pipefail
