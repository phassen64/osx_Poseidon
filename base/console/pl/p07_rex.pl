# *****************************************************************************
$PGMNAME="[7]:Regulaere Ausdruecke";            # 25.4.2005
# *****************************************************************************
# call: DOS/LINUX> perl File.pl
# uses: p00.pm
# Vers: PERL 5.6  (utf8)
# *****************************************************************************
# !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß

use p00;
$iEc  = $ENV{v_FWK_exitStatus} + 0;
# use perl_5;
# ---- INHALT:
#   1) Suchen in REGs
#   2) Ersetzen in REGs
#   3) Metazeichen
#   4) Modifier
#   5) H?ufigkeitsangaben
#   6) POSIX Zeichenklasse a) positive und b) negative
#   7) Teilmuster speichern und ausgeben
#   8) Positionsangaben in REGs (Anker)
#   9) Extended REGs
#  10) Beispiele
# *****************************************************************************
# l:

# Initialisierungen
$Text   = "Kugel 1\nPyramide 2\nQuader 3";
$Char   = "#";
@List   = ("Schwimmen", "Badminton", "Schach");
# %Hash   = {"Name:","Peter","Geburtsdatum","9.7.1964","Ort","Miami"};
$Array  = [1,3,4];
$Satz1  = "Einfacher Satz.";
$Satz2  = "Zweizweifacher Satz.";
$Satz3  = "Ein mehrzeiliger\nSatz ueber\n3 Zeilen.";
$SatzX  = "Ein Satz mit #Kommentaren .";
$SatzZ  = "Ein mehrzeiliger\nSatz ?ber\n3 Zeilen.";   # Umlaut in REG !
$Mask1  = "aA bbb 12.3 eeeff eeff gHgHh aA";

# goto l;
# ----------------------------------------------------------------------------
# REG:: $var Function Operator Tr pattern1 [ Tr pattern2 ] Tr Modifier;
#               Function={'=~','!~'}
#               Operator={m,s};
#               Modifier={m,g,i,o,s,x}
#               Tr      ={'/','<',...} != {Zahl,Letter,WhiteSpace}
# Bsp:  $t = "abcde"    # Zuweisung mu? zuerst erfolgen
#   1:  $t =~ m/e/i;
#   2:  $t =~ s/e/*/mg;
# ----------------------------------------------------------------------------

# ============================================================================
# 1) Suchen in REGs
# ============================================================================
=pod
Operator    Bedeutung       Bsp.            weiteres
------------------------------------------------------------------------------
m           search          m/.../          optional|mandatory=>Tr != {'/'}
s           substitute      s/.../.../      mandatory
------------------------------------------------------------------------------
=cut        Operatoren in REGs
# l:
&dbg_TRACE("1) REGs Seek",__FILE__,__LINE__);

# --- op='m', Tr='/'
$t  = $Satz1;
@l  = ($t =~ m/Einfach/);    # Ergebnis '1' == TRUE
print "1)  SEEK: $Satz1 => \@l=\"@l\"; \$t=$t";
($l[0] == 1) ? print ":= ok" : print ":= nok" ; print "\n";

# --- op='', Tr='/'
$t  = $Satz1;
@l  = ($t =~ /Einf/);       # 'm' weglassen; Ergebnis '1' == TRUE
print "2a) SEEK: $Satz1 => \@l=\"@l\"; \$t=$t";
($l[0] == 1) ? print ":= ok" : print ":= nok" ; print "\n";

# --- op='m', Tr='+'
$t  = $Satz1;
@l  = ($t =~ m+Einf+);       # Tenner '#' statt '/'; 'm' mandatory
print "2b) SEEK: $Satz1 => \@l=\"@l\"; \$t=$t";
($l[0] == 1) ? print ":= ok" : print ":= nok" ; print "\n";

# --- op='m', Tr1='<', Tr2='>'
$t  = $Satz1;
@l  = ($t =~ m<Einf>);       # Tenner '<' und '>' statt '/'; 'm' mandatory
print "2c) SEEK: $Satz1 => \@l=\"@l\"; \$t=$t";
($l[0] == 1) ? print ":= ok" : print ":= nok" ; print "\n";

