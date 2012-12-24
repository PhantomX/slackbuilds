
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/alpine.manpage.diff.gz | patch -p1 --verbose
# Correct paths and programs in tech-notes.txt:
zcat ${SB_PATCHDIR}/alpine.tech-notes.txt.diff.gz | patch -p1 --verbose

( cd ${PGSRCDIR}
  zcat ${SB_PATCHDIR}/pinepgp-0.18.0-makefile-sed-fix.diff.gz | patch -p1 --verbose
  zcat ${SB_PATCHDIR}/pinepgp.pinegpgp.in.diff.gz | patch -p1 --verbose
)

set +e +o pipefail
