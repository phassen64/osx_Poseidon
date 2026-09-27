# ****************************************************************************
$PGMNAME="[3]:Operatoren und Statements";
# ****************************************************************************
#   uses:   p00.pm
#   Vers:   PERL 5.0
# ****************************************************************************

# !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß

#  1) Zuweisungs-Operatoren
#  2) Vergleichs-Operatoren
#  3) Boolsche-Operatoren (Log.Verkn?pfungen)
#  4) if (x){...} elsif (x) {...} else {...}
#  5) goto
#  6) while (x) {...}
#  7) until (x) {...}
#  8) do {...} until (x)
#  9) for(x,y,z) {...}
# 10) foreach $v @Liste

use p00;    # include + compile von Modul "p00.pm"
$iEc  = $ENV{v_FWK_exitCode} + 0;

# ============================================================================
# 1) Zuweisungs-Operatoren
# ============================================================================
# a) einfache:          {'=','..','\','->'}
# b) arithmetische:     {'+','-','*','/','**','%'}
# c) bitweise:          {'&','|','^','>>','<<','!','~',}
# d) kombinierte Z.
#    arithmetische kZ.: {'+=','-=','*=','/=','**=','%='}    # {arithm}{'='}
#    bitweise kZ.:      {'&=','|=','^=','<<=','>>='}        # {bitweise}{'='}
# e) Strings:           {'.','x','q','qq','qw',++'}
# ============================================================================
#   print-Formats:      {'%d','%x','%X','%b'}

# ----------------------------------------------------------------------------
&dbg_TRACE("1) Zuweisungs-Operatoren",__FILE__,__LINE__);

# a) einfache
$a = 10;            # Dezimalzahl oder String Zuweisung
$b = "?";  $z   = $a;
printf ("e1: a=%d, b=%s, z:=a=%d\n",$a,$b,$z);              # '='
@l = ('A'..'E');    # Bereichs-Operator '..'
print ("e2: l = <@l>\n");                                   # '..'
$ptrL = \@l;        # Referenz-Operator '\'
print ("e3: \\l = $ptrL\n");                                # '\'
                    # Pfeil-Operator '->'
print ("e4: l = {$ptrL->[0],$ptrL->[1],$ptrL->[2]}\n");     # '->'

&dbg_TRACE("1a) Zahlen",__FILE__,__LINE__);

# b) Arithmetische
$a   = 10; $b   = 2; $c   = 3;
printf ("z1: %s+%s = %d\n",$a,$b,$a+$b);    # z=12  # Addition
printf ("z2: %s-%s = %d\n",$a,$b,$a-$b);    # z=8 # Subtraktion
printf ("z3: %s*%s = %d\n",$a,$b,$a*$b);    # z=20  # Multiplikation
printf ("z4: %s**%s = %d\n",$a,$b,$a**$b);  # z=100 # Potenzieren
printf ("z5: %s/%s = %d\n",$a,$b,$a/$b);    # z=5 # DIV
printf ("z6: %s/%s = %d\n",$a,$c,$a/$c);    # z=3 # DIV
print  ("z7: $a%$c = ",$a%$c,"\n");         # z=1 # Modulo

# c) Bitweise
$b   = 185;                             # DOS-Perl kennt keine Bin?rzahlen !
# $b  = 0b10111001;                     # Bin?rzahl in Unix-Perl
printf("b1: %b(bin) = %d(dez)\n",$b,$b);
printf("b1: %b & 1  = %b\n",$b,$b & 1);     # AND
printf("b2: %b & 0  = %b\n",$b,$b & 0);
printf("b3: %b | 0  = %b\n",$b,$b | 0);     # OR
printf("b4: %b ^ 1  = %b\n",$b,$b ^ 1);
printf("b5: %b ^ 0  = %b\n",$b,$b ^ 0);     # XOR
printf("b6:!%b      = %b\n",$b,!$b);        # NOT
printf("b7:~%b      = %b\n",$b,~$b);        # Komplement
printf("b8: %b >>1  = %b\n",$b,$b >>1);     # Shift-Right
printf("b9: %b <<1  = %b\n",$b,$b <<1);     # Shift-Left

