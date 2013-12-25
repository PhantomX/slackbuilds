
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sddm-git.e707e229-session-list.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sddm-0.2.0-0.11.20130914git50ca5b20-xdmcp.patch
# Don't end the PAM session twice
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sddm-pam_end.patch

set +e +o pipefail
