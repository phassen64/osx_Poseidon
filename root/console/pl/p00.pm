# ****************************************************************************
# INLCUDE
# ****************************************************************************

# Dieses File ist eine Sammlung der Includes dieses Tutorials
# Die Funktionen sind nach den Script-Nummern sortiert, in 
# der sie im Tutorial definiert werden.

#   encoding: UTF-8
# !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß

# ============================================================================
# FILE: t01.pl
# ============================================================================
sub dbg_TRACE()   # t01.pl
{
    # @_={$_[0],$_[1]} # Par1, Par2
	my  $T = localtime(time());	# 'my' => $T nur hier sichtbar
#    printf("\n*** [FILE:%s; LINE:%3.3d; ",$_[1],$_[2]);
#    printf(" TIME:%s]",$T);    # Zeit
    printf("\n");
    my $osname = $^O;
    my $myOsName = substr($osname,0,1); # 'l':Linux, 'M':MsWindows
    printf("*** [%s;%3.3d;",$_[1],$_[2]);
    printf("%s]",$T);    # Zeit
    printf(":%s: \"%s\"\n",$myOsName,$_[0]);
    printf("\n");
}
	
sub dbg_LINE()   # t01.pl
{
#	print("----");
 	print($_[0]x70);
 	print ("\n");
}

# ============================================================================
# FILE: t03.pl
# ============================================================================
sub dbg_CALL()  # t03.pl
{ 
#   'caller' klappt nicht unter DOS	
	for($i=0;((my($pckg,$file,$line,$name) = caller($i))&& ($i<5));$i++)
	{
		print "[$i]:Package:$pckg;File:$file;Line:$line;Name:$name\n";	
	}
}

# ============================================================================
# FILE: t05.pl
# ============================================================================
$PI = 3.1415926535897932384626433832795028841968;
$EF = 2.718281828;


sub dbg_printHash() {
#   Aufruf : &dbg_printHash(\%h);
    my $ptrHash = shift;  
    for ($i=1;($key,$obj) = each(%{$ptrHash}); $i++)  
    {
        if ($i == 1) {print "    HASH=:"};
        print "[$i]:$key=>$obj;";        
    }
    print "\n";
}


# ============================================================================
# FILE: t06.pl
# ============================================================================

sub dbg_printFileInfo()
# INP: $ArgInfo
# FCT: print()
{
	print ("Device              : $ArgInfo[0]","\n");
	print ("Inode               : $ArgInfo[1]","\n");
	print ("Mode                : $ArgInfo[2]","\n");
	print ("hard-Links          : $ArgInfo[3]","\n");
	print ("uid                 : $ArgInfo[4]","\n");
	print ("gid                 : $ArgInfo[5]","\n");
	print ("rdev                : $ArgInfo[6]","\n");
	print ("fileSize            : $ArgInfo[7]","\n");
	print ("time lastAccess     : $ArgInfo[8]","\n"); $ArgTime= $l[8]; &printTime();    
	print ("time lastChange     : $ArgInfo[9]","\n");
	print ("time lastInodeChange: $ArgInfo[10]","\n");
	print ("blocksize           : $ArgInfo[11]","\n");
	print ("blocks              : $ArgInfo[12]","\n\n");
}

sub dbg_printTime()
# INP: $ArgTime
# OUT: "<hour,min,sec;day,..,year>"
# FCT: localtime(), print()
{
    $ArgTime = shift();
    ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $daylightsv) 
        = localtime($ArgTime);                                      
    $year += 1900;
    $mon  += 1;
    if($wday == 1) { $day = "Monday" }
    if($wday == 2) { $day = "Tuesday"};
    if($wday == 3) { $day = "Wednesday"};
    if($wday == 4) { $day = "Thursday"};
    if($wday == 5) { $day = "Friday"};
    if($wday == 6) { $day = "Saturday"};
    if($wday == 7) { $day = "Sunday"};
    printf("<%2.2d:%2.2d:%2.2d;",$hour,$min,$sec);
    print " $day,$mday.$mon.$year>";
}

sub dbg_fileName()      # get new FileName
# INP: $Vers = 0, $ArgFile
# OUT: $File
# VAR: $i, $Ext, $Fname
# FCT: rindex(), substr(), print
{    
    $Fname  = $ArgFile;             # use __FILE__
    $Vers  += 1;
    $Ext    = ".dt";
    $i = rindex($Fname,'.');        # find index of last '.'
    $File = substr($Fname,0,$i);    # str(0...i)
    $File = $File  .  $Ext . '.' . $Vers;    
    print "\tsub(): new file name \'$File\' ***\n";
}


# ============================================================================
# FILE: t08.pl
# ============================================================================

sub dbg_printList ()
#   IN: ptr auf eine Liste
{
    my $ptrList = shift;       
    my $MAX_LINE_SIZE = 10;
#   Liste steht jetzt in @{$ptrList}

    if (!ref $ptrList) {
#       die("ERROR:dbg_printList")};  - zu hart!
        print "ERROR: Arg ist keine Referenz!\n";
        return;
    }
    print "LISTE = (";
    $i=0;
    foreach $l (@{$ptrList}) {
        $i++;
        print "[$i]:'$l';";  
        ($i % $MAX_LINE_SIZE == 0) ? print "\n" : print " " ; 
    } # Ausgabe aller Listenelemente
    print ")\n";

} # dbg_printList


sub dbg_printList2 (\@)
#   IN: ptr auf eine Liste
#   Aufruf: dbg_printList2(@Liste)
#   - Ohne '&' vor der Fkt und ohne '\@' als Parameter
{
    my $ptrList = shift;       
    my $MAX_LINE_SIZE = 10;
#   Liste steht jetzt in @{$ptrList}

    if (!ref $ptrList) {
#       die("ERROR:dbg_printList")};  - zu hart!
        print "ERROR: Arg ist keine Referenz!\n";
        return;
    }
    print "LISTE = (";
    $i=0;
    foreach $l (@{$ptrList}) {
        $i++;
        print "[$i]:'$l';";  
        ($i % $MAX_LINE_SIZE == 0) ? print "\n" : print " " ; 
    } # Ausgabe aller Listenelemente
    print ")\n";

} # dbg_printList2



# ============================================================================
# FILE: t09.pl
# ============================================================================

sub dbg_checkError($$) {
##   # INP:  $FileName, $LineNr
#    # OUT:  FehlerNr beim letzten Aufruf
#    # Anw:  FehlerCheck nach eval() Aufrufen
#    # Bsp:  eval {...&fct1();...};
#    #       &dbg_checkError(__FILE__,__LINE__); 
#    
        $dbgFile = shift();
        $dbgLine = shift();
        if ($@)
        {
             my $dbgErr = $@;
             chomp($dbgErr);
             print "\n";
             print "*** ERROR: $dbgFile;$dbgLine;\n";
             print "*** \"$dbgErr\"\n";
             return(1);
        }
   return(0);
}

1; #Return-Wert for 'use'-include-statement, sonst keine Include-Datei!