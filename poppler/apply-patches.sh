
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# for texlive/pdftex, make ObjStream class public
#zcat ${SB_PATCHDIR}/poppler-0.12.1-objstream.patch.gz | patch -p1 -E --backup -z .objstream --verbose
# http://bugzilla.redhat.com/show_bug.cgi?id=480868
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/poppler-0.12.4-annot-appearance.patch

set +e +o pipefail
