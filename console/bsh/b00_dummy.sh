#!/bin/bash


#   m:  replyCpde
declare -i z_iRc=$1
echo "+ b00.dummy.ReplyCode[$z_iRc]" 

#   m:  include
source LIB.inc.bsh

#   m:  run.header
g_sId='TUTOR'   # auch ohne Parameter
g_bLogModeDate=$v_TRUE
f_lib_header $BASH_SOURCE $LINENO $z_iRc; z_iEc=$?

#   test fileName
n='hello.txt'
echo "input FileName =:$n"

s="${n##*.}"
echo "reply =: $s"

#   test path
p='/home/peter/VCS/testSuite_Rhea/hello.txt'
echo "input FilePath =:$p"

#   check lib.dtmString
echo "+ test: f_lib_time_getDtmString"
f_lib_time_getDateTimeString $v_LIB__DTM_FORMAT_now; iRc=$?
echo "$< g_Lib.sRc   =:  [$g_LIB__sRc]"
echo "$< reply.iRc   =:  [$iRc]"

#   check lib.logFile
echo "+ test: f_lib_logfile"
f_lib_logging_getFilePath $BASH_SOURCE 2; iRc=$?
echo "$< g_Lib.sRc   =:  [$g_LIB__sRc]"
echo "$< reply.iRc   =:  [$iRc]"

exit

#   check lib.GetFileName
echo "+ test: f_lib_file_getName"
f_lib_file_getName $p; iRc=$?
echo "$< g_Lib.sRc   =:  [$g_LIB__sRc]"
echo "$< reply.iRc   =:  [$iRc]"

#   check lib.GetFileBody
echo "+ test: f_lib_file_getBody"
f_lib_file_getBody $p; iRc=$?
echo "$< g_Lib.sRc   =:  [$g_LIB__sRc]"
echo "$< reply.iRc   =:  [$iRc]"

#   check lib.GetFileExtension
echo "+ test: f_lib_file_getExtension"
f_lib_file_getExtension $p; iRc=$?
echo "$< g_Lib.sRc   =:  [$g_LIB__sRc]"
echo "$< reply.iRc   =:  [$iRc]"

#   check lib.GetFilePath
echo "+ test: f_lib_file_getPath"
f_lib_file_getPath $p; iRc=$?
echo "$< g_Lib.sRc   =:  [$g_LIB__sRc]"
echo "$< reply.iRc   =:  [$iRc]"

exit

#   m:  show.header.reply
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