# --- op='m', tOp = '!~' , Tr='/'    ---- NOK ----
$t  = $Satz1;
@l  = ($t !~ m/Einfach/);    # VERNEINUNGSOPERATOR !
print "3a)!SEEK: $Satz1 => \@l=\"@l\"; \$t=$t";
($l[0] == 1) ? print ":= ok" : print ":= nok" ; print "\n";

# --- op='', Tr='/'  --- NOK ---
$t  = $Satz1;
@l  = ($t =~ /Zweifach/);   # Ergebnis '' == FALSE
print "3b) SEEK: $Satz1 => \@l=\"@l\"; \$t=$t";
($l[0] == 1) ? print ":= ok" : print ":= nok" ; print "\n";

# __END__


# ============================================================================
# 2) Ersetzen in REGs
# ============================================================================
# l:
&dbg_TRACE("2) REGs Replace",__FILE__,__LINE__);

# REG ersetzen
# --- OK
$t = $Satz = $Satz1;
$t =~ s/Einfach/Zweifach/;   # 's' : substitute
print "01) $Satz => $t\n";

# --- OK
$t = $Satz = $Satz1;
$t =~ s/Satz/Saetze/;       # keine Umlaute !
print "02) $Satz => $t\n";

# ============================================================================
# 3) Metazeichen
# ============================================================================
=pod
Op      Bedeutung
------------------------------------------------------------------------------
^       Position[0] - vor dem ersten Str, siehe '[]'
$       Position[Zeilenende] - hinter dem letzen String
\       besondere Bedeutung des Folgezeichens aufheben
.       jedes Zeichen au?er Zeilenende
|       eine Alternative
()      Symbole zu einer Gruppe zusammenfassen
[]      Klasse von einzelnen Zeichen
------------------------------------------------------------------------------
=cut    REG-Metazeichen
# l:
&dbg_TRACE("3) Meta",__FILE__,__LINE__);


# ZeilenAnfang('^')  ****
$t = $Satz1;
$t =~ s/^/xyz/;
# am Zeilenanfang 'xyz' einsetzen
# 's' : Operator "substitute"
# '^' : Metazeichen "ZeilenAnfang"
print "1) $Satz1 => t=\"$t\"\n";

# ZeilenEnde('$') ****
$t = $Satz1;
$t =~ s/$/xyz/;
print "2) $Satz1 => t=\"$t\"\n";

# ---- !PHA:Erg?nzung 6.8.2003
# ZeilenAnfang('^') ans ZeilenEnde('$') kopieren ****
$t = $Satz1;
# --- Teil1: ANFANG bestimmen
$t =~ /(^...)/;      #ersten 3 Zeichen
$a=$1;               # sicher Suchergebnis
# --- Teil2: Sprintf-L?sung
$t = $Satz1;
$t=substr( $t, length($a), length($t)- length($a) );
printf("2b1) $Satz1 => t=\"%s%s\"\n",sprintf($t),$a);
# --- Teil2: REG-L?sung
$t = $Satz1;
$t =~ s/$/$a/;  # use:REG
$t=substr( $t, length($a), length($t)- length($a) );
print "2b2) $Satz1 => t=\"$t\"\n";
# --- Teil2: String Tausch
$t = $Satz1;
$t=substr( $t, length($a), length($t)- length($a) );
$t=$t.$a;       # use: stringConcat
print "2b3) $Satz1 => t=\"$t\"\n";

# Entwerter('\') ****
$t = $Satz1;
$t =~ s/$/xyz\$/;
# '$' soll am Ende stehen
print "3) $Satz1 => t=\"$t\"\n";

# beliebiges Zeichen('.') ****
$t = $Satz1;
$t =~ s/a/#/;
# '#' soll anstelle eines beliebigen Zeichens geschrieben werden
# ACHTUNG: bricht nach einmaligem Finden ab => Ersetzung nur 1x
#          --- siehe Modifier 'g' ---
print "4) $Satz1 => t=\"$t\"\n";

# Alternative('|') ****
$t = $Satz1;
$t =~ s/e|f/#/;
# '#' soll anstelle eines 'e' oder 'f' ersetzt werden.
# ACHTUNG: bricht nach einmaligem Finden ab => Ersetzung nur 1x
#          --- siehe Modifier 'g' ---
print "5) $Satz1 => t=\"$t\"\n";

