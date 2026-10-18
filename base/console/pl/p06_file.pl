# ****************************************************************************
$PGMNAME="[6]:Files,Verzeichnisse";
# ****************************************************************************
#   uses:   p00.pm
#   Vers:   PERL 5.0
# ****************************************************************************

# !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß

use p00;    # include + compile von Modul "i01.pm"
$iEc  = $ENV{v_FWK_exitCode} + 0;
goto l;
# 1) FILE create/open+close
# 2) FILE write
# 3) FILE read
# 4) FILE handling functions
# 5) FILE position
# 6) FILE SYS Functions (Unix-Interface)
# 7) FILE access functions  (stat, link, rename, truncate) (Unix-Interface)
# 8) FILE Hash Database
# 9) DIR  functions
#10) DIR  glob Operator
# ****************************************************************************
l:
#
# FileNamen erstellen
#
$Vers = 0;
sub fileName()
{
    $Fname  = __FILE__;
    $Vers  += 1;
    $Ext    = ".dt";
    $i = rindex($Fname,'.');        # find index of last '.'
    $File = substr($Fname,0,$i);    # str(0...i)
#   $File = $File  . '.' . $Vers . $Ext;
    $File = $File  .  $Ext . '.' . $Vers;
    print "\tsub(): new file name \'$File\' ***\n";
}

# ============================================================================
# 1) FILE erzeugen
# ============================================================================
# open, close

&dbg_TRACE("1) FILE open+close",__FILE__,__LINE__);

# --- open
# --- close
print "1,2)  open()-close() - create+open, close a file\n" ;
&fileName(); $File1=$File;      # neuen FileNamen erstellen     # open()
open  (fp,">$File");            # '>' - write, create if doesn't exist
close (fp);                     # close                         # close()

