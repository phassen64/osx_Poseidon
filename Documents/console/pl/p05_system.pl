# ****************************************************************************
$PGMNAME="[5]:Systemfunktionen";
# ****************************************************************************
#   uses:   p00.pm
#   Vers:   PERL 5.0
# ****************************************************************************

# !$@�����������������������������������������������������������������

use p00;
$iEc  = $ENV{v_FWK_exitCode} + 0;

# include + compile von Modul "i01.pm"
#  1) Datums-Funktionen
#  2) Mathem.-Funktionen
#  3) String-Funktionen
#  4) Listen-Funktionen
#  5) StrList-Konvertierungs-Funktionen
#  6) Hash-Funktionen
#  7) Kontext-Funktionen
#  8) Konvertierungsfunktionen
#  9) Sonderfunktionen
# 10) Formate

# Besondere Variablen:
# $_    : aktueller Str in for-Anweisungen oder split
# @_    : Parameterliste
# $_[i] : i.ter Wert der Parameterliste
# $/    : Wert von 'Zeilenende' - Default={'\n'}
# $#    : Formatliste von printf()
# $@    : ERRORCODE von eval()
# $~    : aktuelles FORMAT

if ($ENV{v_FWK_mode_bBatch}) {
    print "!!! mode:isBatch:=TRUE";
} else {
    print "??? mode:isBatch:=FALSE";
}

# ============================================================================
# 1) Datums-Funktionen          # siehe auch Einf�hrung
# ============================================================================
# time(), gmtime(), localtime(), times()
# ============================================================================

&dbg_TRACE("1) Date & Time",__FILE__,__LINE__);

# - 1) time()

$t = time();                                                    # time()
printf("1) time():: time since (1.1.1970) in secs: %d\n",$t);

# - 2) gmtime()

($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $daylightsv)
    = gmtime($t);                                               # gmtime()
print "2) gmtime()::\n";
print "Time (hhmmss)>",$hour,':',$min,':',$sec,"< \n";
print "Year (YYMM)  >",$year,':',$mon,':',$mday,':(',$wday,':',$yday,")< \n";
print "DayLight  )  >",$daylightsv,"< \n";

# - 3) localtime()

($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $daylightsv)
    = localtime($t);                                            # localtime()
print "3) localtime()::\n";
print "Time (hhmmss)>",$hour,':',$min,':',$sec,"< \n";
print "Year (YYMM)  >",$year,':',$mon,':',$mday,':(',$wday,':',$yday,")< \n";
print "DayLight  )  >",$daylightsv,"< \n";

# - 4) times()

$timeProcess = eval {times()};     # not DOS                    # times()
# --- eval() [9) Sonderfunktionen] : sicher etwas ausf�hren

print "4) times(Process) = ",$timeProcess,"\n";

# ============================================================================
# 2) Mathematische-Funktionen
# ============================================================================
# sin(), cos(), atan2(), exp(), ln(), sqrt(), abs(), int(), srand(), rand()
# ============================================================================
# l:
&dbg_TRACE("2) Mathem.-Funktionen",__FILE__,__LINE__);

$pi = $PI;          # def in i01.pm
$ef = $EF;
$n=10; $l=2; $z=-4.56; $r=time()%100; $e=2; $d=$pi/2;

print "sin()    = sin(",$d,")   = ",sin($d),"\n";               # sin()
print "cos()    = cos(",$d,")   = ",cos($d),"\n";               # cos()
print "atan()   = atan2(",$d,") = ",atan2($d,$pi/2),"\n";       # atan2()
print "power()  = ($n ** $l)    = ",$n**$l,"\n";                # **
print "e^()     = exp(",$e,")   = ",exp($e),"\n";               # exp()
print "ln()     = log(",$ef,")  = ",log($ef),"\n";              # log()
print "sqrt()   = sqrt(",$l,")  = ",sqrt($l),"\n";              # sqrt()
print "ABS()    = abs(",$z,")   = ",abs($z),"\n";               # abs()
print "INT()    = int(",$z,")   = ",int($z),"\n";               # int()
print "srand()  = srand()       = ",srand(),"\n";               # srand()
print "RND()    = rand(20)      = ",rand(20),"\n";              # rand()
# exit(0);

