
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mutt-1.5.18-muttrc.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mutt-1.5.21-cabundle.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mutt-1.5.21-syncdebug.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mutt-1.5.23-add_debug_option.patch

# From Gentoo
for patch in ${PDIR}/mutt-gentoo-${VERSION}-r?.patch ${PDIR}/mutt-gentoo-${VERSION}-r??.patch ; do
  [ -f "${patch}" ] && patch -p1 -E --backup --verbose -i "${patch}"
done

for patches in \
  bdb-prefix.patch \
  dont-reveal-bbc.patch \
  ;do
  patch -p1 --backup --verbose -i ${PDIR}/${patches}
done

for patch in ${PDIR}/[0-9][0-9]-*.patch ; do
  patch -p1 -E --backup --verbose -i "${patch}"
done

set +e +o pipefail
