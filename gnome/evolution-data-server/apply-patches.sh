
SB_PATCHDIR=${CWD}/patches

# RH bug #215702 / GNOME bug #487988
zcat ${SB_PATCHDIR}/${NAME}-1.8.0-fix-ldap-query.patch.gz | patch -p1 -E --backup --verbose || exit 1
# GNOME bug #373146
zcat ${SB_PATCHDIR}/${NAME}-1.10.1-camel-folder-summary-crash.patch.gz | patch -p1 -E --backup --verbose || exit 1
# RH bug #243296
#zcat ${SB_PATCHDIR}/${NAME}-1.11.5-fix-64bit-acinclude.patch.gz | patch -p1 -E --backup --verbose || exit 1
