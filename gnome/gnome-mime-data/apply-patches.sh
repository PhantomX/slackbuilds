
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.2.0-openoffice.patch
# zcat ${SB_PATCHDIR}/${NAME}-2.2.0-rpminstall.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.3.2-nohtmlcomponent.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.4.1-default-applications.patch.gz | patch -p1 -E --backup --verbose
#zcat ${SB_PATCHDIR}/${NAME}-2.0.0-gimp.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.4.0-OOo-startup.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
