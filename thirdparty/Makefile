POCO_ARCH = Linux/x86_64
POCO_LIB_DIR = $(POCO_BASE)/lib/$(POCO_ARCH)
POCO_MODULES = Net Util XML

pocolibs = libPocoNet.a libPocoUtil.a libPocoXML.a libPocoFoundation.a
pocolibpaths = $(foreach libname, $(pocolibs), $(POCO_LIB_DIR)/$(libname))
targetpocolibpaths = $(foreach libname, $(pocolibs), $(LIB_DIR)/$(libname))


.PHONY: all
all: poco


.PHONY: poco
poco: poco-check $(targetpocolibpaths) poco-include


.PHONY: poco-include
poco-include:
ifneq ($(shell if test -d "$(POCO_BASE)/include"; then echo true; else echo false; fi;), true)
	mkdir -p $(POCO_BASE)/include/Poco
	find $(POCO_BASE)/Foundation/include/Poco -type f -exec ln -s -t $(POCO_BASE)/include/Poco {} ';'
	ln -s -t $(POCO_BASE)/include/Poco $(foreach module, $(POCO_MODULES), $(POCO_BASE)/$(module)/include/Poco/*)
endif


$(LIB_DIR)/libPoco%.a: $(POCO_LIB_DIR)/libPoco%.a
	test -d $(LIB_DIR) || mkdir -p $(LIB_DIR)
	ln -s $< $@


$(pocolibpaths): $(POCO_BASE)/Makefile $(POCO_BASE)/config.make
	cd $(POCO_BASE) && $(MAKE)


$(POCO_BASE)/Makefile $(POCO_BASE)/config.make:
	cd $(POCO_BASE) \
	    && ./configure --static --no-tests --no-samples


.PHONY: poco-check
poco-check:
ifneq ($(shell if test -d "$(BASE_DIR)"; then echo true; else echo false; fi;), true)
$(error Directory BASE_DIR=$(BASE_DIR) does not exist)
endif
ifneq ($(shell if test -d "$(POCO_BASE)"; then echo true; else echo false; fi;), true)
$(error Directory POCO_BASE=$(POCO_BASE) does not exist)
endif
ifneq ($(POCO_BASE), $(abspath $(POCO_BASE)))
$(error Directory POCO_BASE=$(POCO_BASE) should specify an absolute path)
endif


.PHONY: clean
clean: poco-clean


.PHONY: poco-clean
poco-clean: poco-check
	rm -f $(foreach libname, $(pocolibs), $(BASE_DIR)/lib/$(libname))
	cd $(POCO_BASE) && rm -r -f include
	cd $(POCO_BASE) && $(MAKE) clean