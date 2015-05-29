TEMPLATE = lib
VERSION = $$SOVERSION
TARGET = qcustomplot$$QTSUFFIX
QT = core gui widgets printsupport

SOURCES = qcustomplot.cpp
HEADERS = qcustomplot.h

target.path = $$LIBDIR
INSTALLS += target

header.path = /usr/include
header.files = qcustomplot.h
INSTALLS += header
