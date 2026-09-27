# !/perl/bin   # Diese Zeile mu� manchmal am Anfang stehen

#   encoding: UTF-8
# !$@�����������������������������������������������������������������

# ############################################################################
# Tutorial �bersicht
# ############################################################################
# Aufruf dieses Perl-Scripts:   >perl -w Name.pl
# Perl-Source Dateien haben die Endung "*.pl";
# Sie werden gestartet durch:
# >perl File.pl
# Dieses Tutorial setzt Perl-Include Dateien (Endungen: *.pm) voraus.
# Dort sind Funktionen und Macros enthalten, die in jedem Script
# verwendet werden.
# ============================================================================

# 01 : �bersicht
# 02 : Einf�hrung
# 03 : Bedingungsanweisungen, Schleifen
# 04 : Packages, Scripts, Funktionen, Variablen
# 05 : Systemfunktionen (mathem., convert, listen, regs, str, format)
# 06 : Files, Verzeichnisse
# 07 : Regs
# 08 : Sondervariablen und besondere Funktionen
# 09 : Klassen
# 10 : Perl-C Schnittstelle

# ============================================================================
# 1) Aufruf eines Perl-Scripts
# ============================================================================

# perl [Optionen] <PerlScript>.[Extension]

# Optionen :
# -h : Hilfetext
# -v : Version des Perl-Interpreters
# -c : compile only - don't start the PerlScript
# -d : start debugging the PerlScript
# -D : set debugging flags
# -w : enable useful 'warnings'
# -W : enable all 'warnings'
# -X : disable all warnings
# -e : online programm
#      Bsp.> perl -e 'print -s "t01.pl"; print "\n"'
#      DateiSize(FILE=t01.pl) und Zeilenvorschub
# -S : start PerlScripts by using '$PATH'

# Extension :
# pl  : �bliche Extension
# plx : sonst

printf("..hello Perl !\n");
printf("File    : %s\n",__FILE__);      # Filename ohne Pfad
printf("Zeile   : %d\n",__LINE__);      # Zeilennummer
# printf("Package : %s\n",__PACKAGE__);   # Packagename (== 'main')


# ============================================================================
# 2) Komentare in Perl-Scripts
# ============================================================================

# 2a) Zeilen-Kommentar
#     Alle Zeilen die mit einem '#' eingeleitet werden sind Kommentar-Zeilen

# 2b) Dokumentation
#
=pod  Start der Dokumentation nach 'pod'
Dokumentation
=cut  Ende der Dokumentation nach der Zeile mit '=cut'
# ProgrammText

# ============================================================================
# 3) get Environment
# ============================================================================

$iEc = $ENV{v_FWK_exitCode} + 0;
print "iEc: $iEc";
exit $iEc;
