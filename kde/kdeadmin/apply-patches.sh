
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.7.1-printing.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.6.2-kcmprinter_root_privs.patch
# fix ksystemlog to find log files correctly
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.8.4-syslog.patch

## upstream patches

set +e +o pipefail
