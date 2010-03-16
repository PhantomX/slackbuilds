
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-4.0.3-cfg.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-4.2.0-noexecstack.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/allegro-4.4.0-multilib.patch.gz | patch -p1 -E --backup --verbose -z .multilib
zcat ${SB_PATCHDIR}/${NAME}-4.2.1-noexecmod.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/allegro-4.4.0-libdir.patch.gz | patch -p1 -E --backup --verbose -z .multilib2
zcat ${SB_PATCHDIR}/${NAME}-4.2.2-fullscreen-viewport.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/allegro-4.4.0-modulelst.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
