# *****************************************************************************
$PGMNAME="[8]:Sondervariablen und besondere Funktionen ";
# *****************************************************************************
# call: DOS/LINUX> perl File.pl
# uses: p00.pm
# Vers: PERL 5.0
# *****************************************************************************

# !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß

use p00;
$iEc  = $ENV{v_FWK_exitStatus} + 0;

# use perl_5;
#
# ---- INHALT:
#
#   1) Sondervariablen
#   2) Slices und Matrizen
#   3) Listen als Argumente
#   4) Hashes als Argumente
#   5) Netzwerk Funktionen
#   6) Proze?-Funktionen
#   7) Uebungs-Aufgabe : compare Files

# *****************************************************************************

# goto l6;

# ============================================================================
# 1) Sondervariablen
# ============================================================================
=pod
Var         Bedeutung       Verwendung      Status
------------------------------------------------------------------------------
%ENV        Environment                     ok
%INC        Include Files                   ok
@INC        Include Dirs                    ok
@EXPORT     stnadardm??iger export          ok
$PATH       Suchpfad                        nok
$HOME       HomeDir         chdir()         nok
$LOGDIR     HomeDir         chdir()         nok
$^O         OsName                          ok
$^T         StartTime                       ?
$OSNAME     OsName in EnglishModule         nok
------------------------------------------------------------------------------
=cut

&dbg_TRACE("1) Sonder-Vars",__FILE__,__LINE__);

# -- Include Path
BEGIN {
    $INC{'Exporter.pm'} = 1;
    use Exporter;
    #Selbst das wichtige Modul 'Exporter' einbetten
    #Dadurch wird auch import() definiert.
    # @ISA = ('Exporter');  #Neue Module sind im Exporter.
    @ISA = qw(Exporter);
}
print "a)   \@INC=          ",@INC,"\n";
print "b)   \@ISA=          ",@ISA,"\n";
&dbg_printList(\@INC);                  # s.unten
print "\n";

# -- GlobVars
print "1)   \%ENV=          ",%ENV,"\n";
print "2)   \$PATH=         ",$PATH,"\n";
print "3)   \$HOME=         ",$HOME,"\n";
print "4)   \$LOGDIR=       ",$LOGDIR,"\n";
print "5)   \@EXPORT=       ",@EXPORT,"\n";
print "6)   \@EXPORT_OK=    ",@EXPORT_OK,"\n";
print "7)   \$^O =          ",$^O,"\n";

do "english.pm";            # use 'English' here
print "8)   \$OSNAME =      ",$OSNAME,"\n";

# -- Umgebungsvariablen
l:
&dbg_TRACE("1a) Sonder-Vars usage",__FILE__,__LINE__);

print ("OS ist : \" $^O \" \n");
if ($^O =~ /MS/) {
    print "Windows Modul!\n";
#   eval 'use windowsModule'
}
else {
    print "Not Windows Modul!\n";
#   eval 'use linuxModule'
}

# -- Prozess-Variablen

print "a) ProcessId \$\$   =        ",$$,"\n";
if (($^O =~ /MS/) || ($^O =~ /linux/)) {
#    sleep(5);       # sleep 5 seconds - time for check the ProcessId
}

$StartTime = $^T;
print "b) StartTime \$\^T  = ",$StartTime," => ";
&dbg_printTime($StartTime);
print "\n";
# __END__

# ============================================================================
# 2) Slices und Matrizen
# ============================================================================
# slice, eval(), arrays

package main;
l3:
&dbg_TRACE("3) Slices",__FILE__,__LINE__);

@L      = ('a'..'z');                       # Aufz?hlungsliste
@SL    = @L[0,3,5,15];                      # SLICE auf Liste
print "a) Slice\n";
print "Slice<";
$i=0;
foreach $l (@SL)
{
    $i++;
    print "[$i]:'$l';";
}
print ">\n";

print "\nb) unechstes 2 dimensionales Array\n";
@l1 = ('a','b','c');
@l2 = ('A','B','C');
@matrix = (@l1,@l2);    # Listen 'l1' und 'l2' werden zusammengelegt
print "Matrix <@matrix>\n";

print "\nc) echtes 2 dimensionales Array mittels Listen\n";
@zeile1 = ('a','b','c');        # 3 Spalten
@zeile2 = ('A','B','C');        # 2 Zeilen
@matrix = (\@zeile1,\@zeile2);  # jetzt Referenzen
print "Matrix <@matrix>\n";
print "Matrix <";
for($i=0; $i<2; $i++) {
    for ($j=0; $j<3; $j++) {
            print "[$i][$j]:$matrix[$i][$j];";
    }
}
print " >\n";