=pod        'Modifier' in open(FHandle, "Modifier FileName)
---------------------------------------------------------------------
(ohne)      : read
<           : read
>           : create + write
>>          : append
+<          : read+write of an existing file
+>          : create, read+write
| File Kdo  : 'Kdo' reads File
-           : STDIN
>-          : STDOUT
>& Expr     : write a file, duplicate Fptr
<&=FileNo   : read a file, convert FileNo->FileHandle
---------------------------------------------------------------------
=cut

# ============================================================================
# 2) FILE write
# ============================================================================
# print , printf, (sprintf)

&dbg_TRACE("2) FILE write",__FILE__,__LINE__);

# --- printf([FilePtr] Formatstr,Variablenliste)
print "2a) printf() - write a Text into a file\n" ;             # printf()
$z1="-77.123";
print "\tFile : $File\n";
open  (fp,">>$File"); # '>>' anh?ngen
    printf(fp "Datei: %s ***\n",$File);         # '%s' => String
    printf(fp "Zahl : %+6.2f\n",$z1);           # '%d' => Zahl
close (fp);
# print "\n";

# --- sprintf /*NOK*/
print ("2b)  sprintf() = /*NOK*/ = ");                          # sprintf()
sprintf($str,"Zahl:%3.3d,Str:%s",$z1,$s1);
print ("'$str'\n");

=pod      Formatzeichen         Formatstr = "%[MODIFIER]Z";
---------------------------------------------------------------------
%%      : kein Parameter;
%d      : ganze Zahl m. Vorzeichen;
%e, %E  : Gleitkommazahl mit kleinem {e-2) oder gro?em {E-2};
%f      : Gleitkommazahl;
%o      : oktale Zahl o. Vorzeichen
%x, %X  : Hexzahl mit {abcdef} oder {ABCDEF}
%s      : Zeichenkette; %u: unsigned;
%n      : Anzahl der bisl. formatierten Zeichen;
--- Wiederholungen:
%g      : (wie %e oder %f);
%i      : (wie %d);
%F      : (wie %lf);
%G      : (wie %g mit 'E' f?r Exponent);
%E      : (wie %e jedoch mit 'E');
%D      : (wie %ld);
--- Modifier
+,-     : Vorzeichen bei Zahlen
F.N     : Feldweite 'F', Nachkommazahlen : 'N'
l       : lange Zahlen - z.B. %ld"
*       : beliebige Stellen - Wert bestimmt sie
#       : f?hrende '0' bei Octal- oder '0x' bei Hex-Zahlen
---------------------------------------------------------------------
=cut

# ============================================================================
# 3) FILE read
# ============================================================================
# read , (readline), getc

&dbg_TRACE("3) FILE read",__FILE__,__LINE__);

# --- read                                                      # read()
print "3a) read a file \n";
open  (f1,"<$File");                # '<' lesend ?ffnen
    $n = read(f1,$Buffer,1024);     # lese Maximal 1024 Bytes in $Buffer
#   $n = read(f1,$Buffer,1024,5);   # '5' filler bytes vor dem Lesen
    if ($n > 0)
    {
        print("Buffer  = \n\<$Buffer\> \n");
    }
close (f1);

# --- readline   # read each line                               # readline()
print "3b) readline a file /*NOK*/\n";
open  (f1,"<$File");                # '<' lesend ?ffnen
    $d = readline(f1,$Buffer);
    print("Buffer = \n\<$Buffer\>\n");
close (f1);

# --- getc       # read a single char                           # getc()
print "3c) getc \n";
open  (f1,"<$File");                # '<' lesend ?ffnen
    print("Buffer = \n\<");
    while(defined($c = getc(f1)))
    {
        ($c eq "\n") ? print "+NL+" : print "$c";
    }
    print ">\n\n";
close (f1);

# ============================================================================
# 4) FILE handling functions
# ============================================================================
# eof, fileno, (binmode), warn

&dbg_TRACE("4) FILE handling functions",__FILE__,__LINE__);

# --- eof          # EOF
print "4a) eof \n";
open  (f1,"<$File");                # '<' lesend ?ffnen
    while(defined($c = getc(f1)))   # while (<>) /*NOK*/
    {
        print "$c";
        if ( eof  f1) { last;}                                  # eof()
    }
    print "#End!\n\n";
close (f1);

# --- fileno       # get FilePtr
print "4b) fileno \n";
printf ("FileNo(STDIN)  = %d\n",fileno(STDIN));                 # fileno()
printf ("FileNo(STDOUT) = %d\n",fileno(STDOUT));
printf ("FileNo(STDERR) = %d\n",fileno(STDERR));
open  (f1,"<$File");                # '<' lesend ?ffnen
printf ("FileNo(f1)     = %d\n",fileno(f1));
close (f1);

# --- binmode     # binary Files
print "4c) binmode /*NOK-noBinMode in DOS*/\n";
&fileName(); $File2=$File;
$z1=$77;
open  (f1,">$File");
#   print (f1 "Datei: $File *** \n");
    if (binmode(f1)) { print "Binmode ! ***\n" };               # binmode()
    for ($i=1; $i<=10; $i++)
    {
        print (f1 $i);
    }
close (f1);
print "\n";


# --- warn     # Text auf STDERR ausgeben
print "4d1) warn()\n";
$@="Warning1 = Besonderer WarningText\n";
warn;                                                           # warn()
print "4d2) warn(Text)\n";
warn("Warning1 = Seltener Text\n");
print "\n";

# __END__
# ============================================================================
# 5) FILE position
# ============================================================================
# seek, tell

&dbg_TRACE("5) FILE position functions",__FILE__,__LINE__);

# --- seek      # seek (FH, 'bytePos' relativ zum STARTPUNKT, STARTPUNKT)
# --- tell      # Ausgabe der 'bytePos'
print "5a)-5b)  seek()+tell() \n";
$File=$File1;
open  (f1,"<$File");
    printf ("BytePos(Start) : %d\n",tell(f1));                  # tell()
    $n = read(f1, $Buffer, 1024);    # alles einlesen
    print("Buffer  = \n\<$Buffer\> \n");
    $j = 0;
    for ($i=0; $i<5; $i++)
    {
        $j = $i*2;                   # jedes 2. Byte
        seek (f1, $j , SEEK_SET);    # BytePos 'j'              # seek()
        $b = getc(f1);               # 1 Zeichen lesen
        print "Byte[$j]:$b;";        # Ausgabe
    }
    print "\n";
    printf ("BytePos(Ende)  : %d\n\n",tell(f1));
close (f1);

=pod        Startpunkte f?r seek und sysseek [siehe .u.]
---------------------------------------------------------------------
SEEK_SET    0   suche ab Datei-Anfang
SEEK_CUR    1   suche ab aktueller Position
SEEK_END    2   suche ab Datei-Ende
---------------------------------------------------------------------
=cut

# ============================================================================
# 6) Sys-FILE-Functions (Unix-Schnittstelle)
# ============================================================================
# sysopen, sysread, syswrite, sysseek

&dbg_TRACE("6) SYSFILE functions",__FILE__,__LINE__);

# --- sysopen           * open a file
# --- sysread           * file read
# --- syswrite          * file write
print "6a)-6c)  sysopen(), sysread(), syswrite() \n";
sysopen  (f1,"$File",O_RDW);                                    # sysopen()
    $n = sysread(f1, $Buffer, 1024);                            # sysread()
#        1024 Bytes lesen
    print("Buffer1 = \n\<$Buffer\> \n");
close (f1);   # es gibt kein 'sysclose'

print "6d)  sysseek()\n";
# --- sysseek(fp, pos, mode) * seek a byte in a file
sysopen  (f1,"$File",O_RDW);        # wie 'open', RDW = Read+Write
    $Buffer = $Buffer . "!SYSWRITE!";
    syswrite(f1, $Buffer, 1024);  # File beschreiben            # syswrite()

    for ($i=0; $i < 5; $i++)
    {
        $j = $i*2;
        eval {sysseek (f1, $j ,2);};  # BytePos 'j' suchen ab Ende
        $ret = &dbg_checkError(__FILE__,__LINE__);
        if ($ret > 0)
        {
            print "sysseek->seek\n";    #WinNT with seek()
            seek (f1, $j , SEEK_END);
        }
#
        $b = getc(f1);                # 1 Zeichen lesen
        print "Byte[$j]:$b;";         # Ausgabe
    }
    print "\n";
close (f1);
print("Buffer2 = \n\<$Buffer\> \n");

# __END__

# ============================================================================
# 7) FILE access functions
# ============================================================================
# Info:         stat, lstat,  Dateitestoperatoren
# Admin:        (chmod, chown, utime)   # Unix
# Links:        link, symlink, readlink, unlink # Unix
# ?nderungen:   rename, truncate
&dbg_TRACE("7) FILE access",__FILE__,__LINE__);
sub printTime()
{
    ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $daylightsv)
        = localtime($ArgTime);
    print "\tTime(hhmmss)<",$hour,':',$min,':',$sec,">;";
    print "Year(YYMM)<",$year,':',$mon,':',$mday,':(',$wday,':',$yday,")>;";
    print "DayLight:<",$daylightsv,">;\n";
}

