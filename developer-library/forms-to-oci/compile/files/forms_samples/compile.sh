#!/bin/bash
. ./env.sh

# Libraries
for FILE in `ls $FMB_PATH/*.pll`; do
  OUTPUT=${FILE/pll/plx}
  echo "PLL: $FILE -> $OUTPUT"
  $FORMS_INSTANCE/bin/frmcmp_batch.sh $FILE $DB_USER/$DB_PASSWD@$DB_TNS \
    module_type=library batch=yes output_file=$OUTPUT compile_all=special
done

# Menus
for FILE in `ls $FMB_PATH/*.mmb`; do
  OUTPUT=${FILE/mmb/mmx}
  echo "MMB: $FILE -> $OUTPUT"
  $FORMS_INSTANCE/bin/frmcmp_batch.sh $FILE $DB_USER/$DB_PASSWD@$DB_TNS \
    module_type=menu batch=yes output_file=$OUTPUT compile_all=special
done

# Forms
for FILE in `ls $FMB_PATH/*.fmb`; do
  OUTPUT=${FILE/fmb/fmx}
  echo "FMB: $FILE -> $OUTPUT"
  $FORMS_INSTANCE/bin/frmcmp_batch.sh $FILE $DB_USER/$DB_PASSWD@$DB_TNS \
    module_type=form batch=yes output_file=$OUTPUT compile_all=special
  ERR=${FILE/fmb/err}
  echo --- FMB Compilation output -------------------------------------------
  cat $ERR
  echo ----------------------------------------------------------------------
  echo 
done