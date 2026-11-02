# ****************************************************************************
# $PGMNAME="[10]:C/PERL API";
# *****************************************************************************
# call: DOS/LINUX> perl File.pl
# uses: p00.pm
#     : pl10.c           - corresponding C-File
#     : pl10_make.sh     - corresponding Make-File
# Vers: PERL 5.6
# *****************************************************************************

# !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß

use p00;
use Symbol;         # abstract file handles
$iEc = $ENV{v_FWK_exitStatus} + 0;

# ---- INHALT:
# *****************************************************************************
goto l;

l:
&dbg_TRACE("C/PERL",__FILE__,__LINE__);


# ============================================================================
# 1) C calls PERL
# ============================================================================
#
# Die folgenden Funktionen werden von einem C-Programm aus aufgerufen,
# das in dem korrespondierenden C-File 't10.c' steht.
# Das Makefile 't10_make.sh' ?bersetzt dieses File und erzeugt
# ein lauff?higes File 't10.run'.

# Linux:
# gcc myFile.c \
# -I /usr/lib/perl5/5.6.0/i586-linux/CORE \
# -L /usr/lib/perl5/5.6.0/i586-linux/CORE \
# -o myFile.run \
# `perl -MExplils::Embed -e ccopts -e ldopts`


sub perl_show ()
{
    &dbg_TRACE("perl_show",__FILE__,__LINE__);
}

sub perl_power ()
{
    my ($a,$b) = @_;
    &dbg_TRACE("perl_power",__FILE__,__LINE__);
    return($a ** $b);
}

# ============================================================================
# 2) PERL makes C
# ============================================================================

# Hier wird ein C-File generiert.
# Das File benannt als 't10.pl.c'.
# Das Makefile 't10_make.sh' ?bersetzt dieses File und erzeugt
# ein lauff?higes File 't10.pl.run'.

sub fwrite($$)
{
    my  $fp = shift();
    my  $line = shift();
    print ($fp "$line\n");
}


$File = __FILE__ . ".c";       # Name 't10.pl.c'
print "NewFile : $File\n";

my  $fd = gensym();
my  $rc = open  ($fd,">$File"); # '>>' anh?ngen
    fwrite($fd,"#include \<stdio.h\>");
    fwrite($fd,"int main () {");
    fwrite($fd,"\tprintf(\"hello world!\\n\");");
    fwrite($fd,"\tprintf(\"<%s;%s>\\n\",__DATE__,__TIME__);");
    fwrite($fd,"}");
    fwrite($fd,"/*Ende*/");
close($fd);

# ============================================================================
# 3) PERL calls C
# ============================================================================

# Perl kann nicht bequem direkt C-Programme aufrufen.
# Es mu? eine Bibliothek erzeugt werden, die perl-Executable dynamisch/statisch
# l?dt.
# Die Bibiliothek wird in der Sprache 'XS' geschrieben, die Wrapper-Subroutinen
# enth?lt.
#

# 1) Default Dateien

#   Verzeichnis mit Default-Dateien generieren mit dem Tool 'h2xs'
#       >h2xs -A -n t10
#   Es wird ein Verzeichnis 't10' erzeugt.
#   In diesem Verzeichnis stehen die Files:
#       MANIFEST, Makefile.PL, t10.pm, t10.xs, test.pl, Changes

# 2) Arbeit mit der Dir 't10'
#   Die Arbeit mit der Perl-Datei 'hello.pl' ist das Ziel der folgenden
#   Arbeit.
#   Es wird zuerst das File 'Makefile.PL' editiert, anschlie?end das
#   File 'Makefile' mit:
#       >perl Makefile.PL
#   erzeugt.
#   Nach dem Aufruf von:
#       >make
#   werden entsprechende Libraries in den SubDirs der Dir 't10' erzeugt.
#   Anschlie?end ist 'hello.pl' ausf?hrbar mit
#       >perl hello.pl
#   .

# 3) Einbinden von neuen Funktionen
#   Die XS-Datei 't10.xs' wird editiert und C-Statements eingef?gt.
#   Es werden 4 verschiedene M?glichkeiten ausprobiert:
#       1) Es wird die Funktion 'hello()' implementiert, die
#          eine einfache Ausgabe macht. Die entsprechende 'printf' Funktion
#          steht im obigen File.
#       2) Die Funktion 'even()' testet Input-Werte und gibt einen
#          R?ckgabe-Wert (RETVAL) zur?ck.
#          In der Funktion 'hello.pl' wird der R?ckgabe-Wert ausgegeben.
#       3) Die Funktion 'round()' rundet Input-Wert.
#          Es wird ebenfalls ein Wert zur?ckgegeben.
#          Neu ist, es wird die mathematische Library 'lm' verwendet.
#          Diese Angabe mu? im 'Mapefile.PL' vermerkt werden.
#       4) Die Funktion 'hello2()' ruft eine Funktion in der eigenen
#          Library 'libSimple' auf, die ?ber das Script 'makeSimple.sh'
#          erzeugt wird.
#          Es ?bersetzt die Dateien 'libSimple.c' und 'simpleMain.c'.
#          Ferner erzeugt es aus 'libSimple.c' als eine Library und bindet
#          diese mit 'simpleMain.o'.
#          Zu guter letzt wird als Test der Library die Library-Funktion
#          'helloTest()' aufgerufen.
#          *** Dieses Beispiel funktioniert nicht, bzw.
#              die Library 'libSimple.so' wird vom Perl-Interpreter
#              nicht gefunden. ***
#
#

exit($iEc);
__END__