print "\nc1) Zugriff auf einzelne Komponenten\n";
$ref1   = $matrix[0];
@z1     = @$ref1;
print "Z1               : @z1\n";
print "Zeile1           : @{$matrix[0]}\n";
print "Zeile2           : @{$matrix[1]}\n";
print "matrix[1]->[1]   : $matrix[1]->[1]\n";
print "matrix[1][2]     : $matrix[1][2]\n";

print "\nd) 2 dimensionales Array aus einzelnen Arrays\n";
@matrix = (['a','b','c'],['A','B','C']);
print "Matrix <@matrix>\n";
print "Matrix <";
for($i=0; $i<2; $i++) {
    for ($j=0; $j<3; $j++) {
            print "[$i][$j]:$matrix[$i][$j];";
    }
}
print ">\n";

print "Matrix <";
foreach $ref_zeile (@matrix) {
    foreach $spalte (@$ref_zeile) { print "$spalte; " }
}
print ">\n";


# ============================================================================
# 3) FunktionsParameter: Liste
# ============================================================================

&dbg_TRACE("3) Argument: Funktionen",__FILE__,__LINE__);

sub printList ()
{
#   IN: ptr auf eine Liste
    my $ptrList = shift;
#   if (!ref $ptrList) {die("ERROR:printList")}; - bricht Perl Proze? ab!

#   Liste steht jetzt in @{$ptrList}

    print "LISTE0=<",@{$ptrList},">\n";  # einfache Ausgabe

    print "LISTE1=<";
    $i=0;
    foreach  (@{$ptrList}) {
        $i++;
        print "[$i]:'$_'; ";
    } # Ausgabe aller Listenelemente, aktuelles ist : '$_'
    print ">\n";

    print "LISTE2=<";
    $i=0;
    foreach $l (@{$ptrList}) {
        $i++;
        print "[$i]:'$l'; ";
    } # Ausgabe aller Listenelemente
    print ">\n";

    print "LISTE3=<";
    for($i=1,$l="Init"; ($i<10) && ($l ne ""); $i++) {
        $l = (@{$ptrList})[$i];
        print "[$i]:'$l'; ";
    } # Ausgabe bis leeres l
    print ">\n";

} # printList

# --- Liste ausgeben

@l = (a,b,c,d);
print "\na) printList(@l)\n";
&printList(\@l);

print "\nb) dbg_printList(@l)\n";
#oder
&dbg_printList(\@l);        # use Include Module !
&dbg_printList(@l);         # Fehler: keine Referenz

# --- Listen addieren - Funktionen mit ProtoType

