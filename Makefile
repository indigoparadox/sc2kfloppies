
# vim: set noexpandtab:

# Exclude this from pairs because the 2-char extension is handled weird.
UNCOMP := 4,tiles.db

# Start at disk [2-] since disk 1 has no compressed files.
PAIRS_RAW := $(filter-out $(UNCOMP),$(shell grep -oP "(?<=\s)[2-9],[^,]*" disk1/SETUP.INF))

FILES_COMP := $(foreach PAIR,$(PAIRS_RAW),disk$(shell echo "$(PAIR)" | awk 'BEGIN { FS="," }; {print $$1}')/$(shell echo "$(PAIR)" | awk 'BEGIN { FS="," }; {print $$2}' | sed 's/[a-z0-9]$$/_/')) disk4/tiles.db_

DISKS := 1 2 3 4 5 6 7 8 9

# Commands

MSCOMPRESS := mscompress
DD := dd
MCOPY := mcopy
MKFS_VFAT := /sbin/mkfs.vfat

# Configuration

# 1.44 MB in 512k sectors
FLOPPY_DENSITY := 2880

# Targets

all: $(FILES_COMP)

# Directory Creation Rule

disk%/.stamp:
	mkdir -p -v $(shell dirname $@)
	touch $@

# Image Generation Rules

define DISK_IMG_RULE
disk$(1).img: $$(filter disk$(1)/%,$$(FILES_COMP))
	$(DD) if=/dev/zero bs=512 count=$(FLOPPY_DENSITY) of="$$@" && $(MKFS_VFAT) "$$@"
	$(MCOPY) -spmv -i "$$@" $$^ "::"
endef
$(foreach DISK,$(DISKS),$(eval $(call DISK_IMG_RULE,$(DISK))))

# Compression Rules

disk5/%.sc_: source/scenario/%.scn | disk5/.stamp
	$(MSCOMPRESS) $<
	mv -v $< $@

disk2/%.bm_: source/bitmaps/%.bmp | disk2/.stamp
	$(MSCOMPRESS) $<
	mv -v $<_ $@

disk2/%.da_: source/data/%.dat | disk2/.stamp
	$(MSCOMPRESS) $<
	mv -v $<_ $@

disk2/%.id_: source/data/%.idx | disk2/.stamp
	$(MSCOMPRESS) $<
	mv -v $<_ $@

disk2/%.mi_: source/sounds/%.mid | disk2/.stamp
	$(MSCOMPRESS) $<
	mv -v $<_ $@

disk2/%.wa_: source/sounds/%.wav | disk2/.stamp
	$(MSCOMPRESS) $<
	mv -v $<_ $@

disk3/%.bm_: source/%.bmp | disk3/.stamp
	$(MSCOMPRESS) $<
	mv -v $<_ $@

disk3/%.dl_: source/%.dll | disk3/.stamp
	$(MSCOMPRESS) $<
	mv -v $<_ $@

disk3/%.sc_: source/%.sc2 | disk3/.stamp
	$(MSCOMPRESS) $<
	mv -v $<_ $@

disk3/%.ex_: source/%.exe | disk3/.stamp
	$(MSCOMPRESS) $<
	mv -v $<_ $@

disk3/%.wa_: source/%.wad | disk3/.stamp
	$(MSCOMPRESS) $<
	mv -v $<_ $@

disk3/%.hl_: source/%.hlp | disk3/.stamp
	$(MSCOMPRESS) $<
	mv -v $<_ $@

disk4/%.hl_: source/%.hlp | disk4/.stamp
	$(MSCOMPRESS) $<
	mv -v $<_ $@

disk4/%.wa_: source/%.wad | disk4/.stamp
	$(MSCOMPRESS) $<
	mv -v $<_ $@

disk4/%.ex_: source/%.exe | disk4/.stamp
	$(MSCOMPRESS) $<
	mv -v $<_ $@

# Special case: WING stuff has DLLs but comes from different source dir.

disk4/ctl3d.dl_: source/wing/ctl3d.dll | disk4/.stamp
	$(MSCOMPRESS) $<
	mv -v $<_ $@

disk4/ctl3dv2.dl_: source/wing/ctl3dv2.dll | disk4/.stamp
	$(MSCOMPRESS) $<
	mv -v $<_ $@

disk4/d2htools.dl_: source/wing/d2htools.dll | disk4/.stamp
	$(MSCOMPRESS) $<
	mv -v $<_ $@

disk4/wing.dl_: source/wing/wing.dll | disk4/.stamp
	$(MSCOMPRESS) $<
	mv -v $<_ $@

disk4/wing32.dl_: source/wing/wing32.dll | disk4/.stamp
	$(MSCOMPRESS) $<
	mv -v $<_ $@

disk4/wingde.dl_: source/wing/wingde.dll | disk4/.stamp
	$(MSCOMPRESS) $<
	mv -v $<_ $@

disk4/dib.dr_: source/wing/dib.drv | disk4/.stamp
	$(MSCOMPRESS) $<
	mv -v $<_ $@

disk4/wingdib.dr_: source/wing/wingdib.drv | disk4/.stamp
	$(MSCOMPRESS) $<
	mv -v $<_ $@

disk4/dva.38_: source/wing/dva.386 | disk4/.stamp
	$(MSCOMPRESS) $<
	mv -v $<_ $@

disk4/wingpal.wn_: source/wing/wingpal.wnd | disk4/.stamp
	$(MSCOMPRESS) $<
	mv -v $<_ $@

# End special case.

disk4/%.dl_: source/%.dll | disk4/.stamp
	$(MSCOMPRESS) $<
	mv -v $<_ $@

disk4/%.in_: source/%.inf | disk4/.stamp
	$(MSCOMPRESS) $<
	mv -v $<_ $@

disk4/tiles.db_: source/tiles.db | disk4/.stamp
	$(MSCOMPRESS) $<
	mv -v $<_ $@

disk6/%.mi_: source/scurkart/%.mif | disk6/.stamp
	$(MSCOMPRESS) $<
	mv -v $<_ $@

disk6/%.pc_: source/scurkart/%.pcx | disk6/.stamp
	$(MSCOMPRESS) $<
	mv -v $<_ $@

disk7/%.mi_: source/scurkart/%.mif | disk7/.stamp
	$(MSCOMPRESS) $<
	mv -v $<_ $@

disk7/%.pc_: source/scurkart/%.pcx | disk7/.stamp
	$(MSCOMPRESS) $<
	mv -v $<_ $@

disk7/%.sc_: source/cities/%.sc2 | disk7/.stamp
	$(MSCOMPRESS) $<
	mv -v $<_ $@

disk8/%.sc_: source/cities/%.sc2 | disk8/.stamp
	$(MSCOMPRESS) $<
	mv -v $<_ $@

disk9/%.sc_: source/cities/%.sc2 | disk9/.stamp
	$(MSCOMPRESS) $<
	mv -v $<_ $@

disk7/%.wr_: source/cities/%.wri | disk7/.stamp
	$(MSCOMPRESS) $<
	mv -v $<_ $@

