# ****************************************************************************
$PGMNAME="[4]:Packages,Scripts,Funktionen,Variablen";
# ****************************************************************************
#   uses:   p00.pm
#   Vers:   PERL 5.0
# ****************************************************************************
# !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß

use p00;
$_iEc = $ENV{v_FWK_exitCode} + 0;  # not iEc => reset deletes

#  1) Packages - Namensr?ume
#  2) BEGIN...END in Packages
#  3) Pragmas
#  4) Aufrufparameter - Scripts, Funktionen
#  5) Funktionen mit Prototype
#  6) Funktionen mit return-Werten
#  7) Funktionen mit Stack-Trace
#  8) Namensr?ume in Funktionen - 'my', 'local'
#  9) Variablen pr?fen
# 10) Typeglobs (Symboltabelle)

# goto l;

# ============================================================================
# 1) Namensr?ume  (Packages)
# ============================================================================

&dbg_TRACE("1) package",__FILE__,__LINE__);
#
# bis hierhin sollte Package 'main' aktive sein !
#

print("1) Aktives Packages : ",__PACKAGE__,"\n");

package P1;
$v1 = 1; $i = 10;       # Package1: Variablen '$i' und '$v1' definiert
print("2) Aktives Packages : ",__PACKAGE__,"\n");

package P2;
$v2 = 2; $i = 20;       # Package2: Variablen '$i' und '$v2' definiert
print("3) Aktives Packages : ",__PACKAGE__,"\n");

print '$P1::i=',$P1::i,';$P2::i=',$P2::i,"\n";     # <10, 20
print '$P1::v1=',$P1::v1,';$P2::v2=',$P2::v1,"\n";  # < 1,""    # v1 nur in P1
print '$P1::v2=',$P1::v2,';$P2::v2=',$P2::v2,"\n";  # < "",2    # v2 nur in P2

package main;           # aktivies Packages ist wieder 'main'
print("4) Aktives Packages : ",__PACKAGE__,"\n");

# ============================================================================
# 2) 'BEGIN' ... 'END' in Packages
# ============================================================================

&dbg_TRACE("2) BEGIN...END",__FILE__,__LINE__);

package B1;
print "2) package B1: Dieser Text steht im Script\n";
END {
    print("2a) package B1 [File:",__FILE__,";Zeile:",__LINE__,"]: 'END'\n");
#   Dieser Block wird am Ende des Perl-Scripts ausgef?hrt,
#   Also auch nach den folgenden Ausgaben,
#   die entweder f?r 'main' oder f?r 'B1' definiert worden
#   sind.
}
BEGIN {
    print("2b ) package B1 [File:",__FILE__,";Zeile:",__LINE__,"]: 'BEGIN'\n");
#   Dieser Block wird am Anfang des Perl-Scripts ausgef?hrt,
#   obwohl package 'main' vor 'B1' definiert ist.
}
package main;

# ============================================================================
# 3) Pragmas in Packages
# ============================================================================
# Pragmas werden mit 'use' eingeleitet und mit 'no use' deaktiviert

# l:
&dbg_TRACE("3) Pragmas",__FILE__,__LINE__);

# --- strict
# use strict;                           # strenge Pr?fungen an
@l=(1,2,3);                             # -> Error
print "Liste: @l\n";; # -> Error
# --- no strict;                        # strenge Pr?fungen aus
# --- diagnostics -verbose              # not in DOS-Perl

# --- subs   {Funktionen - siehe Kapitel 4}
package PP;
use subs 'sin';                         # definiere eigene sinus-fct()
sub sin($$);                            # Prototyp mit 2 skalaren Argumenten
sub sin($$) {                           #
    $arg1 = @_[0];  # par1 - s. Kapitel 4)
    $arg2 = @_[1];  # par2 - s. Kapitel 4)
    return($arg1 + $arg2);
}
print "mySIN(1,2) = ",&sin(1,2),"\n";   # FctAufruf PX->sin()
package main;                           # change PackageName to oldOne

#  __END__

# ============================================================================
# 4) Aufrufparameter von Scripts und von Funktionen
# ============================================================================

# a) Script ---

&dbg_TRACE("4) Aufrufparameter",__FILE__,__LINE__);
# Funktionsaufruf einer Funktion in dem Modul "i01.pm"

print ("Script  : ",$0,"\n");       # Name des Scripts - in C: ARGV[0]
$args = @ARGV;
print ("Args    : ",$args,"\n");    # Anzahl der Argumente
for ($i=0; $i < $args; $i++)
{
    print("Arg[",$i,"]  : ",@ARGV[$i],"\n"); # Args[i]
}

# b) Funktion ---

