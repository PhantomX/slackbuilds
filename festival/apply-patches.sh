
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Set defaults to American English instead of British English - the OALD
# dictionary (free for non-commercial use only) is needed for BE support
# Additionally, prefer the smaller (and I think nicer sounding) nitech hts
# voices.
zcat ${SB_PATCHDIR}/${NAME}-1.96-nitech-american.patch.gz | patch -p1 -E --backup --verbose

# Whack some buildroot references
zcat ${SB_PATCHDIR}/${NAME}_buildroot.patch.gz | patch -p1 -E --backup --verbose

# Use shared libraries
zcat ${SB_PATCHDIR}/${NAME}-1.96-speechtools-shared-build.patch.gz | patch -p1 -E --backup --verbose

# Fix a coding error (see bug #162137). Need to upstream.
zcat ${SB_PATCHDIR}/${NAME}-1.96-speechtools-rateconvtrivialbug.patch.gz | patch -p1 -E --backup --verbose

# Link libs with libm, libtermcap, and libesd (see bug #198190).
# Need to upstream this.
zcat ${SB_PATCHDIR}/${NAME}-1.96-speechtools-linklibswithotherlibs.patch.gz | patch -p1 -E --backup --verbose

# For some reason, CXX is set to gcc on everything but Mac OS Darwin,
# where it's set to g++. Yeah, well. We need it to be right too.
zcat ${SB_PATCHDIR}/${NAME}-1.96-speechtools-ohjeezcxxisnotgcc.patch.gz | patch -p1 -E --backup --verbose

# Look for siteinit and sitevars in /etc/festival
zcat ${SB_PATCHDIR}/${NAME}-1.96-etcsiteinit.patch.gz | patch -p1 -E --backup --verbose

# Alias old cmu names to new nitech ones
zcat ${SB_PATCHDIR}/${NAME}-1.96-alias_cmu_to_nitech.patch.gz | patch -p1 -E --backup --verbose
rm -f lib/alias_cmu_to_nitech.scm.cmu2nitech

# Look for speech tools here, not back there.
zcat ${SB_PATCHDIR}/${NAME}-1.96-findspeechtools.patch.gz | patch -p1 -E --backup --verbose

# Build main library as shared, not just speech-tools
zcat ${SB_PATCHDIR}/${NAME}-1.96-main-shared-build.patch.gz | patch -p1 -E --backup --verbose

# This is a hack to make the shared libraries build with actual
# sonames. Should pretty much do the right thing, although note
# of course that the sonames aren't official upstream.
zcat ${SB_PATCHDIR}/${NAME}-1.96-bettersonamehack.patch.gz | patch -p1 -E --backup --verbose

# this updates speech_tools to a development version which fixes
# a 64-bit cleanliness issue (among other changes).
zcat ${SB_PATCHDIR}/${NAME}-1.96-speechtools-1.2.96-beta+awb.patch.gz | patch -p1 -E --backup --verbose

# This makes festival use /usr/lib[arch]/festival/etc for its
# arch-specific "etc-path", rather than /usr/share/festival/etc/system_type.
# Then I use sed to replace the token with actual arch-specific libdir.
# A better way would be to actually make this a flexible makefile parameter,
# but that's something to take up with upstream.
zcat ${SB_PATCHDIR}/${NAME}-1.96-kludge-etcpath-into-libarch.patch.gz | patch -p1 -E --backup --verbose
for f in speech_tools/main/siod_main.cc src/arch/festival/festival.cc; do
  sed -i -e "s,{{HORRIBLELIBARCHKLUDGE}},\"lib${LIBDIRSUFFIX}\"," ${f}
done

# For some reason, the Nitech voices (and the previous CMU versions) fail to
# define proclaim_voice, which makes them not show up in the voice
# descriptions, which makes gnome-speech not show them.
#zcat ${SB_PATCHDIR}/${NAME}-1.96-nitech-proclaimvoice.patch.gz | patch -p1 -E --backup --verbose

# Cure "SIOD ERROR: unbound variable : f2b_f0_lr_start"
#zcat ${SB_PATCHDIR}/${NAME}-1.96-nitech-fixmissingrequire.patch.gz | patch -p1 -E --backup --verbose

# An apparent copy-paste error in these voices -- slt is referenced
# in all of them.
#zcat ${SB_PATCHDIR}/${NAME}-1.96-nitech-sltreferences.patch.gz | patch -p1 -E --backup --verbose

zcat ${SB_PATCHDIR}/gcc43.patch.gz | patch -p1 -E --backup --verbose

# Native pulseaudio support, https://bugzilla.redhat.com/show_bug.cgi?id=471047
[ "${SB_PA}" = "YES" ] && patch -p1 -E --backup -z .pa --verbose -i ${SB_PATCHDIR}/${NAME}-speech-tools-pulse.patch

zcat ${SB_PATCHDIR}/gcc44.patch.gz | patch -p1 -E --backup --verbose

# gcc 4.7 is finnicky about ambiguous function references'
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.gcc47.patch

# Bring back old patch since gcc 4.7 no longer ignores unknown options
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/no-shared-data.patch

# There is a typo in the festival_server script
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.96-server-script-typo.patch

set +e +o pipefail
