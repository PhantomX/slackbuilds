#!/bin/sh

set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

zcat ${SB_PATCHDIR}/${NAME}-2007-png14.patch.gz | patch -p0 -E --backup --verbose

######
# Red Hat-specific TeX configuration patches
######

# and sane defaults to build against can be inserted via sed
zcat ${SB_PATCHDIR}/${NAME}-2007-browser.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-teckit.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-fedora_paths.patch.gz | patch -p1 -E --backup --verbose

######
# TeX patches
######

zcat ${SB_PATCHDIR}/${NAME}-2007-makej.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2007-badscript.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2007-tmpcleanup.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-fmtutil-infloop.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2007-kpse-extensions.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-more_paths.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-CVE-2007-4033.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-dvipsoverflow.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-dviljktemp.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-poppler.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-man-notetex.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-man-context.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-lacheck.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-elif.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-getline.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-poolfix.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-dvipsconfig.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-CVE-2010-0829-dvipng-multiple-array-indexing-errors.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-CVE-2010-0739_1440-integer-overflows.patch

######
# mpeters contributed patches
######
# fixes man pages to utf-8
zcat ${SB_PATCHDIR}/${NAME}-2007-copyright-utf8-man.patch.gz | patch -p1 -E --backup --verbose
# use proper shellbang
zcat ${SB_PATCHDIR}/${NAME}-2007-epstopdf-shellbang.patch.gz | patch -p1 -E --backup --verbose

######
# Debian patches
######
zcat ${SB_PATCHDIR}/${NAME}-Build_script.patch.gz | patch -p3 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-mktexlsr_fixes.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-fix_pkfix_invocation.patch.gz | patch -p3 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-12a_fix_thumbpdf_invocation.patch.gz | patch -p3 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-12b_fix_a2ping_invocation.patch.gz | patch -p3 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-12c_fix_pdfcrop_invocation.patch.gz | patch -p3 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-12d_fix_ebong_invocation.patch.gz | patch -p3 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-12e_fix_vpe_invocation.patch.gz | patch -p3 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-texdoc.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-dvips_fontbug_fix_upstream.patch.gz | patch -p3 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-maketexmf.patch.gz | patch -p3 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-fmtutil_keep_failedlog.patch.gz | patch -p3 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-checklib_fixes.patch.gz | patch -p3 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-fix_makempx_installation.patch.gz | patch -p3 -E --backup --verbose

######
# Mandriva patches
######
zcat ${SB_PATCHDIR}/${NAME}-pdftex.patch.gz | patch -p1 -E --backup --verbose

######
# Suse patches
######
zcat ${SB_PATCHDIR}/${NAME}-source-icu.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-source-t1lib.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-source-warns.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-source-x11r7.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-source-CVE-2007-0650.patch.gz | patch -p0 -E --backup --verbose

# 1000-: Japanese pTeX
zcat ${SB_PATCHDIR}/${NAME}-2007-fmtutil-ptex.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
