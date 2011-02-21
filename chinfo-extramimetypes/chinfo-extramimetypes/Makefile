# chinfo-extramimetypes Makefile

# Copyright (C) 2008, 2010 Phantom X, Goiania, Brazil.
# This Makefile.in is free software; the author
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY, to the extent permitted by law; without
# even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE.

SHELL=/bin/sh

PACKAGE = chinfo-extramimetypes
VERSION = 8.1

DESTDIR =
PREFIX = /usr
DATADIR = $(PREFIX)/share
MIMEDIR = $(DATADIR)/mime/packages
KDEPREFIX=`kde-config --prefix`
KDEAPLNKDIR = `kde-config --expandvars --install apps`
KDEMIMEDIR = `kde-config --expandvars --install mime`
MANDIR = $(PREFIX)/share/man/man1
SYSCONFDIR = /etc
LOCALEDIR = $(KDEPREFIX)/share/locale
DOCDIR = $(PREFIX)/share/doc/$(PACKAGE)-$(VERSION)

SMIFILES =  \
	chinfo-extramimetypes-cdimage.xml \
	chinfo-extramimetypes-gm.xml \
	chinfo-extramimetypes-hash.xml \
	chinfo-extramimetypes-slackbuild.xml

HIDDENFILES = \
	geany-desktop.desktop \
	geany-hash.desktop \
	geany-xgettext.desktop \
	gimp-ico.desktop \
	gimp-xcf.desktop \
	kwrite-desktop.desktop \
	kwrite-hash.desktop \
	kwrite-php.desktop \
	kwrite-xgettext.desktop \
	mozilla-firefox-maf.desktop \
	redhat-audio-player-extra.desktop

APPFILES = \
	x-bin.desktop x-c2d.desktop \
	x-cdi.desktop x-img.desktop \
	x-la.desktop \
	x-lzma.desktop x-maf.desktop \
	x-mdf.desktop x-nrg.desktop \
	x-ofc.desktop \
	x-ofr.desktop x-ofs.desktop \
	x-shorten.desktop \
	x-slackbuild.desktop \
	x-tlz.desktop x-txz.desktop \
	x-xz.desktop \
	x-lzma-compressed-tar.desktop \
	x-xz-compressed-tar.desktop

AUDIOFILES = \
	x-2sf.desktop \
	x-ape.desktop \
	x-bonk.desktop \
	x-dsf.desktop \
	x-gsf.desktop \
	x-gym.desktop \
	x-mac.desktop \
	x-nsf.desktop \
	x-pac.desktop \
	x-psf.desktop \
	x-qsf.desktop \
	x-spc.desktop \
	x-ssf.desktop \
	x-tta.desktop \
	x-usf.desktop \
	x-wavpack-correction.desktop \
	x-wavpack.desktop

TEXTFILES = \
	md5.desktop \
	md6.desktop \
	sha1.desktop \
	sha224.desktop \
	sha256.desktop \
	sha384.desktop \
	sha512.desktop

VIDEOFILES = \
	x-flv.desktop

DOCS = README ChangeLog COPYING
MANPAGE =
POFILES =

srcdir = .
top_srcdir = .
subdir = .

am__cd = CDPATH="$${ZSH_VERSION+.}$(PATH_SEPARATOR)" && cd
GZIP_ENV = --best
AMTAR = tar
am__tar = ${AMTAR} chf - "$$tardir"
am__untar = ${AMTAR} xf -

mkdir_p = mkdir -p --

DISTFILES = $(DIST_COMMON)
distdir = $(PACKAGE)-$(VERSION)
top_distdir = $(distdir)
am__remove_distdir = \
  { test ! -d $(distdir) \
    || { find $(distdir) -type d ! -perm -200 -exec chmod u+w {} ';' \
         && rm -fr $(distdir); }; }
DIST_ARCHIVES = $(distdir).tar.gz
distuninstallcheck_listfiles = find . -type f -print
distcleancheck_listfiles = find . -type f -print
DIST_COMMON = $(srcdir)/Makefile COPYING ChangeLog README chinfo-extramimetypes.spec \
	SlackBuild audio application hidden smi text video

all:

install: all
	mkdir -p -m 0755 $(DESTDIR)$(MIMEDIR)
	mkdir -p -m 0755 $(DESTDIR)$(KDEAPLNKDIR)/.hidden
	mkdir -p -m 0755 $(DESTDIR)$(KDEMIMEDIR)/application
	mkdir -p -m 0755 $(DESTDIR)$(KDEMIMEDIR)/audio
	mkdir -p -m 0755 $(DESTDIR)$(KDEMIMEDIR)/text
	mkdir -p -m 0755 $(DESTDIR)$(KDEMIMEDIR)/video
	for xml in $(SMIFILES) ; do \
	  install -m 0644 smi/$${xml} $(DESTDIR)$(MIMEDIR)/$${xml} ;\
	done
	for desktop in $(HIDDENFILES) ; do \
	  install -m 0644 hidden/$${desktop} $(DESTDIR)$(KDEAPLNKDIR)/.hidden/$${desktop} ;\
	done
	for desktop in $(APPFILES) ; do \
	  install -m 0644 application/$${desktop} $(DESTDIR)$(KDEMIMEDIR)/application/$${desktop} ;\
	done
	for desktop in $(AUDIOFILES) ; do \
	  install -m 0644 audio/$${desktop} $(DESTDIR)$(KDEMIMEDIR)/audio/$${desktop} ;\
	done
	for desktop in $(TEXTFILES) ; do \
	  install -m 0644 text/$${desktop} $(DESTDIR)$(KDEMIMEDIR)/text/$${desktop} ;\
	done
	for desktop in $(VIDEOFILES) ; do \
	  install -m 0644 video/$${desktop} $(DESTDIR)$(KDEMIMEDIR)/video/$${desktop} ;\
	done
