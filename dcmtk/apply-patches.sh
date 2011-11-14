
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dcmtk-3.6.0-0001-Added-soname-information-for-all-targets.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dcmtk-3.6.0-0002-Install-libs-in-the-correct-arch-dir.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dcmtk-3.6.0-0003-Removed-bundled-libcharl-reference-in-dcmjpls.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dcmtk-3.6.0-0004-Use-system-charls.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dcmtk-3.6.0-0005-Fixed-includes-for-CharLS-1.0.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dcmtk-3.6.0-0006-Added-optional-support-for-building-shared-libraries.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dcmtk-3.6.0-0007-Add-soname-generation-for-modules-which-are-not-in-D.patch

set +e +o pipefail