# Gruppen('()') ****
$t = $Satz = $Satz2;
$t =~ s/(ei)/#/;     # ersetzt nur 1x - siehe Modifier 'g' unten
print "6) $Satz => t=\"$t\"\n";

# Klassen('[]') **** s.u. ****
# POSIX Class

# __END__

# ============================================================================
# 4) Modifier in REGs
# ============================================================================

=pod
Modifier    Bedeutung
------------------------------------------------------------------------------
g  	        global - nicht beim ersten Treffer abbrechen
i           Gro?- und Kleinschreibung nicht unterscheiden
m           String:=Folge von Zeilen; '^'=ZeilenAnfang,'$'=ZeilenEnde
s           String:=1 Zeile; hier META='.' pa?t auf ZeilenEnde
ms          {'m','s'}
x           Extended REG == REG mit LeerZeichen und Kommentaren
------------------------------------------------------------------------------
=cut        Modifier

&dbg_TRACE("4) REGs Modifier",__FILE__,__LINE__);
$Satz = $Satz1;

# Modifier('g') ****
$t = $Satz;
$t =~ s/e|f/#/g;
# Meta '|' : Alternative
# Modifier 'g' : global search
print "1) $Satz => t=\"$t\"\n";

# Modifier('g','i') ****
$t = $Satz;
$t =~ s/e|f/#/gi;
print "2) $Satz => t=\"$t\"\n";

# Modifier('g','m','s') ****
$t = $Satz3;
$t =~ s/e|f/\?/gms;   # \? ==> '?'
print "3) $Satz3 => t=\n\"$t\"\n";

# __END__


# ============================================================================
# 5) H?ufigkeitsangaben
# ============================================================================
=pod
Op      Expr fits
------------------------------------------------------------------------------
{n}     genau n-mal
{n,}    wenigstens n-mal
{n,m}   wenigstens n-mal, h?chstens m-mal
*       beliebig oft                        ==  '{0,}'  mit n = '0'
+       beliebig oft, mindestens einmal     ==  '{1,}'  mit n = '1'
?       einmal                              ==  '{1}'   mit n = '1'
*?      beliebig oft - eventuell keinmal
+?      mindestens einmal                   ==  '{1,}'  mit n = '1'
??      einmal oder keinmal                 ==  '{0,1}' mit n = '0', m = '1'
------------------------------------------------------------------------------
=cut    REG-H?ufigkeitsangaben
#l:
&dbg_TRACE("5) Multiple",__FILE__,__LINE__);
$Mask = $Mask1;
# ZeilenEnde('$') ****

# op/x/y/g
$t = $Mask;
$t =~ s/b/#/g;
print "01) $Mask => t=\"$t\"\n";

# '*'
$t = $Mask;
$t =~ s/b*/#/g;         # op={'*'}; => ?berall ersetzen
print "02) $Mask => \n\tt=\"$t\"\n";

# '+'
$t = $Mask;
$t =~ s/e+/*/g;         # {'e','ee','eee',...} => '*'
print "03) $Mask => t=\"$t\"\n";

# '??'
$t = $Mask;
$t =~ s/b\??/#/g;       # op := '??'; 'b' -> '#' ?berall
print "04) $Mask => t=\"$t\"\n";

# 's/...{1}/'
$t = $Mask;
$t =~ s/e{1}/*/;        # 'e' -> '*' einmalig
print "05) $Mask => t=\"$t\"\n";

# 's/...{1}/g'
$t = $Mask;
$t =~ s/e{1}/*/g;       # 'e' -> '*' an beliebigen Stellen
print "06) $Mask => t=\"$t\"\n";

# '{2}'
$t = $Mask;
$t =~ s/e{2}/*/g;       # 'ee' -> '*'
print "07) $Mask => t=\"$t\"\n";

# 'op///i'
$t = $Mask;
$t =~ s/gh/*/ig;            # {'gh','gH','Gh','HH'} -> '*' # Gro?/Klein
print "08) $Mask => t=\"$t\"\n";

# '{1,2}'
$t = $Mask;
$t =~ s/e{1,2}f{1}/*/g;    # {'ef','eef'} -> '*'
print "09) $Mask => t=\"$t\"\n";

