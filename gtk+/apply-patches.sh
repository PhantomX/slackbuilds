
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/gtk+-1.2.10-ahiguti.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/gtk+-1.2.8-wrap-alnum.patch.gz | patch -p1 -E --backup --verbose
# Supress alignment warnings on ia64
zcat ${SB_PATCHDIR}/gtk+-1.2.10-alignment.patch.gz | patch -p1 -E --backup --verbose
# Improve exposure compression
zcat ${SB_PATCHDIR}/gtk+-1.2.10-expose.patch.gz | patch -p1 -E --backup --verbose
# Handle focus tracking for embedded window properly
zcat ${SB_PATCHDIR}/gtk+-1.2.10-focus.patch.gz | patch -p1 -E --backup --verbose
# Find gtkrc files for the current encoding better
zcat ${SB_PATCHDIR}/gtk+-1.2.10-encoding.patch.gz | patch -p1 -E --backup --verbose
# Don't screw up CTEXT encoding for UTF-8
zcat ${SB_PATCHDIR}/gtk+-1.2.10-ctext.patch.gz | patch -p1 -E --backup --verbose
# Don't warn about missing fonts for UTF-8
zcat ${SB_PATCHDIR}/gtk+-1.2.10-utf8fontset.patch.gz | patch -p1 -E --backup --verbose
# Accept KP_Enter as a synonym for Return everywhere
zcat ${SB_PATCHDIR}/gtk+-1.2.10-kpenter.patch.gz | patch -p1 -E --backup --verbose
# Allow theme switching to work properly when no windows are realized
zcat ${SB_PATCHDIR}/gtk+-1.2.10-themeswitch.patch.gz | patch -p1 -E --backup --verbose
# Fix crash when switching themes
zcat ${SB_PATCHDIR}/gtk+-1.2.10-pixmapref.patch.gz | patch -p1 -E --backup --verbose
# Fix computation of width of missing characters
zcat ${SB_PATCHDIR}/gtk+-1.2.10-missingchar.patch.gz | patch -p1 -E --backup --verbose
# Fix sizes of Ukrainian fontsets
zcat ${SB_PATCHDIR}/gtk+-1.2.10-ukfont.patch.gz | patch -p1 -E --backup --verbose
# Fix file selection delete-dir when changing directory problem
# also, fix memory corruption problem when changing directories.
zcat ${SB_PATCHDIR}/gtk+-1.2.10-deletedir.patch.gz | patch -p1 -E --backup --verbose
# Improve warning for missing fonts
zcat ${SB_PATCHDIR}/gtk+-1.2.10-fontwarning.patch.gz | patch -p1 -E --backup --verbose
# Allow themes to make scrollbar trough always repaint
zcat ${SB_PATCHDIR}/gtk+-1.2.10-troughpaint.patch.gz | patch -p0 -E --backup --verbose
# Fix a crash that can happen in some apps when the current
# locale is not supported by XLib.
zcat ${SB_PATCHDIR}/gtk+-1.2.10-localecrash.patch.gz | patch -p1 -E --backup --verbose
# Patch from CVS to fix b.g.o #56349
zcat ${SB_PATCHDIR}/gtk+-1.2.10-dndorder.patch.gz | patch -p0 -E --backup --verbose
# Patch from CVS to fix b.g.o #94812
zcat ${SB_PATCHDIR}/gtk+-1.2.10-clistfocusrow.patch.gz | patch -p0 -E --backup --verbose
# Fix GTK+ to obey X server's default bell volume
zcat ${SB_PATCHDIR}/gtk+-1.2.10-bellvolume.patch.gz | patch -p1 -E --backup --verbose
# Hack up the configure scripts to deal with some obscure
# breakage with ancient libtool
zcat ${SB_PATCHDIR}/gtk+-1.2.10-libtool.patch.gz | patch -p1 -E --backup --verbose
# Add a dependency on libgdk to libgtk (#106677)
zcat ${SB_PATCHDIR}/gtk+-1.2.10-gtkgdkdep.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/gtk+-underquoted.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/gtk+-1.2.10-ppc64.patch.gz | patch -p1 -E --backup --verbose
# do not allow for undefined symbols in shared libraries -- Rex
zcat ${SB_PATCHDIR}/gtk+-1.2.10-no_undefined.patch.gz | patch -p1 -E --backup --verbose
# http://bugzilla.redhat.com/222298
zcat ${SB_PATCHDIR}/gtk+-1.2.10-multilib.patch.gz | patch -p1 -E --backup --verbose
# Remove redundant shared library dependencies
zcat ${SB_PATCHDIR}/gtk+-1.2.10-unused-deps.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
