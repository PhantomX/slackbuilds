
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xz.git-54df428799a8d853639b753d0e6784694d73eb3e.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xz.git-8c19216baccb92d011694590df8a1262da2e980c.patch
# xzgrep: return 0 when at least one file matches (+ test)
# ~> upstream (ceca37901783)
# ~> #1109122
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xz-5.1.2alpha-xzgrep-exit.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xz-5.1.2alpha-xzgrep-exit-test.patch

set +e +o pipefail
