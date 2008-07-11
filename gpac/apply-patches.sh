zcat ${CWD}/010_all_configure.patch.gz | patch -p1 --verbose || exit 1
zcat ${CWD}/020_all_nostrip.patch.gz | patch -p1 --verbose || exit 1
zcat ${CWD}/030_all_destdir.patch.gz | patch -p1 --verbose || exit 1
zcat ${CWD}/040_all_soname.patch.gz | patch -p1 --verbose || exit 1
zcat ${CWD}/050_all_pic.patch.gz | patch -p1 --verbose || exit 1
zcat ${CWD}/060_all_recursivemake.patch.gz | patch -p1 --verbose || exit 1
zcat ${CWD}/070_all_bsd.patch.gz | patch -p1 --verbose || exit 1
zcat ${CWD}/080_all_configdefines.patch.gz | patch -p1 --verbose || exit 1
