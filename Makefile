#
# Makefile
#
# $Id: //poco/1.4/Util/samples/SampleServer/Makefile#1 $
#
# Makefile for Poco SampleServer
#
POCO_BASE = thirdparty/sources/poco

CC = g++
CFLAGS = -I$(POCO_BASE)/include
LDFLAGS = -L$(POCO_BASE)/lib/Linux/x86_64
LDLIBS = -lPocoUtil -lPocoXML -lPocoFoundation -lpthread

SOURCE_DIR = src
OUTPUT_DIR = out

sources = $(wildcard $(SOURCE_DIR)/*.cpp)
objects = $(patsubst %.c,%.o, $(sources))

target = $(OUTPUT_DIR)/SampleServer

.PHONY: all
all: $(target)

%.o: %.cpp
	$(CC) -c -o $@ $< $(CFLAGS)

$(target): $(objects)
	$(CC) -o $@ $^ $(LDFLAGS) $(LDLIBS)

.PHONY: clean
clean:
	rm $(target) $(objects)