sub f1() {
    print ("Funktion: f1","\n");       # keine globVariable f?r Fcts ?
    $args = @_;
    print ("Args    : ",$args,"\n");    # Anzahl der Argumente
    for ($i=0; $i < $args; $i++)
    {
        print("Arg[",$i,"]  : ",@_[$i],"\n"); # Args[i]
    }
}

&dbg_TRACE("Funktion:@_",__FILE__,__LINE__);
&f1("Peter","Miami",1964);

# ============================================================================
# 5) Funktionen mit Prototypen
# ============================================================================
l5:
&dbg_TRACE("5) prototype args",__FILE__,__LINE__);

# Prototydefinitionen
# sub f();          # kein Argument
# sub f($);         # 1 skalares Argument
# sub f($$);        # 2 skalare Argumente
# sub f($;$);       # 1 Argument 'mandatory', 1 Argument 'optional'
# sub f(@)          # 1 Liste oder Liste skalarer Argumente
# sub f($@)         # 1 skalares Arg. + 1 Liste oder eine Liste sk.Argumente
# sub f(\@)         # Referenz auf eine Liste
# sub f(\%)         # Referenz auf ein Hash
# sub f(&)          # Referenz auf eine Funktion
# sub f(*)          # 1 Typeglob

sub fct_p1($);      # prototype
sub fct_p1($)
{
    my $arg1 = shift();
    print "fct_p1() : arg1 = ",$arg1,"\n";
}

print "1) fct_p1(55) !\n";
&fct_p1(55);
print "2) fct_p1(55,66) !\n";
&fct_p1(55,66);         # kein Abbruch - obwohl falscher Zugriff!

# ============================================================================
# 6) Funktionen mit Return-Werten
# ============================================================================
l6:
&dbg_TRACE("6) fct{return}",__FILE__,__LINE__);

sub f2() {
    return (3);
}

print 'Returnwert der Funktion f2 :: &f2() = ',&f2(),"\n";  # <3
print "\n";

sub f2x($) {    # Funktion mit Prototype
    $i = shift; # 1.Parameter
    return ($i * $i);
}

print 'Returnwert der Funktion f2 :: &f2() = ',&f2x(3),"\n";  # <9

# ============================================================================
# 7) Funktionen - TRACE
# ============================================================================

&dbg_TRACE("7) caller",__FILE__,__LINE__);

#  Mit der Funktion 'caller' kann ein Aufruf zur?ckverfolgt werden.
#  Die Funktion gibt eine Liste zur?ck mit den Werten:
#  Funktionsname : c a l l e r
#  Parameter     : int      - Aufruftiefe
#  ReturnWerte   : Liste
#                   'PackageName', 'FileName', 'Zeilennummer',
#                   'Packagename der aufgerufenen Funktion'
#                   'Kennung ob die Fktn Argumente hat'
#                   'Kennung,ob die Fktn im Listenkontext aufgerufen wurde.

sub fct_C1()
{
    print "function C1()\n";
    &fct_C11();
}

sub fct_C11()
{
    print "function C11()\n";
    for($i=0;((($pckg,$file,$line,$name) = caller($i))&& ($i<5));$i++)
    {
        print "[$i]:Package:$pckg;File:$file;Line:$line;Name:$name\n";
    }
    print "function C11() - use 'dbg_CALL()'\n";
    &dbg_CALL();
}

print "1) Call fct_C1() !\n";
&fct_C1();

# ============================================================================
# 8) Variablen und ihre Namensr?ume in Funktionen ('my', 'local')
# ============================================================================

&dbg_TRACE("8) my und local",__FILE__,__LINE__);

# 'my'    : lokale Variable f?r einen Block oder eine Funktion
# 'local' : lokal gegen?ber der Aufrufer-Funktion, global f?r Sub-Funktionen
#         : 'local' mu? aus historischen Gr?nden verwendet werden bei:
#         : Systemvariablen, Dateihandles

# globale Variablen
$i     = 1001;
$j     = 1002;

sub fct_print()
{
    print "fct_print(): i = $i; j = $j\n";
}

sub fct_my()        # testet 'my'
{
    my $i = 1;      # globales '$i' unver?ndert                 # my
    $j    = 2;      # ?ndert globales '$j'

    print "fct_my(): i = $i; j = $j\n";
    &fct_print();
#   '$i' [fct_1] nicht definiert in 'fct_print',
#   jedoch im dar?ber liegenden Block.
#   Daher wird die globale Variable '$i==1001' ausgegeben.
}

