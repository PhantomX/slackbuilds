
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/rsync-3.0.10-lose-track.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/rsync-3.1.0-protect_args.patch

# Set to YES if autogen is needed
SB_AUTOGEN=NO

set +e +o pipefail
