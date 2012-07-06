CC=gcc
#OPTFLAGS=-g -O0
OPTFLAGS=-O3
CFLAGS=-Wall -fPIC $(OPTFLAGS)
LDFLAGS=$(OPTFLAGS)

MODULES_LIB = sha2.o
MODULES_PROG = sha2prog.o
MODULES_SPEED = sha2speed.o

VERSION := 1.0.1
VERSION_MAJ := $(shell echo $(VERSION) |sed 's/\..*//')
LIBNAME=libsha2.so
SONAME=$(LIBNAME).$(VERSION_MAJ)


all: libsha2 sha2 sha2speed

libsha2: $(MODULES_LIB)
	$(CC) $(LDFLAGS) -shared -fPIC -Wl,-soname,$(SONAME) -o $(LIBNAME).$(VERSION) $(MODULES_LIB)
	ln -sf $(LIBNAME).$(VERSION) $(SONAME)
	ln -sf $(SONAME) $(LIBNAME)

sha2: libsha2 $(MODULES_PROG)
	$(CC) $(MODULES_PROG) $(LDFLAGS) -o sha2 -L. -lsha2

sha2speed: libsha2 $(MODULES_SPEED)
	$(CC) $(MODULES_SPEED) $(LDFLAGS) -o sha2speed -L. -lsha2

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	rm -f *.o sha2 sha2speed
	rm -f *.so*

PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin
LIBDIR ?= $(PREFIX)/lib
INCLUDEDIR ?= $(PREFIX)/include

install: all
	install -d $(DESTDIR)$(BINDIR)
	install sha2 sha2speed $(DESTDIR)$(BINDIR)
	install -d $(DESTDIR)$(INCLUDEDIR)
	install -pm 644 sha2.h $(DESTDIR)$(INCLUDEDIR)
	install -d $(DESTDIR)$(LIBDIR)
	install $(LIBNAME).$(VERSION) $(LIBNAME) $(SONAME) $(DESTDIR)$(LIBDIR)
	ln -sf $(LIBNAME).$(VERSION) $(DESTDIR)$(LIBDIR)/$(SONAME)
	ln -sf $(SONAME) $(DESTDIR)$(LIBDIR)/$(LIBNAME)

.PHONY: clean all libsha2 sha2 sha2speed install
