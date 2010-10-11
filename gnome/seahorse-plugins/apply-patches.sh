
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://bugzilla.gnome.org/show_bug.cgi?id=579738
zcat ${SB_PATCHDIR}/seahorse-agent-uninit.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