# ============================================================================
# 3) String-Funktionen
# ============================================================================
# length(), substr(), index(), rindex(), lc(), lcfirst(), uc(), ucfirst()
# chop(), chomp(), y()/tr(), quotemeta(), (sprintf())
# ============================================================================
# l:
&dbg_TRACE("3) String-Fkt",__FILE__,__LINE__);

$str="abcdefghijklmnopqrstuvwxyzabcd";
$strOld = $str;
$STR="ABCDEFGHIJKLMNOPQRSTUVWXYZABCD";
$Nam="Ernie und Bert";
$Set="Gehen, singen, tanzen.";

# 1) Length of a String
# l = length($str);                                             # length()
print "1)  length(",$str,")     = ",length($str),"\n"; #< 30

# 2) Get a Sub-String
# s = substr($str,offset[,len]) ;                               # substr()
print "2a) substr(",$str,",5)   = ",substr($str,5),"\n";#< f
print "2b) substr(",$str,",5,3) = ",substr($str,5,3),"\n"; #< fgh

# 3) Index (=Byte-Offset) of the first occurence of char in a string
# i = index($str,'c');   i={0,...,n}=Offset in Str[i]           # index()
print "3a) index(",$str,",F)    = ",index($str,'F'),"\n"; # < -1 #da kein 'F'
print "3b) index(",$str,",f)    = ",index($str,'f'),"\n"; # < 5
print "3c) index(",$str,",a)    = ",index($str,'a'),"\n"; # < 0

# 4) Index of the last occurence of a char in a string
#    i = rindex($str,'c');                                      # rindex()
print "4)  rindex(",$str,",a)   = ",rindex($str,'a'),"\n";

# 5) lower case
#    lc ($str) ; != {�,�,�} # keine Umlaute                     # lc()
print "5)  lc(",$STR,")         = ",lc($STR),"\n";

# 6) lower case first letter
#    lcfirst ($str) ;                                           # lcfirst()
print "6)  lcfirst(",$STR,")    = ",lcfirst($STR),"\n";

# 7) upper case
#    uc ($str) ; != {�,�,�} # keine Umlaute                     # uc()
print "7)  uc(",$str,")         = ",uc($str),"\n";

# 8) upper case first letter
#    ucfirst ($str) ;                                           # ucfirst()
print "8)  ucfirst(",$str,")    = ",ucfirst($str),"\n";


# 9) chop - rmv last char - change src string                   # chop()
print '9)  c = chop($str=',"$str) = ",chop($str),"\n",
           '      => $str = ',$str,"\n";

# 10) chomp - rmv last $/='\n'-char if exist - change src str   # chomp()
$/='c';  #neues 'NewLine'
print '10) chomp($str=',"$str) = ",chomp($str),"\n",
           '      => $str = ',$str,"\n";
$/='\n'; #normal

# 11) tr oder y                                                 # y()
$str=$strOld; $str =~ y/a/+/;
print "11a) $strOld =~ y/a/+/  = $str \n";        # alle 'a' durch '+'
$str=$strOld; $str =~ tr/b/!/;
print "11b) $strOld =~ tr/b/!/ = $str \n";       # dito
# keine Umlaute erlaubt!

# 12) quotemeta                                                 # quotemeta()
$s1="\t\n\n";  #Sonderzeichen  quotieren
print '12)  quotemeta($s1) = ',quotemeta($s1),"\n";
# keine Umlaute erlaubt!
print "\n";

# 13) sprintf /*NOK*/                                           # sprintf()
#     sprintf($str,"Formatstr",Werte)   [t06,printf()]
$s1="???";
print '13)  sprintf() = ',sprintf($s1,"ZAHL:%d\n",77)," = $s1\n";


# ============================================================================
# 4) Listen-Funktionen
# ============================================================================
# shift()-unshift(), push()-pop(), splice()
# reverse()-sort(),
# map({Fct(),BLOCK}), grep({BLOCK,REG})
# ============================================================================
# l:

&dbg_TRACE("4) Listen-Fkt",__FILE__,__LINE__);
@LN=("1.","Name","2.","PLZ","3.","ORT");
@L1=(1,2,3,4,5,6,7);
@L2=(11,2,7,22,4,1,9);
@L3=('a','b','c');
@P1=("Gehen ", "singen ", "tanzen", "springen");

print '@L  = (',@L,')'," = (@L)\n";         # Listen- und Stringausgabe
# print "0)  scalar(@L)  = ",scalar(@L),"\n"; # Anzahl der Listenelemente
# print '@L  =(',"@L",');',"\n";

#
# shift()-unshift(), pop()-push(), splice() ----------------------------------
#
print "--- shift()\n";
# c = shift(@List) * shift first ListElem into a char-Variable
# c = erstes Zeichen der Ausgangsliste, Liste verkleinert sich
# IN/OUT: @L/@L' - change to @L
@L = @L1;
print "1a) shift(@L) = ",shift(@L),'; @L=(',"@L",")\n";         # shift()
print "1b) c = shift(@L) = ",$c = shift(@L),'; @L=(',"@L",")\n";

print "--- unshift()\n";                                        # unshift()
# n = unshift(@List,c) * put a char-Variable to first ListElem
# n = Anzahl der Listen-Elemente
# IN/OUT: @L/@L' - change to @L
print "2)  unshift(@L,$c) = ",unshift(@L,$c),'; @L=(',"@L",")\n";
print "2b) unshift(@L,x) = ",unshift(@L,x),'; @L=(',"@L",")\n";

print "--- pop()\n";
# c = pop(@List) * get last ListElem
# c = erstes Zeichen der Ausgangsliste, Liste verkleinert sich
# IN/OUT: @L/@L' - change to @L
@L = @L1;
print "3)  pop(@L) = ",$c = pop(@L),'; @L=(',"@L",")\n";        # pop()

print "--- push()\n";
# n = push(@List,c) * put a char-Variable to last ListElem
# n = Anzahl der Listen-Elemente
# IN/OUT: @L/@L' - change to @L
print "4)  push(@L,$c) = ",push(@L,$c),'; @L=(',"@L",")\n";     # push()

print "--- splice()\n";                                         # splice()
# @r = splice(@l,Offset,Anzahl,@neu);  * multifunction to a List
# -- l�schen eines Listenelementes
# INP: @L; OUT: @LX - no change to @L
@L = @L1;
print "5a) LX = splice(@L,1,1) = ",@LX = splice(@L,1,1),"\n";
print "    \@L=(@L); \@LX=(@LX) \n";
# -- Listenelement ersetzen
@L = @L1;
print "5b) LX = splice(@L;1;1;@L3) = ",@LX = splice(@L,1,1,@L3),"\n";
print "    \@L=(@L); \@LX=(@LX) \n";
# -- Listenelemente einf�gen
@L = @L1;
print "5c) LX = splice(@L;1;0;@L3) = ",@LX = splice(@L,1,0,@L3),"\n";
print "    \@L=(@L); \@LX=(@LX) \n";

#
# reverse(), sort()     ------------------------------------------------------
#
print "--- reverse()\n";
# @L' = reverse(@L);        * reverse List
# INP: @L; OUT: @LX - no change to @L
@L = @L1;
print "6)  LX = reverse(@L) = ",@LX = reverse(@L),"\n";         # reverse()
print "    \@L=(@L); \@LX=(@LX) \n";

print "--- sort()\n";
# @L' = sort(@L);           * sort List
# INP: @L; OUT: @LX - no change to @L
@L = @L2;
print "7)  LX = sort(@L2) = ",@LX = sort(@L),"\n";              # sort()
print "    \@LX=(@LX); \@L=(@L) \n";

#
# map: , grep() --------------------------------------------------------------
#
print "--- map()\n";
# @Lx = map({op,block},@L);   * map an 'op' or an block to a list
# INP: @L; OUT: @LX - no change to @L

# -- use single operator 'uc' == upper case letter
@L = @L3;
print "8a) LX = map(uc,@L) = \n";                               # map()
# @LX = map (uc,@L);      # Linux:=ok; WinNT:=Nok
@LX = map (uc($_),@L);    # Linux:=ok; WinNT:=ok
print "    \@L=(@L); \@LX=(@LX) \n";