sub printFileInfo()
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

$Vers = 0; &fileName();     # get FileName
open  (fp,">$File");
    printf (fp "Wichtiger Text!");
close (fp);

# --- stat(FileName)    * get status file informations
print ("7a) stat($File) = ",@l = stat($File),"\n");             # stat()
@ArgInfo=@l; &printFileInfo();
# stat([fp|FileName]) # ohne Args => letztes stat()

# --- lstat(FileName)   * get link and status file informations
print ("7b) lstat($File) = ",@l = lstat($File),"\n");           # lstat()
@ArgInfo=@l; &printFileInfo();
# lstat(fp|FileName)

# --- file state options
print ("7c) Dateitest: \'$File -s\' => ");                      # print -Opt
print "FileSize:  ";
print -s "$File";        # print -<Option> FileName;  * in einer Zeile !
print "\n\n";

=pod Dateitest-Operatoren
---------------------------------------------------------------------
-c  TRUE: Datei ist ein character device
-e  TRUE: Datei existiert
-f  TRUE: Datei ist ein File - kein Verzeichnis
-l  TRUE: Datei ist ein symbolischer link
-p  TRUE: Datei ist FIFO
-s  Dateigr??e
-z  TRUE: Datei mit L?nge '0'
-A  last access time
-B  TRUE: Datei ist Bin?rdatei
-C  last inode access time
-M  modification date
-S  Datei ist ein socket
---------------------------------------------------------------------
=cut

# print ("7x) chmod: ",chmod($File,0644),"\n");           # NOK
# print ("7x) link: ",link($File,"testFile"),"\n");       # unsupported

# --- rename(FileName,New-FileName)     * rename a file
$FileNew = $File.".ren";
print "7d) rename($File,$FileNew) : \n";
$iOK = rename($File,$File.".ren");                              # rename()
($iOK) ? print "rename: ok" : print "rename: nok!";
$File = $FileNew;
print "\n\n";

# --- truncate(File,new-fileSize)       * reduce the fileSizeof a file
print "7e) truncate($File,10)\n";
print "FileSize Old :  "; print -s "$File"; print "\n";
$iOK = truncate($File,10);                                      # truncate()
print "FileSize New :  "; print -s "$File"; print "\n";

# ============================================================================
# 8) Hash DB
# ============================================================================
# dbmopen, dbclose
# use: die() * stop subProcess
# l:
&dbg_TRACE("8) HASH Dbase",__FILE__,__LINE__);

# --- dbmopen   * open or create+open a hash database
# --- dbclose   * close a hash database
print "8a)-8b) dbmopen(), dbmclose()\n";
$dbName = "myDb";
dbmopen (%dbHash, $dbName, 0777)                                # dbmopen()
    or (die "\tERR: dbmopen($dbName)");
