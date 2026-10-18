#   *****************************************************************
#   SCRIPT:   search String or Patterns
#   *****************************************************************
#   USAGE:  a) >perl <SCRIPT.pl> -file=<fileList> -str='text'
#           b) >perl <SCRIPT.pl> -file=<fileList> -src=/<REGXPR>/ 
#   DESC:       Find a) string or b) patterns in files.
#   REM:      
#           a)  With option 'str' complete strings like
#               $TEXT="bla PeterHassen hallo" is 'PeterHassen'
#               a String, but not 'Peter'.
#           b)  With the option 'src' the script searches for substrings.  
#               In $TEXT="PeterHassen"  is 'Peter' a valid sub-String. 
#   
#   AUTH:   P.Hassen
#   DATE:   22.2.2005, 9.6.2006
#   *****************************************************************

# --- Header --------------------------------------------------------

    use     FCT;            # GENERAL INCLUDE FILE
        #   F_dirReadRecursive()
        #   F_getOpts();
        #   F_HASH();
        #   F_LIST();
        #   F_mode_T();
        #   _W();
    use     Symbol;         # abstrakte file handles
    use     strict;     
    use     subs qw(main usage);

# --- Input ---------------------------------------------------------

    my          $C_MODE_STR="mode=STR";
    my          $C_MODE_REGEXPR="mode=REGEXPR";
    
    my          %l_Opts;                # ={};
    my          $inputOK = 0;
    my          $mode = "";
    my          $tm=$C_TRACE_MASK_USER;

    $inputOK = F_getOpts(%l_Opts,&usage);
    F_printOpts($tm);   # print if trace is active

    if ($inputOK) {
        if (F_mode_T()){
            F_HASH(%l_Opts);
        };
        if ($l_Opts{"dir"}  eq 0) {
            $l_Opts{"dir"} = '.';
        };
        if ($l_Opts{"file"} eq 0)
        {
                usage();
                exit();
        }    
        if ($l_Opts{"str"} ne 0)  {
            $mode = $C_MODE_STR;
        }
        elsif ($l_Opts{"src"} ne 0) {           
            $mode = $C_MODE_REGEXPR;
        }
        else {
                usage();
                exit();
        }    
        print "*** MODE: '$mode'\n";
    }
    else {
        exit;
    }    

# --- Body ----------------------------------------------------------

    my      $l_actions=0;
    my      ($rc,$g_dirCounter,$g_fileCounter,$g_filesMatched,$g_actions) 
                =   F_dirReadRecursive($l_Opts{dir},$l_Opts{file},&main);
    my      $line = sprintf (
            "*** Dirs:%d;Files:%d,FilesMatches:%d,searchesOK:%d,RC:$rc\n",
                $g_dirCounter,
                $g_fileCounter,
                $g_filesMatched,
                $g_actions,
                $rc);
    
    print($line);
    exit;
 

