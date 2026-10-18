#   *****************************************************************
#   BASIC LIBRARY FUNCTIONs for PERL SCRIPTS
#   *****************************************************************
#   usage:  "use FCT;"
#   AUTHOR: P.Hassen
#   Date:   9.6.2006
#   UPDT:   25.6.2009: with project BUILD
#   *****************************************************************
#   encoding: UTF-8
# !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß

=head1  FUNCTION
    The PERLFCT library exports only Functions with a leading 'F'.
    Inside it uses corresponding 'f'  functions.
=cut

    reset 'a-z';            # clean lower case vars

    BEGIN
    {
            my $file      = __FILE__;
            $file         =~ tr /\\/\//s;  # substitute: '\' => '/'
#!ANM:  KEIN printf() in der Library ohne Tace
#       Besser eine globale Variable zur Verf?gung stellen.
            printf("### START LIB =<%s>  perlVers=<%vd>\n",$file,$^V);
    }
    END
    {
            my $tstr = FCT::f_getDateTime();
            my $str  = "<<< END OF LOGGING  : " . $tstr . "\n";
            my $file = FCT::f_modFileNamePath(__FILE__);
            printf("### END OF LIB=<%s>:[%s]\n",$file,$tstr);
            FCT::_L($str);  #LOG
    }

#   &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
    package OS;                        # problem with redefinitions
#   &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
    use Cwd         'cwd','chdir';          # pwd
    use vars        qw ($v_HOME);
    $v_HOME         = cwd();
    $v_HOME         =~ tr /\\/\//s;     #   substitute: '\' => '/'


#   &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
    package main;                                           #GLOBAL
#   &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

    use Symbol;         # abstract file handles
    use POSIX;
    use strict;

#   global CONSTANTs
    use vars    qw($v_PI $v_EF);
    $v_PI = 3.1415926535897932384626433832795028841968;
    $v_EF = 2.718281828;

#   global Vars for dirTree
    use vars    qw ($v_dirCounter $v_fileCounter $v_callCounter);
    use vars    qw ($v_depth $v_actions $v_filesMatched);
    use vars    qw ($v_HOME);
    $v_dirCounter   =       0;
    $v_fileCounter  =       0;
    $v_depth        =     - 1;
    $v_filesMatched =       0;
    $v_actions      =       0;
    $v_callCounter  =   0;          #   bounded function
    $v_HOME         =   $OS::v_HOME;

#   global  FILEs
    use vars    qw($C_OPTSFILE $C_LOGFILE);
    $C_OPTSFILE     = $v_HOME .  "/" . "OPTFILE.txt";
    $C_LOGFILE      = $v_HOME  . "/" . "LOGFILE.txt";

#   global Vars else
    use vars    qw(%v_Opts);    #global OptsHash

#   global TRACE values
    use vars    qw($C_TRACE_MASK_USER);
    use vars    qw($C_TRACE_MASK_MAIN);
    use vars    qw($C_TRACE_MASK_SUB);
    use vars    qw($C_TRACE_MASK_DUMMY);
    use vars    qw($C_TRACE_MASK_DEFAULT);
    $C_TRACE_MASK_USER          = 0x8000;   # 1000.0000   #usr body
    $C_TRACE_MASK_MAIN          = 0x4000;   # 0100.0000   #usr main fct
    $C_TRACE_MASK_SUB           = 0x2000;   # 0010.0000   #usr fct
    $C_TRACE_MASK_DUMMY         = 0x1000;   # 0001.0000   #other
    $C_TRACE_MASK_DEFAULT       = 0xFFFF;
    #   NOK   $C_TRACE_MASK_DEFAULT       = $FCT::C_TRACE_MASK_DEFAULT;


#   -----------------------------------------------------------------
#   exported Functions
#   -----------------------------------------------------------------

#   *** simple print info
    sub F_HEADER(;$$$){return(FCT::f_HEADER($_[0],$_[1],$_[2]))};
    sub F_LINE(;$$$){return(FCT::f_LINE($_[0],$_[1]))};
    sub F_LIST(\@;$)    {return FCT::f_LIST($_[0],$_[1])};
    sub F_HASH(\%;$)    {return FCT::f_HASH($_[0],$_[1])};

#	*** better use that
    sub F_printList(\@;$)    {return FCT::f_LIST($_[0],$_[1])};
    sub F_printHash(\%;$)    {return FCT::f_HASH($_[0],$_[1])};

#   *** Trace main functions
    sub F_TRACE(;$$){
        return  FCT::f_TRACE_do($_[0],$_[1],2)}; #use f_CALLER()
    sub F_TRACE_init($) {return FCT::f_TRACE_init($_[0])};
    sub F_TRACE_set($)  {return FCT::f_TRACE_set($_[0])};
    #   --- Trace '_T':: Caller must set to '2'
    sub _T($$;$)        {return FCT::_T($_[0],$_[1],2);}
    #   simple trace
    sub F_TRC($$)       {return FCT::f_TRACE_raw($_[0],$_[1])};

#   *** prints with TRACE or WARNINGs
    sub F_print($;$)    {return FCT::f_printStr($_[0],$_[1])};
    sub F_mode_T()      {return FCT::f_mode_T()};
    sub F_mode_W()      {return FCT::f_mode_W()};
    sub F_mode_O()      {return FCT::f_mode_O()};   # overwrite
    sub _W()            {return FCT::f_mode_W()};

#   *** complex functions
    sub F_getOpts(\%;\&){ return FCT::f_getOpts($_[0],$_[1]) };
    sub F_putOpts(\%;$) { return FCT::f_printOpts($_[0])};
    sub F_readOptsFile($\@) {return FCT::f_readOptsFile($_[0],$_[1])};
    sub F_startRegExpr(\$$$$$) {
        return FCT::f_startRegExpr($_[0],$_[1],$_[2],$_[3],$_[4])};
    sub F_dirReadRecursive($$\&;\@) {
        my $rc = FCT::f_dirReadRecursive($_[0],$_[1],$_[2],$_[3]);
        return($rc);
    };
    sub F_printOpts(;$) {return FCT::f_printOpts($_[1])};   # print global Opts, use tmask
    sub F_printFile($)      {return FCT::f_printFile($_[0])};
    sub F_getFileSize($)    {return FCT::f_getFileSize($_[0])};

#   *** other functions
    sub F_sortStr($) {return FCT::f_sortStr($_[0])};
    sub F_help()     {return FCT::f_help()};

#   *** SYS functions
    sub F_getFileInfo($){return FCT::f_getFileInfo($_[0])};
    sub F_getSysError(;\$) {return FCT::f_getSysError($_[0],$_[1])};

#   *** TIME functions
    sub F_getTime()     {return FCT::f_getTime()};
    sub F_getDate()     {return FCT::f_getDate()};
    sub F_getDateTime()         { return FCT::f_getDateTime()};
    sub F_getDateTimeHash(\%)   { return FCT::f_getDateTimeHash($_[0])};
    sub F_modTimeStr2TimeInt($) { return FCT::f_modTimeStr2TimeInt($_[0])};
    sub F_modTimeInt2TimeStr($) { return FCT::f_modTimeInt2TimeStr($_[0])};
    #IN: '12:30:45' (hh:mm:ss) RET:45045


#   *** file naming
    sub F_getFileName($) {return FCT::f_getFileName($_[0])};
    sub F_getDirName($) {return FCT::f_getDirName($_[0])};
    sub F_makeFileNamePath($$)   {return FCT::f_makeFileNamePath($_[0],$_[1])};
    sub F_modFileNamePath($)  {return FCT::f_modFileNamePath($_[0])}; #make UNIX path
    sub F_addFileExtension($) {return FCT::f_addFileExtension($_[0],$_[1])};
    sub F_subFileExtension($) {return FCT::f_subFileExtension($_[0])};
    sub F_getFileExtension($) {return FCT::f_getFileExtension($_[0])};
    sub F_getFileNamePath($)  {return FCT::f_getFileNamePath($_[0])};
    sub F_safeFile($)         {return FCT::f_safeFileVersion($_[0])};
    sub F_copyFile($$)        {return FCT::f_copyFile($_[0],$_[1])};
    sub F_moveFile($$)        {return FCT::f_moveFile($_[0],$_[1])};
    sub F_deleteFile($)       {return FCT::f_deleteFile($_[0])};
    sub F_removeFile($)       {return FCT::f_removeFile($_[0])};
    sub F_renameFile($$)    {return FCT::f_renameFile($_[0],$_[1])};
    sub F_isFileName($)       {return FCT::f_isFileName($_[0])};

#   *** ctype functions
    sub F_isPrint($) {return FCT::f_isPrint($_[0])};
    sub F_isUpper($) {return FCT::f_isUpper($_[0])};
    sub F_isLower($) {return FCT::f_isLower($_[0])};
    sub F_isLetter($) {return FCT::f_isLetter($_[0])};
    sub F_isDigit($) {return FCT::f_isDigit($_[0])};
    sub F_isAlnum($) {return FCT::f_isAlnum($_[0])};

#   &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
    package FCT;
#   &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&


    use Cwd             'cwd','chdir';            # pwd
    use Symbol;         # abstract file handles
    use Getopt::Long;   # GetOption()
    use strict;
    use POSIX;          # 'isalnum','isdigit','isalpha','isprint';
    use File::Copy;     # file copy
#   use ENCODE;         # utf8,...

#   global functions

#   static and global TRACE MASKs
    use vars qw($v_trace $v_traceGLOBAL);
    my  $v_traceGLOBAL      = 0;                #opts
    my  $v_trace            = 0;                #fctn

#   static (local)trace Mask
    #   --- default
    my  $C_TRACE_MASK_DEFAULT   = 0xFFFF; # 0xFFFF;    # trace ALL
    #   --- local traceMasks
    my  $C_TRACE_MASK_BASE      = 0x0001; # 0000.0010
    my  $C_TRACE_MASK_SYS       = 0x0002; # 0000.0010
    my  $C_TRACE_MASK_REG       = 0x0004; # 0000.0100
    my  $C_TRACE_MASK_META      = 0x0008; # 0000.1000
    my  $C_TRACE_MASK_OPTS      = 0x0010; # 0001.0000
    my  $C_TRACE_MASK_TREE      = 0x0020; # 0020.0000   #any fctn
    my  $C_TRACE_MASK_FILE      = 0x0040; # 0100.0000   #usr fct
    my  $C_TRACE_MASK_BIN       = 0x0080; # 1000.0000   #usr main fct
    #   --- user traceMasks
    my  $C_TRACE_MASK_USER      = $::C_TRACE_MASK_USER;     # FCT.pm User
    my  $C_TRACE_MASK_MAIN      = $::C_TRACE_MASK_MAIN;     # dito
    my  $C_TRACE_LIB            = 1;

#   proto types
#   --- CHAR TYPE functions
    sub f_isPrint($);
    sub f_isDigit($);
    sub f_isLetter($);
    sub f_isAlnum($);
    sub f_isUpper($);
    sub f_isLower($);
#   --- OS Functions
    sub f_OS_DIR_SEPERATOR();   # get '/'
    sub f_OS_DIR_CURRENT();
    sub f_OS_NEWLINE();
#   --- SYS Functions
    sub f_OS_GET_DATE_TIME(;\$);# ($dateStr,$timeStr) = f([\$timeStr])
    sub f_getTime();            # $time = f() RC="hh:mm:ss"
    sub f_getDate();            # $date = f() RC="YY:MM:DD"
    sub f_getDateTime();        # f()
    sub f_getDateTimeHash(\%);  # $rc = f(\%HashPtr)
#   --- BASIC and SYS print functions
    sub f_HASH(\%;$);
    sub f_printHash(\%;$$);     # $str = f(\%HashName;name,tmask)
    sub f_LIST(\@;$);           # print List
    sub f_ARGV();
    sub f_REF(\@);              # check pointer
    sub f_printTime();
    sub f_getFileInfo($);       # f($file)
    sub f_getFileSize($);       # f($file)
    sub f_getSysError(;\$);     # $rStr|$rInt = f([errStr_ptr])
#   --- Tools
    sub f_sortStr($);
    sub f_printFile($);         # print a textfile
#   --- Dir/File Names
    sub f_getDirName($);        # f($filePath)
    sub f_getFileName($);       # $fname = f(fnamePath)
    sub f_getFileNamePath($);
    sub f_modFileNamePath($);   # adjust unix FilePath
    sub f_setFileVersion($;$);  # $file = f($file,[$vers])
    sub f_addFileExtension($$); # f("file","ext")   -> "file.ext"
    sub f_subFileExtension($);  # f("file.ext")     -> "file"
    sub f_getFileExtension($);  # ext = f($FilePath)
    sub f_isFileName($);        # rOK = f($FilePath);
#   --- HELP functions
    sub f_help();               # RC:returns a help str
    sub f_helpModes();
    sub f_helpOpts();
    sub f_helpTrace();
    sub f_helpRegs();
    sub f_helpFullRegExpr();
    sub f_helpSimpleRegExpr();
    sub f_dummyHelp();
#   --- TRACE Functions
    sub f_LINE(;$$);
    sub f_HEADER(;$$$);
    sub f_CALLER($;\$\$\$\$);   # f(lvl,fct,file,line,pack)
    sub f_STACK($);             # f($lvl)
    sub f_DEBUG($$);            # f($str,$localTrace)
    sub f_TRACE_do(;$$$);       # f($traceId,$tmask,$callLvl)
    sub f_TRACE_set($);
    sub f_TRACE_init($);
    sub f_TRACE_ok();           # return($v_trace)
#   --- Options
    sub f_printOptions();       # BASIC functions
    sub f_initOpts(\%);
    sub f_getOpts(\%\&);        # f(lOpts,lhelpFkt)
    sub f_readOptsFile($\@);    # $rc = f($fileName,@list)
    sub f_readQualifier(\$\$;$);  # $rOK= f($q,$src,$sep)  INOUT:$q="q/src/"
#   --- Regs
    sub f_startRegExpr(\$$$$$); # $rc=f(\strIO,qual,src,obj,modi)
    sub f_parseRegExprStr($\$\$\$\$); #$rc=f(str,\q,\src,\obj,\m);
    sub f_xstr2asc($\$);        # f($src,$obj)
    sub f_addMeta ($\$);        # f($src,$obj)   * usePtr
    sub f_delMeta ($\$);        # f($src,$obj)
    sub f_metaList(\@);         # f(\@List)
    sub f_metaHashKey(\%$);     # f(\%h,$key)

    sub f_hex2asc($\$);         # f($src,$obj)
    sub f_hex2uni($\$);         # f(hexStr,unicode) #t.b.d.l.
    sub f_hex2bin($\$);         # $nrOfVals = f(hexStr_I,val_O)
#   --- Recursive
    sub f_dirReadRecursive($$\&;\@);

#   *****************************************************************
#   STATIC                      only in this module
#   *****************************************************************

#   --- global files
    my  $C_OPTSFILE = $::C_OPTSFILE;
    my  $C_LOGFILE  = $::C_LOGFILE;

#   --- static Constants
    my  $C_MAX_DEPTH            =   4;
    my  $C_MAX_FILE_VERSIONS    =   999;
    my  $C_LINE_SIZE            =   70;   #<80
    my  $C_ASC_MAX              =   0x7F;

#   --- static Lists
    my  ($C_SEPERATOR,$C_META,$C_EXTENSION,$C_COMMENT) = ('/','\\','.','=');
    my  $C_NULL=chr(1);
    my  $C_NULL_STR="";
    my  @C_QUALIFIER_LIST=('tr','y','s','m');
    my  @C_MODIFIER_LIST=('c','d','e','g','i','m','o','s','x');
    my  @C_SEPERATOR_LIST=('/','\\','|','\'','"') ;
    my  @C_REGEXPR_SPECIAL_CHAR_LIST
        =('\\','/','.','+','*','?','^','$','|','(',')','[',']','{','}');
    my  @C_SIMPLE_QUALIFIER_LIST=('t','a','u','x');

#   --- special strings and chars
    my  $C_STANDARD_SIMPLE_QUALIFIER='t';    #a text String
    my  $C_TIME_STR_SEPERATOR   = "#";
    my  $C_OPTFILE_COMMENT      = '#';
    my  $C_OPTFILE_SEPERATOR    = '=';
    my  $C_OPTFILE_BRACE        = '"';
    my  $C_FILE_EXTENSION       = '.';
    my  $C_DIR_SEPERATOR        = '/';
    my  $C_MARKER_TRACE         = "***";

#   --- static Vars
    my  $s_initOpts   = 0;