# -- use single operator 'sqrt' == square()
@L = @L1;
print "8b) LX = map(sqrt,@L) = \n"; @LX = map (sqrt,@L);  # 1 op
print "    \@L=(@L);\n";
print "    \@LX=(@LX); \n";

# -- use a block
print "8c) LX = map({add-Block},@L) = \n";
@L = @L1;
$i = 0;
@LX = map               # keine () - sonst WARNING !
      {
        $i += $_;       # addiere Listenelemente
      } @L ;
print "    \@L=(@L); \@LX=(@LX) \n";

# -- use a function
print "8d) LX = map((&add()),@L1) = \n";
$i=0;
sub add() {
    $i += $_[0];
#   return($i); # not used
}
@L = @L1;
@LX = map ((&add($_)),@L);
print "    \@L=(@L); \@LX=(@LX) \n";

print "--- grep()\n";
# @Lx = grep({op,block},@L);   * grep 'op' or an block to a list
# INP: @L; OUT: @LX - no change to @L
# -- use simple REG - find 'g' in a String-List
@L = @P1;
print "9a) LX = grep(/g/,@L) = \n"; @LX = grep (/g/,@L);         # grep()
print "    \@L=(@L); \@LX=(@LX) \n";
# -- use Block - get numbers bigger than '10' in a Number-List
@L = @L2;
print "9b) LX = grep(/g/,@L) = \n";
@LX = grep
      {
         $_ > 10;
#        if ($_ > 10) {1};  # * dito
      } @L;
print "    \@L=(@L); \@LX=(@LX) \n";


# ============================================================================
# 5) StrList-Konvertierungs-Funktionen
# ============================================================================
# split({REG})-join()
# ============================================================================

&dbg_TRACE("5) Str/List-Fkt",__FILE__,__LINE__);

$Nam="Ernie und Bert";
$Set="Gehen, singen, tanzen.";

# 1) split a string to a list                                  # split()
#    split(/REG/,$str) -> @list
$_="Ernie und Bert";
print "--- split()\n";
print "a)  split(",'$_=',$_,")  = ",split(),"\n";           # o.Args, use '$_'
print "b)  split(/ /,$Nam)      = ",split(/ /,$Nam),"\n";   # / /
print "c)  split(/e/,$Nam)      = ",split(/e/,$Nam),"\n";   # /e/
print "d)  split(/en/,$Set)     = ",split(/en/,$Set),"\n";  # /en/
print "e)  split(/en/,$Set,2)   = ",split(/e/,$Set,2),"\n"; # /e/,$v,2
# Es wird 1x split ausgef�hrt, das sind dann "2" Teile
# also : 'number' => split x number-1
$n = split(/en/,$Set); # kein sinnvoller Wert in DOS-Perl
$s = split(/en/,$Set);
print "f)  \$s = split(/en/,$Set)  = ",$s,"\n"; # split(/n/,$v,2)   #String
@l = split(/en/,$Set);
print "g)  \@l = split(/en/,$Set)  = ",@l,"\n";  # split(/n/,$v,2)  #List

# 2) join a list to a string                                # join()
#    join($str1,@list) ->  $str2
print "--- join()\n";
print "a)  join('en',\@l=@l)       = ",join('en',@l),"\n";  # siehe split f)
print "b)  join(':',('A','B','C')  = ",join(':',('A','B','C')),"\n";
$str="XYZ"; # use a $strVar
print "c)  join($str,('A','B','C') = ",join($str,('A','B','C')),"\n";

# ============================================================================
# 6) Hash-Funktionen
# ============================================================================
# each(), delete(), exists(), keys(), values()
# ============================================================================
&dbg_TRACE("6) Hash",__FILE__,__LINE__);

@L1=(1,2,3,4,5,6,7);
@L3=('a','b','c');
%H1=(k1=>"Name",k2=>"PLZ",k3=>"Ort");
%H2=(k1,"Name",k2,"PLZ",k3,"Ort");

print "--- each()\n";
print "1)  each(%H)\n";
%H = %H1;
sub printHash() {
    for ($i=1;($key,$obj) = each(%H); $i++)                     # each()
    {
        if ($i == 1) {print "    HASH=:"};
        print "[$i]:$key=>$obj;";
    }
    print "\n";
}
&printHash();

