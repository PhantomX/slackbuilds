#!/bin/sh

mkdir texlive-source-free
cd texlive-source-free
tar -xjvf ../source.tar.bz2
for file in texk/texlive/nts.pl \
 texk/dvipsk/contrib/bbfig/bb.ps \
 texk/dvipsk/contrib/pspic/pspic.sty \
 texk/dvipsk/contrib/psfntmac/ps_lfonts.tex \
 texk/dvipsk/contrib/psfntmac/ps_plain.tex \
 texk/dvpisk/contrib/timesmat.sty \
 texk/dvpisk/contrib/MakeTeXPK.pl\
 ; do
   rm $file
done

tar -cjvf ../source-free.tar.bz2 .
cd ..
rm -rf texlive-source-free