#   *****************************************************************
#   MODE+OPTS  FUNCTIONS
#   *****************************************************************

    sub f_mode_L() {
        if (!defined %::v_Opts) {
            return(0);
        }
        (!defined $::v_Opts{"Logging"}) ?
            return(0) : return($::v_Opts{"Logging"});
    }
    sub f_mode_O() {return($::v_Opts{"Overwrite"});}
    sub f_mode_W() {return($::v_Opts{"Warning"});}
    sub f_mode_R() {return($::v_Opts{"Recursive"});}
    sub f_mode_T() {return($::v_Opts{"Trace"});}
    sub _W(){return(f_mode_W());}
    sub _L($)           # log without trace
    {
        my $str   = $_[0]; # parameter_1
        if (f_mode_L) {
            my $fp = gensym();
            my $file = $::v_Opts{"logfile"};
            my $rc = open($fp,">> $file");;
            print ($fp $str);
            close($fp);
            return(1);  #   log
        }
        return(0);      #   noLogging
    }
    sub _P($)   # _P($str)
    {
        my $str     = $_[0]; # parameter_1
        my $args    = @_;       #nrOfArgs
        my $rc      = 0;
        if (!defined %::v_Opts) {
            warn "??? _P() or TRACE before getOpts";
        	print f_STACK(5);
            return($rc);
        }
        # --- Logging has higher prio than Tracing
        if (f_mode_L)                 # Logging active
        {
            _L($str);
            if (f_mode_L == 1) {
				if (f_TRACE_ok) {if ($args == 1){print "$str"; $rc=1}};
            	# print f_STACK(3);
        		# print "+++ TRACEOK:$rc ?\n";

            }
        }
        elsif (f_TRACE_ok)      #  Tracing without Logging
        {
            if ($args == 1) {print "$str";$rc=1} ;
        }
        else {
            #   TEST: warn "_P() with no TRACE";
        }
        return($rc);    #1:I have printed, 0:else not
    }
    sub _T($$;$)  # _T($tmask,$str;lvl)
    {
        my $args    = @_;
        if ($args < 2) {warn "&&& args(f(mask,str))=$args???"; exit;}
        my ($tmask,$tStr,$lvl)= (shift(),shift(),shift());
        chomp($tStr);    #inputStr with no '\n'

        if (!defined $lvl) {
            $lvl = 1;   #default
        }

        my ($file,$line,$fct,$packvar) = (0,0,0,0);
        f_CALLER($lvl,$fct,$file,$line,$packvar);

        my $str = sprintf("%s T:<%s>;<%d>;<%s>:<%s>\n",
                $C_MARKER_TRACE,
                $file,
                $line,
                $fct,
                $tStr);

        f_TRACE_set($tmask);
        _P($str);
    }



#   *****************************************************************
#   TYPE Functions
#   *****************************************************************
    # The "perl" POSIX.pm functions like "isdigit","isalnum",...
    # works 'string' and not 'char' oriented, as ctype.h for "C".
    # Therefore exactly corresponding functions are defined.

sub f_isPrint($) {
    my $i = ord($_[0]);
    if  ( ($i < ord (' ')) || ($i > ord('~')) )
    {
        return(0);
    }
    return(1);
}

sub f_isLower($) {
    my $i = ord($_[0]);
    if ( ($i < ord ('a')) || ($i > ord ('z')) )
    {
        return(0);
    }
    return(1);
}

sub f_isUpper($) {
    my $i = ord($_[0]);
    if ( ($i < ord ('A')) || ($i > ord ('Z')) )
    {
        return(0);
    }
    return(1);
}

sub f_isLetter($) {
    my $c   = shift();
    if (f_isLower($c) || f_isUpper($c))
    {
        return(1);
    }
    return(0);
}

sub f_isDigit($) {
    my $i = ord($_[0]);
    if  (($i < ord ('0')) || ($i > ord('9')))
    {
        return(0);
    }
    return(1);
}


sub f_isAlnum($) {
    my $c = shift;
    if (f_isLetter($c) && f_isDigit($c))
    {
        return(1);
    }
    return(0);
}


#   *****************************************************************
#   OS and SYS Functions
#   *****************************************************************

sub f_OS_DIR_SEPERATOR()
{
    my      $v=0;
    if      ($^O eq "MSWin32")   { $v = "\\"}
    elsif   ($^O eq "Linux"    ) { $v = "/"  }
    else                         { $v = "//"  } ;
    return($v);
}


sub f_OS_DIR_CURRENT()
{
    my $file    = cwd();
    $file       =~ tr /\\/\//s;  # substitute: '\' => '/'
    return($file);   # modified
}

sub f_OS_NEWLINE()
{
    my $v=0;
    if      ($^O eq "MSWin32")   { $v = "\r\n"}
    elsif   ($^O eq "Linux"    ) { $v = "\n"  }
    else                         { $v = "\n"  } ;
    return($v);
}



#   =================================================================
sub f_OS_DATE_TIME(;\$)         # $timeStr = f([\$timeStr])
#   =================================================================
    #   INOUT: [timePtr]*optional = "<hour,min,sec;day,..,year>"
    #   RET  : $timeStr = "<hour,min,sec;day,..,year>"
{
    my  $dateTimePtr            = shift();
    my  ($timeStr,$dateStr)     = $C_NULL_STR;
    my  $day                    = 0;
    my  $Time                   = time();
    my  ($sec,$min, $hour, $mday, $mon, $year,
            $wday, $yday, $daylightsv)      = localtime($Time);
    my  @dateTimeList=();

    $year += 1900;
    $mon  += 1;

    if($wday == 1) { $day = "Monday" }
    if($wday == 2) { $day = "Tuesday"};
    if($wday == 3) { $day = "Wednesday"};
    if($wday == 4) { $day = "Thursday"};
    if($wday == 5) { $day = "Friday"};
    if($wday == 6) { $day = "Saturday"};
    if($wday == 7) { $day = "Sunday"};

    $timeStr = sprintf("%s.%2.2d.%2.2d%s%2.2d:%2.2d:%2.2d",
                        $year,$mon,$mday,
                        $C_TIME_STR_SEPERATOR,
                        $hour,$min,$sec);

    $dateStr    = sprintf("%s.%2.2d.%2.2d",$year,$mon,$mday);
    $timeStr    = sprintf("%2.2d.%2.2d.%2.2d",$hour,$min,$sec);
    if (defined $dateTimePtr) {
         $$dateTimePtr = sprintf("%s.%s",$dateStr,$timeStr);
    }
    return ($dateStr,$timeStr);

}


#   *****************************************************************
#   TIME Functions
#   *****************************************************************

#   =================================================================
sub f_getTime()                     # $time = f()
#   =================================================================
{
    my  ($dateStr,$timeStr) = f_OS_DATE_TIME();
    return($timeStr);
}

#   =================================================================
sub f_getDate()                     # $date = f()
#   =================================================================
{
    my  ($dateStr,$timeStr) = f_OS_DATE_TIME();
    return($dateStr);
}


#   =================================================================
sub f_getDateTime()                 # $dateTime = f()
#   =================================================================
{
    my  ($dateStr,$timeStr) = f_OS_DATE_TIME();
    my  $str = sprintf("D_%s.T_%s",$dateStr,$timeStr);
    # the day time shell be used as a file name !
    # never use ':' signs
    return($str);
}

#   =================================================================
sub f_getDateTimeHash(\%)           # $rc = f(%myList)
#   =================================================================
{
    my  $dateTimeHash_ptr       = shift();
    my  $l_time                 = time();
    my  $wday                   = $C_NULL;
    my  ($sec,$min, $hour, $day, $mon, $year,
              $wdayId, $yday, $daylightsv)      = localtime($l_time);
    if($wdayId == 1) { $wday = "Monday" }
    if($wdayId == 2) { $wday = "Tuesday"};
    if($wdayId == 3) { $wday = "Wednesday"};
    if($wdayId == 4) { $wday = "Thursday"};
    if($wdayId == 5) { $wday = "Friday"};
    if($wdayId == 6) { $wday = "Saturday"};
    if($wdayId == 7) { $wday = "Sunday"};
    %$dateTimeHash_ptr = (
        "s" => $sec,
        "m" => $min,
        "h" => $hour,
        "Y" => 1900+$year,
        "D" => $day,
        "M" => $mon+1,
        "W" => $wday
    );
    # f_HASH(%$dateTimeHash_ptr,"DateHash");
    return(%$dateTimeHash_ptr);
    # return(0);
}

#   =================================================================
sub f_modTimeStr2TimeInt($)  #IN: '12:30:45' (hh:mm:ss) RET:45045
#   =================================================================
{
    my  $sVal   = shift();
    my  $rVal   = 0;
    my ($i,$n)  = (0,0);
    my  @list   = ();

    # $sVal = '12:30:45';
    @list = split(/:/,$sVal);
    # F_LIST(@list,"my");
    $n = $#list+1;
    $rVal = 0;
    for($i=0; $i<$n; $i++) {
        $rVal = $rVal * 60 + $list[$i];
    }
    # printf("f(sVal:%s)=rval:%d\n",$sVal,$rVal);
    return($rVal);
}

#   =================================================================
sub f_modTimeInt2TimeStr($)  #IN:45045 OUT:'12:30:45' (hh:mm:ss)
#   =================================================================
{
    my  $iVal   = shift();
    my  $sVal   = 0;
    my  ($hour,$min,$sec)=(0,0,0);

    $hour       =   $iVal / 3600;
    $iVal       =   $iVal % 3600;   # 1845
    $min        =   $iVal / 60;    # 1845 / 60 = 30
    $sec        =   $iVal % 60;     # 1845 % 60 = 45
    $sVal = sprintf("%2.2d:%2.2d:%2.2d",$hour,$min,$sec);
    return($sVal);
}



#   *****************************************************************
#   BASIC print functions  (List,Hash,Array)
#   *****************************************************************

#   --- LISTs

#   =================================================================
sub f_printStr($;$)            # f(str;tmask)
#   =================================================================
{
    my  $str    = shift();
    my  $tm     = shift();
    if (!defined $tm)       {$tm = $C_TRACE_MASK_DEFAULT; };
    _P($str);
    return(1);
}

#   =================================================================
sub f_printList(\@;$$)                      # f(\@Liste;[name,tmask])
#   =================================================================
#   IN          : listPtr
#   IN(optional): comment name of the List
#   IN(optional): traceMask, if '0', don't print.
{
    my  $ptrList    = shift();
    my  $listName   = shift();
    my  $tmask      = shift();
    my  $str=0;
    my  $i=0;
    my  $len=0;

    if (!defined $ptrList || ref($ptrList) ne "ARRAY") {
        if (_W) {warn("??? print list with no ptr?")};
        return($C_NULL);
    }
    if (!defined $listName) { $listName = "LIST";};
    if (!defined $tmask)    { $tmask    = $C_TRACE_MASK_DEFAULT;};

    $str = sprintf("<<< Lx='%s'::=(",$listName);
    $i = 0;
    foreach my $l (@{$ptrList}) {
        $str = $str . sprintf("[$i]='$l'");
        (($i+1) % 5 == 0) ? ( $str = $str . sprintf("\n") )
                          : ( $str = $str . ";"           ) ;
        $i++;
    } # Ausgabe aller Listenelemente
    $str = $str . ")\n";
    if ($tmask != 0) {
        f_TRACE_set($tmask);
        _P($str);
    }
    return($str);

}   # End of f_printList()


#   =================================================================
sub f_LIST(\@;$)                      # f_LIST(@List;"ListName")
#   =================================================================
#   print a LIST - ignore trace mask
{
    my  $ptrList    = shift;
    my  $nameList   = shift;
    if (!defined $nameList) { $nameList = "f.LIST"; }
    print f_printList(@$ptrList,$nameList,1);
}

#   =================================================================
sub f_ARGV()                            # f()
#   =================================================================
{
    #   DESC: This functions reads the args of the scripts
    #   EXAM:   > perl prog.pl arg1 arg2
    #           < argv[0]=arg1 argv[1]=arg2
    print f_printList(@ARGV,"ARGV",0);   #TM = MIN
    print "ARGV='@ARGV'\n";;
    print "PARS='@_'\n";;
    # TRACE probably not defined.
}


#   =================================================================
sub f_PARAMS()  # --- doesn't work - to be defined later
#   =================================================================
{

    #   sub f($) {
    #       print "PARAMS:'@_'\n";      # this works
    #   }
    print f_printList(@_,"PARAMS",0);   # function args - but empty
}


#   --- HASHes

#   =================================================================
sub f_printHash(\%;$$)          # $str = f(%HashName;[$name,$tmask])
#   =================================================================
#   IN          : hashPtr
#   IN(optional): comment name of the hash
#   IN(optional): traceMask, if '0', don't print.
{
    my $ptrHash     = shift;
    my $hashName    = shift;
    my $tmask       = shift;
    my $str=0;

    if (!defined $ptrHash || ref($ptrHash) ne "HASH") {
         if (_W) {warn "&&& no ptr for print hash"};
         return($C_NULL);
    };
    if (!defined $tmask)    { $tmask=$C_TRACE_MASK_DEFAULT};
    if (!defined $hashName) { $hashName = "hash";};

    $str = sprintf("<<< H='%s'::={",$hashName);
    for (my $i=0;(my $key, my $obj) = each(%{$ptrHash}); $i++)
    {
        if ($i > 0) {
            ($i+1 % $C_LINE_SIZE == 0) ?
                $str =
                $str . sprintf("  ***\n") : $str = $str . sprintf(";");
        }
        $str = $str . sprintf("[$i]=\'$key\'=>\'$obj\'");
    }
    $str = $str . sprintf("}\n");
    # print "---01:tmask:$tmask\n";
    if ($tmask != 0) {
        f_TRACE_set($tmask);
        # print "mask=$tmask;vmask:$v_trace;gMask:$v_traceGLOBAL;\n";
        _P($str);
        # print $str;
    }
    return($str);
} # f_printHash


#   =================================================================
sub f_printOpts(\%;$)                       # f(;tmask)
#   =================================================================
#   2007.10.16: Umkehr-Funktion zu f~getOpts
#   Im Gegensatz zu den anderen f_printXXX() wird hier tats�chlich
#   etwas ausgegeben und nicht als $str gespeichert.
{
    my  $ptrHash    = shift;
    my  $tm         = shift;
    my  $hashName   = "lOpts";

    if (!defined $ptrHash || ref($ptrHash) ne "HASH") {
         if (_W) {warn "&&& lOpts not defined - use global one"};
         %$ptrHash = %::v_Opts;
         $hashName = "tmp_gOpts";
         # return(1);
    };
    if (!defined $tm) {
        $tm = $C_TRACE_MASK_DEFAULT;
    };
    my $str = f_printHash(%$ptrHash,$hashName,0);
    print $str;
    return(1);
}


#   =================================================================
sub f_HASH(\%;$)                        # f(%hashPtr,hashName)
#   =================================================================
#   print a HASH - ignore trace mask
{
    my  $ptrHash    = shift;
    my  $nameHash   = shift;
    my  %hash       = %$ptrHash;
    my  $str        = $C_NULL;
    if (!defined $ptrHash || ref($ptrHash) ne "HASH") {
        warn "??? fHash with HASHptr";
        return(0);
    }
    if (!defined $nameHash) { $nameHash = "f.HASH"; }
    $str =  f_printHash(%hash,$nameHash,0);
    print $str;
    return(1);
}

#   --- REFs

#   =================================================================
sub f_REF(\@)                           # &f(\@_)
#   =================================================================
{
    # checks the pointer in a list

    my $ParameterList = $_[0];
    my $n = @$ParameterList;
    my $p=0;

    f_LIST(@$ParameterList);
    if (ref($ParameterList) ne "ARRAY") {
        warn "??? use a list!"; return(0);
    }
    print "<<< REFS:{";
    for (my $i=0; $i<$n; $i++)
    {
        $p = $ParameterList->[$i];
        if    (ref($p) eq "SCALAR"&& defined $$p) {print "rfS($i):$$p;";}
        elsif (ref($p)eq "ARRAY" && defined @$p) {print "rfA($i):@$p";}
        elsif (ref($p)eq "HASH"  && defined @$p) {print "rfH($i):%$p;";}
        elsif (ref($p)eq "GLOB"  && defined @$p) {print "rfG($i):$p;";}
        elsif (ref($p)eq "CODE"  && defined @$p) {print "rfF($i):$p;";}
        elsif (ref($p)eq "REF"   && defined @$p) {print "rfR($i):\$p;";}
        elsif (!ref $p)                           {print "val($i):$p;";}
        ;
    }
    print "}\n";
    return(1);
}


