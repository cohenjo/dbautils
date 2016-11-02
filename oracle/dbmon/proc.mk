# 
# $Header: proc.mk.pp 1.4 95/04/26 10:28:11 jboyce Osd<unix> $ proc.mk.pp
# 
#
# proc.mk - Command file for "make" to compile and load Pro*C 2.0 programs.
#
# Usage to build any program:
#	make -f proc.mk EXE=xyz OBJS="a.o b.o c.o"
#
# Special syntax to link demo program:
#	make -f proc.mk sample1
#
# Special syntax to link and install proc executable:
#	make -f proc.mk install
#
# NOTE:   ORACLE_HOME must be either:
#		. set in the user's environment
#		. passed in on the command line
#		. defined in a modified version of this makefile
#
# Pro*C programs are assumed to have the extension ".pc"
#

SHELL=/bin/sh

LIBHOME=$(ORACLE_HOME)/lib

I_SYM= -I

CC=cc

CFLAGS=-I. -O

CFLAGS=-I. -O -Aa -D_HPUX_SOURCE +ESsfc +ESlit

LDFLAGS=-Wl,-adefault -L$(LIBHOME)

ARLOCAL=

AR=ar $(ARLOCAL)
ARCREATE=ar cr$(ARLOCAL)
ARDELETE=ar d$(ARLOCAL)
ARREPLACE=ar r$(ARLOCAL)

ECHO=$(ORACLE_HOME)/bin/echodo

OTHERLIBS=`cat $(ORACLE_HOME)/rdbms/lib/sysliblist` $(MLSLIBS)

LLIBPSO=

LLIBSQL=$(LIBHOME)/libsql
LLIBPSO=-lstublm

XLIBS=-lXt -lX11 -lm

XLIBHOME = /usr/lib
MOTIFLIBHOME = /usr/lib

MOTIFLIBS = -L$(MOTIFLIBHOME) -lXm -L$(XLIBHOME) -lXt -lX11 -lm

CLIBS=$(OTHERLIBS)

SO=a

NLSRTLHOME= $(SRCHOME)/nlsrtl3

NLSRTLLIB= -lnlsrtl3.a

LIBNLSRTL= $(LIBHOME)/libnlsrtl3.$(SO)
LLIBNLSRTL=-lnlsrtl3

NLSRTLINC = $(I_SYM)$(NLSRTLHOME)/public $(I_SYM)$(NLSRTLHOME)/sosd/public \
$(I_SYM)$(NLSRTLHOME)/include $(I_SYM)$(NLSRTLHOME)/src/nlsdata

NLSRTLPUBLIC = $(I_SYM)$(NLSRTLHOME)/public \
$(I_SYM)$(NLSRTLHOME)/sosd/public $(STDINCLUDE)

COREHOME= $(SRCHOME)/oracore3

LIBCORE= $(LIBHOME)/libcore3.$(SO)
LIBCV6= $(LIBHOME)/libc3v6.$(SO)
LLIBCORE= -lcore3
LLIBCV6= -lc3v6

CORELIBD= $(LIBNLSRTL) $(LIBCV6) $(LIBCORE)
CORELIBS= $(LLIBNLSRTL) $(LLIBCV6) $(LLIBCORE) $(LLIBNLSRTL) \
	$(LLIBCCOREFUND) $(LLIBCORE)

LIBNETWORK= $(LIBHOME)/libsqlnet.a
NTCONTAB= $(LIBHOME)/ntcontab.o

TNSLIBS= -lsqlnet
TNSLIBD= $(LIBSQLNET)

LIBSQLNET=$(LIBHOME)/libsqlnet.a
LLIBSQLNET=-lsqlnet
NETLIBD= $(OSNTAB) $(LIBSQLNET)
NETLIBS=  $(OSNTAB) $(LLIBSQLNET)

OSNTAB= $(LIBHOME)/osntab.o
OSNTABST= $(LIBHOME)/osntabst.o
LIBSQLNET= $(LIBHOME)/libsqlnet.a

SQLNETLIBS= -lsqlnet

LIBPLS= $(LIBHOME)/libpls.a
LLIBPLS= -lpls

ROSHOME= $(TK2HOME)/ros

ROSPUBLIC= $(I_SYM)$(ROSHOME)/include
ROSDEFS= $(I_SYM)$(ROSHOME)/defs

LIBROS= $(LIBHOME)/libros.a
LLIBROS= -lros

LIBTK2C= $(LIBHOME)/libtk2c.a
LLIBTK2C= -ltk2c
LIBTK2M= $(LIBHOME)/libtk2m.a
LLIBTK2M= -ltk2m

LIBQAP= $(LIBHOME)/libpartnerR5.a
LLIBQAP= -lpartnerR5