# '|'
$t = $Mask;
$t =~ s/^(a|A)|(e|A)$/*/g;    # ZAnfang:{'a','A'}->'*'; ZEnde:{'e','A']->'*'
print "10) $Mask => t=\"$t\"\n";

# '^.'
$t = $Mask;
$t =~ s/^.{2}/xyz/g;   # 2 beliebiges Zeichen am ZeilenAnfang -> 'xyz'
print "11) $Mask => t=\"$t\"\n";

# '.$'
$t = $Mask;
$t =~ s/.{2}$/xyz/g;   # 2 beliebige Zeichen am ZeilenEnde -> 'xyz'
print "12) $Mask => t=\"$t\"\n";

=pod
Op          Prio    Bedeutung
------------------------------------------------------------------------------
()          1       Ged?chtnis f?r Muster
+,*,?,{}    2       wenigstens n-mal
^,$,\b      3       Anker
|           4       Alternative
------------------------------------------------------------------------------
=cut        REG Priorit?ten der Metazeichen * Prio-1 > Prio-2 > ... > Prio-n *

# ============================================================================
# 6a) POSIX Zeichenklassen
# ============================================================================

=pod
[[:posix:]] Symbol \p{utf8}     Bedeutung           = {Zeichen}
------------------------------------------------------------------------------
lower               IsLower     Kleinbuchstabe      = {'a',...,'z'}
upper               IsUpper     Gro?buchstabe       = {'A',...,'Z'}
alpha               IsAlpha     Buchstabe           = {IsLower, IsUpper}
digit       \d      IsDigit     Ziffer              = {'0',...'9'}
xdigit              IsXdigit    Hexadezimalziffer   = {IsDigit,'A',...,'F'}
alnum               IsAlnum     Alphanumerisch      = {IsAlpha, IsDigit}
word        \w      IsWord      Alph.Str            = {IsAlnum,'_'}
punct               IsPunct     InterpunktionsZchn  = {'.',';',',',':','!','?'}
print               IsPrint     Druckbares Zeichen  = (IsWord, IsPunct, ' ')
space       \s      IsSpace     Whitespace          = {' ','\t','\n'}
cntrl               IsCntrl     Steuerzeichen       = {0x00,...,0x1F}
graph               IsGraph     Graph. Symbol       = {0xA9,...,0xFF}
ascii               IsASCII     ASCII-Zeichen       = {0x00,...,0xFF}
------------------------------------------------------------------------------
=cut    POSIX-CharClass, Perl-CharSymbols, Unicode-CharClass
# l:
&dbg_TRACE("6) Posix",__FILE__,__LINE__);

$Mask = $Mask1;
$Satz = $Satz1;

BEGIN {
#    POSIX           # perl 5.6 : Posix-CharClass
#    use utf8;       # perl 5.6 : Unicode-CharClass
#    PERL-CC         # perl 5.2 : Perl-CharClass
}

# POSIX-CharClass ------------------------------------------------------------

$t = $Mask;
$t =~ s/[[:lower:]]/*/g;            # lower case letters
print "x01) $Mask => t=\"$t\"\n";

$t = $Mask;
$t =~ s/[[:upper:]]/*/g;
print "x02) $Mask => t=\"$t\"\n";

$t = $Mask;
$t =~ s/[[:alpha:]]/*/g;
print "x03) $Mask => t=\"$t\"\n";

$t = $Mask;
$t =~ s/[[:digit:]]/*/g;            # Digits
print "x04) $Mask => t=\"$t\"\n";

$t = $Mask;
$t =~ s/[[:alnum:]]/*/g;
print "x05) $Mask => t=\"$t\"\n";

$t = $Mask;
$t =~ s/[[:punct:]]/*/g;
print "x06) $Mask => t=\"$t\"\n";

$t = $Mask;
$t =~ s/[[:space:]]/*/g;
print "x07) $Mask => t=\"$t\"\n";

