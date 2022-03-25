#!/bin/bash
. ./env.sh

# Libraries
for FILE in `ls $FMB_PATH/*.pll`; do
  OUTPUT=${FILE/pll/plx}
  if [ "$FILE" -ot "$OUTPUT" ]; then
    echo "Skip $FILE"
  else
    echo "PLL: $FILE -> $OUTPUT"
    $FORMS_INSTANCE/bin/frmcmp_batch.sh $FILE $DB_USER/$DB_PASSWORD@$DB_TNS \
    module_type=library batch=yes output_file=$OUTPUT compile_all=special
  fi 
done

# Menus
for FILE in `ls $FMB_PATH/*.mmb`; do
  OUTPUT=${FILE/mmb/mmx}
  if [ "$FILE" -ot "$OUTPUT" ]; then
    echo "Skip $FILE"
  else  
    echo "MMB: $FILE -> $OUTPUT"
    $FORMS_INSTANCE/bin/frmcmp_batch.sh $FILE $DB_USER/$DB_PASSWORD@$DB_TNS \
      module_type=menu batch=yes output_file=$OUTPUT compile_all=special
  fi       
done

# Forms
for FILE in `ls $FMB_PATH/*.fmb`; do
  OUTPUT=${FILE/fmb/fmx}
  if [ "$FILE" -ot "$OUTPUT" ]; then  
    echo "Skip $FILE"
  else    
    echo "FMB: $FILE -> $OUTPUT"
    $FORMS_INSTANCE/bin/frmcmp_batch.sh $FILE $DB_USER/$DB_PASSWORD@$DB_TNS \
      module_type=form batch=yes output_file=$OUTPUT compile_all=special
    ERR=${FILE/fmb/err}
    echo --- FMB Compilation output -------------------------------------------
    cat $ERR
    echo ----------------------------------------------------------------------
    echo
  fi  
done