LIBTK2P= $(LIBHOME)/libtk2p.a
LLIBTK2P= -ltk2p
LIBTK2UC= $(LIBHOME)/libuc.a
LLIBTK2UC= -luc
LIBTK2REM= $(LIBHOME)/librem.a
LLIBTK2REM= -lrem
LIBTK2OT= $(LIBHOME)/libot.a
LLIBTK2OT= -lot
LIBTK2OTX= $(LIBHOME)/libotx.a

LLIBTK2OTX= -lotx

LIBTK2UT= $(LIBHOME)/libut.a

LLIBTK2UT= -lut

LIBTK2SL= $(LIBHOME)/libsl.a
LLIBTK2SL= -lsl
LIBTK2RE= $(LIBHOME)/libre.a

LLIBTK2RE= -lre

TK2UICLIBD= $(LIBTK2RE) $(LIBTK2UC) $(LIBTK2C) $(LIBTK2OT) $(LIBTK2REM) \
	$(LIBROS) $(LIBTK2P) $(LIBTK2UT) $(LIBTK2SL)

TK2UICLIBS= $(DYNAMIC_ON_TK2) \
	$(LLIBTK2SL) $(LLIBTK2RE) $(LLIBTK2UC) $(LLIBTK2C) $(LLIBTK2OT) \
	$(LLIBTK2RE) $(LLIBTK2REM) $(LLIBROS) $(LLIBTK2C) $(LLIBTK2P) \
	$(LLIBTK2C) $(LLIBTK2P) -lm $(LLIBTK2REM) $(LLIBTK2C) $(LLIBTK2OT) \
	$(LLIBTK2UT) $(LLIBTK2UC) $(LLIBTK2SL) $(LLIBTK2C) \
	$(DYNAMIC_OFF_TK2)

TK2UIMLIBD= $(LIBTK2OT) $(LIBTK2RE) $(LIBTK2UC) $(LIBTK2REM) $(LIBROS) \
	$(LIBTK2M) $(LIBTK2P) $(LIBTK2UT) $(LIBTK2SL)

TK2UIMLIBS= $(DYNAMIC_ON_TK2) \
	$(LLIBTK2OT) $(LLIBTK2RE) $(LLIBTK2UC) $(LLIBTK2REM) $(LLIBROS) \
	$(LLIBTK2M) $(LLIBTK2P) $(LLIBTK2M) $(LLIBTK2P) \
        $(LLIBTK2M) $(LLIBTK2OT) $(LLIBTK2UT) $(LLIBTK2SL) $(DYNAMIC_OFF_TK2)

PLSPECFILES=

LIBOCIC= $(LIBHOME)/libocic.a
LLIBOCIC= -locic

TTLIBD= $(NETLIBD) $(LIBORA) $(CORELIBD)

TTLIBS= $(NETLIBS) $(LLIBORA) $(LLIBSQLNET) $(LLIBORA) $(LIBPLSHACK) $(CORELIBS) $(LDLIBS) $(CLIBS)

STLIBDNOPLS= $(OSNTABST) $(CONFIG) $(CORELIBD) $(NETLIBD) $(RDBMSLIBDNOPLS)
STLIBD= $(OSNTABST) $(CONFIG) $(CORELIBD) $(NETLIBD) $(RDBMSLIBD)
STLIBSNOPLS= $(OSNTABST) $(CONFIG) $(RDBMSLIBSNOPLS) $(RDBMSLIBSNOPLS) \
 $(PLSPECFILES) $(LLIBSQLNET) $(LLIBORA) $(LLIBSQLNET) $(CORELIBS) $(LLIBPSO) \
 $(LDLIBS) $(CLIBS)
STLIBS= $(OSNTABST) $(CONFIG) $(RDBMSLIBS) $(RDBMSLIBS) $(PLSPECFILES) \
 $(LLIBSQLNET) $(LLIBORA) $(LLIBSQLNET) $(CORELIBS) $(LLIBPSO) $(LDLIBS) $(CLIBS)

LLIBNETV2= $(LIBNETV2)
LLIBNETWORK= $(LIBNETWORK)

CONFIG= $(LIBHOME)/config.o
OPIMAI= $(LIBHOME)/opimai.o
LIBORA= $(LIBHOME)/libora.a
LIBKNL= $(LIBHOME)/libknl.a
LIBKNLOPT= $(LIBHOME)/libknlopt.a

LLIBORA= -lora

LLIBKNL= -lknl
LLIBKNLOPT= -lknlopt

RDBMSLIBDNOPLS= $(LIBORA) $(LIBKNLOPT) $(LIBKNL)
RDBMSLIBD= $(LIBORA) $(LIBKNLOPT) $(LIBPLS) $(LIBKNL)
RDBMSLIBSNOPLS= $(LLIBORA) $(LLIBKNLOPT) $(LLIBKNL)
RDBMSLIBS= $(LLIBORA) $(LLIBKNLOPT) $(LLIBPLS) $(LLIBKNL)