#   *****************************************************************
#   print system informations
#   *****************************************************************

#   =================================================================
sub f_getFileInfo($)                  # $str = f($file)
#   =================================================================
{
    my $file        = shift();
    my @fileInfo    = stat($file);
    my $str         = $C_NULL_STR;
    $str =
        sprintf("###INFO (FILE=$file)\n")   .
        sprintf("Device                 : $fileInfo[0]\n") .
	    sprintf("Inode                  : $fileInfo[1]\n") .
	    sprintf("Mode                   : $fileInfo[2]\n") .
	    sprintf("hard-Links             : $fileInfo[3]\n") .
	    sprintf("uid                    : $fileInfo[4]\n") .
	    sprintf("gid                    : $fileInfo[5]\n") .
	    sprintf("rdev                   : $fileInfo[6]\n") .
	    sprintf("fileSize               : $fileInfo[7]\n") .
	    sprintf("time lastAccess        : $fileInfo[8]\n") .
	    sprintf("time lastChange        : $fileInfo[9]\n") .
	    sprintf("time lastInodeChange   : $fileInfo[10]\n") .
	    sprintf("blocksize              : $fileInfo[11]\n") .
	    sprintf("blocks                 : $fileInfo[12]\n");
	return($str);
}

#   =================================================================
sub f_getSysError(;\$)            # $eC = f([error])
#   =================================================================
{
    #   USAGE:      checks an error like errno.h in C
    #   EXAMPLE:    ... rename(file1,file2);
    #                   $errno = f()
    #                   if ($errno) {
    #                       printf("errStr:'$errno'\n";  # str
    #                       printf("errVal:'%d'\n",errno)
    #                   }
    #   REM:        Type of errno is INT or STRING and depends on
    #               call context.
    #   REM:        Errno '$!' must be cleared before calling!
    #               Better usage:
    #                   $! = 0;
    #                   myfunction(...);
    #                   print "Error:'f()'\n";
    #
    #   --- OLD
    #   USAGE:      checks an error after last eval() call

    # --- new
    # my  ($pErr) = (shift());
    # my  $errno  = $!;                  # only for eval : $@;
    # my  $errno  = $@;
    # if  (defined $pErr) {
    #     $$pErr      =  sprintf("SYSERROR='%s'('%d')",$errno,$errno);
    # }
    # return($errno);

    my ($pErr_ptr) = (shift());
    my $err = $@;
    my $str = 0;
    if ($err)
    {
        chomp($err);
        $str = sprintf("&&& sysERR=\'%s\'",$err);
        if (defined $pErr_ptr) {
            $$pErr_ptr = $str;
            return(1);          # errCode wanted
        }
        else {
            return($str);       # errStr wanted
        }
    }
    return(0);

}

#   *****************************************************************
#   SMALL TOOLS
#   *****************************************************************