print "--- delete()\n";
%H = %H1;
print "2)  HX = delete(%H,k1) = ",delete($H{k1}),"\n";          # delete()
&printHash();

print "--- exists()\n";
&printHash();
print "3)  exists(%H,k1) = ",exists($H{k1}),"\n";               # exists()
print "3b) exists(%H,k2) = ",exists($H{k2}),"\n";
&printHash();

%H = %H1;
print "--- keys()\n";
&printHash();
print "4a)\t for keys %H =: ";
for (keys %H)                                                   # keys()
{
    $i = $_;
    print "$i;";                                       # Keys des Hashes
}
print "\n";
print "4b)\t scalar keys %H =: ",scalar keys %H,"\n";  # Anzahl der Keys

%H = %H1;
print "--- values()\n";
&printHash();
print "5a)\t for values %H =: ";
for (values %H)                                                 # values()
{
    $i = $_;
    print "$i;";                                       # Value des Hashes
}
print "\n";
print "5b)\t scalar values %H =: ",scalar values %H,"\n";  # Anzahl der Values


# ============================================================================
# 7) Kontextfunktionen
# ============================================================================
# scalar(), wantarray()
# ============================================================================

&dbg_TRACE("7) Kontext-Fkt",__FILE__,__LINE__);

# scalar
# wantarray

@LN=("1.","Name","2.","PLZ","3.","ORT");
@LM=("+","Name","#","PLZ","*","ORT");
@L1=(1,2,3,4,5,6,7);
%h=("1.","Name","2.","PLZ","3.","ORT");
$a=["Name","PLZ","ORT"];

@l=@L1;
print "--- scalar\n";       # erzwinge skalaren Return
print "a)  scalar(@l)  = ",scalar(@l),"\n";     # Anzahl der Listenelemente
print "b)  scalar(%h)  = ",scalar(%h),"\n";     # 3/8 == TRUE => h nicht leer
print "c)  scalar($a)  = ",scalar($a),"\n";     # ARRAY()

sub f1 (@)
{
    if (!defined(wantarray))        # undefined Kontext
    {
#       print "void!";              # void Kontext
        $r = 0;
        return($r);                 # return = FALSE
    }
    elsif (wantarray)               # Listenkontext
    {
        return(@_);                 # return Liste
    }
    else
    {
        return($_[0]);              # return 1.Parameter
    }
}

print "--- wantarray\n";
# $b = wantarray();
=pod 	wantarray kontextbezogene R�ckgabewerte
------------------------------------------------------------------------------
TRUE	Listenkontext
FALSE	Skalar - Str/Zahl
undef	void-Kontext
------------------------------------------------------------------------------
=cut
@l=@LM;                                                       # KONTEXT:
$r = -1;
print("a)  &f1(\@l)) = "); &f1(@l); print "retValue=$r\n";    # undefined
#          Linux< retValue=0; WinNT< retValue=-1;
print("b)  \$r=&f1(\@l)) = "); $r = &f1(@l); print "retValue=$r\n";  # Skalar
print("c)  print scalar &f1(\@l)) = ", scalar &f1(@l),"\n");  # Skalar
print("d)  print &f1(\@l) = ",&f1(@l),"\n");                  # Liste


# ============================================================================
# 8) Konvertierungsfunktionen
# ============================================================================
# chr(), ord(), hex(), oct(), pack(), unpack(), vec()
# ============================================================================
# l:
&dbg_TRACE("8) Konv-Fkt",__FILE__,__LINE__);

# chr, ord
# hex, oct
# pack, unpack
# vec

# 'A'(char) = 65(d) = 41(h) = 101(o)

print "--- chr(),ord(),hex(),oct()\n";
print "a)  chr(65)   = ",chr(65),"\n";     # Ascii -> Char      # chr()
print "b)  ord(A)    = ",ord('A'),"\n";    # Char -> Ascii      # ord()
print "c)  hex(41)   = ",hex(41),"\n";     # Hexa -> Decimal    # hex()
print "d)  oct(101)  = ",oct(101),"\n";    # Octa -> Decimal    # oct()
# print "\n";

