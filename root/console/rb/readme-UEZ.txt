=== readme uez

+   Das Projekt
    a)  Erstellt anhand einer ultraEdit-24 Projekt-Datei(uep) eine zip-Datei     *   zip
    b)  oder umgekehrt kann eine zip-Datei auf die Quellen zurückkopieren.  *   unzip
    c)  Ferner kann es uep-Dateien parsen   * parse
    d)  oder selbst eine uep-Datei von einem Directory-Baum erstellen. * build

+   Es wird unterschieden in
    a)  der DOS-Batch-Datei uez.bat
    b)  und der Ruby-Datei  ueZip.rb.

+   Im Editor werden (Projekt-)Werkzeuge definiert, welche
    die Batch-Datei aufruft, die wiederum die Ruby-Datei aufruft.

+   Beispiele für uez.bat Verwendungen

    $   uez         .. oder ...
    $   uez ?       :   Hilfe aufrufen
    $   uez !       :   Standard-Aktionendurchführen (ein zip Kommando)
    $   uez +       :   init der default-parameter
    $   uez zip d:\MY\cfg\IDM\ue24\_prj\UEZ.prj e:\UEZ\src
                    :   Erstellt auf %TMP% eine zip-Datei
    $   uez build BMG d:\BMG\prj\GMFC7 e:\UEZ\uep
                    :   erstellt eine uep-Datei von d:\BMG\prj\GMFC7








           