sub fct_local()     # testet 'l o c a l'
{
    local $i = 10;  # globales '$i' unver?ndert                 # local
    $j       = 20;  # ?ndert globales '$j'

    print "fct_local(): i = $i; j = $j\n";
    &fct_print();   #
#   '$i' [fct_2] ist global aus Sicht von 'fct_print'.
#   Daher wird die 'local'-Variable '$i==10' ausgegeben.
}


print "1) Call fct_my() !\n";
&fct_my();      # m y
print "glob(): i = $i; j = $j\n\n";     # < i=1001; j=2
print "2) Call fct_local() !\n";
&fct_local();   # l o c a l
print "glob(): i = $i; j = $j\n";       # < i=10; j=20

# ============================================================================
# 9) Variablen pr?fen
# ============================================================================
l5:
# 9a) defined --- Teste ob eine Variable definiert ist

&dbg_TRACE("9) defined",__FILE__,__LINE__);

$i=1001; $j=1002; $s="Text"; $pi=\$i;

print '1) defined $i',"\n";
(defined $i) ? print 'OK:$i defined' : print 'KO:$i not defined'; print "\n";
print '2) defined $k',"\n";
(defined $k) ? print 'OK:$k defined' : print 'KO:$k not defined'; print "\n";

# 9b) undef  --- L?sche Vars oder Funktionen im package

&dbg_TRACE("undef",__FILE__,__LINE__);

$i=77;
undef $i;
print '1) undef $i',"\n";
if (defined $i) {print 'OK:$i defined';}
else            {print 'KO:$i not defined';};
print "\n";

# 9c) reset --- L?sche globale Variablen

&dbg_TRACE("reset",__FILE__,__LINE__);

$i=1001;
print 'Global Variable $i = ',$i,"\n";
reset 'a-z';    # Vars mit Namen 'a* ... z*' l?schen; hier auch  : >reset 'i';
print "reset a-z \n";
print 'Global Variable $i = ',$i,"\n";


if (defined $i) {print 'OK:$i defined';}
else            {print 'KO:$i not defined';};
print "\n";

# 'reset' wird auch zum Zur?cksetzen von REG's verwendet.

# 9d) ref --- Bestimme den Typ einer Referenz

&dbg_TRACE("ref",__FILE__,__LINE__);

$i=10; $p = $i; #keine Referenz
print '0) ref $p["',$i,'"]=',ref $p,"\n" ;                  # ref $p="SCALAR"

$i=10; $p = \$i;
if (ref $p) {print '1) ref $p["',$i,'"]=',ref $p,"\n" }     # ref $p="SCALAR"

$a=[1,2,3]; $p = \$a;
if (ref $p) {print '2) ref $p["',$a,'"]=',ref $p,"\n" }     # ref $p="REF"

@l=(1,2,3); $p = \@l;
if (ref $p) {print '3) ref $p["',@l,'"]=',ref $p,"\n" }     # ref $p="ARRAY"

%h=(1=>"A",2=>"B",3=>"C"); $p = \%h;
if (ref $p) {print '4) ref $p["',%h,'"]=',ref $p,"\n" }     # ref $p="HASH"

$i=1; $pi = \$i; $p = \$pi;
if (ref $p) {print '5) ref $p["',$pi,'"]=',ref $p,"\n" }    # ref $p="REF"


# ============================================================================
# 10) Typeglobs (Symboltabelle)
# ============================================================================
&dbg_TRACE("10) Typeglobs",__FILE__,__LINE__);

# Namen werden in einer Symboltabelle gespeichert.
# Namen k?nnen gleichgesetzt werden.

# Symbole f?r alle Typen gleichsetzen
$i = 77;
if (defined $j) {print 'OK:$j defined';}
else            {print 'KO:$j not defined';}; print "\n";
print '$i=',$i,';$j=',$j,';',"\n";
print '1) *j = *i',"\n";
*j = *i;    # Variablen i+j s?mtlichen Typs (Hash, Listen, Skalare) gleich
print '$i=',$i,';$j=',$j,';',"\n";

# Symbole f?r einen bestimmten Typs gleichsetzen
$i1 = 77;
@i1 = (1,2,3);
print '$i=',$i1,';$j1=',$j1,';',"\n";
print '@i=',@i1,';@j1=',@j1,';',"\n";
if (defined $j1) {print 'OK:$j1 defined';}
else             {print 'KO:$j1 not defined';}; print "\n";
print '2) *j = \$i1',"\n";
*j1 = \$i1;     # *j1 := skalar-Referenz von i1
print '$i=',$i1,';$j1=',$j1,';',"\n";
print '@i=',@i1,';@j1=',@j1,';',"\n";

# ============================================================================
# Ende
# ============================================================================
l_END:
&dbg_TRACE($PGMNAME,__FILE__,__LINE__);
exit($_iEc);