# d) Zuweisung
# -- dezimal
$z = $a;
$z += $b;
print  ('Z1: $a=',"$a",'+=',"$b = $z \n");  # z=12 # +=
printf("\n");
# -- hex
$h   = 0xAB;
printf("h1: %x = %X = %d = %b\n",$h,$h,$h,$h);
# __END__

# e) Strings

&dbg_TRACE("1b) Strings",__FILE__,__LINE__);

# -- String-Concatenierung mit '.'
printf ("s1: %s.%s = %s\n",$a,$b,$a.$b); # '.'  # $a.$b =>"12"
print  ("s2: $a,$b = ",$a,$b,"\n");         # $a,$b =>"12"

# -- Wiederholungsoperator 'x'
print  ('s3:"10"x3 = ',"10"x3,"\n");    # $a x3 =>"101010"

# -- Quotierungsoperatoren 'q','qq','qw'
#    'q{}'
$str1 = q{ab};
$str2 = 'ab';  # identische Anweisung
# print ('qa b} = ',$str,"\n");
print 'q : str1=',$str1,',str2=', $str2, "\n";    #$str1 = $str2
#    'qq{}' * quote "strings"
$str1=qq{ABC}; $str2="ABC";
print 'qq: str1=',$str1,',str2=', $str2, "\n";    #$str1 = $str2
#    'qw{}'   * quote 'words
$str1=qw{ABC DEF GHI jklm 1234};
print 'qw: str1=',$str1, "\n";    #Nr of Words
# qw<Sep>
@list1 = qw# ABC DEF # ; # == @list1={"ABC","DEF"}
print "qw#: l[0]:",$list1[0],";l[1]:",$list1[1], "\n";
# qw<Sep={'(',{','<','['}>
@list1 = qw< ABC DEF > ; # == @list1={"ABC","DEF"}
print "qw<: l[0]:",$list1[0],";l[1]:",$list1[1], "\n";

# -- Magischer Operator (String-Inkrementierung}
print "++A  = ",++($str='A'),"\n";  # A->B
print "++A1 = ",++($str='A1'),"\n";  # A->B

#Falsche Ausgaben
#printf ("z7: %s\%%s = %d\n",$a,$c,$a % $c);    # z=3 => ERR- klappt nicht
#printf ("s2: %s,%s = %s\n",$a,$b,$a,$b);   # ERR - falsche Ausgabe

# ============================================================================
# 2) Vergleichs-Operatoren
# ============================================================================
# Kondition : {'?'}
# Zahlen    : {'>','<','==','>=','<=','<=>','!'}
# Strings   : {'eq','equal','ge','lt','gt','le','ne','not','cmp'}
# ============================================================================
# 2a) Kondition # ------------------------------------------------------------

&dbg_TRACE("2) Vergleichs-Ops",__FILE__,__LINE__);

# -- '?'   # Fragezeichen-Operator
print("01) (1 == 2) ? ");
(1 == 2) ? print("ja") : print("nein");                         # ' (x) ? a:b
print ("\n");

# Die folgenden Vergleiche werden mit dem Fragezeichen-Operator
# durchgef?hrt.

# 2a) Zahlen -----------------------------------------------------------------

&dbg_TRACE("2a) vergleiche: Zahlen",__FILE__,__LINE__);

$a = 1; $b = 2; $c = 3; $d = $a;

print("01) $a  == $b ? =: ");                                   # '=='
($a == $b)? print "ja!": print "nein!" ;

print("\n02) $a  >  $b ? =: ");
($a > $b) ? print "ja!" : print "nein!";                        # '>'

print("\n03) $a  <  $b ? =: ");
($a < $b) ? print "ja!" : print "nein!" ;                       # '<'

print("\n04) $a >=  $d ? =: ");
($a >= $d) ? print "ja!" : print "nein!";                       # '>='

