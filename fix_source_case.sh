#!/bin/bash

for i in `find source`; do

   if [ -d "$i" ]; then
      continue
   fi

   SOURCE_FILE_LOWER=`echo "$i" | tr '[:upper:]' '[:lower:]'`
   SOURCE_FILE_LOWER_DIR=`dirname "$SOURCE_FILE_LOWER"`

   mkdir -p $SOURCE_FILE_LOWER_DIR

   mv -v "$i" "$SOURCE_FILE_LOWER"
done

