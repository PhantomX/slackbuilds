# konqinfohelper Makefile

# Copyright (C) 2010 Phantom X, Goiania, Brazil.
# This Makefile.in is free software; the author
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY, to the extent permitted by law; without
# even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE.

SHELL=/bin/sh

PACKAGE = konqinfohelper
VERSION = 1.0

DESTDIR =
PREFIX = /usr
SRVMENUDIR = `kde4-config --install services`ServiceMenus
DATADIR = `kde4-config --install data`$(PACKAGE)
MANDIR = $(PREFIX)/share/man/man1
SYSCONFDIR = /etc
LOCALEDIR = $(KDEPREFIX)/share/locale
DOCDIR = $(PREFIX)/share/doc/$(PACKAGE)-$(VERSION)

SRVFILES = gifinfo.desktop jpginfo.desktop m4ainfo.desktop mkvinfo.desktop \
           mp3info.desktop mpginfo.desktop ogginfo.desktop pdfinfo.desktop \
           pnginfo.desktop wavinfo.desktop
BINFILES = konqinfohelper

DOCS = README ChangeLog COPYING
MANPAGE =
POFILES =

srcdir = .
top_srcdir = .
subdir = .

am__cd = CDPATH="$${ZSH_VERSION+.}$(PATH_SEPARATOR)" && cd
GZIP_ENV = --best
AMTAR = tar
am__tar = ${AMTAR} chof - "$$tardir"
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
DIST_COMMON = $(srcdir)/Makefile COPYING ChangeLog README bin servicemenus

all:

install: all
	mkdir -p -m 0755 $(DESTDIR)$(SRVMENUDIR)
	mkdir -p -m 0755 $(DESTDIR)$(DATADIR)
	for servicemenu in $(SRVFILES) ; do \
	  install -m 0644 servicemenus/$${servicemenu} $(DESTDIR)$(SRVMENUDIR)/$${servicemenu} ;\
	  sed -i -e "s|_DATADIR_|$(DATADIR)|g" $(DESTDIR)$(SRVMENUDIR)/$${servicemenu} ;\
	done
	for binfile in $(BINFILES) ; do \
	  install -m 0755 bin/$${binfile} $(DESTDIR)$(DATADIR)/$${binfile} ;\
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
	for servicemenu in $(SRVFILES) ; do \
	  rm -f $(DESTDIR)$(KDEAPLNKDIR)/$${servicemenu} ;\
	done
	for binfile in $(BINFILES) ; do \
	  rm -f $(DESTDIR)$(DATADIR)/$${binfile} ;\
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
