  
SB_PATCHDIR=${CWD}/patches

# Fix desktop file.
zcat ${SB_PATCHDIR}/${NAME}-desktop.patch.gz | patch -p1 -E --backup --verbose || exit 1

zcat ${SB_PATCHDIR}/${NAME}-segfault.patch.gz | patch -p1 -E --backup --verbose || exit 1

zcat ${SB_PATCHDIR}/${NAME}-quit.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Low ink is a warning condition, not an error.
zcat ${SB_PATCHDIR}/${NAME}-marker-supply.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Link libsane-hpaio against libsane (bug #234813).
zcat ${SB_PATCHDIR}/${NAME}-libsane.patch.gz | patch -p1 -E --backup --verbose || exit 1

zcat ${SB_PATCHDIR}/${NAME}-dbus.patch.gz | patch -p1 -E --backup --verbose || exit 1

zcat ${SB_PATCHDIR}/${NAME}-strstr-const.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Prevent SELinux audit message from the CUPS backends
# zcat ${CWD}/${NAME}-no-root-config.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Make utils.checkPyQtImport() look for the gui sub-package.
zcat ${SB_PATCHDIR}/${NAME}-ui-optional.patch.gz | patch -p1 -E --backup --verbose || exit 1

# From Slackware stock
# Fix an issue that could cause high CPU utilization after switching to a different user.
zcat ${SB_PATCHDIR}/${NAME}-3.9.2-high_cpu_utilization_logout.patch.gz | patch -p0 -E --backup --verbose || exit 1