#   HashDatabase mit den Files {'myDb.pag','myDb.dir'} anlegen
    print "\tOK: dbmopen($dbName)\n";
    eval {$dbHash{'key1'} = '1' };   # key='key1', value='1'
    eval {$dbHash{'key2'} = '2' };   # key='key2', value='2'
#   !WinNT:NOK
    %ArgH = %dbHash; &dbg_printHash();
dbmclose (%dbHash);                                             # dbmclose()


# ============================================================================
# 9) Dir functions
# ============================================================================
# create:       opendir, closedir
# i/o:          readdir
# position:     rewinddir, seekdir, telldir,
# change:       mkdir, rmdir

&dbg_TRACE("9) DIR functions ",__FILE__,__LINE__);

# --- opendir(dirPtr,dirName)       * open an existing directory
# --- closedir(dirPtr)              * close a dir by using a dirPtr
# --- readdir(dirPtr)               * read a dir - get a list @L or a $str
print "9a)-9c) opendir, readdir, closedir\n";
$Dir=".";   # actualDir = '.'; upperDir = '..'
opendir (dp,$Dir);                                              # opendir()
    @l = readdir(dp);   # ret=@DirList                          # readdir()
    join (';',@l);      # seperator=';' in dirStr "file1;file2;..."
    $i = 0;
    foreach $file (@l)
    {
        if ($i++ % 5 == 0) {print "\n\t"};
        print "$file;";
    }
    print "\n\nFiles : \'$i\' im Verzeichnis : \'$Dir\'\n";
closedir(dp);                                                   # closedir()
print "\n";

# --- seekdir(dirPtr)               * search files in a dir /*NOK*/
# --- telldir(dirPtr)               * get dir Pos
# --- rewinddir(dirPtr)             * go back to DirPos '0'
print "9d)-9f) seekdir, telldir, rewinddir\n\n";
$Dir=".";   # actualDir = '.'; upperDir = '..'
opendir (dp,$Dir);
    rewinddir(dp);      # useful in DOS-Perl                    # rewinddir()
    printf("DirPos[0]           : %d\n",telldir(dp));           # telldir()
    print "\nAusgabe mit READDIR:\n";
    for ($i=0; $file = readdir(dp); $i++)
    {
        $FileName[$i]  = $file;
        $FilePos[$i]   = $p = telldir(dp);
        print "$file($i,$p);";
    }
    $n = $i;    # 1 zu weit
    printf("\nMax Files          : %d",$i);
    printf("\nMax File Pos       : %d",$FilePos[$i-1]);
    printf("\nLast File          : %s",$FileName[$i-1]);
    print "\nAusgabe mit SEEKDIR:\n";
    rewinddir(dp);
    $getOk = 0;
    for ($i=0; $i < $n; $i++)
    {
        if ($getOk)
        {
            $p = $FilePos[$i];
            $file = $FileName[$i];  # gespeicherter Wert
        }
        else
        {
            $p = $FilePos[$i];
            seekdir(dp,$p);                                     # seek()
            $file = readdir(dp);    # Pos0 = File '.' wird ?berlesen
        }
        print "$file($i,$p);";
    }
    print "\n";
closedir(dp);
print "\n";

# --- mkdir(dirName)    * make a Dir
# --- rmdir(dirName)    * delete a Dir
print "9g) mkdir :Dir1,Dir2,Dir3\n";                            # mkdir()
# mkdir("Dir1");    WinNT:=Nok
mkdir("Dir1",0777);
mkdir("Dir2",0777);
mkdir("Dir3",0777);
print "9h) rmdir :Dir3\n";
rmdir("Dir3");                                                  # rmdir()

# ============================================================================
# 10) Dir Glob-Operator
# ============================================================================
&dbg_TRACE("10) dirGlob",__FILE__,__LINE__);

# --- glob "Globbing-Muster"  * get a File List using a pattern
print "10a) glob\n";
@l = glob "*.pl";                                               # glob()
# alle PerlScripts dieser Dir selektieren
# '*' : beliebiges Zeichen
# '?' : ein Zeichen beliebig
$i=0;
foreach $file (@l)
{
    $i++;
    print ("$file($i);");   # Ausgabe
    if ($i % 5 == 0) {print "\n"};
}

# --- <> "Globbing-Muster"    * get a File List using a pattern
print "\n\n";
print "10b) \"<>\"\n";
@l = <*.pl *.dt.? *.txt>;                                       # <>
$i=0;
foreach $file (@l)
{
    $i++;
    print ("$file($i);");   # Ausgabe
    if ($i % 5 == 0) {print "\n"};
}
print "\n";

&dbg_TRACE($PGMNAME,__FILE__,__LINE__);  print "\n";
exit($iEc);
