
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

tar xvf ${CWD}/${PDSRCARCHIVE}

zcat ${CWD}/${PSRCARCHIVE} | patch -p1 -E --backup --verbose

### Debian
for patch in \
  makefile-destdir.patch \
  mediaprm-fix_etc-fdprm.patch \
  floppymeter-confirmation_message.patch \
  MAKEFLOPPIES-chown_separator.patch \
  MAKEFLOPPIES-xsiisms.patch \
  MAKEFLOPPIES-devfs.patch \
  MAKEFLOPPIES-usage.patch \
  superformat-devfs_floppy.patch \
  superformat-env_variables.patch \
  superformat-verify_later.patch \
  fdmount-compilation_linux_2.6.patch \
  dont_strip_binaries.patch \
  help_messages.patch \
  remove_texi2html_dependency.patch \
  floppymeter-makefile_typo.patch \
  documentation-faq_cleanup.patch \
  ; do
  patch -p1 -E --backup --verbose -z .pdeb -i debian/patches/${patch}
done

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
