#
# Makefile
#
# $Id: //poco/1.4/Util/samples/SampleServer/Makefile#1 $
#
# Makefile for Poco SampleServer
#
BASE_DIR = $(abspath $(CURDIR))
SOURCE_DIR = $(BASE_DIR/)src
OUTPUT_DIR = $(BASE_DIR)/out
LIB_DIR = $(BASE_DIR)/lib

POCO_BASE = $(BASE_DIR)/thirdparty/sources/poco

CPP = g++
CPPFLAGS = -I$(POCO_BASE)/include
LDFLAGS = -L$(LIB_DIR)
LDLIBS = -lPocoNet -lPocoUtil -lPocoXML -lPocoFoundation -lpthread


sources = $(wildcard $(SOURCE_DIR)/*.cpp)
objects = $(patsubst %.cpp,%.o, $(sources))

target = $(OUTPUT_DIR)/SampleServer
target-properties = $(foreach prop-file, $(notdir $(wildcard $(SOURCE_DIR)/*.properties)), $(OUTPUT_DIR)/$(prop-file))

export BASE_DIR POCO_BASE LIB_DIR

.PHONY: all
all: thirdparty $(target) $(target-properties)


%.o: %.cpp
	$(CPP) -c -o $@ $< $(CPPFLAGS)


$(target): $(objects)
	test -d $(OUTPUT_DIR) || mkdir -p $(OUTPUT_DIR)
	$(CPP) -o $@ $^ $(LDFLAGS) $(LDLIBS)


$(OUTPUT_DIR)/%.properties: $(SOURCE_DIR)/%.properties
	cp $< $@


.PHONY: thirdparty
thirdparty:
	cd $(BASE_DIR)/thirdparty && $(MAKE)


.PHONY: thirdparty-clean
thirdparty-clean:
	cd $(BASE_DIR)/thirdparty && $(MAKE) clean


.PHONY: clean
clean: thirdparty-clean
	rm -f $(target) $(target-properties) $(objects)
