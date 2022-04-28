
# vim: set noexpandtab:

FILES_RAW := $(shell grep -oP "(?<=\s([0-9]), )[^,]*" disk1/SETUP.INF)

FILES_COMP := $(foreach FILE_ITEM,$(FILES_RAW),$(shell echo $(FILE_ITEM) | sed 's/[a-z]$$/_/'))

all: $(FILES_COMP)
	echo $(FILES_COMP)

%.bm_: source/BITMAPS/$(shell echo '%.BMP' | tr '[:lower:]' '[:upper:]')
	echo $<

