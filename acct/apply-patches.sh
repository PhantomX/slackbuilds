
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/acct-6.5.3-logdir-fhs.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/psacct-6.5.1-exit.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/psacct-6.3.2-sa-manfix.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/psacct-6.3.2-lastcomm_man.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/acct-6.3.2-sa_manpage.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/psacct-6.3.2-man-pages.patch.gz | patch -p1 -E --backup --verbose 

set +e +o pipefail
