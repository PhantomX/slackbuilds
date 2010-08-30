
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/config.layout.diff.gz | sed -e "s#lib/httpd#lib${LIBDIRSUFFIX}/httpd#" | patch --verbose -p1
zcat ${SB_PATCHDIR}/${NAME}-2.2.14-confd.patch.gz | patch -p0 -E --backup --verbose

# build/scripts patches
zcat ${SB_PATCHDIR}/${NAME}-2.1.10-apctl-l.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.1.10-apxs.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.2.9-deplibs.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.1.10-disablemods.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.1.10-layout.patch.gz | patch -p1 -E --backup --verbose
# Features/functional changes
zcat ${SB_PATCHDIR}/${NAME}-2.2.11-xfsz.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.1.10-pod.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.0.45-export.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.2.11-corelimit.patch.gz | patch -p1 -E --backup --verbose
#zcat ${SB_PATCHDIR}/${NAME}-2.2.11-selinux.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.2.9-suenable.patch.gz | patch -p1 -E --backup --verbose
# Bug fixes
zcat ${SB_PATCHDIR}/${NAME}-2.2.0-authnoprov.patch.gz | patch -p1 -E --backup --verbose
# Security fixes

set +e +o pipefail
