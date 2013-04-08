
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
( cd 3.0-sgml
  zcat ${SB_PATCHDIR}/docbook-dtd30-sgml-1.0.catalog.patch.gz | patch -p0 -E --backup --verbose
)
( cd 3.1-sgml
  zcat ${SB_PATCHDIR}/docbook-dtd31-sgml-1.0.catalog.patch.gz | patch -p0 -E --backup --verbose
)
( cd 4.0-sgml
  zcat ${SB_PATCHDIR}/docbook-dtd40-sgml-1.0.catalog.patch.gz | patch -p0 -E --backup --verbose
)
( cd 4.1-sgml
  zcat ${SB_PATCHDIR}/docbook-dtd41-sgml-1.0.catalog.patch.gz | patch -p0 -E --backup --verbose
)
( cd 4.2-sgml
  zcat ${SB_PATCHDIR}/docbook-dtd42-sgml-1.0.catalog.patch.gz | patch -p0 -E --backup --verbose
)
zcat ${SB_PATCHDIR}/docbook-4.2-euro.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/docbook-dtds-ents.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/docbook-sgml-systemrewrite.patch
zcat ${SB_PATCHDIR}/docbook-dtd412-entities.patch.gz | patch -p1 -E --backup --verbose


set +e +o pipefail