#	install -m644 -D $(MANPAGE) $(DESTDIR)$(MANDIR)/$(MANPAGE)
#	gzip $(DESTDIR)$(MANDIR)/$(MANPAGE)
	mkdir -p -m 0755 $(DESTDIR)$(DOCDIR)
	install -m 0644 $(DOCS) $(DESTDIR)$(DOCDIR)/
# 	for pofile in $(POFILES) ; do \
# 	 pobase=`basename $$pofile .po` ;\
# 	 install -d $(DESTDIR)$(LOCALEDIR)/$$pobase/LC_MESSAGES ;\
# 	 msgfmt -o $(DESTDIR)$(LOCALEDIR)/$$pobase/LC_MESSAGES/kdelibs-extramimetypes.mo po/$$pofile ;\
# 	done

uninstall:
	for xml in $(SMIFILES) ; do \
	  rm -f smi/$${xml} $(DESTDIR)$(MIMEDIR)/$${xml} ;\
	done
	for desktop in $(HIDDENFILES) ; do \
	  rm -f $(DESTDIR)$(KDEAPLNKDIR)/.hidden/$${desktop} ;\
	done
	for desktop in $(APPFILES) ; do \
	  rm -f $(DESTDIR)$(KDEMIMEDIR)/application/$${desktop} ;\
	done
	for desktop in $(AUDIOFILES) ; do \
	  rm -f $(DESTDIR)$(KDEMIMEDIR)/audio/$${desktop} ;\
	done
	for desktop in $(TEXTFILES) ; do \
	  rm -f $(DESTDIR)$(KDEMIMEDIR)/text/$${desktop} ;\
	done
	for desktop in $(VIDEOFILES) ; do \
	  rm -f $(DESTDIR)$(KDEMIMEDIR)/video/$${desktop} ;\
	done
	rm -rf $(DESTDIR)$(DOCDIR)
#	rm $(DESTDIR)$(MANDIR)/$(MANPAGE).gz
#	rm -rf $(DESTDIR)$(DOCSDIR)
# 	for pofile in $(POFILES) ; do \
# 	 pobase=`basename $$pofile .po` \
# 	 rm -f $(DESTDIR)$(LOCALEDIR)/$$pobase/LC_MESSAGES/kdelibs-extramimetypes.mo \
# 	done

clean:

distdir: $(DISTFILES)
	$(am__remove_distdir)
	mkdir $(distdir)
	@srcdirstrip=`echo "$(srcdir)" | sed 's|.|.|g'`; \
	topsrcdirstrip=`echo "$(top_srcdir)" | sed 's|.|.|g'`; \
	list='$(DISTFILES)'; for file in $$list; do \
	  case $$file in \
	    $(srcdir)/*) file=`echo "$$file" | sed "s|^$$srcdirstrip/||"`;; \
	    $(top_srcdir)/*) file=`echo "$$file" | sed "s|^$$topsrcdirstrip/|$(top_builddir)/|"`;; \
	  esac; \
	  if test -f $$file || test -d $$file; then d=.; else d=$(srcdir); fi; \
	  dir=`echo "$$file" | sed -e 's,/[^/]*$$,,'`; \
	  if test "$$dir" != "$$file" && test "$$dir" != "."; then \
	    dir="/$$dir"; \
	    $(mkdir_p) "$(distdir)$$dir"; \
	  else \
	    dir=''; \
	  fi; \
	  if test -d $$d/$$file; then \
	    if test -d $(srcdir)/$$file && test $$d != $(srcdir); then \
	      cp -pR $(srcdir)/$$file $(distdir)$$dir || exit 1; \
	    fi; \
	    cp -pR $$d/$$file $(distdir)$$dir || exit 1; \
	  else \
	    test -f $(distdir)/$$file \
	    || cp -p $$d/$$file $(distdir)/$$file \
	    || exit 1; \
	  fi; \
	done
	-find $(distdir) -type d ! -perm -777 -exec chmod a+rwx {} \; -o \
	  ! -type d ! -perm -444 -links 1 -exec chmod a+r {} \; -o \
	  ! -type d ! -perm -400 -exec chmod a+r {} \; -o \
	  ! -type d ! -perm -444 -exec $(SHELL) $(install_sh) -c -m a+r {} {} \; \
	|| chmod -R a+r $(distdir)

dist-gzip: distdir
	tardir=$(distdir) && $(am__tar) | GZIP=$(GZIP_ENV) gzip -c >$(distdir).tar.gz
	$(am__remove_distdir)

dist-bzip2: distdir
	tardir=$(distdir) && $(am__tar) | bzip2 -9 -c >$(distdir).tar.bz2
	$(am__remove_distdir)

dist-xz: distdir
	tardir=$(distdir) && $(am__tar) | xz -9 -c >$(distdir).tar.xz
	$(am__remove_distdir)

dist dist-all: dist-xz

.NOEXPORT:
