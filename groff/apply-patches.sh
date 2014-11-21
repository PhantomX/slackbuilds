
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-missing-groff-x11-info-message-when-gxditview-not-fo.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-load-site-font-and-site-tmac-from-etc-groff.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-various-security-fixes.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0004-don-t-use-usr-bin-env-in-shebang.patch
# SSIA
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0005-Add-missing-rule-for-gropdf.patch

### Gentoo
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/groff-1.22.3-parallel-mom.patch

set +e +o pipefail