$t = $Mask;
$t =~ s/[[:print:]]/*/g;            # druckb. Zeichen
print "x08) $Mask => t=\"$t\"\n";

$t = $Mask;
$t =~ s/[a[:punct:]H]/*/g;      # Mehrfachauswahl : 'a',{punct},'H'
print "x09) $Mask => t=\"$t\"\n";

$t = $Mask;
$t =~ s/[[:digit:][:upper:]]/*/g;   # Kombi Posix-CharClasses
print "x10) $Mask => t=\"$t\"\n";

# Perl-CharClass  -----------------------------------------------------------

$t = $Mask;
$t =~ s/\d/*/g;                 # alle Digits
print "p01) $Mask => t=\"$t\"\n";

$t = $Mask;
$t =~ s/\w/*/g;                 # alle W?rter
print "p02) $Mask => t=\"$t\"\n";

$t = $Mask;
$t =~ s/\s/*/g;                 # alle Spaces
print "p03) $Mask => t=\"$t\"\n";

$t = $Mask;
$t =~ s/[a\d]/*/g;              # 'a' und Digit' - Mehrfachauswahl mit '[]'
print "p04) $Mask => t=\"$t\"\n";

$t = $Mask;
$t =~ s/[\dA]/*/g;              # Pos. von 'A' beliebig bei Mehrfachauswahl
print "p05) $Mask => t=\"$t\"\n";

# Unicode-CharClass  ---------------------------------------------------------

$t = $Mask;
$t =~ s/\p{IsLower}/*/g;
print "u01) $Mask => t=\"$t\"\n";

$t = $Mask;
$t =~ s/\p{IsUpper}/*/g;
print "u02) $Mask => t=\"$t\"\n";

$t = $Mask;
$t =~ s/\p{IsAlpha}/*/g;
print "u03) $Mask => t=\"$t\"\n";

$t = $Mask;
# $t =~ s/\p{IsXdigit}/*/g;                # IsXdigit unknown in PERL-Linux
# print "u04) $Mask => t=\"$t\"\n";

$t = $Mask;
$t =~ s/\p{IsASCII}/*/g;
print "u05) $Mask => t=\"$t\"\n";

# Combi Unicode-CharClasses
$t = $Mask;                                 # NOK: IsLower + IsPunct
# $t =~ s/\p{IsLower} \p{IsPunct}/*/g;
# $t =~ s/[\p{IsLower}][\p{IsPunct}]/*/g;
# $t =~ s/[\p{IsLower}]|[\p{IsPunct}]/*/g;
# $t =~ s/\p{IsLower}{IsPunct}/*/g;
# $t =~ s/(\p{IsLower})(\p{IsPunct})/*/g;
# print "u04) $Mask => t=\"$t\"\n";

# Combi-CharClasses  ---------------------------------------------------------

# $t = $Mask;                           # NOK
# $t =~ s/[[:punct:]] [\p{IsUpper}]/*/g;
# print "c01) $Mask => t=\"$t\"\n";

# ============================================================================
# 6b) Negierte POSIX Zeichenklassen
# ============================================================================
=pod
!Posix      Symbol  !Symbol !Unicode        Bedeutung
------------------------------------------------------------------------------
[:^word]    \w      \W      \P{IsDigit}     'Wort' pa?t nicht
[:^space]   \s      \S      \P{IsSpace}     'WhiteSpace' pa?t nicht
[:^digit]   \d      \D      \P{IsWord}      'Digit' pa?t nicht
...         ...     ...     ...             usw.
            \pP     \PP                     'Property' pa?t nicht
            \X                              'Extended Unicode'
            \C                              'C-Char'
------------------------------------------------------------------------------
=cut        Negierte POSIX-Zeichenklasse
# l:
&dbg_TRACE("6b) !Posix",__FILE__,__LINE__);
$Mask = $Mask1;

# !POSIX-CharClass -----------------------------------------------------------

$t = $Mask;
$t =~ s/[[:^lower:]]/*/g;            # lower case letters
print "x01) $Mask => t=\"$t\"\n";

$t = $Mask;
$t =~ s/[[:^upper:]]/*/g;
print "x02) $Mask => t=\"$t\"\n";