print("\n05) $a <=  $d ? =: ");
($a <= $d) ? print "ja!" : print "nein!";                       # '<='

# Complement
print("\n06) !($a == $b))=: ");
(!($a == $b)) ? print "ja!" : print "nein!";                    # '!'

# Compare
print("\n07) $a <=> $b ? =: ");
$z = ($a <=> $b);                                               # '<=>'
($z == -1) ? print "($a <  $b) == ","$z" : print "";
($z ==  0) ? print "($a == $b) == ","$z" : print "";
($z ==  1) ? print "($a >  $b) == ","$z" : print "";

print "\n";

# 2b) Strings ----------------------------------------------------------------

&dbg_TRACE("2b) vergleiche: Strings",__FILE__,__LINE__);

# - Strings
$a = "Anton"; $b = "Berta"; $c = "Cesar"; $d = $a;

print("01) ($a eq $d)  =: ");
($a eq $d) ?  print "ja!" : print "nein!" ;                     # 'eq'

print("\n02) ($a gt $b)  =: ");
($a gt $b) ? print "ja!"  : print "nein!" ;                     # 'gt'

print("\n03) ($a lt $b)  =: ");
($a lt $b) ? print "ja!"  : print "nein!" ;                     # 'lt'

print("\n04) ($a ge $b)  =: ");
($a ge $b) ?  print "ja!" : print "nein!" ;                     # 'ge'

print("\n05) ($a le $b)  =: ");
($a le $b) ?  print "ja!" : print "nein!" ;                     # 'le'

print("\n06) (not ($a gt $b)) =: ");
(not($a gt $b)) ? print "ja!" : print "nein!";                  # 'not'

print("\n07) ($a cmp $b) =: ");
$z = ($a cmp $b);                                               # 'cmp'
($z <= -1) ? print('a lt b == ',"$z") : print "";
($z ==  0) ? print('a eq b == ',"$z") : print "";
($z >=  1) ? print('a gt b == ',"$z") : print "";

# perl convertiert "a lt b" zu "a < b";

print ("\n");

# ============================================================================
# 3) Boolsche-Operatoren (Logische Verkn?pfungen)
# ============================================================================
# C-Typ     : {'&&','||','!'}                       # hohe Priori?t
# Perl-Typ  : {'and','or','not','xor'}              # niedrige Priorit?t
# ============================================================================
l3:
&dbg_TRACE("3) Bool-Operatoren",__FILE__,__LINE__);

$a = 1; $b = 2; $c = 3; $d = $a;

print("01) (($a < $b) && ($a == $d))  ? =: ");                  # '&&' => AND
(($a < $b) && ($a == $d))  ? print "ja!" : print "nein!";

print("\n02) (($a > $b) || ($a == $d))  ? =: ");
(($a > $b) || ($a == $d))  ? print "ja!" : print "nein!";       # '||' => OR

print("\n03) (($a > $b) || !($a == $d)) ? =: ");
(($a > $b) || !($a == $d)) ? print "ja!" : print "nein!";       # '!' => NOT

print("\n04) (($a < $b) and ($a == $d))  ? =: ");               # 'and' => AND
(($a < $b) and ($a == $d))  ? print "ja!" : print "nein!";

print("\n05) (($a > $b) or ($a == $d))  ? =: ");
(($a > $b) or ($a == $d))  ? print "ja!" : print "nein!";       # 'or' => OR

print("\n06) (($a > $b) or not ($a == $d)) ? =: ");
(($a > $b) or not($a == $d)) ? print "ja!" : print "nein!";     # 'not' => NOT

print("\n07) (($a < $b) xor ($a == $d))  ? =: ");
(($a < $b) xor ($a == $d))  ? print "ja!" : print "nein!";      # 'xor' => XOR

print("\n");
# __END__

# ============================================================================
# 4) if {...} [elsif {...} else {...}]; {....} if; unless {....}
# ============================================================================

&dbg_TRACE("4) if",__FILE__,__LINE__);

