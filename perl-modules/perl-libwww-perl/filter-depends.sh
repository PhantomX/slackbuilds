#!/bin/sh

/usr/lib/rpm/find-requires.perl $* | grep -v HTTP::GHTTP | grep -v Win32 | grep -v NTLM