$t = $Mask;
$t =~ s/[[:^alpha:]]/*/g;
print "x03) $Mask => t=\"$t\"\n";

# !Perl-CharClass  ----------------------------------------------------------

$t = $Mask;
$t =~ s/\D/*/g;                 # NICHT alle Digits
print "p01) $Mask => t=\"$t\"\n";

$t = $Mask;
$t =~ s/\W/*/g;                 # NICHT alle W?rter
print "p02) $Mask => t=\"$t\"\n";

$t = $Mask;
$t =~ s/\S/*/g;                 # NICHT alle Spaces
print "p03) $Mask => t=\"$t\"\n";

# !Unicode-CharClass  --------------------------------------------------------

$t = $Mask;
$t =~ s/\P{IsLower}/*/g;
print "u01) $Mask => t=\"$t\"\n";

$t = $Mask;
$t =~ s/\P{IsUpper}/*/g;
print "u02) $Mask => t=\"$t\"\n";

$t = $Mask;
$t =~ s/\P{IsAlpha}/*/g;
print "u03) $Mask => t=\"$t\"\n";


# ============================================================================
# 7) Teilmuster speichern und ausgeben
# ============================================================================

# Teilmuster werden in der REG-Anweisung mit dem Klammerpaar '()'
# gespeichert.
# Die folgende Tabelle zeigt die Symbole an, die in einer print()-Anweisung
# Teilmuster ausgeben.

=pod
Variable    Bedeutung
------------------------------------------------------------------------------
$&          Gesamter, passender String
$+          Inhalt des letzten passenden Klammerpaares
$`          Alles vor dem passenden String
$'          Alles nach dem passenden String
$1          Ergebnis der ersten Klammer N=1
$<N>        Ergebnis der n-ten Klammer  N={1,2,..}
------------------------------------------------------------------------------
=cut        REG-Variablen
# l:
&dbg_TRACE("7) Teilmuster",__FILE__,__LINE__);
$Mask = $Mask1;

# Speichern mit '()'
$t = $Mask;
# ----------------------------------------------------------------------------
$t =~ /(.)\.(.)/g;          # Quell-REG
# ----------------------------------------------------------------------------
# 1 Zeichen vor und nach dem Zeichen '.'
# '.' mu? mit '\' gefluchtet werden - also im REG gilt : '\.' ==> '.'

# '$&'
print "m01) $Mask => X=\"$&\"\n";

# '$+'
print "m02) $Mask => X=\"$+\"\n";

# '$`'
print "m03) $Mask => X=\"$`\"\n";

# '$''
print "m04) $Mask => X=\"$'\"\n";

# '$1'
print "m05) $Mask => X=\"$1\"\n";

# '$2'
print "m06) $Mask => X=\"$2\"\n";

# '\1' # REG mit Bezug auf eine Klammer im REG
$Mask = "12333456789";
$t = $Mask;
# ----------------------------------------------------------------------------
$t =~ /(3)\1(4)/g;
# ----------------------------------------------------------------------------
# 1) finde '3';
# 2) dupliziere Klammer1
# 3) suche '4' hinter '3'
# Anstelle von '$1' wird in REGs '\1' geschrieben
print "m07) $Mask => X=\"$&\"\n";

# --- '$_'
$_ = 'ab cd';           # '$_' : Suchraum f?r die Mustersuche
# ----------------------------------------------------------------------------
@l = m/(..)\ (..)/;
# ----------------------------------------------------------------------------
# @l speichert das gefundene Muster in einer Liste
print "8) ";
print join ',',@l;
print "\n" ;

# __END__

# ============================================================================
# 8) Anker-Positionsangaben in REGs
# ============================================================================
=pod
Symbol  !Symbol     Bedeutung
------------------------------------------------------------------------------
^                   Position vor dem ersten Str
\A                  Anfang des Strings
$                   Position hinter dem letzten Str
\z                  Ende eines Strings
\Z                  Ende eines Strings - vor ZeilenEnde
\b      \B          Inhalt des letzten passenden Klammerpaares
\G                  Position des letzten positiven Mustervergleichs = pos()
$\                  Aktuelle Zeile
------------------------------------------------------------------------------
=cut        Positive+Negative Ankersymbole

# l:
&dbg_TRACE("8) Anker",__FILE__,__LINE__);

# '^'
$t = $Mask = $Mask1;
$t =~ s/^/xyz/g;
print "1a) $Mask => t=\"$t\"\n";

# '\A'
$t = $Mask;
$t =~ s/\A/xyz/g;
print "1b) $Mask => t=\"$t\"\n";    # gleiche Resultate 1a)-1b)

# '\$'
$t = $Mask = $Satz3;        # new Pattern:=Satz3
$t =~ s/$/xyz/g;
print "2a) t=\n\"$t\"\n";

# '\Z'
$t = $Mask;
$t =~ s/\Z/xyz/g;
print "2b) t=\n\"$t\"\n";

# '\z'
$t = $Mask;
$t =~ s/\z/xyz/g;
print "2c) t=\n\"$t\"\n";   # gleiche Resultate 2a)-2c)

# '\b'  * ? *
# '\B'  * ? *
# '\G'  * ? *

# ============================================================================
# 9) Erweiterte Regul?re Ausdr?cke und Muster
# ============================================================================

=pod
Symbol              Bedeutung
------------------------------------------------------------------------------
(?=Expr)            TRUE, wenn Expr als N?chstes pa?t(TRUE) ist
(?!Expr)            TRUE, wenn Expr als N?chstes FALSE ist
(?<=Expr)           TRUE, wenn Expr vorher TRUE w?re
(?<!Expr)           TRUE, wenn Expr vorher FALSE w?re
(?#Comment)         Kommentar. Text wird ignoriert
(?:Pattern)         Einfache Klammer ohne Speicherung des Ergebnisses
(?{Statements})     Anweisungen werden ausgef?hrt; kein Platz n?tig im REG;
                    Pragma use re 'eval' n?tig
(?(Cond) pOk|pNok)  Bedingter Ausdruck mit 2 Ergebnis Patterns pOk,pNok
------------------------------------------------------------------------------
=cut        Erweiterte Ausdr?cke

l:
&dbg_TRACE("9) ExtendedREGs",__FILE__,__LINE__);

# -- 'Normaler REG'
$t = $Mask = $Mask1;
$t =~ s/e+/*/g;
print "01) $Mask => t=\"$t\"\n";

