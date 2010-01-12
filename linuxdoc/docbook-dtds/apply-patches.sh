  
SB_PATCHDIR=${CWD}/patches

( cd 3.0-sgml || exit 1
  zcat ${SB_PATCHDIR}/docbook-dtd30-sgml-1.0.catalog.patch.gz | patch -p0 -E --backup --verbose || exit 1
) || exit 1
( cd 3.1-sgml || exit 1
  zcat ${SB_PATCHDIR}/docbook-dtd31-sgml-1.0.catalog.patch.gz | patch -p0 -E --backup --verbose || exit 1
) || exit 1
( cd 4.0-sgml || exit 1
  zcat ${SB_PATCHDIR}/docbook-dtd40-sgml-1.0.catalog.patch.gz | patch -p0 -E --backup --verbose || exit 1
) || exit 1
( cd 4.1-sgml || exit 1
  zcat ${SB_PATCHDIR}/docbook-dtd41-sgml-1.0.catalog.patch.gz | patch -p0 -E --backup --verbose || exit 1
) || exit 1
( cd 4.2-sgml || exit 1
  zcat ${SB_PATCHDIR}/docbook-dtd42-sgml-1.0.catalog.patch.gz | patch -p0 -E --backup --verbose || exit 1
) || exit 1
zcat ${SB_PATCHDIR}/docbook-4.2-euro.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/docbook-dtds-ents.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/docbook-sgml-systemrewrite.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/docbook-dtd412-entities.patch.gz | patch -p1 -E --backup --verbose || exit 1
