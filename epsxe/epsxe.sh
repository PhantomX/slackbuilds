#!/bin/sh
if ! test -d LIBDIR/psx-plugins ; then
	echo 'Install psx-plugins package first!'
	exit 1
fi

test -d ${HOME}/.epsxe || mkdir ${HOME}/.epsxe
test -e ${HOME}/.epsxe/epsxe || ln -sf BINDIR/epsxe.bin ${HOME}/.epsxe/epsxe
test -f ${HOME}/.epsxe/keycodes.lst || ln -sf SHAREDIR/epsxe/keycodes.lst ${HOME}/.epsxe/keycodes.lst
test -e ${HOME}/.epsxe/bios || ln -sf SHAREDIR/epsxe/bios ${HOME}/.epsxe/bios
test -e ${HOME}/.epsxe/plugins || ln -sf LIBDIR/psx-plugins/plugin ${HOME}/.epsxe/plugins
if ! test -d ${HOME}/.epsxe/cfg ; then
	mkdir ${HOME}/.epsxe/cfg
fi
for i in LIBDIR/psx-plugins/cfg/* ; do
	test -e ${HOME}/.epsxe/cfg/${i##*/} || ln -s $i ${HOME}/.epsxe/cfg
done
if ! test -d ${HOME}/.epsxe/cheats ; then
	mkdir ${HOME}/.epsxe/cheats
fi
for i in SHAREDIR/epsxe/cheats/* ; do
	test -e ${HOME}/.epsxe/cheats/${i##*/} || ln -s $i ${HOME}/.epsxe/cheats
done
if ! test -d ${HOME}/.epsxe/patches ; then
	mkdir ${HOME}/.epsxe/patches
fi
for i in SHAREDIR/epsxe/patches/* ; do
	test -e ${HOME}/.epsxe/patches/${i##*/} || ln -s $i ${HOME}/.epsxe/cheats
done
test -d ${HOME}/.epsxe/memcards || mkdir ${HOME}/.epsxe/memcards
test -d ${HOME}/.epsxe/sstates || mkdir ${HOME}/.epsxe/sstates
test -d ${HOME}/.epsxe/snap || mkdir ${HOME}/.epsxe/snap

cd ${HOME}/.epsxe
exec ./epsxe
