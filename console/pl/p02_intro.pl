# ****************************************************************************
# Einführung
# ****************************************************************************

#   encoding: UTF-8
# !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß

#  1) Initialisierung von Variablen
#  2) Ausgabe
#  3) Macros
#  4) Skalare
#  5) Operatoren
#  6) Arrays
#  7) Listen
#  8) Hashes
#  9) Funktionen
# 10) Abbruch, Ende

# ============================================================================
# INCLUDE PATH for Windows
# ============================================================================
# push(@INC,"C:/CMD"); #   $PATH_BIN="C:/BIN"; push(@INC,$PATH_BIN);--err
#use p00;    # include + compile von Modul "p00.pm"

# ============================================================================
# 1) Initialisierungen von Variablen
# ============================================================================
$PGMNAME = "[2]:Einfuehrung";  # String-Variable
$cStr    = $PGMNAME; # Zuweisung: String-Variable := String-Variable
$i       = 77;       # Numerische-Variable
$iPtr    = \$i;      # Ptr-Variable
$iEc     = $ENV{v_FWK_exitCode} + 0;

# ============================================================================
# 2) Ausgabe
# ============================================================================
# -- print
print  "String  : $cStr\n";        # Perl-Typ
print  "String  : ",$cStr,"\n";    # Perl-Typ - Listenform
print ("String  : ",$cStr,"\n");   # Perl-Typ - Listenform und Klammer
# -- printf
printf("Zahl    : $i\n");          # Shell-Typ
printf("Ptr     : %d\n",$$iPtr);   # C-Typ;   *iPtr = i = 77
# -- Zahlformate f?r printf
$h   = 0xAB; # Hexzahl
printf("String: %s; Zahl: %x = %X = %d = %b\n",$cStr,$h,$h,$h,$h);
# 's':String, 'x':hexzahl klein, 'X':Hexzahl, '%d':Dezimalzahl, 'b':bin?r

# ============================================================================
# 3) MACROS
# ============================================================================
printf("File    : %s\n",__FILE__);      # Filename ohne Pfad
printf("Zeile   : %d\n",__LINE__);      # Zeilennummer
printf("Package : %s\n",__PACKAGE__);   # Packagename (== 'main')

# ============================================================================
# 4) SKALARE (Zahlen und Strings)
# ============================================================================
printf("\n*** Line :%d\n",__LINE__);
printf("Zahlen und Strings\n");

#Zahlen
$z=4;           print "Zahl 1: $z"; print "\n";
$z=1_000_000;   print "Zahl 2: $z"; print "\n";
$z=3.14;        print "Zahl 3: $z"; print "\n";
$z=1.2e+2;      print "Zahl 4: $z"; print "\n";
$z=-1.2e-6;     print "Zahl 5: $z"; print "\n";
$z=0xAB;        print "Zahl 6: $z"; print "\n"; # Zahl wird dezimal ausgegeben

#Einfache Strings
$t='abc\n';     print "Str  1: $t\n";  #< abc\n # kein Zeilenvorschub
$t='abc\'';     print "Str  2: $t\n";  # Sonderzeichen \' #< abc'
$t='abc\\';     print "Str  3: $t\n";  # Sonderzeichen \\ #< abc\

#Komplexe Strings
$t="abc\n!";    print "KStr 1: $t\n";  # <abc  <! ;Zeilenvorschub!
$t="abc\'";     print "KStr 2: $t\n";  # Sonderzeichen \" #< abc'
$t="abc\\";     print "KStr 3: $t\n";  # Sonderzeichen \\ #< abc\
$t="abc\td";    print "KStr 4: $t\n";  # tab
$t="abc\x43";   print "KStr 5: $t\n";  # Hexzeichen 'C'
$t="ABC\lBC";   print "KStr 6: $t\n";  # Little Letter

# ============================================================================
# 5) Arrays
# ============================================================================
printf("\n***  Line :%d\n",__LINE__);
printf("Arrays\n");

$Array = ["Peter","09.07.1964","Miami"];  # $Array ist ein C-Ptr;

printf ("Array[0]    : %s\n",$$Array[0]); # C: char *array[]; array[1]
printf ("Array[1]    : %s\n",$$Array[1]);
printf ("Array[2]    : %s\n",$$Array[2]);

printf("...NEGATIVES ARRAY ELEMENT\n");
printf ("Array[-1]   : %s\n",$$Array[-1]);

# ============================================================================
# 6) Listen
# ============================================================================
printf("\n*** Line :%d\n",__LINE__);
printf("Listen\n");

$Array = ["Peter","09.07.1964","Miami"];  # s.o.
@Liste = ("Peter","09.07.1964","Miami");    # Listen-Definition

printf("Name        : %s\n",$Liste[0]);  # 1.Feld
printf("Geburtstag  : %s\n",$Liste[1]);
printf("Stadt       : %s\n",$Liste[2]);

@L      = (1..4);                           # Listen-Defintion mit Aufz?hlung
printf("a) L[0]:%d,L[1]:%d,L[2]:%d,L[3]:%d\n",$L[0],$L[1],$L[2],$L[3]);

@L      = ('a'..'d');                       # Listen-Definition mit Aufz?hlung
printf("b) L[0]:%s,L[1]:%s,L[2]:%s,L[3]:%s\n",$L[0],$L[1],$L[2],$L[3]);

@L      = ('a'..'z')[0,3,5,15];             # Aufz?hlungsliste mit SLICE
printf("c) L[0]:%s,L[1]:%s,L[2]:%s,L[3]:%s\n",$L[0],$L[1],$L[2],$L[3]);

# ============================================================================
# 7) Hashes (Listen-Paare)
# ============================================================================

