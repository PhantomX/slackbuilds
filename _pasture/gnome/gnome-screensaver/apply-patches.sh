
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-2.20.0-default-theme.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.26.0-securitytoken.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.20.0-blank-by-default.patch.gz | patch -p1 -E --backup --verbose
#zcat ${SB_PATCHDIR}/${NAME}-2.20.0-selinux-permit.patch.gz | patch -p1 -E --backup --verbose
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.30.2-libnotify07.patch

set +e +o pipefail
