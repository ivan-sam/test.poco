#
# Makefile
#
# $Id: //poco/1.4/Util/samples/SampleServer/Makefile#1 $
#
# Makefile for Poco SampleServer
#
POCO_BASE = /code/Igrosoft/thirdparty/sources/Poco

CC = g++
CFLAGS = -I$(POCO_BASE)/include
LDFLAGS = -L$(POCO_BASE)/lib/Linux/x86_64
LIBS = -lPocoUtil -lPocoXML -lPocoFoundation -lpthread

objects = SampleServer.o

target         = SampleServer
target_version = 1
target_libs    = PocoUtil PocoXML PocoFoundation

#include $(POCO_BASE)/build/rules/exec

.PHONY: all
all : $(target)

%.o : %.cpp
	$(CC) -c -o $@ $< $(CFLAGS)

$(target) : $(objects)
	$(CC) -o $@ $^ $(LDFLAGS) $(LIBS)
