
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-1.0.2-slackware.patch.gz \
  | sed -e "s|_LIBDIR_|/usr/lib${LIBDIRSUFFIX}|g" \
  | patch -p0 -E --backup --verbose

set +e +o pipefail
