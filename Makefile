# $Id: Makefile,v 1.8 2002/05/06 13:06:03 matthew Exp $

CC=gcc
CFLAGS=-g -Wall -Werror
LDFLAGS=-g

PROGS=filtergen
PREFIX=/usr/local
BINDIR=$(PREFIX)/sbin
MANDIR=$(PREFIX)/share/man

LDFLAGS=-lfl

all: $(PROGS)

%.yy.c: %.l
	flex -B -o$@ $<

OBJS=filtergen.o gen.o filter.o filterlex.yy.o fg-util.o fg-iptables.o fg-ipchains.o fg-ipfilter.o fg-cisco.o

filtergen: $(OBJS)
	$(CC) -o $@ $(OBJS) $(LDFLAGS)

clean:
	rm -f *.o *~ core $(PROGS) *.yy.c

install:
	install -d $(BINDIR) $(MANDIR)/man{5,8}
	install -m755 $(PROGS) $(BINDIR)
	install -m644 *.5 $(MANDIR)/man5
	install -m644 *.8 $(MANDIR)/man8
