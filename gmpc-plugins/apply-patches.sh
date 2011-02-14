
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
( cd gmpc-libnotify-*
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gmpc-libnotify.git-083ded0f35d4404cd378a975e3b6f2af520b4c54.patch
  patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gmpc-libnotify.patch
)

set +e +o pipefail
