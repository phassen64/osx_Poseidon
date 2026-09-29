#!/bin/bash


#   m:  clear screen
if [ "$1" == "" ]; then
    clear && echo -en "\e[3J"
fi

#   this script
z_EXE=$BASH_SOURCE
z_SCP=`basename $z_EXE`

#   m:  replyCpde
declare -i z_iEc=$1
declare -i z_iRc

#   m:  include
source LIB.inc.bsh

#   m:  run.header
sId='TUTOR'
f_lib_header $z_SCP $LINENO $z_iEc; z_iEc=$?; z_iRc=$z_iEc

#   m:  show.header.reply
echo "reply.iRc[$z_iRc]" 
echo "reply.iEc[$z_iEc]" 

#   m:  content
f_lib_puts "this text is red"  $v_COL_ID_red
f_lib_puts "this green"        $v_COL_ID_green
f_lib_puts "and I am blue"     $v_COL_ID_blue
f_lib_puts "or may be yellow"  $v_COL_ID_yellow

#   m:  data
d=$(date +%s.%N)
s="<<< TIME now is:$d"
echo "I will log the text:'$s' into logfile:<$v_sLogfile>"
echo "$s" >> $v_sLogfile   #    append into existing logfile

#   m:  run.footer
f_lib_footer $z_SCP $LINENO $z_iRc