sub addLists (\@\@)         # protoType
#   IN: \@ptrL1, \@ptrL2
{
    my ($pL1,$pL2) = @_;
#   eleganter als:  my $pL1 = shift; my $pL2 = shift;
    my @eL  = ();       # leere Liste erzeugen

    foreach (0..$#$pL1)     # Sonderbedeutung '$#$ptrVar'
    {
        $eL[$_] = $$pL1[$_] + $$pL2[$_];    # '$_' anstelle von $i
    }
    return(@eL);
} # addLists

@l1 = (1,2,3);
@l2 = (4,5,6);
@e = addLists(@l1, @l2);
# Liste k?nnen ohne Adress-Operator '\' angegeben werden
# es darf aber kein '&' vor dem Funktionsaufruf stehen.

print "\nc) addLists(@l1 , @l2) =: @e\n";

print "\nd')dbg_printList2(@l1)\n";
dbg_printList2(@l);         # kann ohne '&' aufgerufen werden
print "\n";


# ============================================================================
# 4) FunktionsParameter: Hashes
# ============================================================================

&dbg_TRACE("4) Argument: Hashes",__FILE__,__LINE__);

sub printHash() {
    my $ptrHash = shift;
    for ($i=1;($key,$obj) = each(%{$ptrHash}); $i++)
    {
        if ($i == 1) {print "    HASH=:"};
        print "[$i]:$key=>$obj;";
    }
    print "\n";
}

%h=(k1,"Name",k2,"PLZ",k3,"Ort");
# print "a)  print(%h)",&printHash(\%h),"\n";   # ERR: Reihenfolge !
print "a)  print(%h)\n";
&printHash(\%h);
# Ok: &dbg_printHash(\%h); - Test
print "\n";

# ============================================================================
# 5) Netzwerk-Funktionen
# ============================================================================
l6:
# Umgebungsvariablen
&dbg_TRACE("5) Netzwerk",__FILE__,__LINE__);  print "\n";

use Socket;

# --- gethostbyname()           * Host Name  -NOK-
# $name = gethostbyname();

# --- gethostbyaddr()           * Host Addr -NOK-
# ($name, $alias, $addrType, $len, @addrs) = gethostbyaddr('fr121458');
# ($name, $alias, $addrType, $len, @addrs) = gethostbyaddr();
# ($name, $alias, $addrType, $len, $l1, $l2, @addrs) = gethostbyaddr();

# --- getnetbyname()            * Net Addr -OK-
# ($name, $alias, $addrType, $len, $net) = getnetbyname('loopback');
print "getnetbyname : ";
# print join ':',getnetbyname('loopback');
eval { print join ':',getnetbyname('loopback');};
&dbg_checkError(__FILE__,__LINE__);
print "\n";

# --- getgrgid()                * GrpId -NOK-
# eval {my ($name, $passwd, $gif, $members) = getgrgid()}; # [1,S.169]
# &testError(__FILE__,__LINE__);
# print "getgrpid : $name = $members \n";
print "\n";

# ============================================================================
# 6) Proze?-Funktionen
# ============================================================================
# Sondervariable: $^O  * OsName *
# l:
&dbg_TRACE("6) Prozesse",__FILE__,__LINE__);

eval {$pid = fork;};
&dbg_checkError(__FILE__,__LINE__);

if (!defined($pid==0)) {
    print "Err:fork!\n";
}
elsif ($pid == 0) {
    print "Child!\n";
    sleep(10);
}
else {
    print "Father!; ChildId: $pid\n";
}

&dbg_TRACE("Ende",__FILE__,__LINE__);


# ============================================================================
# 7) Uebungsaufgabe: Cmp Files
# ============================================================================
# Vergleiche Files
# - mit unterschiedlichem Directory-Pfad
# - mit gleichem File-Namen
# FilePathName := DirName/FileName

&dbg_TRACE("7) find+diffFiles",__FILE__,__LINE__);

$DIRSEP     = '/';
$MAXFILES   = 20;

sub diffFile () {
    $file1   = shift();
    $file2   = shift();
    $file    = shift();
    system ("diff $file1 $file2 >$file");
    @l          = stat($file);
    $fileSize   = $l[12];
    print "$file;SZ=$fileSize";
    if ($fileSize == 0)
    {
        rename($file,"Tmp.diff");    # no remove() in Perl
    }
}

sub findFile () {

# if (Dir1:fileName == Dir2:fileName)

    $str    = shift();
    $dir1   = shift();
    $dir2   = shift();

    print "Dir1     : $dir1\n";
    print "Dir2     : $dir2\n";

    $pat    = "*.".$str;
    print "Pattern  : $pat\n";

    $path1  = $dir1."/";
    $file1  = $path1.$pat;
    print "path1    : $path1\n";
    print "File1    : $file1\n";

    $path2  = $dir2."/";
    $file2  = $path2.$pat;
    print "path2    : $path2\n";
    print "File2    : $file2\n";

#   $pat    = "t*.pl";

    @l1     = glob $file1;
    @l2     = glob $file2;

    print "\nAusgabe:\n";
    for ($i=1; $i < $MAXFILES; $i++)
    {
        $file   = @l1[$i];
        if (defined $file) {
            if ($file eq "") {
                last;
            };
        }
        else {
            warn "Undefined FILE";
            exit;
        }
        $r      = rindex($file,$DIRSEP);
        $l      = length($file);
        $fileX  = substr($file,$r+1,$l-$r);
        print ("$file($i)=>");   # Ausgabe
        print ("$fileX($i);\n");    # Ausgabe
        $FILE1  = $file;

        for ($j=1; $j < $MAXFILES; $j++)
        {
            $file   = @l2[$j];
            if ($file eq "") {last};
            $r      = rindex($file,$DIRSEP);
            $l      = length($file);
            $fileY  = substr($file,$r+1,$l-$r);
            $FILE2  = $file;
            print "$fileY;";
            if ($fileX eq $fileY)
            {
                print ("$FILE1($i)==$FILE2($j);");
                $file = "$fileX"."\.diff";
#               ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                &diffFile($FILE1,$FILE2,$file);
#               ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                print "\n";
                last;
            }
        }
    }
}

#   FUNKTION klappt nicht immer
#   &findFile("pl","p00.pl",".");

exit($iEc);