# -- Modifier:='x' bedeutet 'Extended REG'
$t = $Mask = $Mask1;
$t =~ s/
      e+/   # OK: Kommentar im X-REG
      */xg;
# e+={'e','ee','eee',...} wird ersetzt durch '*'
print "02) $Mask => t=\"$t\"\n";

# -- '?='   *OK*
$t = $Mask = $Mask1;
$t =~ /\w+(?=\.)/g;                 # POSIX-Perl='\w'; 1 Wort vor dem '.'
print "03) $Mask => X=\"$&\"\n";    # passender Ausdruck == '$&'

# -- '?!'   *NOK*
$t = $Mask = "eins, zwei, drei. vier!";
$t =~ /\w+(?!,)/g;                 # \w+ = 1 Wort
print "04) $Mask => X=\"$&\"\n";   #

# -- '?<='   *NOK*
$t = $Mask = "eins, zwei, drei. vier!";
# Die folgende Anweisung fuehrt zu einem sofortigen Abbruch des
# PerlScripts.
# Keine Abhilfe durch 'eval' oder Abfrage von '$^O'.
# $t =~ /(?<= )(\w+),/gm;
print "05) $Mask => X=\"$&\"\n";

# -- '?(cond) OkPat|NokPat'     *NOK*  [Perl Gepackt, S.124]
print "06a) ";                  #simple example => *NOK*
$t = "Mein Muster";
if ( /$t/i ) {print "ok!\n"}    #'OK' erwartet
else         {print "nok!\n"};
print "06b) ";                  #cond example => *NOK*
$ic = 1;    # Variable IgnoreCase := TRUE
$t = (($ic)?"(?i)":"")."Mein Muster";    #Cond XREG
if ( /$t/ ) {print "ok!\n"}     #'OK' erwartet
else        {print "nok!\n"};

# __END__


# ============================================================================
# 10) Beispiele
# ============================================================================

#l:
&dbg_TRACE("10) Beispiele",__FILE__,__LINE__);

