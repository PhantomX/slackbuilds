  
SB_PATCHDIR=${CWD}/patches

# ntpbz #628, #1073
zcat ${SB_PATCHDIR}/${NAME}-4.2.4p4-kernel.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-4.2.4p0-droproot.patch.gz | patch -p1 -E --backup --verbose || exit 1
# ntpbz #812
zcat ${SB_PATCHDIR}/${NAME}-4.2.4-groups.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-4.2.4p2-tentative.patch.gz | patch -p1 -E --backup --verbose || exit 1
# ntpbz #897
zcat ${SB_PATCHDIR}/${NAME}-4.2.4p2-noseed.patch.gz | patch -p1 -E --backup --verbose || exit 1
# ntpbz #830
zcat ${SB_PATCHDIR}/${NAME}-4.2.4p4-multilisten.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-4.2.4-html2man.patch.gz | patch -p1 -E --backup --verbose || exit 1
# ntpbz #898
zcat ${SB_PATCHDIR}/${NAME}-4.2.4p5-htmldoc.patch.gz | patch -p1 -E --backup --verbose || exit 1
# fixed in 4.2.5
zcat ${SB_PATCHDIR}/${NAME}-4.2.4p2-filegen.patch.gz | patch -p1 -E --backup --verbose || exit 1
# ntpbz #738
zcat ${SB_PATCHDIR}/${NAME}-4.2.4-sprintf.patch.gz | patch -p1 -E --backup --verbose || exit 1
# add option -m to lock memory
zcat ${SB_PATCHDIR}/${NAME}-4.2.4p6-mlock.patch.gz | patch -p1 -E --backup --verbose || exit 1
# fixed in 4.2.5
zcat ${SB_PATCHDIR}/${NAME}-4.2.4p2-clockselect.patch.gz | patch -p1 -E --backup --verbose || exit 1
# don't build sntp
zcat ${SB_PATCHDIR}/${NAME}-4.2.4p2-nosntp.patch.gz | patch -p1 -E --backup --verbose || exit 1
# ntpbz #802
zcat ${SB_PATCHDIR}/${NAME}-4.2.4p5-sleep.patch.gz | patch -p1 -E --backup --verbose || exit 1
# ntpbz #779, #823
zcat ${SB_PATCHDIR}/${NAME}-4.2.4p5-bcast.patch.gz | patch -p1 -E --backup --verbose || exit 1
# ntpbz #759
zcat ${SB_PATCHDIR}/${NAME}-4.2.4p0-retcode.patch.gz | patch -p1 -E --backup --verbose || exit 1
# ntpbz #397
zcat ${SB_PATCHDIR}/${NAME}-4.2.4p2-noif.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-4.2.4p4-ipv6.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-4.2.4p4-cmsgalign.patch.gz | patch -p1 -E --backup --verbose || exit 1
# clock_gettime needs -lrt
sed -i.gettime 's|^LIBS = @LIBS@|& -lrt|' ntp{d,q,dc,date}/Makefile.in
zcat ${SB_PATCHDIR}/${NAME}-4.2.4p4-gettime.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-4.2.4p4-resinit.patch.gz | patch -p1 -E --backup --verbose || exit 1
# ntpbz #992
zcat ${SB_PATCHDIR}/${NAME}-4.2.4p5-rtnetlink.patch.gz | patch -p1 -E --backup --verbose || exit 1
# remove when #460561 is fixed
zcat ${SB_PATCHDIR}/${NAME}-4.2.4p5-retryres.patch.gz | patch -p1 -E --backup --verbose || exit 1
# ntpbz #808
zcat ${SB_PATCHDIR}/${NAME}-4.2.4p5-driftonexit.patch.gz | patch -p1 -E --backup --verbose || exit 1

#zcat ${SB_PATCHDIR}/${NAME}-4.2.4-linkfastmath.patch.gz | patch -p1 -E --backup --verbose || exit 1

# replace BSD with advertising code in ntp{dc,q} to allow linking with readline
for f in include/{ntp_rfc2553,rsa_md5}.h \
  libntp/{mktime,memmove,md5c,ntp_rfc2553,ntp_random}.c
do rm -f ${f}; touch ${f}; done
ln -sf md5.h include/rsa_md5.h
ln -sf md5.c libntp/md5c.c
zcat ${SB_PATCHDIR}/${NAME}-4.2.4p4-bsdadv.patch.gz | patch -p1 -E --backup --verbose || exit 1

if [ "${SB_AVAHI}" != "YES" ] ;then
  zcat ${SB_PATCHDIR}/${NAME}-4.2.4p6-noavahi.patch.gz | patch -p0 -E --backup --verbose || exit 1
  autoreconf -if || exit 1
fi
