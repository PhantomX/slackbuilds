zcat ${CWD}/${PNAME}-2.6.3-locale-compat.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${CWD}/${PNAME}-2.6.3-gtk-crash.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${CWD}/${PNAME}-2.6.3-g_thread_init.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${CWD}/${PNAME}-2.6.3-expat2.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${CWD}/${PNAME}-2.6.3-strconv.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${CWD}/${PNAME}-2.6.4-config-script.patch.gz | patch -p1 -E --backup --verbose || exit 1
