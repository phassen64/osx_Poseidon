/*  ######################################################################## */
/*  01: Einleitung                                                           */
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
 *  Quellen f?r das Tutorial:
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

/*  =======================================================
 *  Includes
 *  =======================================================
 */

 /* !CRQ-240514:manual set __USE_TUTOR__MAIN
 *  MsVs20XX sollte "__USE_TUTOR__MAIN" setzen
  */

#if 0
    #if defined(_MSC_VER)
        #define __USE_TUTOR__MAIN
    #elif defined(__BORLANDC__)
        #define __USE_TUTOR__MAIN
    #endif
#endif

  /* initialize functions only here*/
#ifndef __USE_TUTOR__MAIN
    #define INC__TUTOR_LIBRARY
#endif
#include "c00_include.h"    /* eigenes Header-File                */

/*  =======================================================
 *  FUNKTIONEN
 *  =======================================================
 */
int F01_intro(int);

/*  -------------------------------------------------------
 *  Funktions-Kopf
 *  -------------------------------------------------------
 */
int F01_intro(int p_iEc)
{

/*  -------------------------------------------------------
 *  PROGRAMM Body
 *  -------------------------------------------------------
 */
    printf("============================================================\n");
    printf("[C01]: Hello C89!\n");   /* eine Ausgabe eines Textes */
    printf("============================================================\n");

    /* Ausgabe von Werten, die vom PreProcessor (PP)
     * vor dem Compilier-Vorgang generiert werden
     */
    printf("--- FILE:%s,DATE={%s-%s}\n",
            __FILE__,
            __DATE__,
            __TIME__);

    /* PreProcessor Kommandos */

    /*
     * Ist eine PP-Predefinition
     * eines C++-Compilers gesetzt ?
     *
    */

#ifdef  __STDC__
    /* not defined in C++ */
    printf("--- isSTANDARD_C = <%d>\n",__STDC__);
#endif

#ifdef  __cplusplus
    printf("--- isC++:=YES\n");
#else
    printf("--- isC++:=NO !\n");
#endif

    printf("--- COMPILER:");
#if defined(_MSC_VER)
    printf("'_MSC_VER'\n");
#elif defined(__GNUC__)
    printf("'__GNUC__'\n");
#elif defined(__BORLANDC__)
    printf("'__BORLANDC__'\n");
#else
    printf("'??? UNKNOWN'\n");
#endif


/*  -------------------------------------------------------
 *  RETURN
 *  -------------------------------------------------------
 */
    printf("--- EndOfFile:%s at LineNr:%d \n",__FILE__,__LINE__);
    return(p_iEc);       /* integer return-Wert */
                    /* I.d.R. bedeutet '0' kein Fehler */
}

#ifndef __USE_TUTOR__MAIN
int main(int args, char *argv[]) {
	#ifdef _MSC_VER
  	  	#define _CRT_SECURE_NO_WARNINGS
    		#pragma warning( disable : 4996 )
    #endif
/*  -------------------------------------------------------
 *  Get Environment Variable
 *  -------------------------------------------------------
 */
    int     iEc = atoi(getenv("v_FWK_exitCode"));
    return  F01_intro(iEc);
}
#endif
