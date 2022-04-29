
# vim: set noexpandtab:

FILES_RAW := $(shell grep -oP "(?<=\s([0-9]), )[^,]*" disk1/SETUP.INF)

FILES_COMP := $(foreach FILE_ITEM,$(FILES_RAW),disk$(shell grep -oP "(?<=\s)[0-9](?=, $(FILE_ITEM))" disk1/SETUP.INF)/$(shell echo $(FILE_ITEM) | sed 's/[a-z]$$/_/'))

all: $(FILES_COMP)
	echo $(FILES_COMP)

disk2/.stamp:
	mkdir -v disk2
	touch $@

disk5/%.sc_: source/SCENARIO/$(shell echo '%.SCN' | tr '[:lower:]' '[:upper:]')
	mscompress $<
	mv -v $< $@

disk2/%.bm_: source/BITMAPS/$(shell echo % | tr '[:lower:]' '[:upper:]').BMP | disk2/.stamp
	mscompress $<
	mv -v $<_ $@