print "--- pack(),unpack()\n";
$pstr = pack('c*',ord('A'),ord('B'),ord('C')); #
print "a)  pack(s)    = ",$pstr,"\n";               # ABC       # pack()
# packStr = pack(schablonenStr,@list)
#	Codiert eine Liste in ein Bin�rformat gem�� einer Codierungs-Schablone.
#	Ergebnis ist ein umgewandelter Str.
#       Die Codierung kann ASCII, UUENCODE,...etc sein.
print "b)  unpack(s)  = ",unpack("c*",$pstr),"\n";  # 656667    # unpack()
# @list = unpack(schablonenStr,packStr) 	d
#	decodiert gem�� einer Codierungs-Schablone
# print "\n";

=pod	Codierungsschablone f�r pack / unpack
------------------------------------------------------------------------------
a/A	ASCII-Str mit Null-/Leerzeichen auff�llen
b/B	Bitfolge in steigender/fallender Reihenfolge
c/C	Zeichenwert mit/ohne Vorzeichen
f/d	Gleitkommazahl mit einfacher(float)/doppelter(double) Genauigkeit
h/H	Hexadezimale Zahl, beginnend mit niederwertigem/h�herwertigem Nibble
i/I	Ganze Zahl mit/ohne Vorzeichen
l/L	Langwort mit/ohne Vorzeichen
n/N	Wort/Langwort in "Big Endian"-Darstellung (z.B. Intel, DOS)
s/S	Wort mit/ohne Vorzeichen
u	Mit uuencode codierte Zeichenkette
p/P	Zeiger auf Zeichenkette/Zeiger auf eine Struktur (String fester L�nge)
v/V	Wort/Langwort in "Little Endian"-Darstellung (z.B. Motorola, VAX)
w	Eine mit ISO Basic Encoding Rules (BER) komprimierte Zahl
x/X	Nullbyte/EinByte zur�ck
@	Auff�llen mit Nullbytes bis Position
*	Lies alle Folgezeichen Bsp.:"c*"
%	unpack - n-Bitpr�fsumme Bsp.:"%n"
------------------------------------------------------------------------------
=cut pack / unpack

print "--- vec()\n";
# Eine Zahl bin�r speichern in einem Feld
# vec($tempStr,Offset,len)
$d    = 0;
$z    = 0xe;
# $z    = "4";
print "\tz = $z\n\tv = ";
vec($d,0,8) = $z;                                               # vec()
print vec($d,3,1); # d[3]
print vec($d,2,1); # d[2]
print vec($d,1,1); # d[1]
print vec($d,0,1); # d[0]

print "\n";

# ============================================================================
# 9) Sonder-Funktionen
# ============================================================================
# eval(), warn(), crypt()
# ============================================================================
# l:
&dbg_TRACE("9) Sonder-Fkt",__FILE__,__LINE__);

print "--- eval()\n";  # Auswertung ohne PerlScript-Abbruch
print "--- warn()\n";  # Errorcode auf STDERR
sub testDiv()
{
    $a = shift(); $b = shift();
    eval { $z = $a/$b };                                        # eval()
    if ($@)                 # $@ : ERRCODE von eval()
    {
        print "ERROR:";
        warn($@);                                               # warn()
#       'warn' Systemfehlermeldung auf STDERR schreiben
#       [t06, Files...]
        return(undef);
    }
    else
    {
        return ($z);
    }
}

print "1) testDiv(10/2) = ",&testDiv(10,2),"\n";

if ($ENV{v_FWK_mode_bBatch}) {
    print "2) testDiv(10/0) = ==> not in mode:BATCH \n";
} else {
    print "2) testDiv(10/0) = \n";
    print "testDIV = ",&testDiv(10,0),"\n";  # WARNING
}