# l1: # error
$Text   = "Kugel 1\nPyramide 2\nQuader 3";
$i=0; # Laufvariable in den folgenden Beispielen

# -----------------------------------------------------------------------------
# Ersetzen
# -----------------------------------------------------------------------------

# Vor den Anfang eines Textes 1 Zeichen setzen
$t = $Text; $i++;
$t =~ s/^/$Char/;
# cVar =~ s/Reg1/Reg2/mModifier+' -  Such-Syntax
# '^'  : Anfang einer Zeile
print "Text[$i]:\n\"$t\"\n";

# Vor den Anfang jeder Zeile eines Textes 1 Zeichen setzen
$t = $Text; $i++;
$t =~ s/^/$Char/gm;
# 'g'  : global - kein sofortiger Abbruch nach 1. erfolgreicher Suche
# 'm'  : multiple line - alle Zeilen durchsuchen.
print "Text[$i]:\n$t\n";

# Am Endejeder Zeile eines Textes 1 Zeichen setzen
$t = $Text; $i++;
$t =~ s/$/$Char/gm;
# 'g'  : global - kein sofortiger Abbruch nach 1. erfolgreicher Suche
# 'm'  : multiple line - alle Zeilen durchsuchen.
print "Text[$i]:\n$t\n";

# -----------------------------------------------------------------------------
# Suchen und ersetzen  2.Teil (Klammervariablen)
# -----------------------------------------------------------------------------

$z = "5+7";
$z =~ s|^(\d+)\+(\d+)$|$1+$2|e;
#statt '/' hier '|'
#'+'	: hat Sonderbedeutung - daher '\+'
#^(\d+) : Zahl am Anfang
#(\d+)$ : Zahl am Ende
# $1	: Ergebnis von Ausdruck der 1.Klammer
# $2    : Ergebnis von Ausdruck der 2.Klammer
print "Zahl: $z\n";

# -----------------------------------------------------------------------------
# Ausgabe aller ersten W?rter in einem Text
# -----------------------------------------------------------------------------
# ^   	Am Anfang jeder Zeile suchen
# \w 	alphanumerische Zeichen
# +  	mindestens einmal
# g  	global - nicht beim ersten Treffer abbrechen
# m  	alle Zeilen durchgehen
$t = $Text;
@mask = ($t =~ /^\w+/gm); $i=1;
foreach (@mask) {
	print "Word[$i]:$_ ;"; $i++;
};
print "\n";


# -----------------------------------------------------------------------------
# Ausgabe aller ersten W?rter in einem Text mit einem gesicherten Pattern
# -----------------------------------------------------------------------------
$t = $Text;
$m1 = '^\w+';	# Pattern ?bergeben
@mask = ($t =~ /$m1/gm); $i=1;
foreach (@mask)
{
	print "Pattern[$i]:$_;"; $i++;
};
print "\n";


# ============================================================================
# 11) Positions und andere Funktionen
# ============================================================================
=pod
FCT                 Bedeutung
------------------------------------------------------------------------------
pos                 position, mit der die letzte Suche endete
study               String mehrfach durhsuchen
------------------------------------------------------------------------------
=cut       Reg-Funktionen

&dbg_TRACE("11) Positionen",__FILE__,__LINE__);  print "\n";

#   --- suche 'a' vom Anfang des Strings
$ALPHA  = "a";
$t      = "123" . $ALPHA . "456" . $ALPHA . "789" ;
$t      =~ m/[[:alpha:]]/g;         # search first alpha - mit global
$i      = pos($t);
print "a)   pos('$t','$ALPHA')= $i\n";

#   --- suche weiter mit der position von oben
pos($t) = $i;
$t      =~ m/[[:alpha:]]/g;         # search first alpha - mit global
$i      = pos($t);
print "b)   pos('$t','$ALPHA')= $i\n";

#   --- beginne wieder am Anfang zu suchen
pos($t) = 0;                        # '0' == ANFANG
$t      =~ m/[[:alpha:]]/g;         # search first alpha - mit global
$i      = pos($t);
print "c)   pos('$t','$ALPHA')= $i\n";


&dbg_TRACE($PGMNAME,__FILE__,__LINE__);  print "\n";
exit($iEc);

__END__
