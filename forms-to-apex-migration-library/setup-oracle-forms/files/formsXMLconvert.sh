#!/bin/bash
rm *.xml
for file in *.{fmb,mmb,rpt}
do
  echo $file
  sh ./frmf2xml.sh $file
done