# Boolscher Ausdr?cke f?r Zahlenvergleich : {'<','>'}
# x < y =: TRUE => x ist kleiner als y
# x > y =: TRUE => x ist gr??er als y

# 1) : if (x) {....}  [elsif {...} else {...}]

printf("1) *** if (x) {...} \n");
if (1 < 2) { print "1) if (1 < 2) =: ja"; }
printf("\n");


# 2) : if (x) {....} else {....}

if (2 < 1)
{
    print "2) if (2 < 1) = : ja";
}
else
{
    print "2) else (2 < 1) = : nein";
}
printf("\n");


# 3) : if (x) {....} elseif (x) {...} else {....}

if (2 < 1)
{
    print "3) if (2 < 1) = : ja";
}
elsif (1 < 2)
{
    print "3) elseif (1 < 2) = : ja";
}
else
{
    print "3) else (2 < 1) = : nein";
}
printf("\n");

# 4) : (....) if (x)

printf("4) *** (x) if (x) \n");
print "4) 1 < 2 =: ja" if (1 < 2);   # keine {} n?tig
printf("\n");

# 5) : unless (x) {....}

printf("5) *** unless(x) {...} ***\n");
unless (1 < 2)
{
    print "5) unless !( 1 < 2 ) = : ja";
}
else
{
    print "5) unless else ! (1 < 2 ) = : nein";
}
printf("\n");

# 6) 'SWITCH' - simulation eines C-switches

print("\n6) switch $a (>=,==,<=) $b ? =: ");
SWITCH: {
if ($a >= $b) { print "if $a  >= $b"; last SWITCH; }  # 'last' stop Schleife
if ($a == $b) { print "if $a   = $b"; last SWITCH; }  # 'last' kein continue
if ($a <= $b) { print "if $a  <= $b"; last SWITCH; }
}
print "\n";

# ============================================================================
# 5) goto ... marke
# ============================================================================

&dbg_TRACE("5) goto",__FILE__,__LINE__);

# goto Marke; ...; Marke:

goto l_test_Marke;
printf "Dieser Text wird ?bersprungen !\n";
l_test_Marke:
printf "1) GOTO - es geht weiter !\n";

# use GOTO-Marks ###

# Wenn nur ein kurzer Programmabschnitt durchlaufen werden soll,
# sind Marken vorbereitet, benannt nach den Kapitel-Nummern.
# Das Ende eines Kapitels ist durch ein '__END__' gekennzeichnet.
# Es m?ssen die entsprechenden Marken, Befehle auskommentiert werden.

# goto l_start3;
# goto l_start4;
# goto l_start6;

# ============================================================================
# 6) while(x) {..(*)..} [continue {....}]; (*)=[last, goto, next, redo]; goto
# ============================================================================

&dbg_TRACE("6) while",__FILE__,__LINE__);

# while (x) {....};

$i = 0;
print("1) while(x) {...}; ");
while($i < 5)
{
    $i++;
    print "i=$i; ";
}

# while (x) {..last..};

$i = 0;
print("\n2) while(x) {...last..}; ");
while($i < 5)
{
    $i++;
    if ($i > 2) {last}; #last ohne Marke
    print "i=$i; ";
}

# Marke: ... while(x) {..{last Marke}..};

$i = 0;
print("\n3) while(x) {...{last Marke}..}; ");
l_while_last_ende:      # Name der folgenden 'while'-Schleife
while($i < 5)
{
    $i++;
    if ($i > 2) {last l_while_last_ende}; # -kein GOTO! - Ende der Loop
    print "i=$i; ";
}

# while (x) {..{goto Marke}..}; ...Marke:

$i = 0;
print("\n4) while(x) {...goto..}; ");
while($i < 5)
{
    $i++;
    if ($i > 2) {goto l_while_goto_ende}; # GOTO!
    print "i=$i; ";
}
l_while_goto_ende:

# while (x) {...next..}; continue {...}

