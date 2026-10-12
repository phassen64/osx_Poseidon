/*  ######################################################################## */
/*  01: introduction                                                         */
/*  ######################################################################## */

/*
    encoding: UTF-8
    !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿ
*/

/*
 *  Die Files dieses Projektes sind compilierbar mit einem C-Compiler
 *  gem?? dem ANSI-C Standard von 1989/1990.
 *  Es wurden die folgenden C/C++-Compiler verwendet
 *  a)  der Gnu C-Compiler im Paket MiniGw und
 *  b)  der msvc im msVisualStudio2005.
 *
 *
 *  INHALT:
 *  =======
 *  I)  C-Tutorial
 *      01: Einleitung
 *      02: Daten Typen, Variablen und Konstanten
 *      03: Operatoren
 *      04: Strukturen / complex data types
 *      05: Kontrollstrukturen (Ablaufsteuerung)
 *      06: MACROS
 *      07: Funktionen
 *      08: IO und FileIO
 *      09: System-Funktionen
 *      10: Module, Speicherklassen, externe/globale Variablen
 *
 *  ANM:
 *  ====
 *  Es gibt 3 verwandte C-Tutorials
 *      I       C-Tutorial      :   native C programming
 *      II      C2C++-Tutorial  :   using C with C++ operators
 *      III     C++-Tutorial    :   real C++ programming
 *  In dem C2C++ Tutorial werden alle Sourcen vom C-Tutorial, bis auf c01 und
 *  c10 includiert und ?bersetzt.
 *
 *  SOURCE:
 *  ======
 *      HeaderDateien   : *.h           -   c00.h
            # Das Header-File besteht aus Deklarationen und C-Code.
            # Letzerer wird eingebunden, wenn "INC__TUTOR_LIBRARY"
            # definiert wird in den Source-Files.
 *      C-Dateien       : *.c           -   c01.c...c10.c,c10_a,c10_b.c
 *      C++-Dateien     : *.cpp         -   nur C10_c.cpp
 *      make-Dateien    : make_ALL.bat   # alle C-Dateien compilieren
 *                        make_c10.bat   # das spezielle projekt c10 erstellen
 *                        make.bat       # erstellt genau 1 c-file
 *
 *  TOOLS:
 *  =====
 *      cmd.exe f?r WindowsXP,WIN32
 *      gnu_for_windows-Compiler
 *          gcc.exe 3.4.2
 *          g++.exe 3.4.2
 *          Quelle: http://www.mingw.org/, Version 5.1.3
 *      msVisualStudio8 - cl.exe

 *
 *  Quellen für das Tutorial:
 *  ========================
 *      1)  Programmieren in C - Brian W.Kernighan & Dennis M.Richie, Hanser
 *      2)  C++ kompakt - mitp, Herbert Schildt, 3.Auflage
 *      3)  http://www.roboternetz.de/wissen/index.php/C-Tutorial

 *
 *  MACROS:
 *  =======
 *      USE_TUTOR_C         :   C++ Tutorials oder includiert in C2C++
        USE__TUTOR_C2CPP    :   C2C++ Files
        INC__TUTOR          :   Include c00_include.h
        INC_TUTOR_LIBRARY   :   C-Funktionen, hart codiert, im c00.h Header-File
        __cplusplus         :   build-in c++-Compiler f?r C++ und 'C' files
        __C_NATIVE          :   Stand C89/ISO C90
        __C_ADVANCED        :   better C
        __GNUC__            :   gnu-C/C++ Compiler spezifisch
        _MSC_VER            :   msvc spezifisch
        _WIN32              :   windows32, kann sowohl gnu als auch msvc sein
        _WIN64              :   windows64
        OS_WINDOWS          :   == _WIN32 && _WIN64
 *
 *  DOXYGEN:
 *  ========
 *  Die DoxyGen dokumentation ist GEPLANT.
 *
 *  AUTOR:
 *  P.Hassen, Oktober,2007
*/

/*
 *  =======================================================
 *  reserved c-key words (32)
 *  =======================================================
 *  memClass:   auto, extern, register, static      (4)
 *  varClass:   const, volatile                     (2)
 *  dataType:   char, double, float, int, void      (5)
 *  control :   break, case, continue, default,
                do(x)while, goto, else, for,
                if, switch, while                   (11)
    modifier:   long, short, signed, unsigned       (4)
    anyType :   enum, struct, typedef, union        (4)
    operator:   sizeof, return                      (2)     : S=32


 *  Anm: Neu erkl?rte Key words werden in diesem Tutrial
 *  gekenzeichnet durch ein '!' und dem Wort 'KEYWORD'.
 *  Das '!' entf?llt bei der zweiten oder dritten Verwendung.
 *
 *  =======================================================
 *  some meta-characters
 *  =======================================================
 *  bool    :   {'&&','||,'!',...}
 *  assign  :   {'=',',','+=','-=','*=',...}
 *  char    :   {''','"','\'};
 *  control :   {'{','}',';'}
 *  comment :   {'/ *', '*\/' }
 *
 *  =======================================================
 *  !EYE Catcher
 *  =======================================================
 *  KEY:    keyword
 *  OPR:    operator
 *  FCT:    function
*/


/*  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

*   usage:
        *   compile, then link, then run
        $>  gcc -c c01_intro.c -o c01_intro.obj         *   compiling
        $>  gcc c01_intro.obj -o c01_intro.exe          *   linking
        $>  ./c01_intro.exe
        $<  hello,World!

*   usage:
        *   compile + link, then run
        $>  gcc c01_intro.c -o c01_intro.exe            *   compile+link
        $>  ./c01_intro.exe
        $<  hello,World!

*   &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& */


#include "c00_tutorC89_1_base.h"

int main() {
    printf("hello,World!\n");
    return 100;
}