#   =================================================================
sub f_sortStr($)
#   =================================================================
#   IN:     $str    = "xadxax1ee1bc"
#   RET/OUT:$rc     = "1abcdex"
#   DESC:   Sort a string and remove multiple chars.
{
    my  $str            = shift();
    my  ($i,$c,$e,$n)   = (0,0,0,0);
    my  @list=();
    my  @listOBJ=();

    @list   = split(//,$str);
    @list   = sort(@list);
    $n      = $#list+1;
    for ($i=0; $i < $n; $i++)
    {
        $e  = $list[$i];    # print "e[$i]=$e;";
        if ($c ne $e)
        {
            $c = $e;        # remember
            push(@listOBJ,$e);
        }
    }   # print "\n";
    $str    = join('',@listOBJ);
    return($str);
}

#   *****************************************************************
#   FileName Handling
#   *****************************************************************
#   --- doesn't change the file itself - changes only the input name

#   =================================================================
sub f_safeFileVersion($)            #   f($file)
#   =================================================================
#   FUNC:   Copies a file to a new version of the file.
#   USE:    A user want to save a file frequently.
#   IN:     fileName                # file exists
#   RES:    fileName.<VVV>          # VVV=VersionNr
#   RET:    0:error, 1:success
#   EXAMPLE:
#   >       f("file.txt")           # User asks for
#   <       "file.txt.001"          # new file version is created
#   >       f("file.txt");          # second call
#   <       "file.txt.002"          # next version is created
{

    my  $p_File         = shift();
    my  $versOK         = 0;
    my  ($vers,$ext)    = (0,0);
    my  ($file,$fileName,$fileVers,$dir,$str)    = (0,0,0,0,0);
    my  ($i,$l,$c)   = (0,0,0);
    my  $C_MAX_FILE_VERSIONS = 10;
    my  $C_FILE_EXTENSION_CHAR    = '.';
    my  $HOMEDIR        = cwd();        # save processDir
    my  $rc             = 0;
    my  $fp             = gensym();
    my  $tm             = $C_TRACE_MASK_FILE;

    #   --- init values
    $file   = f_getFileName($p_File);      # f_getFileName($filePath)
    $dir    = f_getDirName($p_File);

    #   --- use local dir
    chdir($dir);

    #   --- file exists ?
    $rc = open($fp,"< $file");
    if ((!defined $rc) || ($file eq 0)) {
        if(_W) {warn "??? Can't open file '$file'";};
        return(0);
    }
    close($fp);

    #   --- extract extension
    $fileName   = f_subFileExtension($file);
    $ext        = f_getFileExtension($file);

    #   --- search for next free versions
    for($i=0; $i<$C_MAX_FILE_VERSIONS; $i++) {
        $vers  = sprintf("%3.3d",$i+1);
        $fileVers   = $fileName . "." . $ext . "." . $vers;
        $rc = open($fp,"< $fileVers");
        if (!defined $rc) {
            last;
        }
        close($fp);
    }

    #   --- clean old files if no free entry
    if ($i == $C_MAX_FILE_VERSIONS) {
        _T($tm,"MAX FILE VERSIONS!\n");
        if(_W){ warn "!!! I clean old file versions!";};
        for($i=0; $i<$C_MAX_FILE_VERSIONS; $i++) {
            $vers  = sprintf("%3.3d",$i+1);
            $fileVers   = $fileName . "." . $ext . "." . $vers;
            unlink $fileVers;   # delete files in perl style
        }
        $vers = "001";
        $fileVers   = $fileName . "." . $ext . "." . $vers;
    }

    #   --- copy old file to new file name
    _T($tm,"VERSFILE::'$file'->'$fileVers'\n");
    copy    $file,$fileVers; # create new file

    #   --- finish work
    chdir($HOMEDIR);
    return(1);
}


#   =================================================================
sub f_safeFile($$$)         #   f($fileSRC,$fileOBJ,$mode)
#   =================================================================
#   FUNC:   Copy or move a file.
#   DESC:   Copy/Move SRC-file without/with overwrite an existing
#           OBJ-file. If overwrite, the original one is saved in
#           a file version.
#           A 'move' is a rename of a file,
#           a 'copy' results in two different files with same content.
#   PARA:   IN:     $fileSRC    - src file, or tempFile
#           OUT:    $fileOBJ    - obj file - is safe in every case
#           IN:     $mode       -   0:  copy $fileSRC -> $fileOBJ
#                                   1:  move $fileSRC -> $fileOBJ
#   ENV:    uses f_safeFileVersion()
#   RET:    0:success, 1:error
#   EXAMPLE:A)  >   f("file.Tmp","file",0);
#               <   "file" and "file.001" are created.
#           B)  >   f("file.Tmp","file",1);
#               <   "file" has content of old "file.Tmp" + "file.001" is
#                   created.
{
    my  $fp             =   gensym();
    my  $fileSRC        =   shift();
    my  $fileOBJ        =   shift();
    my  $mode           =   shift();
    my  $rc             =   0;
    my  $tm             =   $C_TRACE_MASK_FILE;

    #   --- from-file exists ?
    $rc = open($fp,"< $fileSRC");
    if ((!defined $rc) || ($fileSRC eq 0)) {
        if(_W) {warn "??? Can't open file '$fileSRC'";};
        return(0);
    }
    close($fp);

    #   --- check to-File
    if ($mode > 0) {
        #   to-file exists ?
        $rc = open($fp,"< $fileOBJ");
        if ((!defined $rc) || ($fileOBJ eq 0)) {
            _T($tm,"CREATE '$fileOBJ' only.");
            copy($fileSRC, $fileOBJ);   # if to-file doesn't exist : copy
            return(1);                  # ready !
        }
        close($fp);

        #   to==from file ?
        if ($fileSRC eq $fileOBJ) {
            _T($tm,"ERR:$fileSRC ::SRC==OBJ");
            if(_W) {warn "??? SRC==OBJ : use f_safeFileVersion()";};
            return(0);
        }
        #   to-file exists and != from-file !    ---
    }

    #   --- save a file version ?
    if ($mode >= 0)     # del,mov,cpy
    {
        $rc = f_safeFileVersion($fileOBJ);
    }
    else {
        $rc = 1;
    }

    #   --- delete src file
    if ($rc) {
        $rc     = unlink $fileOBJ;              # delete object
    }

    #   --- copy or move the file
    if ($mode == 0) {
        _T($tm,"DEL: SRC == '$fileSRC'\n");     # delete
    }
    elsif ($mode == - 1) {
        _T($tm,"RMV: SRC == '$fileSRC'\n");     # remove
    }
    elsif ($mode == - 2) {
        $rc     = rename($fileSRC,$fileOBJ);    # rename = move without safe SRC
        _T($tm,"REN: SRC == '$fileOBJ'\n");
    }
    elsif ($mode == 1) {
        $rc     = rename($fileSRC,$fileOBJ);    # move with safe SRC
        _T($tm,"MOV: SRC -> '$fileOBJ'\n");
    }
    elsif ($mode == 2) {
        $rc     = copy($fileSRC,$fileOBJ);      # copy only
        _T($tm,"CPY: SRC -> '$fileOBJ'\n");
    }

    return($rc);
}


#   =================================================================
sub f_deleteFile($)        #   f($fileSRC)
#   =================================================================
{
    return(f_safeFile($_[0],$_[0],0));
}

#   =================================================================
sub f_removeFile($)        #   f($fileSRC)
#   =================================================================
{
    return(f_safeFile($_[0],$_[0],- 1));
}
#   =================================================================
sub f_renameFile($)        #   f($fileSRC)
#   =================================================================
{
    return(f_safeFile($_[0],$_[1],- 2));
}

#   =================================================================
sub f_moveFile($$)         #   f($fileSRC,$fileOBJ)
#   =================================================================
{
    return(f_safeFile($_[0],$_[1],1));
}

#   =================================================================
sub f_copyFile($$)         #   f($fileSRC,$fileOBJ)
#   =================================================================
{
    return(f_safeFile($_[0],$_[1],2));
}




#   =================================================================
sub f_getFileName($)                # $fname = f(fnamePath)
#   =================================================================
    # INP: $fileName with Path          Example: "D:\SUB1\file.txt"
    # RET: $fileName without '/' Path   Example: "file.txt"
{
    my $filePath    = shift();
    if (!defined $filePath) {warn "??? gFileName(?)"; return(0)} ;
    $filePath       =~ tr /\\/\//s;
    my $i           = rindex($filePath,'/');
    if ($i > 0) {
        return(substr($filePath,$i+1,length($filePath)-$i));
    }
    else {
        return($filePath);
    }
}

#   =================================================================
sub f_getDirName($)                 # $dirName = f($filePath)
#   =================================================================
    # example1:
    #   INP: $fileNamePath          "D:\SUB1\file.txt"
    #   OUT: $dirName               "D:/SUB1"
    # example2:(specialCase)
    #   INP: $fileName              "file.txt"
    #   OUT: $dir                   "D:/myDir"
    # example3:(specialCase)
    #   INP: $fileName              "C:\file.txt"
    #   OUT: $dir with Path         "C:/"
    #   In this case f() uses current Dir !
    # REM:
    #   change 24.2.2004  - work with relative pathes
    #   ..\TMP\text1.txt    -> D:\TMP\text1.txt => dir=D:\TMP
    #   change 14.9.2007  - work with top-level dir
    #   change 07.5.2008  - work with windows toplevel Dir c: or u:
    # REM:
    #   Since $dir=cwd() returns at C: the string 'C:/'
    #   We use the same syntax now . 7.5.2008
    #   $dir="u:"  ;    chdir($dir);    $dir2=cwd() ;       $dir==u:/
    #   $dir="u:/test"  ;    chdir($dir);    $dir2=cwd() ;  $dir==u:/test
    #   TOP LEVEL dir C: returns now as "C:/"

{
    my          $filePath;
    my          $homeDir;
    my          $dir;
    my          $i;
    my          $l;
    my          $C_TEST_FILE="C:/Sandbox/BootloaderEmbedded/EBS5_1_BSL_AuC/Source/HWE_FLS/flash_prog.c";
    my          $bCHECK=0;
    my          $tm = $C_TRACE_MASK_FILE;

    $filePath   = shift();

    #   --- translate DOS to UNIX file namings
    $filePath   =~ tr /\\/\//s;

    #   --- check special file path
    if ($filePath eq $C_TEST_FILE) {
        $bCHECK=1;
        print "#01 f_getDirName:: filePath=$filePath\n";
    }

    #   --- Cut file name, look for last '/'
    $i  = rindex($filePath,'/');
    if ($i > 0)
    {   #   INPUT: filePath = dir/file
        $dir = substr($filePath,0,$i);
        $i  = rindex($dir,'/');
        $l  = length($dir);          # $filePath = "C:"; => len=2
        if (($i < 0) && ($l == 2) && (substr($dir,1,1) eq ':')) {
            f_printStr("--- TOPLEVEL DIR : '$dir'\n",$tm);
            $dir = $dir . '/';      # Windows topLevel-Dir add '/'
        }
        if ($bCHECK) {
            print  "#03a f~getDirName:: dir i_0=$dir; index_i=<$i>\n";
        }
    }
    else        {    #   INPUT: filePath="fileName"    - special case
        $dir = f_OS_DIR_CURRENT();
        if ($bCHECK) {
            print  "#03b f~getDirName:: dir i_X=$dir\n";
        }
    }

    #   --- prepare look at found dir : save curr dir position
    $homeDir = cwd();
    if ($bCHECK) {
        print "#05 f~getDirName:: homeDir=$homeDir\n";
    }
    chdir($dir);        # goto DIR of input-filePath
                        # REM: chdir("C:") doesn't work !
    #    $dir    = f_OS_DIR_CURRENT();    # OLD-VERSION

    #   --- get file path with
    $filePath   = cwd();            # again

    if ($filePath ne $dir) {
        f_printStr("??? f~getDirName()::filePath='$filePath' <> dir='$dir'\n",$tm)
    }
    if ($bCHECK) {
        print "#07a f~getDirName:: filePath=$filePath\n";
        print "#07b f~getDirName:: DIR=$dir\n";
    }
    $dir = $filePath;
    chdir($homeDir);
    return($dir);
}


#   =================================================================
sub f_makeFileNamePath($$)            # IN: $dir, $file
#   =================================================================
#   Example1:
#       IN:     $dir        =   "D:"
#       IN:     $file       =   "file.txt"
#       OUT:    $filePath   =   "D:/file.txt"
#   Exampl2:
#       IN:     $dir        =   "D
#   REM:    The fct returns
{
    my $dir    = shift();
    my $file   = shift();

    my      $C_TEST_FILE="+myCAN.txt";
    my      $i=0;
    my      $l=0;
    my      $filePath="/";

    $dir       =~ tr /\\/\//s;  # substitute: '\' => '/'
    $i = index($dir,':');
    $l = length($dir);          # $dir = "C:\"; len=3
    if ($i > 0 && $l == 3) {
        #   SPECIAL case for Windows TopLevel Dir like "C:\"
        #   $dir = "C:/"
        #   $dir = chop($dir); err - doesn't change to "C:" - why ?
        #
        $dir = substr($dir,0,2);    #cut last '/'
    }
    $filePath = $dir . '/' . $file;
    return($filePath);
}

#   =================================================================
sub f_getFileNamePath($)                # $filePath = f($file)
#   =================================================================
#   IN:     $file           Example:"file.txt"
#   OUT:    $filePath       Example:"D:/SUB1/file.txt"
{
    my $file    = shift();
    $file       =~ tr /\\/\//s;  # substitute: '\' => '/'
    my $i       = rindex($file,'/');
    if ($i > 0) {
        return($file);   # noChange
    }
    else {
        my $dir = cwd();
        return($dir . "/" . $file);
    }
}


#   =================================================================
sub f_modFileNamePath($)                # $unixFilePath = f($FilePath)
#   =================================================================
#   IN:     $filePath       Example:"D:\SUB1\file.txt"
#   OUT:    $unixFilePath   Example:"D:/SUB1/file.txt"
{
    my $file    = shift();
    if (!defined $file) {warn "fileName?"; exit;}
    $file       =~ tr /\\/\//s;  # substitute: '\' => '/'
    return($file);   # modified
}


#   =================================================================
sub f_addFileExtension($$)      # IN:f("file","ext")   OUT:"file.ext"
#   =================================================================
#   IN:     $filePath
#   OUT:    $filePath.EXT
{
    my $file            = shift();
    my $fileExtension   = shift();
    $file               = $file . '.' . $fileExtension;
    return($file);
}

#   =================================================================
sub f_subFileExtension($)       # IN:f("file.ext")      OUT:"file"
#   =================================================================
#   IN:     $filePath.EXT
#   OUT:    $filePath
#   EXA:    > f("D:\TMP\test1.hlp.cpp")
#           < "D:\TMP\test1.hlp"
{
    my $file            = shift();
    my $i               = 0;
    $i                  = rindex($file,'.');
    $file               = substr($file,0,$i);
    return($file);
}


#   =================================================================
sub f_getFileExtension($)   # ext = f($FilePath)
#   =================================================================
#   IN:     $filePath               Example:"D:\SUB1\file.txt"
#   OUT:    $unixFilePath +$ext     Example:"D:/SUB1/file" , "txt"
{
    my $file    = shift();
    my $fileExtension = 0;
    my $i=0;

    if (!defined $file) {warn "fileName?"; exit;}
    $file       =~ tr /\\/\//s;  # substitute: '\' => '/'
    $i = rindex($file,$C_FILE_EXTENSION);
    if ($i > 0) {
        $fileExtension  = substr($file,$i+1,length($file)-$i-1);
    }
    return($fileExtension);
}


#   =================================================================
sub f_isFileName($)     # rOK = f($FilePath)
#   =================================================================
#   IN:    $unixFilePath +$ext     Example:"D:/SUB1/file" , "txt"
#   OUT:   0: noFile, 1: isFile
{
    my $file    = shift();
    my $fileExtension = 0;
    my ($i,$l,$c)      = (0,0,0);

    if (!defined $file) {warn "fileName?"; exit;}
    $file       =~ tr /\\/\//s;  # substitute: '\' => '/'

    $c = substr($file,$i,1);
    if (f_isDigit($c)) {
        return(0);
    }

    $l  = length($file);
    $c  = substr($file,$l-1,1);
    print "last char is '$c'\n";
    if ($c eq $C_DIR_SEPERATOR) {
        print "not file!\n";
        return(0);
    }

    return(1);
}

#   =================================================================
sub f_printFile($)
#   =================================================================
#   IN:     $filePath
#   RET/OUT:$rc     = 1:OK, 0:FALSE
#   DESC:   print a text file
{
    my  $file   = shift();
    my  $fp     = gensym();
    my  $rc;
    my  $line;

    $rc = open($fp,"< $file");
    if (! $rc) {
        if(_W) {warn "*** WARN:open(FILE:\"$file\",READ)"};
        return(0);
    }
    while (!eof($fp))
    {
        # --- get line and prepare a str
        $line  = readline($fp);
        print $line;
    }
    close($fp);
    return($rc);
}


#   =================================================================
sub f_getFileSize($)
#   =================================================================
#   IN:     $filePath
#   OUT:    fileSize
{
    my  $file       = shift();
    my  $fileSize   = (stat($file))[7];

    #  --- stat values
    #  0 dev      device number of filesystem
    #  1 ino      inode number
    #  2 mode     file mode  (type and permissions)
    #  3 nlink    number of (hard) links to the file
    #  4 uid      numeric user ID of file's owner
    #  5 gid      numeric group ID of file's owner
    #  6 rdev     the device identifier (special files only)
    #  7 size     total size of file, in bytes
    #  8 atime    last access time in seconds since the epoch
    #  9 mtime    last modify time in seconds since the epoch
    # 10 ctime    inode change time in seconds since the epoch (*)
    # 11 blksize  preferred block size for file system I/O
    # 12 blocks   actual number of blocks allocated

    return($fileSize);
}



#   *****************************************************************
#	TRACE functions
#   *****************************************************************


#   =================================================================
sub f_LINE(;$$)                         # f('-',10)
#   =================================================================
#   DESRC:  prints 1 line at screen
{
    my $args    = @_ ;
    my ($c,$l)  = (0,0);
    ($args >= 1) ? ($c = shift()) : ($c = $C_COMMENT);
    ($args >= 2) ? ($l = shift()) : ($l = $C_LINE_SIZE);
 	print('-' x $l);
	print ("\n");
}


#   =================================================================
sub f_HEADER(;$$$)          # f("fct",FileName,LineNr);
#   =================================================================
#   DESRC:  prints simply a Name at screen surrounded
#           by 2 seperator lines
#   USAGE:  f_HEADER("fct")
#           f_HEADER("fct",__FILE__,__LINE__)
{
    my  $args    = @_ ;
    my  ($fctn,$file,$line)=(shift(),shift(),shift());
    my  $osname = $^O;
    my  $myOsName = substr($osname,0,1); # 'l':Linux, 'M':MsWindows
    if ($args == 1) {
        printf("*** fct:\'%s\'\n",$fctn);
    }
    elsif ($args >= 3) {
        f_LINE();
        (defined $file) ?
            ($file = f_modFileNamePath($file)) : ($file="?File?");
        if (!defined $line) { $line="?Line"; };
        printf("[%s;%3.3d]:%s:%s()\n",$file,$line,$osname,$fctn);
        f_LINE();
    }
}

#   =================================================================
sub f_CALLER($;\$\$\$\$)            # $callStr = f($lvl,$fct,...)
#   =================================================================
#   USE:  $callStr = f($lvl[,$fct_O,file_O,$line_O,$pack_O])
#   IN:   $level        0:STANDARD
#   OUT: ($fct,$file,$line,$pack)
#   RET: "FCT:$fct,FILE:$file,LINE:$line"
{
    my  $level                       = shift();
    my  ($p_fctPtr,$p_filePtr,$p_linePtr,$p_packPtr)
            = (shift(),shift(),shift(),shift());
    my  ($pack0,$file0,$line0,$fct0) = (0,0,0,0);
        ($pack0,$file0,$line0,$fct0) = caller($level);
    my  ($pack1,$file1,$line1,$fct1) = caller($level+1);
    my  $callStr = 0;


    if ((!defined $fct0)||(!defined $file0) ||(!defined $line0) ||
        (!defined $pack0))
    {
        $p_fctPtr = $p_filePtr = $p_linePtr = $p_packPtr = 0;
        if (_W) { warn ("&&& CALL STACK TOO DEEP"); }
        return(0);
    };
    $file0          = f_getFileName($file0);
    if (!defined $fct1)   {$fct1 ="?FCT=BODY?"};

    (defined $p_fctPtr) ?   ($$p_fctPtr     = $fct1)    : ();
    (defined $p_filePtr)?   ($$p_filePtr    = $file0)   : ();
    (defined $p_linePtr)?   ($$p_linePtr    = $line0)   : ();
    (defined $p_packPtr)?   ($$p_packPtr    = $pack0)   : ();

#   print "f_CALLER: PACK=$pack0,FILE=$file0,LINE=$line0,FCT=$fct0\n";
    $callStr = sprintf("<<< CALL($level): $fct0;$file0,$line0");

    return($callStr);
}

#   =================================================================
sub f_STACK($)          # f($stackLvl)
#   =================================================================
#   print for each level the stack
#   Instead of f_CALL() the stackLvl starts with '0' for the own
#   location.
#   Example: >print f_STACK(2);
#		     <STACK(0..2): <FUNCTION > <FILE> <LINE>
{
    my  $lvl = shift();
    my ($pack1,$file1,$line1,$fct1)=(0,0,0,0);
    my  $str="";

    if ($lvl < 0) { if(_W) {warn "??? fSTACK(>0)"}; return($str);};
    for (my $i=0; $i <= $lvl; $i++)
    {
        ($pack1,$file1,$line1,$fct1)=(0,0,0,0);
        f_CALLER($i+1,$fct1,$file1,$line1);
        $str =  $str .
                sprintf("<<< STACK($i): '$fct1'['$file1','$line1'] \n");
    }
    return($str);
}

#   =================================================================
sub f_TRACE_init($)                 # $tmGlobal = f(tmask)
#   =================================================================
{
    my  $tmask          = shift();
    $v_traceGLOBAL      = $tmask;
    $v_trace            = $tmask;
    return($v_traceGLOBAL);
}


#   =================================================================
sub f_TRACE_set($)                  # $traceOK = f(tmask)
#   =================================================================
{
    if ($v_traceGLOBAL == $C_TRACE_MASK_DEFAULT)
    {
        $v_trace    = $C_TRACE_MASK_DEFAULT;
    }
    else
    {
        $v_trace    = shift();
        $v_trace    &= $v_traceGLOBAL;
    }
    ($v_trace) ? ( return(1) ) : ( return(0) ) ;
}


#   =================================================================
sub f_TRACE_ok()                    # $traceOK = f()
#   =================================================================
{
    if (!defined $v_trace)  { $v_trace = 0 };
    ($v_trace) ? ( return(1) ) : ( return(0) ) ;
}


#   =================================================================
sub f_TRACE_do(;$$$)          # f([;traceId,traceMask,CallLevel])
#   =================================================================
#   DESRC:  If set option '-T' traces are generated.
#           FileName,LineNumber and Time is printed.
#   REM:    traceMask=='0' :=> only print TRACES - delete global Trace
#   USAGE:  f_TRACE_do(name,mask);
{
    my  $args           = @_ ;
    my  $p_traceId      = shift();
    my  $p_tm           = shift();
    my  $p_lvl          = shift();
    my  $osname = $^O;
    my  $myOsName = substr($osname,0,1); # 'l':Linux, 'M':MsWindows
    my  $timeStr=0;                         ;
    my  ($lvl,$fct,$file,$line,$packg) = (0,0,0,0,0);
    my  $str = 0;

    if  (!defined $p_traceId) {
        $p_traceId = "?ID?";
    }
    if (!defined $p_tm) {
        if (_W) { warn "!!! f~TRACE~do(tmask) not defined"; }
        $p_tm=0;
    }
    if (!defined $p_lvl) {
        $p_lvl = 1;
    }

    $str = f_CALLER($p_lvl,$fct,$file,$line);
    $str =
    sprintf("%s FCT={%s;%s;%3.3d};TIME={%s};OS={\'%s\'};TXT={'%s'}\n",
                $C_MARKER_TRACE,
                $fct,
                f_getFileName($file),
                $line,
                f_getTime(),
                $myOsName,
                $p_traceId);

    f_TRACE_set($p_tm);
    if   ($p_tm == 0) { print $str }    # print always, independent of '-T' user input
    else { _P($str) };
}

#   =================================================================
sub f_TRACE_raw($$)          # f(str,trl)
#   =================================================================
{
    my  $p_sStr         = shift();
    my  $p_iLvl         = shift();
    if ($p_iLvl > 0) {
        printf("%s",$p_sStr);
    }
}    

#   *****************************************************************
#   OPTS HANDLING
#   *****************************************************************

#   =================================================================
sub f_dummyHelp()                #f()
#   =================================================================
#   If the user omit the help function in f_getOpts(), this
#   dummy help function is invoked.
{
    my $str =
    sprintf("<<< DUMMY USER HELP : sorry, no special help\n");
    return($str);
}

#   =================================================================
sub f_help()
#   =================================================================
{
    my $str =
    "<<< GENERAL USAGE\n" .
    "perl -S -I <INCPATH> f.pl <ARGS>\n" .
    "--- with ARGS:  [-<HELPS>] [-<MODES>] [-<OPTIONS>]\n" .
    "*** Introduction\n" .
    "HELPS  ={h|H|help[=N={0,...,9}]}\n" .
    "       : N={1:Intro,2:Modes,3:Options,4:Trace}\n" .
    "       : N={5:RegExpr,6:fullRegExpr,7:simpleRegExpr}\n" .
    "       : N={9:userHelp,0=1+9(default)}\n" .
    "MODES  ={O,L,S,T[=HHHH],W,R,of,lf}\n".
    "OPTS   ={dir,file,str|xstr,reg|{src,obj},text,val,nr,fctnr}\n" .
    "\n";
    return($str);
}

#   =================================================================
sub f_helpModes()
#   =================================================================
{
    my $str =
    "<<< HELP MODES\n" .
    "perl f.pl [-h=0...9] [-<MODES>] [-<OPTIONS>]\n" .
    "*** Modes\n" .
    "Opts|O|o           : use Options in \'$C_OPTSFILE\'\n" .
    "optsfile|of        : own OptsFile. implies -O\n" .
    "Logging|L[=N]      : log output to \'$C_LOGFILE\'\n" .
    "logfile|lf         : own LogFile.  implies -L\n" .
    "VERSION|v          : version\n" .
    "Overwrite|ov       : overwrite source (userfctn dependend)\n" .
    "Recursive|R        : searches recursive subdirs\n" .
    "Trace|T[=HHHH]     : trace and traceMask\n" .
    "Warn|W             : prints warnings\n" .
    "\n"  .
    "*** REM            \n"  .
    "'-L' or '-L=1'     : logging and trace.\n" .
    "'-L=2'             : logging only\n" .
    "*** Other Helps you get with \"\-H=<N>\"\n"  .
    "\n" ;
    return($str);
}

#   =================================================================
sub f_helpOpts()
#   =================================================================
{
    my $str =
    "<<< HELP OPTIONS\n" .
    "perl f.pl [-h=0...9] [-<MODES>] [-<OPTIONS>]\n" .
    "*** Opts\n" .
    "--- general\n" .
    "dir        : Directory\n" .
    "file|f     : File {Globbing(*,?)}\n" .
    "val        : decimal Value\n" .
    "nr         : decimal Value\n" .
    "cmd        : command\n" .
    "fct        : (test function) Number\n" .
    "fctnr      : function Number\n" .
    "--- strings  ={str|xstr} *only 1 of both!!!\n" .
    "text       : simple text\n" .
    "             USAGE: -text=<TEXT>\n" .
    "str        : String\n"    .
    "             USAGE: -str=<TEXT> or -str='<X-TEXT>'\n" .
    "             REM  : X-TEXT={[TEXT]|\"\\HH\"} \n" .
    "                    with:HH=asciiCode and Meta=\'\\\' \n" .
    "             EXMPL: X-TEXT:='pet\\45r' means ='petEr' \n" .
    "xstr       : or Extended (X-)String with \'\\HH\' \n" .
    "             USAGE: -xstr=<X-TEXT>\n" .
    "--- expressions ={reg|{src,obj}} *only 1 !!!\n" .
    "src=[<q>]/<str>/           :a simple RegExpr\n" .
    "obj=[<q>]/<str>/           :a simple RegExpr\n" .
    "reg=<q>/<src>/<obj>/<m>    :a RegularExpression\n" .
    "regI=<STR>               :string for a RegExpr\n" .
    "\n" .
    "*** REM: In the case of '-xstr' the result is used\n" .
    "         in '-str'\n" .
    " " ;
    return($str);
}

#   =================================================================
sub f_helpRegs()
#   =================================================================
{
    my $str =
    "<<< HELP REGULAR AND SIMPLE EXPRESSIONS\n" .
    "perl f.pl [-h=0...9] [-<MODES>] [-<OPTIONS>]\n" .
    "\n\n" .
    "=== a.) (Full) Regular Expression Usage\n" .
    "regEXPR:={-reg=q/src/obj/m [-regI='text']} \n" .
    "*** REM: with 'regI' the regExpr is immediately\n" .
    "       : performed and saved in 'regO'\n" .
    "-reg = <q>/<src>/<obj>/<m> : a Unix RegExpression\n" .
    " q   = {s,m,tr,y}          : RegExpr known qualifiers\n" .
    " m   = {c e g i m o s x }  : RegExpr known modifiers \n" .
    " src                       : a X-String\n" .
    " obj                       : a X-String\n" .
    "*** USE: >perl f.pl -regI=ABC -reg=s/A/x/g\n" .
    "         <'xBC'\n" .
    "*** USE: >perl f.pl -regI=A1B2C3 -reg=s/[[:digit:]]/x/g\n" .
    "         <'AxBxCx'\n" .
    "*** REM: The components of '-reg' are copied into the \n" .
    "         Options '-src','-obj','-qual' and '-modi'.\n" .
    "*** REM: The input text is saved in '-regI'\n" .
    "         the result is saved into '-regO'.\n" .
    "\n\n" .
    "=== b.) Simple Expression Usage\n" .
    "-src = <q>/<str>/\n" .
    "-obj = <q>/<str>/\n" .
    "   q = {[t],T,x,a,u}       : simple qualifers -def:'t'\n" .
    "*** EXAMPLES              \n" .
    "q:=  => str='....'         : normal String\n" .
    "q:=s => str='....'         : ...the same\n" .
    "q:=x => str='...\\HH...'    : extended Str - mix of chars and hexcoded chars\n" .
    "q:=h => str='HH..HH'       : <HH>+  HH=asciiValue\n" .
    "q:=u => str='HHHH..HHHH'   : <HHHH>+ =unicodeValue\n" .
    "*** REM: In the case of '-src' the qualifier is saved in\n" .
    "         '-qual', if '-obj' it is saved in '-modi'.\n" .
    "*** REM: It make only sense to use\n" .
    "         either RegExpressions or SimpleExpressions\n" .
    "\n" ;
    return($str);
}

#   =================================================================
sub f_helpFullRegExpr()
#   =================================================================
{
    my $str =
    "<<< HELP (FULL) REGULAR EXPRESSION MODES\n" .
    "-reg = <q>/<src>/<obj>/<m> : a Unix RegExpression\n" .
    "   q:  {s,m,tr,y}          : RegExpr known qualifiers\n" .
    "   m:  {c e g i m o s x }  : RegExpr known modifiers \n" .
    "---Qualifiers 'q':\n" .
    "   tr: translate\n" .
    "   y:  meaning equal to 'tr'\n" .
    "   s:  substitute\n" .
    "   m:  search for a pattern\n" .
    "---Modifiers 'm':\n" .
    "   c:  continues previous match\n" .
    "   d:  delete chars found in SEARCHLIST but not in REPLCMNTLIST\n" .
    "   g:  global - don't stop at once\n" .
    "   i:  case insensitiv pattern matching\n" .
    "   m:  multiple line\n" .
    "   o:  interpolates variable once only\n" .
    "   s:  match '.' even as empty lines\n" .
    "   x:  extended RegExpr - more than 1 line\n" .
    "---Extended-Strings in 'src' and 'obj':\n" .
    "   In <src> and <obj> use for typical reg chars the corresponding\n" .
    "   ascii-code x-values. For instance instead of '^' use '\\5E'.\n" .
    "   The syntax for x-values are :   x-value::'\\'<ASCIICODE>.\n" .
    "===TABLE of important reg chars....\n" .
    "   '^':'45' \n" .
    "   ';':'3B' \n" .
    "***examples: \n" .
    "   <src>='\\45#'    # look for lines starting wih '#' \n" .
    "   <src>='\\3B\$'    # look for lines ending with ';' \n" .
    "\n" ;
    return($str);
}

#   =================================================================
sub f_helpSimpleRegExpr()
#   =================================================================
{
    my $str =
    "<<< HELP SIMPLE REGULAR EXPRESSION MODES\n" .
    "-reg = [<q>]/<src>/          : a simple  RegExpression\n" .
    "   q:  {t,a,u,x} :='t'       : Qualifiers\n" .
    "---Qualifiers q:\n" .
    "   t:  normal text string - default if 'q' is omitted\n" .
    "   a:  ascii-chars - are 2-hex-numbers like '45' for an 'e' \n" .
    "   u:  uni-Char - are 4-hex-numbers \n" .
    "   x:  extended string like '...\\HH...'\n" .
    "\n" ;
    return($str);
}

#   =================================================================
sub f_helpTrace()
#   =================================================================
{
    my $str =
    "<<< HELP TRACE MASKS\n" .
    "perl f.pl [-h=0...9] [-<MODES>] [-<OPTIONS>] -T[=HHHH]\n" .
    "*** REM:\n" .
    "A trace mask a 4-digit hex Value (==16-bit dual-Value).\n" .
    "It activates corresponding traces in the fct-LIB or in the user-SCRIPT.\n" .
    "Combine traces are get by traceMore = trace1 & trace2.\n"  .
    "If you omit the MASK=HHHH, the default trace mask is used.\n"  .
    "This means all traces are active or: "  .
    sprintf("trace mask '%4.4X' is used.\n",$C_TRACE_MASK_DEFAULT)  .
    "--- DEFINED BITMASKS\n" .
    sprintf("BASE       : %4.4X\n",$C_TRACE_MASK_BASE) .
    sprintf("SYS        : %4.4X\n",$C_TRACE_MASK_SYS) .
    sprintf("REG        : %4.4X\n",$C_TRACE_MASK_REG) .
    sprintf("META       : %4.4X\n",$C_TRACE_MASK_META) .
    sprintf("OPTS       : %4.4X\n",$C_TRACE_MASK_OPTS) .
    sprintf("DIRTREE    : %4.4X\n",$C_TRACE_MASK_TREE) .
    sprintf("FILE       : %4.4X\n",$C_TRACE_MASK_FILE) .
    sprintf("BIN        : %4.4X\n",$C_TRACE_MASK_BIN) .
    sprintf("SUB  (USR) : %4.4X\n",$::C_TRACE_MASK_SUB) .
    sprintf("MAIN (USR) : %4.4X\n",$::C_TRACE_MASK_MAIN) .
    sprintf("DEFAULT    : %4.4X\n",$C_TRACE_MASK_DEFAULT) .
    "\n" ;
    return $str;
}


#   =================================================================
sub f_initOpts(\%)              #f(\%Opts)
#   =================================================================
{
    my  $p  = shift();
        %$p = (
        "help"      => $C_NULL, # fGetOpts set:'0',if set without Val
        "opts"      => 0,   # Opts-File
        "optsfile"  => 0,   # Opts-FileName - read options here
        "Logging"   => $C_NULL,   # Ausgaben(Trace,Debug,normale)loggen L=0,1,2
        "logfile"   => 0,   # Log-FileName - log into this file
        "dir"       => 0,   # Dir
        "file"      => 0,   # File
        "text"      => 0,   # Text without any tricks
        "str"       => 0,   # Str
        "xstr"      => 0,   # extended X-Str "abc\xNN..\xNN..."
        "reg"       => 0,   # RegExpr
        "regI"      => 0,   # RegExpr InputText
        "regO"      => 0,   # RegExpr OutputText
        "src"       => 0,   # STR || reg.SRC    reg=q/<src>/
        "obj"       => 0,   # STR || reg.OBJ    reg=q/src/obj/m
        "qual"      => 0,   # reg.Qualifier     reg=qualifier/.../
        "modi"      => 0,   # reg.Modifier      reg=q/..../modifier
        "val"       => 0,   # decimal value
        "nr"        => 0,   # number
        "cmd"       => 0,   # function or function number
        "fct"       => 0,   # function or function number
        "fctnr"     => 0,   # function or function number
        "VERSION"    => 0,  # Version
        "Overwrite"  => 0,  # Overwrite Src-File if Possible
        "Warning"   => 0,   # WarningLevel
        "Recursive" => 0,   # SubDirectores
        "Trace"     => 0   # Trace
        );
}


#   =================================================================
sub f_getOpts (\%\&)        # f(%optHash &,[&helpFunction &])
#   =================================================================
    #   RC:     0:Input not OK, 1:OK
    #   IN/OUT: optHash:        - Hash, where the options are saved to
    #   IN:     helpFunction:   - Additional help of the user function
    #   USES:   s_initOpts      - counts the recursive calls
    #   DESC:
    #   Puts Options into input-Hash;
    #   If Option='-h' it calls the 'helpFunction' and 'f_helpUsage'.
    #   When Option='-O' it reads the OptionFile and calls themselve
    #   recursive.
{
    my  $args       = @_;           #nr of valid arguments
    my  @l_argv     = ();
    my  $p_Opts_ptr = shift();
    my  $pHelpFkt   = shift();
    my  ($file,$str,$val,$n,$rc)    =(0,0,0,0,0);
    my  ($reg,$src,$obj,$qualifier,$modifier) = (0,0,0,0,0);
    my  $tm         = $C_TRACE_MASK_OPTS;
    my  $fp         = gensym();
    my  %hOpt      = ();  # !CRQ-190528:helperHash


#-- init Options (recursive call?)
    if ($s_initOpts == 0) {
        f_TRACE_init(0);
        f_initOpts(%$p_Opts_ptr);
    }

#-- check args  - automatically call help if no args
    $args   =   @ARGV;          # cmd Args
    if ($args == 0) {
        if (defined $pHelpFkt) {
            &$pHelpFkt();
        }
        return(0);
    }

#-- read Options    : GetOptions() clears @ARGV() !!!
    @l_argv = @ARGV;    #save ARGV
    $rc  = GetOptions(
                \%hOpt,
                'help|h|?:i', # '-h':0;'-h<N>':<N>;else:C_NULL
                'opts|o',   #OPTIONEN-FILE
                'optsfile|of=s',    #OptsFile
                'Logging|L:i',  #default=0/1:LOG+TRACE;2:LOGGING ONLY
                'logfile|lf=s',     #LogFile
                'dir=s',    #Dir = '.' == currentDir
                'file|f=s',
                'text=s',   #text
                'str=s',    #Str
                'xstr=s',   #X-Str xstr="p\x45ter" => str=peter
                'reg=s',    #RegStr reg="qual/src/obj/modi"
                'regI=s',   #RegTxt       IN:text;
                'regO=s',   #RegTxtOutput OUT:text=~reg;
                'src=s',    #simpleQualifier or result=reg-SRC
                'obj=s',    #simpleQualifier or result=reg-OBJ
                'qual=s',   #result=reg-Qualifier
                'modi=s',   #result=reg-Modi
                'val=i',    #Decimal Value
                'cmd=s',    #a cmd value
                'fct=i',    #fct address or function number
                'fctnr=i',  #fct number
                'VERSION|V',	#Version
                'Overwrite|OV',
                'Warning|W',
                'Recursive|R',
                'Trace|T:s'     #Optional TraceMask value=FFFF=ALL
                ) ;
    @ARGV     = @l_argv;            # restore '@ARGV()'
    %$p_Opts_ptr = %hOpt;
    %::v_Opts    = %$p_Opts_ptr;    # copy::USER(%localOpts)->FCT(globalOpts)
    f_HASH(%$p_Opts_ptr,"v_Opts1");

#-- PRINT HELP FUNCTIONS
    if ($C_TRACE_LIB) { printf("+++ fgo: printHelp\n"); };
    if ( defined $$p_Opts_ptr{"help"}  || (! $rc)){
        if (!$rc) {if (_W){warn "&&& ERR: GetOpt::GetOptions";}};
        if (!defined $pHelpFkt) {
                if(_W){warn "!!! I bind dummy user help."};
                $pHelpFkt = \&f_dummyHelp
        };
        $n = $$p_Opts_ptr{"help"};
        if ((!isdigit($n)) || ($n < 0) || ($n > 9)) {
                        if(_W){warn "--- help with Option: '-h'";};
                        &$pHelpFkt();
                        return(0);
        }
        if ($n == 0) {  &$pHelpFkt();                   # 'h'
                        print f_help(); }
        if ($n == 1) {  print(f_help())    }            # 'h=1'
        if ($n == 2) {  print(f_helpModes())    }       # 'h=2'
        if ($n == 3) {  print(f_helpOpts())     }       # 'h=3'
        if ($n == 4) {  print(f_helpTrace())    }
        if ($n == 5) {  print(f_helpRegs())     }
        if ($n == 6) {  print(f_helpFullRegExpr())    }
        if ($n == 7) {  print(f_helpSimpleRegExpr())    }
        if ($n == 8) {  print(f_dummyHelp())    }       # 'h=8'
        if ($n == 9) {  &$pHelpFkt();           }       # 'h=9'

        return(0);  # not a normal input - help !
    }

#-- use Option File
    $s_initOpts ++ ;
    if ( defined $$p_Opts_ptr{"optsfile"}  || defined $$p_Opts_ptr{"opts"} )
    {
        if ($s_initOpts == 1) {     # first call
            if ($$p_Opts_ptr{"optsfile"} ne 0) {
                $file = $$p_Opts_ptr{"optsfile"};
            }
            else {
                $file = $C_OPTSFILE;
            }
            &f_initOpts($p_Opts_ptr);
#           print "***OFILE:$C_OPTSFILE; LFILE:$C_LOGFILE\n";
            $file = f_modFileNamePath($file);
            $rc   = f_readOptsFile($file,@ARGV);   #changes @ARGV[]
            if ($rc == 0) {
                if (_W){warn "*** fgetOpts::Can't read optsFile \'$file\'"};
                f_help();
                return(0);
            };
#           ---------------------------------------------------------
            $rc = f_getOpts(%$p_Opts_ptr,&$pHelpFkt);  #recursiv
#           ---------------------------------------------------------
            return($rc);
        }
    }


#-- set Trace
    # f_HASH(%$p_Opts_ptr,"MYOPTS3");
    if (defined $$p_Opts_ptr{"Trace"})  {
        # print "Trace NE 0\n";
        $str = $$p_Opts_ptr{"Trace"};
        if ($str eq $C_NULL_STR)
        {
            # print "T not defined \n";
            $n = $C_TRACE_MASK_DEFAULT;
            if(_W){warn "!!! f_getOpts:TRACE=ALL"};
        }
        else {
            # print "T == h2bin\n";
            $rc = f_hex2bin($str,$val);     #hexStr=>hexVal
            if ($rc <= 0) {
                if(_W){warn "??? fgOpts(hex2bin):rc=$rc"};
                return(0);
            }
            $n = $val;
            # printf("fgetOpts:TRACE:'%d'=='%X'\n",$n,$val);
        }
        $n = f_TRACE_init($n);   #IN:tmask,OUT:tmaskGlob
        $$p_Opts_ptr{"Trace"} = sprintf("%4.4X",$n);
        %::v_Opts     = %$p_Opts_ptr;       #update changes
    }

   # f_HASH(%::v_Opts);
#-- use Log File
    if ( defined $$p_Opts_ptr{"logfile"} || defined $$p_Opts_ptr{"Logging"} )
    {
        if ($$p_Opts_ptr{"Logging"} ne $C_NULL) {
            if ($$p_Opts_ptr{"Logging"} eq 0) {             #default value '-L'
                $$p_Opts_ptr{"Logging"} = 1;
            }
            if ($$p_Opts_ptr{"logfile"} eq 0) {
                $$p_Opts_ptr{"logfile"} = $C_LOGFILE;
            }
        }
        elsif ($$p_Opts_ptr{"logfile"} ne 0)   {
            $$p_Opts_ptr{"Logging"} = 1;
            $file =  f_modFileNamePath($$p_Opts_ptr{"logfile"});
            $$p_Opts_ptr{"logfile"} = $file;
        }
        $file = $$p_Opts_ptr{"logfile"};

        # --- delete old logfile if exist
        $rc = open($fp,"< $file");         #open(r)
        if (defined $rc) {
            close($fp);
            $rc = unlink $file;
            if ($rc > 0) {  _P("+++ Logfile '$file' deleted\n")}
            else         {  warn "!!! Can't delete open logfile '$file'";}
        }
        # --- create newfile
        $rc = open($fp,"> $file");
        if (defined $rc) {
            $rc = open($fp,">> $file");;
            $str = ">>> LOGGING started : " . f_getTimeFormat() . "\n";
            print ($fp "$str");
            close($fp);
#           _P("+++ LOGFILE '$file' created !\n");
            print("+++ LOGFILE '$file' created !\n");
        }
        else {
            warn "!!! I can' create LOGFILE '$file'\n";
        }
        # ---- update Opts
        %::v_Opts     = %$p_Opts_ptr;       #update changes
        _T($tm,sprintf("*** fgetOPTS:LOGGING NOW?\n"));
    }


#-- set Dir
    if ( (!defined $$p_Opts_ptr{"dir"}) || ($$p_Opts_ptr{"dir"} eq ".")) {
        $$p_Opts_ptr{"dir"} = cwd();
    }


#-- str check   VERSION:14.2.2006 - possible use with qualifiers
    #   str=text        -> text     ; old version
    #   str='text'      -> text     ; new version with sign:' as a strSeperator
    #   str='t\45xt'    -> teExt    ; string with ascii-Code inside
    #   str=q/text/     t.b.d.  later
    if (defined $$p_Opts_ptr{"str"})
    {
        _T($tm,"*** fgOpts:str==OK:(qualifier:$qualifier)\n");
        $str=$$p_Opts_ptr{"str"};   #  str = q/src/ or str = 'text'
        f_readQualifier($str,$qualifier,"'");
        f_xstr2asc($str,$src);      # only extended-String is supported
        $$p_Opts_ptr{"str"}  = $src;
        $$p_Opts_ptr{"qual"} = $qualifier;
    }

#-- Extended String instead of Str
    if (defined $$p_Opts_ptr{"xstr"})           # xstr ==> str
    {
        $src=$$p_Opts_ptr{"xstr"};
        f_xstr2asc($src,$obj);
        $$p_Opts_ptr{str}  = $obj;
    }

#-- SIMPLE QUALIFIER
    #   --- check SimpleQualifierInput | RegInput
    if ((defined $$p_Opts_ptr{"src"}  ||
         defined $$p_Opts_ptr{"obj"} ) &&
         defined $$p_Opts_ptr{"reg"}
        )
    {
        warn "&&& ERR:fgOptions:{src,obj|reg}";
        return(0);
    }

    #   --- read srcStr="q/src/"
    if (defined $$p_Opts_ptr{"src"})
    {
        _T($tm,"*** fgOpts:src==OK\n");
        $src=$$p_Opts_ptr{"src"};       #  reg=q/src/ ;q=qual
        f_readQualifier($src,$qualifier);
        if($qualifier eq 'x') {
            f_xstr2asc($src,$str);  $src=$str;
        }
        elsif($qualifier eq 'a') {
            f_hex2asc($src,$str);   $src=$str;
        }
        elsif($qualifier eq 'u') {
            f_hex2uni($src,$str);   $src=$str;
        }
        else {
            if (_W){warn "*** fgetOpts::use default qualifier";};
        }
        $$p_Opts_ptr{"src"}  = $src;
        $$p_Opts_ptr{"qual"} = $qualifier;
    }

    #   --- read  objStr="m/obj/"
    if (defined $$p_Opts_ptr{"obj"})
    {
        _T($tm,"*** fgOpts:obj==OK\n");
        $obj=$$p_Opts_ptr{"obj"};       #  reg=m/obj/ ;m=modi
        f_readQualifier($obj,$modifier);
        if($modifier eq 'x') {
            f_xstr2asc($obj,$str);  $obj=$str;
        }
        elsif($modifier eq 'a') {
            f_hex2asc($obj,$str);   $obj=$str;
        }
        elsif($modifier eq 'u') {
            f_hex2uni($obj,$str);   $obj=$str;
        }
        $$p_Opts_ptr{"obj"}  = $obj;
        $$p_Opts_ptr{"modi"} = $modifier;
    }

#-- REGULAR EXPRESSION INPUT  rexepr = {-reg=q/src/obj/m -regI="str"}
    if (defined $$p_Opts_ptr{"reg"}) {
        #   usage of complete : RegStr="q/src/obj/m" ;src|obj="...\x.."
        _T($tm,">>> Try a RegEXPR\n");
        $str=$$p_Opts_ptr{"reg"};
        #   --- parse RegExpr "reg=q/src/obj/m"
        $rc = f_parseRegExprStr(
                $str,$qualifier,$src,$obj,$modifier);
        if ($rc == 0) {
            warn "&&& ERR(fGetOptions): parseRegExpr";
            return(0);
        }
        #   --- save back parsed RegExpr "reg=q/src/obj/m"
        if ($modifier eq 0) {
            $$p_Opts_ptr{"reg"}  = $qualifier . "/" . $src . "/" ;
        }
        else {
            $$p_Opts_ptr{"reg"}  =
            $qualifier . "/" . $src . "/" . $obj .  "/" . $modifier;
        }
        #   --- if (regI) start RegExpr
        if (defined $$p_Opts_ptr{"regI"})
        {
            $str = $$p_Opts_ptr{"regI"};
            $rc  = f_startRegExpr(
                $str,$qualifier,$src,$obj,$modifier);
            if ($rc < 0 ) { if (_W) {warn "*** Reg Not found"; }}
            $$p_Opts_ptr{"regO"} = $str;
            _T($tm,sprintf(">>> RegEXPR(%s)=%s; RC=%d\n",
                $$p_Opts_ptr{"regI"} ,
                $$p_Opts_ptr{"regO"} ,
                $rc));
        }
        #   --- save RegExpr elements for later usage in F_startRexExpr()
        $$p_Opts_ptr{"qual"}    = $qualifier;
        $$p_Opts_ptr{"src"}     = $src;
        $$p_Opts_ptr{"obj"}     = $obj;
        $$p_Opts_ptr{"modi"}    = $modifier;
        #   --- update global Opts
        %::v_Opts     = %$p_Opts_ptr;           #update changes
    }
    $s_initOpts = 0;
    _T($tm,"--- Finished fGetOpts.");
    _P("+++ fgo: READY\n");

    return(1);
}

#   =================================================================
sub f_readOptsFile($\@)             #$rc = f($fileName,@list)
#   =================================================================
    #   IN  : fileName  : name of the Option File
    #   OUT : list      : values saved in list context
    #   RET : 1:success, 0:error
    #   DES : The user has used the Option '-O' or '-optsfile'
    #         This function reads the option in the OptionFile.
    #         Options are found there will be put in
    #         @ARGV=(opt1,val1,opt2,val2,...) and can
    #         be used like arguments in the command line.
    #   USE : <Option> = <Value>        ;OptionFile
    #         Value := {"..."|<imm>}    ;Brace-Syntax or direct val
    #       : Comment :: '#'            ;start or ending
    #       : Seperator between 'Option' and 'Value' is '='.
    #   EXAMPLES:
    #       1)nr=5         ;don't use any spaces behind the value
    #       2)str = "text"  #...  ;spaces allowed
{
    my  $file=shift();
    my  $listPtr=shift();
    my  $fp=gensym();
    my  @ArgList = ();   #empty list
    my  $Buffer=0;
    my  ($i,$c,$n,$rc)=(0,0,0,0);
    my  $tm = $C_TRACE_MASK_OPTS;

#   f_HEADER("freadOptsFile",__FILE__,__LINE__); #TRACE not active
    if (!defined $file) { warn "??? fReadOptsFile fName"; return(0);}
    $rc = open($fp,"< $file");
    if ((!defined $rc) || ($file eq 0)) {
        warn "&&& Can't open optsfile '$file'";
        return(0);
    }
    _T($tm,sprintf("--- I read Optfile : '$file'\n"));
    if (!defined $listPtr) {
        warn "--- obj ptr List not defined\n";
        return(0);
    }
    @$listPtr=();    #delete list
    while (!eof($fp))
    {
        # --- get line and prepare a str
        $Buffer  = readline($fp);
        chomp($Buffer);     # rmv NL

        # --- delete leading spaces
        $Buffer =~ s/^[[:space:]]+//;

        # --- next line if line starts with comment
        if (substr($Buffer,0,1) eq $C_OPTFILE_COMMENT)  { next; }

        # --- subst mult spaces after the 'Option'
        $Buffer =~ s/[[:space:]]+/ /;   #no global modifier

        # --- is Buffer empty ???
        if (length($Buffer) == 0) { next ; }

        # --- remove COMMENT part
        $i = index($Buffer,$C_OPTFILE_COMMENT);
        if    ($i > 0)  { $Buffer = substr($Buffer,0,$i) }
        elsif ($i == 0) { next; } #len==0

        # --- split into Option and Value(if exist)
        @ArgList = ();
        @ArgList = split(/$C_OPTFILE_SEPERATOR/,$Buffer,2);

        # --- prepare Option
        if (defined $ArgList[0]) {
            # --- delete multiple ending spaces
            $ArgList[0] =~ s/[[:space:]]+$//;
            push(@$listPtr,$ArgList[0]) ;
        };

        # print "----ArgList0:'$ArgList[0]'\n";

        # --- prepare Value
        if (defined $ArgList[1]) {
            $Buffer = $ArgList[1];
            # --- delete leading (but not ending) spaces in 'Value'
            $Buffer =~ s/^[[:space:]]+//;
            # --- if "..." syntax - remove braces
            if (substr($Buffer,0,1) eq $C_OPTFILE_BRACE) {
                $i = rindex($Buffer,$C_OPTFILE_BRACE);
                if ($i > 0) {
                    # if ($i == 1) { next; } # emtpy String ""
                    $Buffer = substr($Buffer,1,$i-1);
                }
            }
            push(@$listPtr,$Buffer);
        }
    }; #while eof()

    f_printList(@$listPtr,"listARGV",$tm);
    close($fp);
    # exit;
    return(1);
}


#   =================================================================
sub f_readQualifier(\$\$;$)       #f($sreg_IO,$qualifier_O,[seperator])
#   =================================================================
    #   DESC:   parses 'src' and 'qualifier'(or 'mode') in a simple sReg
    #   IN  :   a) sreg="q/abc/"  or
    #       :   b) sreg="/abc/"         (short syntax)
    #       :   c) sreg="/pet\45r/"     -> syntax with ASCII-Code letter
    #       :   d) sreg="peter"         -> wihout any seperator - like a string
    #   OUT :   src="abc"; qualifier="q"
    #   RC  :   0=error,1=found
{
    my  $srcPtr = shift();         # q/<str>/
    my  $quaPtr = shift();         # pointer to qualifier
    my  $sepChar= shift();
    my  $sRegStr    = $$srcPtr;        # q/<str>/
    my  @list       = @C_SIMPLE_QUALIFIER_LIST;     #s,x,a,u
    my  $tm         = $C_TRACE_MASK_OPTS;
    my  $buf        = 0;
    my  $rc         = 0;
    my  ($c,$e,$i,$i_Len,$j,$l,$regOK) = (0,0,0,0,0,0,0);
    my  ($c_First,$c_Second,$c_Last,$c_Src,$c_Sep) = (0,0,0,0,0);

    #   --- len<3 ?
    $i_Len    = length($sRegStr);
    if ($i_Len < 3) {
        _T($tm,"*** fRQ: len < 3\n");       # no Qualifier, no Seps
        return(0);
    }

    #   --- get chars
    $c_First   = substr($sRegStr,0,1);
    $c_Second  = substr($sRegStr,1,1);
    $c_Last    = substr($sRegStr,$i_Len-1,1);
    $c_Src     = substr($sRegStr,2,$i_Len-3);
    _T($tm,"--- fRQ: sReg=<$sRegStr>,Len=<$i_Len>\n");


    #   --- special Seperator by Caller ?
    $regOK      = 0;
    @list       = @C_SEPERATOR_LIST;
    if (defined $sepChar) {
        unshift(@list,$sepChar);
        _T($tm,"!!! fRQ: EXPAND sepList newSep=<$sepChar>\n");
    }
    f_printList(@list,"SepList",$tm);

    #   --- Seperator at end ?
    foreach $e (@list)
    {
        if ($c_Last eq $e) {
            $regOK = 1;
            $c_Sep = $c_Last;
            last;
        }
    }
    if (!$regOK) {
        _T($tm,"*** fRQ: wrong Sep at End\n");
        return(0)
    };

    #   --- Sep at First => simple syntax
    if ($c_First eq $c_Sep) {
        $c_Src = $buf;
        $buf = substr($sRegStr,1,$i_Len-2);
        $$quaPtr = $C_STANDARD_SIMPLE_QUALIFIER;
        $$srcPtr = $buf;
        _T($tm,"*** fRQ: str=='$buf' OK,but no Qualifier\n");
        return(1);
    }

    #   --- Sep not at Second ?
    if ($c_Second ne $c_Sep) {
        _T($tm,"*** fRQ: Sep(Second) <> Sep(Last)\n");
        return(0)
    }

    #   --- len == 3 ?
    if ($i_Len == 3) {
        _T($tm,"*** fRQ: Qualifier but LEN==3 to small for src-Field\n");
        return(0)
    }

    #   --- check simple qualifier
    $regOK     = 0;
    foreach $e (@C_SIMPLE_QUALIFIER_LIST)
    {
        if ($c_First eq $e) {
            $regOK = 1;
            last;
        }
    }
    if (!$regOK) {
        _T($tm,"*** fRQ: Qualifier='$c_First' is not OK !\n");
        return(0)
    };

    #   --- save results
    $$quaPtr   = $c_First;
    $$srcPtr   = $c_Src;
    _T($tm,"*** fRQ: OK:qua=<$c_First>; src=<$c_Src>\n");
    return(1);
}


#   *****************************************************************
#   Regular Expression Handling
#   *****************************************************************

    #@REG=('$','^','|','+','*','?','.',
    #      '/','\\','(',')','[',']','{','}');

    #unter DOS entspricht '^' == '\A'
    #@DOS=('$','\A','|','+','*','?','.',
    #      '/','\\','(',')','[',']','{','}');

    #@UNX=('$','^','|','+','*','?','.',
    #      '/','\\','(',')','[',']','{','}');

    # REGS in DOS
    # \A: am Anfang jeder Zeile - entspricht '^'
    # \B: nach jedem Buchstaben
    # \C: alle Zeichen
    # \D: vor und nach jeder Zahl
    # \H,\I,\J,\K,\L,\M,\N,\O,\P,\Q,\R,\S,\T,\U,\V: free
    # \W: Ende der Zeile - entspricht $

    #   ASCII code table for special Reg chars
    #   !   :   0x21
    #   #   :   0x23
    #   $   :   0x24
    #   '   :   0x27
    #   *   :   0x2A
    #   +   :   0x2B
    #   (   :   0x28
    #   )   :   0x29
    #   .   :   0x2E
    #   /   :   0x2F
    #   0   :   0x30    0...9
    #   :   :   0x3A
    #   <   :   0x3C
    #   =   :   0x3D
    #   >   :   0x3E
    #   ?   :   0x3F
    #   @   :   0x40
    #   A   :   0x41    A...Z
    #   [   :   0x5B
    #   \   :   0x5C
    #   ]   :   0x5D
    #   ^   :   0x5E
    #   `   :   0x60
    #   a   :   0x61    a...z
    #   {   :   0x7B
    #   |   :   0x7C
    #   }   :   0x7D


#   =================================================================
sub f_parseRegExprStr($\$\$\$\$)  #f($strIN,$q,$s,$o,$m)
#   =================================================================
{
    # SYNTAX:f($extendendRegExprStr,\$QUAL,\$SRC,\$OBJ,\$MODI)
    # IN    :1) a regularExpression-String like "<q>/<src>/<obj>/<m>"
    #        or 2) a simpleExpression-String like "<q>/<src>/<m>
    # OUT   :q:qualifier,src:srcPart,and obj:obj-Part,m:modifier;
    #        saved in OptionHash.{modi(M),qual(Q),src(S),obj(O)}
    # RET   :RC={0:sucess,!=0:ERROR}
    # USAGE :perl <script> -reg "....."
    # DESC  :The function is called by using option 'reg'.
    #        Extended X-String input like "ab\x43\x44"=="abcd" is
    #        supported for the 'src' and 'obj' part.
    #        The Meta-Char is usually '\'.
    # Exampl:"s/hans/willi/g"       =>Q='s',M='g',S='hans',O='willi'
    # Exampl:"s/\x41\x42c/def/g"    =>Q='s',M='g',S='abc',O='def'
    # REM   : Typically values for qualifier q:={'tr','s','m','x'}
    #       : typically values for modifier
    #         m:={'c','d','e','g','i','m','o','s','x');


#---1) Regular-Str::    q/SRC/OBJ/[m]   ;q = {'tr','s',...} #RegEX
#---2) SimpleExpression-Str::  q/SRC/   ;q = {'m','x'}  #RegEx,HexStr

    my  ($p_regExpr,$p_quaPtr,$p_srcPtr,$p_objPtr,$p_modPtr) =
            (shift(),shift(),shift(),shift(),shift());
    my  ($c,$i,$j)  = (0,0,0);
    my  ($str,$src,$obj,$elem,$rc)      = (0,0,0,0,0);
    my  ($markOK,$metaOK,$modiOK,$regOK,$objOK)  = (0,0,0,0,0);
    my  ($regStr,$regLen,$l)   = (0,0,0);
    my  ($posQual,$posModi,$posSrc,$posObj,$posSep)   = (0,0,0,0,0);
    my  @list       = @C_QUALIFIER_LIST;
    my  $tm = $C_TRACE_MASK_REG;

#   --- init Value
    _T($tm,"--- RegStr=<$p_regExpr>");
    $$p_quaPtr   = $$p_modPtr = $$p_srcPtr = $$p_objPtr = $C_NULL;

#   --- len
    $regLen = length($p_regExpr);
    if ($regLen < 3) {           # minLength len("q/x/")
        warn "&&& Error: regLen='$regLen' < 3";
        return(0);
    }

#   --- qualifier                       #   1<=size<=2
    for($i=0; $i < $regLen; $i++) {
        $c = substr($p_regExpr,$i,1);
        if (!isalpha($c))  {
            if ($c eq $C_SEPERATOR) { last; }
            warn "&&& RegExp::\'$c\'=:!(isAlpha||SEP)";
            return(0);
        }
    }
    if ($i == 0) {
            warn "*** RegExp::size(Qualifier)==0 warnOnly***";
            return(0);
    }
    else
    {
        $posQual    = $i;         # first '/'
        $str        = substr($p_regExpr,0,$i);  #size(Qual)<=2
        @list       = @C_QUALIFIER_LIST;
        $l          = $#list +1 ;
        $regOK      = 0;
        for ($i=0; $i < $l; $i++) {
#           print "$elem==$str ??\n";
            $elem = shift(@list);
            if ($str eq $elem) {                #test Qualifier
                $$p_quaPtr   = $str;
                $regOK      = 1;
                last;
            }
        }
        if (!$regOK) {
            warn "*** RegExp::Qualifier=\'$str\' not found"; return(0);
        }
    }

#   --- modifier                        # size==1, but more than 1
    $str = 0;
    $posModi = 0;   #ErrorCase
    $l=length($str);
    for($i=$regLen-1; $i >= 0; $i--) {
        $c = substr($p_regExpr,$i,1);
        #_P(sprintf("+++ MOD:reg=%s;len=%d,reg[%d]=%s\n",
        # $p_regExpr,$regLen,$i,$c));
        if (!isalpha($c))  {
            if ($c eq $C_SEPERATOR) {
                last;
            }
            if (_W) {warn "*** RegExp::Modifier\'$c\'=:!(isAlpha||SEP)"};
            return(0);
        }
    }
    if ($i == ($regLen-1)) {
        if (_W){ warn "*** RegExp::size(Modi)==0"};
    }
    else {
        $posModi    = $i;         # last '/'
        $str        = substr($p_regExpr,$posModi+1,$regLen-$posModi);
        for($j=0,$regOK=1; $j<length($str) && $regOK==1; $j++)
        {
            @list       = @C_MODIFIER_LIST;
            $l          = $#list +1 ;
            $c          = substr($str,$j,1);
            #printf("c=%s;j=%d(%d);len=%D\n",$c,$j,length($str),$l);
            for ($i=0,$regOK=0; $i < $l && $regOK == 0; $i++)
            {
                $elem = shift(@list);
                if ($c eq $elem) {
                    $regOK = 1;
                }
            }
        }
        if (!$regOK) {
            if (_W) {warn "*** RegExp::Modifier=\'$str\' not found";};
            _T($tm,"??? Modifier not found");
            return(0);
        }
        $$p_modPtr   = $str;
    }

#   --- regStr
    # 1.) q/abc/        qPos=1,mPos=0,regLen=6
    # 2.) q/abcd/m      qPos=1,mPos=6,regLen=8,
    # 3.) q/m           qPos=1,mPos=1,regLen=3
    if ($posModi == 0) {
        _T($tm,"!!! no MODI found");
        $l = $regLen-2-$posQual;
    } else {
        $l = $posModi-$posQual-1;
    }
    if ($l <= 0) {
        warn "*** RegExp::len=\'$l\'"; return(0);
    }
    $regStr = substr($p_regExpr,$posQual+1,$l);
    #print "regStr(src+obj)=\"$regStr\"\n";       #str='/' zulaessig

#   --- seek(regStr,\src,\obj) for seperator '/' in "src/obj"
    $l = length($regStr);
    ($src,$obj,$regOK,$metaOK,$posSep) = ($C_NULL,$C_NULL,0,0,$l);
    # print "posSep:$posSep\n";
    for ($i=0; $i<$l; $i++)
    {
        $c = substr($regStr,$i,1);
        if ($c eq $C_META)
        {
            if ($metaOK) {
                $metaOK = 0;        # meta sign itself
            } else {
                $metaOK = 1;
            }
        }
        elsif ($c eq $C_SEPERATOR)
        {
            if ($metaOK == 0) {
                $posSep = $i;       # found !!!
                last;
            }
            $metaOK = 0;
        }
        else {
            $metaOK = 0;
        }
    }

#   --- copy regStr -> src,obj
    #print "+++ posSep:$posSep; l:$l; regStr=$regStr\n";
    if ($posSep <= 0) {
        warn "&&& len(QualStr)==0";
        return(0);          #not allowd REG="q//a/m" =>len(src)==0
    }
    $src = substr($regStr,0,$posSep);
    if ($posSep+1 < $l) {
        $regOK = 1;
        $obj = substr($regStr,$posSep+1,$l-$posSep-1);
        $$p_objPtr = $obj;
    }
    $$p_srcPtr = $src;
    $$p_objPtr = $obj;
    #(isprint($$p_objPtr)) ?      print "ispr\n" : print "isntpr\n";
    # print "1)REGSTR::srcPtr=\"$$p_srcPtr\"; objPtr=\"$$p_objPtr\"\n";

#   --- delASC(regSrc,regObj)
    $rc = f_xstr2asc($$p_srcPtr,$src);
    # print "---delASC has deleted $rc chars\n";
    $$p_srcPtr = $src;
    if ($regOK)  {
        f_xstr2asc($$p_objPtr,$obj);
        $$p_objPtr = $obj;  #save it
    };
    # print "2)noASC::srcPtr=\"$$p_srcPtr\"; objPtr=\"$$p_objPtr\"\n";

    _T($tm,"*** PARSE OK\n");
    return(1);
}


#   =================================================================
sub f_startRegExpr(\$$$$$)  #$rc=f($strIO,$qua,$src,$obj,$mod)
#   =================================================================
    #   DESC:Executes are regular Expression and returns the str.
    #   USE: @C_QUALIFIER_LIST=('tr','y','s','m');
    #        @C_MODIFIER_LIST=('c','d','e','g','i','m','o','s','x');
    #   PARS:I/O:{regStr},O:{qualifier,src,obj,modifier}
    #   RC  : >=0: found and replaces
    #   RC  : ==0: nothing found but reg combination OK
    #   RC  : <0 : reg combination error
    #
    #   FUNCTION:   translate    (qualifier 'tr' or 'y')
    #---[ $VAR =� ] tr|y/SEARCHLIST/REPLACEMENTLIST/ [ c d s ]
    #   Translates all occurrences of the characters found in
    #   the search list into the corresponding character in the
    #   replacement list. It returns the number of characters
    #   replaced.
    #---Modifiers:
    #   c:  complements the SEARCHLIST
    #   d:  delete chars found in SEARCHLIST but not in REPLCMNTLIST.
    #   s:  squeezes all sequences of characters
    #       that are translated into the same target character into
    #       one occurrence of this character.

    #   FUNCTION:   search      qualifier='m'
    #---[ EXPR =� ] [m ] /PATTERN/ [ c g i m o s x ]
    #   Searches a string for a pattern, and if found, replaces that
    #   pattern with the replacement text.
    #   It returns the number of substitutionsmade, if any,otherwise
    #   it returns false.
    #   Almost any delimiter may replace the slashes; if
    #   single quotes are used, no interpolation is done on the strings
    #   between the delimiters, otherwise the strings are interpolated
    #   as if inside double quotes.
    #   If bracketing delimiters are used, PATTERN and REPLACEMENT may
    #   have their own delimiters.
    #   If PATTERN is empty, the most recent pattern from a previous
    #   successful match or replacement is used.
    #---Modifiers:
    #   c:  continues previous match
    #   g:  global - don't stop at once
    #   i:  case insensitiv pattern matching
    #   m:  multiple line
    #   o:  interpolates variable once only
    #   s:  match '.' even as empty lines
    #   x:  extended RegExpr - more than 1 line

    #   FUNCTION:   substitute          qualifier='s'
    #---[ $VAR =� ] s/PATTERN/REPLACEMENT/ [ e g i m o s x ]
    #   Searches a string for a pattern, and if found, replaces that pattern
    #   with the replacement text. It returns the number of substitutions
    #   made, if any, otherwise it returns false.
    #   see m /PATTERN/ matching.
    #---Modifiers:
    #   e:  evaluates the replacement string as a perl expression
    #   g i m o s x: see above



{
#   --- ARGS ok?
    my  $n=0;
    $n = @_;
    if ($n < 5) {warn "??? BAD-ERROR: ARGS=$n???"; exit;}
#   --- other Params
    my  $ok=0;
    my  $strPtr              =  shift();
    my  $t = $$strPtr;
    my  ($qua,$src,$obj,$mod) = (shift(),shift(),shift(),shift());
    my  @l=0;
    my  $tm = $C_TRACE_MASK_REG;

    f_TRACE_do("fStartRegExpr",$tm);
    _T($tm,sprintf("===>QUA=$qua;SRC=$src;OBJ=$obj;MOD=$mod;STR=$t\n"));

#   --- SORT and remove doubled modifiers
    if (($mod ne $C_NULL) || (length($mod) != 0)) {
        $mod = lc($mod);
        $mod = f_sortStr($mod);
    }

#   --- SEARCH a RegExpr
    $t = $$strPtr;
    if  (($qua eq 'y') || ($qua eq 'tr'))
    {
        _T($tm,"*** TR\n");
        if ($mod eq $C_NULL)    { $ok=1; @l = ($t =~ y/$src/$obj/)};
        if ($mod eq 'c')        { $ok=1; @l = ($t =~ y/$src/$obj/c)};
        if ($mod eq 'd')        { $ok=1; @l = ($t =~ y/$src/$obj/d)};
        if ($mod eq 's')        { $ok=1; @l = ($t =~ y/$src/$obj/s)};
    }
    elsif (($qua eq 'm') || ($qua eq $C_NULL))
    {
        _T($tm,"*** SEEK($qua)");
        if ($mod eq  $C_NULL)   { $ok=1; @l = ($t =~ m/$src/)};
#       if ($mod eq 'c')        { $ok=1; @l = ($t =~ m/$src/c)};
        if ($mod eq 'cg')       { $ok=1; @l = ($t =~ m/$src/cg)};
        if ($mod eq 'g')        { $ok=1; @l = ($t =~ m/$src/g)};
        if ($mod eq 'gi')       { $ok=1; @l = ($t =~ m/$src/gi)};
        if ($mod eq 'gim')      { $ok=1; @l = ($t =~ m/$src/gim)};
        if ($mod eq 'gis')      { $ok=1; @l = ($t =~ m/$src/gis)};
        if ($mod eq 'gix')      { $ok=1; @l = ($t =~ m/$src/gix)};
        if ($mod eq 'gimx')     { $ok=1; @l = ($t =~ m/$src/gimx)};
        if ($mod eq 'i')        { $ok=1; @l = ($t =~ m/$src/i)};
        if ($mod eq 'im')       { $ok=1; @l = ($t =~ m/$src/im)};
        if ($mod eq 'io')       { $ok=1; @l = ($t =~ m/$src/io)};
        if ($mod eq 'is')       { $ok=1; @l = ($t =~ m/$src/is)};
        if ($mod eq 'ix')       { $ok=1; @l = ($t =~ m/$src/ix)};
        if ($mod eq 'imo')      { $ok=1; @l = ($t =~ m/$src/imo)};
        if ($mod eq 'ims')      { $ok=1; @l = ($t =~ m/$src/ims)};
        if ($mod eq 'imx')      { $ok=1; @l = ($t =~ m/$src/imx)};
        if ($mod eq 'imos')     { $ok=1; @l = ($t =~ m/$src/imos)};
        if ($mod eq 'imox')     { $ok=1; @l = ($t =~ m/$src/imox)};
        if ($mod eq 'imosx')    { $ok=1; @l = ($t =~ m/$src/imosx)};
        if ($mod eq 'o')        { $ok=1; @l = ($t =~ m/$src/o)};
        if ($mod eq 's')        { $ok=1; @l = ($t =~ m/$src/s)};
        if ($mod eq 'x')        { $ok=1; @l = ($t =~ m/$src/x)};
    }
    elsif (($qua eq 's') && ($obj eq $C_NULL))
    {
        _T($tm,"*** SUBST,0");
        if ($mod eq $C_NULL)    { $ok=1; @l = ($t =~ s/$src//)};
        if ($mod eq 'g')        { $ok=1; @l = ($t =~ s/$src//g)};
        if ($mod eq 'gi')       { $ok=1; @l = ($t =~ s/$src//gi)};
        if ($mod eq 'gis')      { $ok=1; @l = ($t =~ s/$src//gis)};
    }
    elsif ($qua eq 's')
    {
        _T($tm,"*** SUBST");
        #   c:  continues previous match
        #   e:  evaluates the replacement string as a perl expression
        #   g:  global - don't stop at once
        #   i:  case insensitiv pattern matching
        #   m:  multiple line
        #   o:  interpolates variable once only
        #   s:  match '.' even as empty lines
        #   x:  extended RegExpr - more than 1 line
        if ($mod eq  $C_NULL)   { $ok=1; @l = ($t =~ s/$src/$obj/)};
        # if ($mod eq 'c')        { $ok=1; @l = ($t =~ s/$src/$obj/c)};  # --sense?
        if ($mod eq 'e')        { $ok=1; @l = ($t =~ s/$src/$obj/e)};
        if ($mod eq 'g')        { $ok=1; @l = ($t =~ s/$src/$obj/g)};
        if ($mod eq 'gi')       { $ok=1; @l = ($t =~ s/$src/$obj/gi)};
        if ($mod eq 'gim')      { $ok=1; @l = ($t =~ s/$src/$obj/gim)};
        if ($mod eq 'gimo')     { $ok=1; @l = ($t =~ s/$src/$obj/gimo)};
        if ($mod eq 'gimos')    { $ok=1; @l = ($t =~ s/$src/$obj/gimos)};
        if ($mod eq 'gimosx')   { $ok=1; @l = ($t =~ s/$src/$obj/gimosx)};
        if ($mod eq 'gims')     { $ok=1; @l = ($t =~ s/$src/$obj/gims)};
        if ($mod eq 'gimx')     { $ok=1; @l = ($t =~ s/$src/$obj/gimx)};
        if ($mod eq 'gimsx')    { $ok=1; @l = ($t =~ s/$src/$obj/gimsx)};
        if ($mod eq 'gis')      { $ok=1; @l = ($t =~ s/$src/$obj/gis)};
        if ($mod eq 'gix')      { $ok=1; @l = ($t =~ s/$src/$obj/gix)};
        if ($mod eq 'gm')       { $ok=1; @l = ($t =~ s/$src/$obj/gm)};
        if ($mod eq 'gmo')      { $ok=1; @l = ($t =~ s/$src/$obj/gmo)};
        if ($mod eq 'gmos')     { $ok=1; @l = ($t =~ s/$src/$obj/gmos)};
        if ($mod eq 'gmosx')    { $ok=1; @l = ($t =~ s/$src/$obj/gmosx)};
        if ($mod eq 'go')       { $ok=1; @l = ($t =~ s/$src/$obj/go)};
        if ($mod eq 'gs')       { $ok=1; @l = ($t =~ s/$src/$obj/gs)};
        if ($mod eq 'gsx')      { $ok=1; @l = ($t =~ s/$src/$obj/gsx)};
        if ($mod eq 'gx')       { $ok=1; @l = ($t =~ s/$src/$obj/gx)};
        if ($mod eq 'i')        { $ok=1; @l = ($t =~ s/$src/$obj/i)};
        if ($mod eq 'im')       { $ok=1; @l = ($t =~ s/$src/$obj/im)};
        if ($mod eq 'imo')      { $ok=1; @l = ($t =~ s/$src/$obj/imo)};
        if ($mod eq 'imos')     { $ok=1; @l = ($t =~ s/$src/$obj/imos)};
        if ($mod eq 'imosx')    { $ok=1; @l = ($t =~ s/$src/$obj/imosx)};
        if ($mod eq 'io')       { $ok=1; @l = ($t =~ s/$src/$obj/io)};
        if ($mod eq 'is')       { $ok=1; @l = ($t =~ s/$src/$obj/is)};
        if ($mod eq 'ix')       { $ok=1; @l = ($t =~ s/$src/$obj/ix)};
        if ($mod eq 'imo')      { $ok=1; @l = ($t =~ s/$src/$obj/imo)};
        if ($mod eq 'ims')      { $ok=1; @l = ($t =~ s/$src/$obj/ims)};
        if ($mod eq 'imx')      { $ok=1; @l = ($t =~ s/$src/$obj/imx)};
        if ($mod eq 'imos')     { $ok=1; @l = ($t =~ s/$src/$obj/imos)};
        if ($mod eq 'imox')     { $ok=1; @l = ($t =~ s/$src/$obj/imox)};
        if ($mod eq 'imosx')    { $ok=1; @l = ($t =~ s/$src/$obj/imosx)};
        if ($mod eq 'o')        { $ok=1; @l = ($t =~ s/$src/$obj/o)};
        if ($mod eq 's')        { $ok=1; @l = ($t =~ s/$src/$obj/s)};
        if ($mod eq 'x')        { $ok=1; @l = ($t =~ s/$src/$obj/x)};
    }
    _P(sprintf("*** QUA==$qua;MOD==$mod;SRC==$src;OBJ=$obj;t=$t;r=$l[0]\n"));

#   --- if found a RegExpr check for retVal in $l[0]
    if ($ok) {
        $$strPtr = $t;
        if ((!defined $l[0]) || ($l[0] < 0))
        {
            if (_W) {warn "!!! Reg RESULT is undefined\n"; };
            return(0);
        }
        else {
            isdigit($l[0]) ? return($l[0]) : return(1);
        }
    }
    else {
        if (_W) {warn "??? RegCombination not found;"};
        return(- 1);
    }
    return(0);
}



#   =================================================================
sub f_xstr2asc($\$)         # $rc = f($srcStr,$objStr)      version:2
#   =================================================================
{
    #   name:   ConvertExtendedString()
    #   INP :   "\HH..\HH"          # srcStr ASCII-coded Hexvalue
    #   OUT :   "AAaaAA..."         # objStr_ptr
    #   ret :   nrOfASCIIchars      # rc
    #   DESC:   Converts a string with extended chars into an asc-Str
    #           This function is neccessary if some chars are not
    #           interpreted or removed by the command shell.
    #           For instance, the DOS command can't recognize the
    #           REGEXPR-char '^'.
    #   REM :   The metaChar '\' must be double if used in the
    #           input sequence.
    #           Example:
    #           1)  input srcStr='\45\5E' returns  objStr='E^'
    #   REM     Convert extended ASCII-chars == 2 hex-numbers
    #           2)  > $rc = f_xstr2asc("\41\42\\\43",\$obj);
    #               < $rc=3,$obj="AB\C"

    my $srcVal = shift();
    my $objPtr = shift();
    my ($src,$obj)=($srcVal,$$objPtr);
    my ($c,$d,$i,$n,$rc)=(0,0,0,0,0);
    my @List=();
    for ($i=0; $i<length($src); $i++)
    {
        $c = substr ($src,$i,1);
        if ($c eq $C_META)
        {
            $d = ucfirst(substr($src,$i+1,1));
            if ($d eq $C_META)  # if (is it the meta char itself) ?
            {   # YES: ignore '\\' - jump over 1 char
                $i+=1;
            }
            else                        # SrcStr: '\nn'
            {   # NO : meta used for extended asc-Code
                if ($i+2 >= length($src))  {   #length("\NN")=3
                    if (_W) {warn "*** fdelASC::size(X) > len";};
                    return(0);
                }
                if (f_hex2asc(substr($src,$i+1,2),$c))  {
                    $i+=2;  # 2x HH
                    $n+=1;  # 1x asc found
                }
            }
        }
        push(@List,$c);
    }
    $obj = join('',@List);
    $$objPtr = $obj;
    return($n);     # nrOfASC
}


#   =================================================================
sub f_hex2asc($\$)          #  $rc = f($inHexStr,$outStr)
#   =================================================================
    #   INP :       "HH....HH"  ; <HH>+
    #   OUT :       "AAaaAA..."         #objStr_ptr
    #   ret :       nrOfASCIIchars      #rc
    #   DESC:       Converts a hexString  - Example: '455E'=>'E^'
    #   REM :       Doesn't remove other meta-coded strings like
    #   Example:    > $rc = f_hex2asc("414243",\$obj);
    #               < $rc=3,$obj="ABC"
{

    my  $src     = shift();
    my  $objPtr  = shift();      #is a pointer
    my  ($str,$obj)    = (0,0);
    my  ($c,$d,$i,$l,$n,$rc)=(0,0,0,0,0,0);
    my  @List=();
    my   $tm=$C_TRACE_MASK_META;

    $l = length($src);
    if (($l % 2)  != 0) {
         if (_W) { warn "&&& hex2asc;LEN=$l /2 != 0";}
         return(0);
    }
    _T($tm,sprintf("*** hex2asc::SRC=$src\n"));
    for ($i=0; $i<$l; $i+=2)
    {
        $str = uc(substr($src,$i,2));
        if (isalnum($str))
        {
            $rc  = f_hex2bin($str,$d);
            if ($rc <= 0) {
                if (_W) { warn "&&& hex2asc:RC<0"; }
                return(0);
            }
            if ($d > $C_ASC_MAX) {
                if (_W) { warn "&&& hex2asc:val='$d'>MAX='$C_ASC_MAX'";}
                return(0);
            }
            $c = chr($d);   # fct(IN:BinVal,OUT:ASCii)
            push(@List,$c);
        }
        else {
            # no Error - ignore 'HH' values without corresponding ASCII
        }
    }
    $n          = $#List +1 ;
    $obj        = join('',@List);
    $$objPtr    = $obj;
    return($n);
}



#   =================================================================
sub f_hex2uni($\$)          # f(hexStr,unicode)  - to be done later
#   =================================================================
{
    #   --- \x{...}
    my  ($src,$objPtr) = (shift(),shift());
    my  ($c,$i,$l) = (0,0,0);

    my $bstr = pack("U",$src);
    print "uSTR(\'$src\')::",
           join(" ", unpack("H*", pack("U", $src))), "\n";
    warn "&&& hex2uni:FUNCTION not implemented !!!";
    return(0);
}


#   =================================================================
sub f_hex2bin($\$)      # $nrOfVals = f(hexStr,valPtr)
#   =================================================================
    #   IN:  hexStr=hexNumStr+
    #        hexNumStr="hh"    ; hh={00,...,7F}
    #   RC:  nrOfVals>0:OK, else:ERROR
    #   Return: number of converted hex valies
    #   Example: hexStr="414230" => val=0xAB0=2736,return=3

{
    my  ($p_hexStr,$p_valuePtr)    = (shift(),shift());
    my  ($d,$i,$l,$z,$n,$summe)     = (0,0,0,0,0,0);

    $l = length($p_hexStr);
    if ($l > 16)
    {
        if(_W){warn "&&& hex2bin: Size \'$l\' to big or not even "};
        return(0);
    }
    for ($i=0;$i<$l; $i++)
    {
        $d = ucfirst(substr($p_hexStr,$i,1));
        if ( (ord($d) >= ord('A')) && (ord($d) <= ord('F')) )
        {
            $z = 10+ord($d)-ord('A');   # A...F
        }
        elsif ( (ord($d) >= ord('0')) && (ord($d) <= ord('9')) )
        {
            $z = ord($d)-ord('0');      # 0...9
        }
        else
        {
            if(_W){warn "&&& hex2Bin: \'$d\' is no hexVal"};
            return(0); # error - no number
        }
#       print "ZAHL[$i]=$d:$z;\n";
        $summe = $summe*16 + $z;
        $n += 1;
    }
    $$p_valuePtr = $summe;
    return($n);     #nrOfHexDigits      "A86" => ret=3
}



#   =================================================================
sub f_addMeta ($\$)      # f($srcStr,$objStr_ptr)
#   =================================================================
{
    #   IN      :char   srcStr[]
    #   OUT     :char * objStr_ptr
    #   RC      :int    NrOfUsedMetaChars
    #   USAGE   :int    f($srcStr,$objStr)
    #   Meta-Marks RegExpr special chars like::
    #   <'\'.'/','.','+','*','?','^','$','|','(',')','[',']','{','}'>
    #   Meta Sign '\' must be demarked itself.

    my  $p_src       = $_[0];    #error if use $$_[0]
    my  $p_objPtr    = $_[1];
    my  @List=();
    my  @ListObj=();
    my  ($c,$e,$i,$j,$l,$n)  = (0,0,0,0,0,0);

    for ($i=0; $i <length($p_src); $i++)
    {
        @List   = @C_REGEXPR_SPECIAL_CHAR_LIST;
        $l      = $#List +1;
        $c      = substr ($p_src,$i,1);
        for($j=0; $j < $l; $j++)
        {
           $e = shift(@List);
           if ($c eq $e)
#          if (($c eq $e)  || ($c eq $C_META))
           {                               #found specChar?
               $n += 1;                    #count it
               push(@ListObj,$C_META);
           }
        }
        push(@ListObj,$c);
    }
    $$p_objPtr = join('',@ListObj);
    return($n);
}

#   =================================================================
sub f_delMeta ($\$)  { # f($srcStr,\$objStr_ptr)
#   =================================================================
#   IN      :srcStr
#   INOUT   :objStr_ptr
#   RET     :NrOfUsedMetaChars
#   DESC    :Deletes the meta sign and reverts function f_addMeta().
#   Examples:
#           a\xNN/b     : S=a<HEXVAL>   O=b
#           a\//b       : S=a/          O=b
#           a\/\//b     : S=a//         O=b
#           a/\/b       : S=a           O=/b
#           a/\/\/b     : S=a           O=//b
#           a\\/b       : S=a\          O=b
#           a\\\\/\\b   : S=a\\         O=\b
#   and soon

    my  $p_src      = $_[0];    #IN: srcStr="text...\<RexEpr>..."
    my  $p_objPtr   = $_[1];    #OUT:objStr="text...<RegExpr>..."
    my  @List=();
    my  @ListObj=();
    my  $metaOK=0;
    my  ($c,$e,$i,$j,$l,$n)  = (0,0,0,0,0,0);

    $l = length($p_src);
    for ($i=0; $i < $l; $i++)
    {
        $c  = substr ($p_src,$i,1);
#       print "+++fdelMETA::pos($i),chr($c)\n";
        if ($c eq $C_META)
        {
            if ($metaOK)
            {
                $metaOK = 0;
                push(@ListObj,$c);      #Meta itself
            }
            else
            {
                $metaOK = 1;            #next is specChar
                $n      += 1;
            }
        }
        else
        {
            $metaOK = 0;
            push(@ListObj,$c);          #anyway
        }
    }
    $$p_objPtr = join('',@ListObj);
    return($n);
}

#   =================================================================
sub f_metaList(\@)              # $rc = f(\@list)    rc=0:noChanges
#   =================================================================
#   DES:    Set a meta char in front of each list members.
#   IN:     list
#   RET:    nrOfListChanges, 0:no changes
#   OUT:    -
{
    my $listPtr             = $_[0];
    my ($i,$val,$valNew)    = (0,0,0);
    for ($i=0; $i < $$listPtr; $i++)
    {
        $val    = $$listPtr[$i];
        f_addMeta($val,$valNew);
        $$listPtr[$i] = $valNew;
    }
    return($i);
}


#   =================================================================
sub f_metaHashKey(\%$)       # f(%varHash,$keyName)
#   =================================================================
#   IN/OUT: hash
#   IN:     option
#   DESC:   Add a meta char ahead of each key naming 'keyName' in a hash.
{
    my $hashPtr   = $_[0];
    my $opts      = $_[1];
    my ($i,$l)    = (0,0);
    for ($i=0;((my $key, my $val)=each(%{$hashPtr})); $i++)
    {
        $l = length($key);
        #--- print "modopts($i) Key:<$key>,Val:<$val>,";
        if (substr($key,0,$l) eq $opts)
        {
            my $valNew=0;
            f_addMeta($val,$valNew);
            #--- print "ValNew:<$val>\n";
            $$hashPtr{$key} = $valNew;
            # err:last;
        }
        #--- print "\n";
    }
    return($i);
}


#   *****************************************************************
#   Recursive Directory Access
#   *****************************************************************

#   The use has set the option "-R" for recursive.

#   =================================================================
sub f_dirReadRecursive($$\&;\@)    # f(dir,file,\&fct;\@list));
#   =================================================================
    #   IN  :   dir or filePath
    #   IN  :   file or filePattern
    #   IN  :   fct  of a function like  $rc = f($filePath)
    #           with    $rc==0:error
    #                   $rc>=0:nrOfSuccess
    #   DESC:
    #   The function ist started by using 'directoy' and a 'file' as
    #   parameter informations.
    #   For every found file with the filename 'file', the
    #   function 'fct' is called.
{
    my  $p_Dir       = shift();      # DIR - full path
    my  $p_File      = shift();      # FILE - file pattern
    my  $p_FktPtr    = shift();      # funktion to call
    my  $p_ListPtr   = shift();      # parameter of this funtion
    my  $dirPtr      = gensym();     # unbenannter Pointer
    my  ($i,$l,$len,$p,$n,$buf,$str)   = (0,0,0,0,0,0,0);
    my  @fileList    = ();
    my  ($file,$dir) = (0,0);
    my  $rc = 0;
    my  $isPattern=0;
    my  $tm = $C_TRACE_MASK_TREE;

    _T($tm,"fDirTree");
    # printf("+++ pFILE=|$p_File|\n");
    if (!defined $p_Dir) {
        if(_W){warn "!!! setDir"};
        $p_Dir=".";
    };
    $p_Dir =~ tr /\\/\//s;
    # print "pDir = $p_Dir\n";
    $rc = opendir($dirPtr,$p_Dir);
    if (!defined $rc) {
        if (_W){warn "??? I can't opendir($p_Dir)?"};
        return(0);
    }
    chdir($p_Dir);                          #change ProcessDir
    $::v_depth++;
    _T($tm,sprintf("--- DIR =$p_Dir"));

    while ($file=readdir($dirPtr))
    {
        #print "��� READIR\n";
        if    ($file eq "." || $file eq "..")  {next;}  # weiter
        elsif (-d "$p_Dir/$file")
        {
            _T($tm,sprintf("+++ DIR =\'%s\'  \t[%3.3d;%d]\n",
                        $file,++$::v_dirCounter,$::v_depth));
            if ($::v_depth >= $C_MAX_DEPTH) {
                if (_W()) {warn "--- ERR:MAX-depth"};
                next;
            };
            if (f_mode_R()) {
                $dir = $p_Dir . "/" . $file;
                _T($tm,sprintf("��� RECURSIVE\n"));
#               +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                $rc = f_dirReadRecursive($dir,$p_File,&$p_FktPtr,@$p_ListPtr);
#               +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            };
        }
        else  # --- work with $file
        {
            _T($tm,sprintf("+++ FILE=\'%s\'\t[%3.3d;%d]\n",
                      $file,
                      ++$::v_fileCounter,
                      $::v_depth));

            $l = length($p_File);
            $isPattern = 0;
            # WE USE: <*.{php,html}> => *.{php,html}
            if (($l >= 4)                                    # <*.{}>    # *
                && (substr($p_File,0,3) eq '*.{' )          # <*.{php,html,htm}>
                && (substr($p_File,$l-1,1)  eq '}'))
            {
                # printf("&&& searchPATTERN:{$p_File}\n");
                # <*.{php}>
                $str        =   substr($p_File,3,$l-4);
                @fileList   =   split(/,/,$str);
                $n          =   $#fileList +1;
                for($i=0; $i < $n; $i++)
                {
                    $str = '.' . $fileList[$i] ;
                    $l      = length($str);         # sizeof(fileEXT) incl. '.'
                    $len    = length($file);
                    if (length($len > $l))
                    {
                        if (substr($file,$len-$l,$l) eq $str)
                        {
                            # printf("##### FOUND:<$str>:$l,FILE=<$file>:$len\n");
                            $isPattern = 1;
                        }
                    }
                }
            }
            elsif ($p_File eq "*")
            {
                $isPattern = 1;
                # printf("&&& searchALL\n");
            }
            else
            {
                # printf("&&& searchEXACT:FILE:'$file'==FILTER:'$p_File':?:");
                if ($p_File eq $file) {
                    # printf("found!");
                    $isPattern = 1;
                }
                # printf("\n");
            }
            if (!defined $p_FktPtr) {next;};
            $::v_callCounter  += 1;
            if ($isPattern) {
                $dir = cwd();
#               +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                $n = &$p_FktPtr("$p_Dir/$file",$p_ListPtr); # calls userFunction($filePath)
#               +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                $::v_actions      += $n;
                _T($tm,sprintf("+++ RETURN OF SUBFKT\n"));
            }
            #print "��� RETURN FKTN\n";
        }
    } #while
    $::v_depth--;
    chdir("..");
    closedir($dirPtr);

    return($rc);

} #recursive DirRead()


1; #Return-Wert for 'use'-include-statement, sonst keine Include-Datei!
