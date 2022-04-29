
= Dependencies =

- mscompress
- dd
- mkfs.vfat
- mtools

= Usage =

Grab WIN31 subdirectory from the SimCity 2000 Special Edition CD-ROM and put it in this project directory. Rename it from "WIN31" to "source".

fix\_source\_case.sh should be run on the source files first, to convert all upper-case named files to lower-case.

Provided the dependencies are installed, the floppy images should be created after running "make".

