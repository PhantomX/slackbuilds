
SB_PATCHDIR=${CWD}/patches

# Set defaults to American English instead of British English - the OALD
# dictionary (free for non-commercial use only) is needed for BE support
# Additionally, prefer the smaller (and I think nicer sounding) nitech hts
# voices.
zcat ${SB_PATCHDIR}/${NAME}-1.96-nitech-american.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Whack some buildroot references
zcat ${SB_PATCHDIR}/${NAME}_buildroot.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Use shared libraries
zcat ${SB_PATCHDIR}/${NAME}-1.96-speechtools-shared-build.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Build (but don't enable by default) the ESD module
zcat ${SB_PATCHDIR}/${NAME}-1.96-speechtools-buildesdmodule.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Fix a coding error (see bug #162137). Need to upstream.
zcat ${SB_PATCHDIR}/${NAME}-1.96-speechtools-rateconvtrivialbug.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Link libs with libm, libtermcap, and libesd (see bug #198190).
# Need to upstream this.
zcat ${SB_PATCHDIR}/${NAME}-1.96-speechtools-linklibswithotherlibs.patch.gz | patch -p1 -E --backup --verbose || exit 1

# For some reason, CXX is set to gcc on everything but Mac OS Darwin,
# where it's set to g++. Yeah, well. We need it to be right too.
zcat ${SB_PATCHDIR}/${NAME}-1.96-speechtools-ohjeezcxxisnotgcc.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Look for siteinit and sitevars in /etc/festival
zcat ${SB_PATCHDIR}/${NAME}-1.96-etcsiteinit.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Alias old cmu names to new nitech ones
zcat ${SB_PATCHDIR}/${NAME}-1.96-alias_cmu_to_nitech.patch.gz | patch -p1 -E --backup --verbose || exit 1
rm -f lib/alias_cmu_to_nitech.scm.cmu2nitech

# Look for speech tools here, not back there.
zcat ${SB_PATCHDIR}/${NAME}-1.96-findspeechtools.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Build main library as shared, not just speech-tools
zcat ${SB_PATCHDIR}/${NAME}-1.96-main-shared-build.patch.gz | patch -p1 -E --backup --verbose || exit 1

# This is a hack to make the shared libraries build with actual
# sonames. Should pretty much do the right thing, although note
# of course that the sonames aren't official upstream.
zcat ${SB_PATCHDIR}/${NAME}-1.96-bettersonamehack.patch.gz | patch -p1 -E --backup --verbose || exit 1

# this updates speech_tools to a development version which fixes
# a 64-bit cleanliness issue (among other changes).
zcat ${SB_PATCHDIR}/${NAME}-1.96-speechtools-1.2.96-beta+awb.patch.gz | patch -p1 -E --backup --verbose || exit 1

# This makes festival use /usr/lib[arch]/festival/etc for its
# arch-specific "etc-path", rather than /usr/share/festival/etc/system_type.
# Then I use sed to replace the token with actual arch-specific libdir.
# A better way would be to actually make this a flexible makefile parameter,
# but that's something to take up with upstream.
zcat ${SB_PATCHDIR}/${NAME}-1.96-kludge-etcpath-into-libarch.patch.gz | patch -p1 -E --backup --verbose || exit 1
for f in speech_tools/main/siod_main.cc src/arch/festival/festival.cc; do
  sed -i -e 's,{{HORRIBLELIBARCHKLUDGE}},"/usr/lib",' ${f}
done

# For some reason, the Nitech voices (and the previous CMU versions) fail to
# define proclaim_voice, which makes them not show up in the voice
# descriptions, which makes gnome-speech not show them.
zcat ${SB_PATCHDIR}/${NAME}-1.96-nitech-proclaimvoice.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Cure "SIOD ERROR: unbound variable : f2b_f0_lr_start"
zcat ${SB_PATCHDIR}/${NAME}-1.96-nitech-fixmissingrequire.patch.gz | patch -p1 -E --backup --verbose || exit 1

# An apparent copy-paste error in these voices -- slt is referenced
# in all of them.
zcat ${SB_PATCHDIR}/${NAME}-1.96-nitech-sltreferences.patch.gz | patch -p1 -E --backup --verbose || exit 1

#zcat ${SB_PATCHDIR}/gcc43.patch.gzz | patch -p1 -E --backup --verbose || exit 1
