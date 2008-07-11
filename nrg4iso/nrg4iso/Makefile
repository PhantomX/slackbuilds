CC=gcc
CFLAGS=-Os -Wall

nrg4iso: main.o iso.o nrg.o endian.o
	$(CC) $(CFLAGS) -o $@ $> $^

main.o: main.c iso.h nrg.h globals.h

iso.o: iso.c iso.h globals.h

nrg.o: nrg.c nrg.h nrg_chunks.h iso.h globals.h

endian.o: endian.c endian.h globals.h

clean:
	rm -v *.o nrg4iso