print "--- crypt()\n";						# crypt()
# crypt(str,Key);  * Verschl�sselung eines Strings *
$str1 = crypt('Text','123');	# Ergebnis: $str1 = '12etB1QGfr2hI'
$str2 = crypt('Text','123');	# gleicher Text, gleicher Schl�ssel
$str3 = crypt('Text','abc');
print "1) Crypt1 = $str1; Crypt2 = $str2; Crypt3 = $str3\n";
$pwd  = '12etB1QGfr2hI';    # Ergebnis von crypt('Text','123');
$pwdX = crypt('Text',$pwd); # Pr�fung
print '2) if ($pwd == ($pwdX = crypt(\'Text\', $pwd))',"\n\t$pwd == $pwdX\n";
($pwdX eq $pwd) ? print "\t: eq!" : print "\t: neq!";
print "\n";
# __END__

# ============================================================================
# 10) Format-Funktionen
# ============================================================================
# format(), write()
# ============================================================================
# Formate eignen sich f�r die formatierte Ausgabe von Dateien.
# Der Befehl 'format' definiert ein Format.
# Es definiert die Ausgaben von Variablen oder Texten, die in der
# Definition enthalten sind.
# Mit 'write' kann das Format ausgegeben.
# Die Variable '$~' enth�lt den Formatnamen (std. = STDOUT).
# Sie mu� ge�ndert werden, wenn mehrere Formate in einer Datei
# verwendet werden.

=pod Aufbau eines Formats
Zeile           Inhalt
------------------------------------------------------------
1               format F =      - 'F' = Formatname
1b optional     Kommentarzeile  - beginnt mit einem '#'
2               Musterzeile     - f�ngt an mit '@' oder '^'
3               Variablenzeile  - kann in { } stehen
4               .
------------------------------------------------------------
=cut Ende

#
# #         : Kommentar am Anfang jeden Formates in Zeile 1b
# @         : String-Platzhalter - erstes Stringszeichen
# >,<,|     : rechts-, links- , zentrierte  Ausgabe
# #         : Zahl
# ^#        : Darstellung, wenn @-Str definiert ist
# ^<<<      : mehrzeilige Ausgabe - 3 Zeichen pro Zeile
# ~         : unn�tige Zeilen vermeiden
# ~~        : beliebige Zeilen auf jeden Fall ausgeben
# {...}     : Variablenliste - f�r Zeile 3

# l:
&dbg_TRACE("10) Formate",__FILE__,__LINE__);

# 1) einfache Ausgabe
print "1) format(ABC)\n";
format F1 =
@>>
"ABC"
.
$~= "F1";  # 'STDOUT' variabel, da verschieden write() Aufrufe
write ;  # Ausgabe des obigen Textes - 3 Zeichen = {@,>,>}

# 2) einfache Ausgabe - Verwendung von rechtsb�ndig
print "2) format(>>>>)\n";
format F2 =
# Kommentar f�r das 2. Format
@>>>>>>>>>>>>>
"ABC"
.
$~= "F2"; # Zuweisung f�r den n�chsten write()-Aufruf
write;    # Ausgabe Format 'F2' - write verwendet '$~'

# 3) linksb�ndig
print "3) format(<<<<<)\n";
format F3 =
@<<<<<<<<<<<<<
"ABC"
.
$~= "F3";
write;

# 4) zentriert
print "4) format(||||)\n";
format F4 =
@|||||||||||||
"ABC"
.
$~= "F4";
write;

# 5) Zahlen und Variablen - 2x Aufruf eines Formats
print "5) Zahlen(###.###)\n";
format F5 =
# 2.Wert nur ausgeben, wenn definiert
Betrag:@###.## DM (^###)
#   $a $b !CRQ-240313:=> errror
.
$~= "F5";
$a=117.567; $b=122;
write;
$a=51.12;   $b=undef; # $b ist 'nicht definiert'
write;

# 6) Liste ausgeben, die in einer Variablenliste steht.
print "6) \$Num, \@Datum\n";
format F6 =
Num:@>> ; Datum:@>.@>.@>>>
{
    $Nr, @Date
}
.
$~= "F6";
$Nr=814; @Date=(11,2,2002);
write;

# 7) Mehrzeile Ausgabe
print "7) mehrzeiliger Text\n";
format F7 =
# 6 chars each line
^|||||~~
$Text
.
$~= "F7";
$Text="abcdefghijklmnopqrstuvwxyzabcd123!";
write;

print "**** ENDE!";
exit($iEc);