#   Beispiel mit Strings
printf("\n*** Line :%d\n",__LINE__);
printf("Hash: Strings\n");

%Hash = ("Name","Peter","Geburstag","09.07.1964","Ort","Miami");

printf("Name        : %s\n",$Hash{"Name"}); # Folgestring v. "Name" ist "Peter"
printf("Geburtstag  : %s\n",$Hash{"Geburstag"});
printf("Ort         : %s\n",$Hash{"Ort"});

#   Beispiel mit Zahlen
printf("\n*** Line :%d\n",__LINE__);
printf("Hash: Zahlen\n");

%Hash = (1,'Peter',2,'09.07.1964',3,'Miami'); # Hash mit Einfachen-Strings

printf("Hash(1)     : %s\n",$Hash{'1'}); #Folgestring von "Name" ist "Peter"
printf("Hash(2)     : %s\n",$Hash{'2'}); # Komponente zu "2" ausgeben
printf("Hash(3)     : %s\n",$Hash{'3'});

%Hash2 = (1=>'Peter',2=>'09.07.1964',3=>'Miami'); # andere Schreibweise

printf("Hash2(1)    : %s\n",$Hash2{'1'}); #Folgestring von "Name" ist "Peter"
printf("Hash2(2)    : %s\n",$Hash2{'2'}); # Komponente zu "2" ausgeben
printf("Hash2(3)    : %s\n",$Hash2{'3'});


#   Beispiel mit Systemvars
printf("\n*** Line :%d\n",__LINE__);
printf("Hash: Systemvars\n");

printf("Env      = %s\n",%ENV);
printf("Env.PATH = %s\n",$ENV{"PATH"});  # "PATH" steht in %ENV
printf("Env.OS = %s\n",$ENV{"OS"});  # "ENV.OS

# ============================================================================
# 8) Funktionen
# ============================================================================

# 8a) Systemfunkionen ###

printf("\n*** Line :%d\n",__LINE__);
printf("Systemfunktionen\n");

$Time1  =time();
$Ltime1 =localtime($Time1);
printf("time()       : %s\n",$Time1); # Time
printf("localtime()  : %s\n",$Ltime1); # LocalTime

# 8b) benannte Funktionen ###

# Im Gegensatz zu Systemfunktionen werden eigene Funktionen
# mit ">& cMyFunction (Par1,Par2,...)" aufgerufen.

sub my_TRACE()   # DOS: sub pr_LINE($) *optional*
{
    print("\nFUNKTION: my_TRACE()\n");
    my  $T = localtime(time()); # 'my' => $T nur hier sichtbar
    printf("*** FILE:%s; LINE:%d; ",$_[0],$_[1]);
    # @_={$_[0],$_[1]} # Par1, Par2
    printf("TIME:%s\n",$T);    # Zeit
}

printf("\nFunktionsaufruf mit Zeilenparametern\n");
&my_TRACE(__FILE__,__LINE__);

# Parameter '__LINE__' ist ein int, der an die Fkt pr_LINE()
# ?bergeben wird.
# DOS-Perl akzeptiert auch: Fct(iArg) und die ?bliche Form &Fct(iArg).

# 8c) unbenannte Funktionen (anonyme Funktionen) ###

$fct = sub(@) {                     # $fct ist ein Ptr auf 'sub...'
    print("\nAnonyme Funktion!\n");
    print("Arg1: ", $_[0], "\n");   # @_={$_[0],$_[1]);
    print("Arg2: ", $_[1], "\n");
    print("Arg3: ", $_[2], "\n");
#   Parameter auf Variablen 'shiften'
    $name = shift(@_);              # i=0; $name = $_[i]; i++;
    $zahl = shift(@_);              #      $zahl = $_[i]
    $ort =  shift;                  # shift ohne Parameter == shift(@_)
    print("Args: ", $name,"-",$zahl,"-",$ort,"\n");
};

# Funktionsaufruf der anonymen Funktion auf die $fkt zeigt.

& $fct("Peter",1964,"Miami");

# ============================================================================
# 9) Include Dateien  (use, require, do)
# ============================================================================
# Es k?nnen '*.pl' und '*.pm' Dateien includiert werden.
# Hier wird die Datei "pl.pm" includiert, welche die Funktionen
# 'dbg_LINE' und 'dbg_TRACE' enth?lt.

# do "pl.pm";          # includiert und startet das File beim Statement
# require "pl.pl";     # wie 'do', aber einmalig pro Datei
# use "pl";            # compiliert, startet nicht - erfordert eine *.pm Datei

use p00;                # compile 'pl.pm'

# calling a function which is defined in Include File 'pl.pm'
&dbg_LINE('+');         # Param1 => $_[0]
print("Script : ",$PGMNAME,"\n");
&dbg_LINE('+');

# Die folgende Funktion wurde in 8) vorgestellt.
# Hier wird die entsprechende Funktion des Include-Files verwendet.
&dbg_TRACE("9) IncludeTest",__FILE__,__LINE__); # entspricht: 'my_TRACE'

# ============================================================================
# 10) Abbruch, Ende des Scripts
# ============================================================================
# ScriptName : $0 oder __FILE__
# ZeilenNr   : $. oder __LINE__
print "+++ Ende:: Scripts = \"$0\" \n";
&dbg_TRACE($PGMNAME,__FILE__,__LINE__);
# __END__
exit($iEc);
#   1      # True-Wert Return-Wert dieser Datei f?r weitere Includes
__DATA__   # Dies  Macro beendet den lesbaren Teil eines Perl-Scripts
__END__    # Dieses Macro beendet sofort jedes Perl-Scripts


