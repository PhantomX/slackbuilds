#!/bin/bash

test -d ${HOME}/.sauerbraten || mkdir ${HOME}/.sauerbraten
cd ${HOME}/.sauerbraten
for i in data packages ; do
	rm -f ${i}
	ln -s SHAREDIR/sauerbraten/${i} ${i}
done
exec LIBDIR/sauerbraten/BINARY "$@"