$i = 0;
print("\n5) while(x) {...continue..}; ");
while($i < 5)
{
    $i++;
    if ($i > 2) { next }; # 'while' abbrechen aber nicht 'continue'
}
continue {
    print "i=$i; ";
}

# while (x) {...redo...};

$i = 0;
print("\n6) while(x) {...redo...}; ");
while($i < 5)
{
    $i++;
    if ($i == 5) { redo }; # nochmal ohne zu pr?fen ob ($i < 5) gilt
    print "i=$i; ";
}
print "\n";

# ============================================================================
# 7) until(x) {....}
# ============================================================================
&dbg_TRACE("7) until",__FILE__,__LINE__);

$i = 0;
print("1) until(x) {...}; ");

until ($i >= 5)
{
    $i++; print "i=$i; ";
}
print "\n";

# ============================================================================
# 8) do {....} until(x);
# ============================================================================
l_start8:
&dbg_TRACE("8) do...until",__FILE__,__LINE__);

$i = 0;
print("1) do {...} until(x); ");
do
{
    $i++; print "i=$i; ";
} until ($i >= 5);
print "\n";

# ============================================================================
# 9) for  (C-Variante)
# ============================================================================
&dbg_TRACE("9) for",__FILE__,__LINE__);

print("1) for () {...};");
for($i=0; $i <= 5; $i++)
{
    print "i=$i; ";
}
print "jetzt i=$i; ";

print("\n2) for (my ...) {...} ;");
$i = 77; # l?sche globales $i
for(my $i=0; $i <= 5; $i++)
{
    print "i=$i; ";
}
print "jetzt i=$i; ";

print("\n3) for (my ...) {... goto...} ;");
for($i=0; $i <= 5; $i++)
{
    print "i=$i; ";
    goto l_for_ende if ($i == 2);
}
l_for_ende:
print "jetzt i=$i;\n";


# ============================================================================
# 10) for oder foreach (Perl-Variante)
# ============================================================================

l_start10:
&dbg_TRACE("10) foreach",__FILE__,__LINE__);

# - for
print('1) for $i (...) {...} ;');

for $i (1,2,3,4,5)
{
    print "i=$i; ";
}

# - foreach
print("\n",'2) foreach $i (...) {...}  ;');    # 'foreach' == 'for'

foreach $i (1,2,3,4,5)
{
    print "i=$i; ";
}

# - foreach (@Liste)
print("\n",'4) foreach my $i (...) {...}  ;');      # Listenvariable
@Liste = (1,2,3,4,5);

foreach $i (@Liste)
{
    print "i=$i; ";
}

# - foreach (++ @Liste)
print("\n",'5) foreach my $i (...) {..++$i..}  ;');  # ++ Listenvariable
@Liste = (1,2,3,4,5);
print "\nListe-START:",@Liste,"\n";

foreach $i (@Liste)
{
    print "i=$i; ";
    ++$i;
}

print "\nListe-ENDE!:",@Liste; # Liste wurde ver?ndert

# - foreach (@Liste ++)
print("\n",'6) foreach my $i (...) {..$i++..}  ;');  # ++ Listenvariable
@Liste = (1,2,3,4,5);
print "\nListe-START:",@Liste,"\n";
foreach $i (@Liste)
{
    print "i=$i; ";
    $i++;               #$Liste[i++];i=1...max
}

print "\nListe-ENDE!:",@Liste; # Liste wurde ver?ndert

# - foreach (@Liste) mit Variablen '$_' anstelle von $i
print("\n",'7) foreach (1..5) {...\'$_\'...}  :');  # autom. Variable '$_'
foreach (1..5)
{
    print "i= $_ ";
}

#- foreach (%Hash)
print("\n",'8) foreach (%Hash):');
%Hash = (1,"Anton",2,"Bert",3,"Cesar",4,"Doris",5,"Emil");
foreach (%Hash)
{
    print "i=$_ ;";
}
print "\n";

l_end:
&dbg_TRACE($PGMNAME,__FILE__,__LINE__);
exit($iEc);

__DATA__

