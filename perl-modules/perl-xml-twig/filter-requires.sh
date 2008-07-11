#!/bin/sh

/usr/lib/rpm/find-requires $* | grep -v 'perl(XML::XPath)'