# *******************************************************************
# MAIN-Function
# *******************************************************************
sub main($)                 # $file       
{
    my  $file=shift();          # IN:    file 
    my  $str;                   # PARAM: str 
    my  $fp=gensym();
    my  ($i,$p,$pos0,$n,$l,$lineNr,$strOK) = (0,0,0,0,0,0,0);
    my  ($line,$lineStr)    = (0,0);
    my  $t=0;
    my  $C_MAX_LINE_NR  =   2000;
    my  $C_LINE_SIZE    =   120;    
    my  $tm = $C_TRACE_MASK_MAIN;
    my  $s_actions = 0;

    printf("--- FILE:%s\n",$file);
    my $rc = open($fp,"< $file"); 
    if (! $rc) {
        if(_W) {warn "*** WARN:open(FILE:\"$file\",READ)"};
        return(0);
    }        
    if (eof($fp)) { 
        if(_W){warn "EOF!"}; 
        return(0);
    }        
#   *** Action
    $lineNr  = 1;

    while (!eof($fp))
    {
#       *** read srcFile ********************************
        $line        = readline($fp);     
        chomp($line);                           #last char
        # printf("--- LINE[%3.3d]:words=%d;line=`%s`<\n", $lineNr,$n,$line);                  
#       -------------------------------------------------------------
        if ($mode eq $C_MODE_STR)
        {
            $str        =   $l_Opts{str};
            my @words       = split(/ /,$line);     # split into words
            $n              = $#words +1;
            # F_LIST(@words);                
            for($i=0,$p=0;$i<$n;$i++,$p++) {
                
                if ($words[$i] eq $str)  {
                    printf("<<< foundSTR::[FILE=%s;POS=(%d:%d)]: \'%s\'\n",
                                $file,$lineNr,$p+1,$str);
                    $s_actions += 1;
                }
                $p += length($words[$i]);
            } 
        }                                          
        elsif ($mode eq $C_MODE_REGEXPR) 
        {
            $str        =   $l_Opts{src};
            $l          =   length($line);
            $lineStr    =   $line;
            $i          = 0;       
            $pos0       = 0;     
            do 
            {
                $strOK = 0;
                #   print "LINE='$line'\n";
                $t      =   $lineStr;        
                if ($t  =~  m/$str/g) 
                {                                   
                    $strOK = 1;
                    $n = pos($t);
                    if (pos($t) < length($str)) { 
                        $p = 0 
                    }
                    else {
                        $p = pos($t) - length($str);
                    };
                    $pos0   += $p;
                    printf("<<< foundPAT::=[FILE:%s;LINE:%d;COL:%d]:%s\n",
                                $file,$lineNr,$pos0+1,$str);
                    $pos0   += length($str);
                    #   print "*** colNext:$pos0\n";
                    $lineStr  = substr($line,$pos0,length($line)-$pos0);                    
                    $s_actions += 1;                    
                }                

            } while($pos0<length($line) && $strOK==1) 
        }

#       ------------------------------------------------------------
        $lineNr++;
        if ($lineNr > $C_MAX_LINE_NR) {
            warn "*** WARN:LINE:$lineNr>$C_MAX_LINE_NR";
        }        
        if (length($line) > $C_LINE_SIZE) {
            warn "*** WARN:LENGTH(Line=$lineNr)>LINESIZE=$C_LINE_SIZE";
            last;
        }            
    } ;     #while
    close($fp);    
    $l_actions += $s_actions;
    return($s_actions);

} # main()



# *******************************************************************
# HELP-Function
# *******************************************************************
sub usage() 
{
    my $file = __FILE__;
    $file =~ tr /\\/\//s;    
printf("
*** FUNCTION:   string or pattern SEARCH...
>   perl %s <ARGUMENTS> <OPTIONS>
    ARGUMENTS::
        -str='<STR>' |
            -src=<qua>/<REX>/   # Strings or RegExpr to be searched  
        -file=<FILE>            # file, wildcard possible
    OPTIONS::
        -dir=<DIR>:='.'         # directory, if omitted homeDir
        -R                      # recursive directory search ?
        -W                      # returns internal warnings
        -H[=HelpNr]             # help informations
        
*** Examples:
1) >perl s.pl -file=hallo*.txt -str Peter    #usage with file pattrn
2) >perl s.pl -file=tes?.txt -str='Peter'    #use seperator in str
3) >perl s.pl -file=test.txt -src=/^int/    #rexp=/^int/ - find subStr 'int'
4) >perl s.pl -file=test.txt -src=x/\\5eint/ #the same but with ASCII-code
5) >perl s.pl -file=*.txt -str='peter' -R    #recursive search
5) >perl s.pl -file=*.txt -str='peter' -T=8000    #trace main
6) >perl s.pl -file=*.txt -src=x/\\5epeter/   # find starting lines with 'peter'
    #   Extended string syntax with qualifier qua='x' ist used.
    #   '\^'==0x5e : find at the start of the line
7) >perl s.pl -file=*.txt -src=x/t.\\24/    
    #   '\$'==0x24 : find lines 'ending' with 't.'
    
",$file,$file);
    return;
 
}
