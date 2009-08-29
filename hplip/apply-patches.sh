  
SB_PATCHDIR=${CWD}/patches

# Upstream patch to fix paper size order and LJColor device class color space.
zcat ${SB_PATCHDIR}/${NAME}-hpcups-reorder.patch.gz | patch -p1 -E --backup --verbose || exit 1

zcat ${SB_PATCHDIR}/${NAME}-strstr-const.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Make utils.checkPyQtImport() look for the gui sub-package.
zcat ${SB_PATCHDIR}/${NAME}-ui-optional.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Make sure to avoid handwritten asm.
zcat ${SB_PATCHDIR}/${NAME}-no-asm.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Clear previous state reasons in the hp backend (bug #501338).
zcat ${SB_PATCHDIR}/${NAME}-clear-previous-state-reasons.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Don't hide state reason changes by missing out newlines in stderr.
zcat ${SB_PATCHDIR}/${NAME}-state-reasons-newline.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Fixed typos in page sizes (bug #515469).
zcat ${SB_PATCHDIR}/${NAME}-parenths.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Don't install base/*.py with executable bit set.
zcat ${SB_PATCHDIR}/${NAME}-non-scripts.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Set RequiresPageRegion in hpcups PPDs (bug #518756).
zcat ${SB_PATCHDIR}/${NAME}-requirespageregion.patch.gz | patch -p1 -E --backup --verbose || exit 1