LIBSOSD=
LLIBSOSD=

LIBPCORE=$(LIBHOME)/libpcore.a
LLIBPCORE= -lpcore

LIBCGEN= $(LIBHOME)/pdc.o
LIBFORGEN= $(LIBHOME)/pdf.o
LIBCOBGEN= $(LIBHOME)/pdb.o
LIBPASGEN= $(LIBHOME)/pdp.o
LIBADAGEN= $(LIBHOME)/pda.o
LIBPLIGEN= $(LIBHOME)/pd1.o
LIBOSDGEN= $(LIBHOME)/pds.o

CODEGENHOME= $(SRCHOME)/codegen

LIBSLAX=$(LIBHOME)/pxslax.o

SLAX=/usr/local/slax/newsx

.y.c:
	$(SLAX) -p -d -v $*.y

SQLHOME= $(ORACLE_HOME)/sqllib

SQLPUBLIC=$(I_SYM)$(SQLHOME)/public
LIBSQL= $(LIBHOME)/libsql.a
SQLLIBS= -lsql

LIBPROC20=$(LIBHOME)/libproc.a
LLIBPROC20= -lproc
LIBPRO= $(LIBPROC20)
LLIBPRO= $(LLIBPROC20)
PROLDLIBS= $(SQLLIBS) $(TTLIBS)

PROC=$(ORACLE_HOME)/bin/proc

PROCOBJS=$(ORACLE_HOME)/proc/lib/main.o \
	$(ORACLE_HOME)/proc/lib/pcdsfv.o \
	$(ORACLE_HOME)/proc/lib/pcdlut.o
PROCPLSFLAGS= sqlcheck=full userid=$(USERID) dbms=v6_char
USERID= scott/tiger
EXE= sample1
OBJS= sample1.o

SAMPLES=sample1 sample2 sample3 sample4 sample5 sample6 sample7 sample8 sample9 sample10 oraca sqlvcp cv_demo

all: build 

# Rule to compile any program (specify EXE= and OBJS= on command line)
build: $(OBJS)
	@if [ "$(ORA_CLIENT_LIB)" = "shared" ]; then \
	$(ECHO) $(CC) $(LDFLAGS) -o $(EXE) $(OBJS) -L$(LIBHOME) -lclntsh $(TTLIBS); \
	else \
	$(ECHO) $(CC) $(LDFLAGS) -o $(EXE) $(OBJS) $(PROLDLIBS) $(OTHERLIBS); \
	fi

# "Shorthand" Rule to compile all the sample program
samples: $(SAMPLES)

$(SAMPLES):
	$(MAKE) -f $(ORACLE_HOME)/proc/lib/proc.mk OBJS=$@.o EXE=$@ build

sample6.o: sample6.pc
	$(PROC) dbms=v6_char iname=$*.pc
	$(CC) $(CFLAGS) $(SQLPUBLIC) -c $*.c

sample9.o: sample9.pc
	$(PROC) $(PROCPLSFLAGS) iname=$*.pc
	$(CC) $(CFLAGS) $(SQLPUBLIC) -c $*.c

cv_demo.o: cv_demo.pc
	$(PROC) $(PROCPLSFLAGS) iname=$*.pc
	$(CC) $(CFLAGS) $(SQLPUBLIC) -c $*.c

# Suffix rules
.SUFFIXES: .exe .o .c .pc

.pc.c:
	$(PROC) $(PROFLAGS) iname=$*.pc 

.pc.o:
	$(PROC) $(PROFLAGS) iname=$*.pc
	$(CC) $(CFLAGS) $(SQLPUBLIC) -c $*.c

.c.o:
	$(CC) $(CFLAGS) $(SQLPUBLIC) -c $*.c

LIBDIR= $(ORACLE_HOME)/proc/lib
DEMODIR= $(ORACLE_HOME)/proc/demo

install_files:
	-rm -f $(DEMODIR)/proc.mk
	-ln $(LIBDIR)/proc.mk $(DEMODIR)/proc.mk

# Rules to relink the proc executable
install: clean proc
	-chmod 755 $(ORACLE_HOME)/bin/proc
	-mv proc $(ORACLE_HOME)/bin/proc
	-chmod 755 $(ORACLE_HOME)/bin/proc

clean:
	-rm -f proc

LIBPLSHACK= $(LLIBPLS)
proc:
	@$(ECHO) $(CC) $(LDFLAGS) -o proc $(PROCOBJS) $(LLIBPROC20) \
	$(LIBCGEN) $(LIBSLAX) $(LIBOSDGEN) $(LIBPCORE) $(LLIBPLS) $(TTLIBS)

