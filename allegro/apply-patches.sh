
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
zcat ${SB_PATCHDIR}/${NAME}-4.0.3-cfg.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup -z .multilib --verbose -i ${SB_PATCHDIR}/allegro-4.4.2-libdir.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/allegro-4.2.3-pack-formatstring.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/allegro-4.4.2-dynamic-addons.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/allegro-4.4.2-buildsys-fix.patch
# Replace racy recursive mutex implementation with proper recursive mutexes
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/allegro-4.4.2-mutex-fix.patch
# Calling Xsync from the bg thread causes deadlock issues
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/allegro-4.4.2-no-xsync-from-thread.patch

set +e +o pipefail
