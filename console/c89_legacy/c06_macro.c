/*  ######################################################################## */
/*  06: PP (PreProcessor)                                                    */
/*  ######################################################################## */
/*
    encoding: UTF-8
    !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿ
*/

/*
 *  USAGE:      >run.exe ...
 *  COMPILE:    cpp file.c...-DTESTx;   with x={1|2}
 */

/*
 *  *** 1) KOMMENTARE
 *  KOMMENTARE von vom C-PP in der Form '/ *....* /' unterstuetzt.
 *  Der einzeilige Kommentar '//....'(EOF) wird nicht unterstuetzt.
 *  Ausserdem duerfen Kommentare nicht geschachtelt werden.
 */

/*  *** 2) Direktive
 *
 *  #include                        : include a file
 *  #define #undef                  : define variables
 *  #defined #undef                 : #if (defined var); undef the var
 *  #if #else #elif #endif          : program control
 *  #ifdef                          : short form of #if defined
 *  #pragma                         : compiler dependent control
 *  #line                           : change __FILE__ or __LINE__
 *  #error                          : compiler stops
 *
 *  Examples and Hints:
 *      #ifdef X  == #if defined (X)    * is the same OP
 *      #if defined (X1) || !defined (X2) || defined (X3)
 */

 /* *** 3) PP Operatoren
  * #       : convert into ""
  * ##      : concat
  */

 /* *** 4) Macro Names
  * {__LINE__, __FILE__, __DATE_,__TIME__, __STDC__, __cplusplus }
  */

/*  ######################################################################## */
/*  PP statements for main()                                                 */
/*  ######################################################################## */

#if ((defined(_WIN32) || defined(_WIN64)) && defined(__MSC_VER))

    /* Ein Symbol, dass der WINDOWS-PP kennt..
    */
    #define   COMPILER_WINDOWS


    #define  _CRT_SECURE_NO_DEPRECATE
    /*
     * fopen() generiert ansonsten eine warning
    */
    #pragma warning (disable: 4514)
    /*
     * Eine 'pragma' Direktive ist eine implementierunsabh?ngige
     * Direktive.
     * Sie steht f?r Anweisungen, die nur von einem bestimmten
     * Compiler verwendet werden sollen.
     */

#endif /* defined(_WIN32) && defined(__MSC_VER) */

#include <stdio.h>  /* Old comment C-style for old-C */
                    /* Der PP-C kennt keine Kommentare '//' */
/* Ein System-File includieren.
 * Der Filename wird in ein <...> eingeschlossen.
 * Das 'h' kann in C++ weggelassen werden.
 * Der PP sucht das File in dem PATH-Verzeichnissen.
 */

/*
 * Der 64-bit long type ist in C99 als 'long long'
 * und in Windows als __int64 definiert.
 */
 /*  !CRQ-240515:RAD:'#error' is really working -- added 'Borland' */
#if defined(COMPILER_C99)
    typedef long long   long64;
#elif defined(COMPILER_WINDOWS)
    typedef __int64     long64;
#elif defined(__GNUC__)
#elif defined(_MSC_VER)
#elif defined(__BORLANDC__)
#else
    #error This compiler is not supported.
#endif


/* Ein eigenes File includieren.
 * Der Filename wird in ein "..." eingeschlossen.
 * Dadurch sucht der PP das File in dem PATH-Verzeichnissen und
 * in dem aktuellen Verzeichnis
 */
#ifndef __USE_TUTOR__MAIN
    #define INC__TUTOR_LIBRARY
#endif
#include "c00_include.h"


/*  ######################################################################## */
/*  PP statements in main() und den Fktn                                     */
/*  ######################################################################## */

int F06_macro(int p_iEc)
{
#ifdef __C_NATIVE
    char    *str="ABCDEFGH";        /* no QSTR in C_NATIVE */
    int     i1 = 11, i2 = 12;
#endif
    printf("============================================================\n");
    printf("[C06]:  Der C-PP und seine MACROs\n");
    printf("============================================================\n");

/*  ------------------------------------------------------------------------ */
/*  Sinnlose Anweisungen auskommentieren      {#if 0}                        */
/*  ------------------------------------------------------------------------ */

#if 0
    Schwachsinn....
#endif


/*  ------------------------------------------------------------------------ */
/*  predefined MACRO-Name's                   {__DATE__...}                  */
/*  ------------------------------------------------------------------------ */

    printf("*** [%s;%d]: MACRO Namen\n",__FILE__,__LINE__);

    printf("\t__DATE__    :<%s>\n",__DATE__);
    printf("\t__TIME__    :<%s>\n",__TIME__);
    printf("\t__FILE__    :<%s>\n",__FILE__);
    printf("\t__LINE__    :<%d>\n",__LINE__);

#ifdef  __cplusplus
    printf("\t__cplusplus :C++:=YES\n");
#else
    printf("\t__cpluslus  :C++:=NO !\n");
#endif

#ifdef  __STDC__
    printf("\t__STDC__    :=YES\n");
#else
    printf("\t__STDC__    :=NO !\n");
#endif

/*  ------------------------------------------------------------------------ */
/*  MACRO-Values                                {#define}                    */
/*  ------------------------------------------------------------------------ */

    printf("*** [%s;%d]: MACRO Values\n",__FILE__,__LINE__);
/*
 *  Macro-Values oder Macro-Konstanten sind feste Werte, die f?r
 *  die Zuweisung an Variablen verwendet werden k?nnen.
 *  Sie entsprechen der Syntax einer MACRO-String,
 *  werden aber anders verwendet.
 */

    /*
     * Die Modifier 'l','ul','f',...
     * k?nnen gross oder klein geschrieben werden
     */

    #define VAR_VALUE_int               123
    #define VAR_VALUE_long              -987654321l
    #define VAR_VALUE_unsigned_long     1234567890ul
    #define VAR_VALUE_float             -9.12345f
    #define VAR_VALUE_char              '!'
    #define VAR_VALUE_string            "abcdef"
    #define VAR_VALUE_double            7.89e-2


    /*
     * ANM: Die MACRO-Values koennen auch zuerst Variablen zugewiesen
     * werden, bevor sie ausgegeben werden
     */
    printf("    ... Elementare Variablen Werte\n");
    printf("\tchar              : %c\n",VAR_VALUE_char);
    printf("\tint               : %d\n",VAR_VALUE_int);
    printf("\tfloat             : %f\n",VAR_VALUE_float);
    printf("\tdouble            : %g\n",VAR_VALUE_double);

    printf("    ... Spezielle Werte\n");
    printf("\tstring            : %s\n",VAR_VALUE_string);
    printf("\tlong              : %ld\n",VAR_VALUE_long);
    printf("\tunsinged long     : %ld\n",VAR_VALUE_unsigned_long);


/*  ------------------------------------------------------------------------ */
/*  MACRO-Operator  quoteString   {#}                                        */
/*  ------------------------------------------------------------------------ */
    printf("*** [%s;%d]: MACRO-OP quote-Str with '#'\n",__FILE__,__LINE__);

    #define QSTR(x)      # x
            /* Die Funktion QSTR quotet den Parameter
             * also aus 'x' wird '"x"'.
             */
#ifndef __C_NATIVE
    char    *str=QSTR(ABCDEFGH);
#endif
    printf("\tQSTR(x) = %s\n",str);


/*  ------------------------------------------------------------------------ */
/*  MACRO-Operator Concatenate  {##}                                         */
/*  ------------------------------------------------------------------------ */
    printf("*** [%s;%d]: MACRO-OP concat with '##'\n",__FILE__,__LINE__);

    #define CONCAT( a, b )  a ## b
    #define XCONCAT(a,b)    CONCAT(a,b)
#ifndef __C_NATIVE
    int i1 = 11, i2 = 12;
#endif
    #define PRINTv(x)       printf("\t...CONCAT(i,x)=%d\n",CONCAT(i,x))
    PRINTv(1);              /* prints 'i1' */
    PRINTv(2);              /* printf 'i2' */

/*
 *  **************************************************************************
 *  Ablaufsteuerung
 *  Die Ablaufsteuerung geschieht durch die Verwendung von
 *  Macro-Strings und PP-Commands.
 *  **************************************************************************
 */

/*  ------------------------------------------------------------------------ */
/*  Ablaufsteuerung mit MAKRO-Strings  {#if, #elif, #else, #endif, #error}   */
/*  ------------------------------------------------------------------------ */

/*
 *  Der Aufrufer hat beim Compilieren ein PP macro string eingegeben
 *  Bei gnuC geschieht dies durch:
 *  DOS>gcc <file.c> -D<macString>
 *  Kommando ausgegeben.
 *  Ein Macro-String wird also durch den AUFRUF des C-Compilers
 *  definiert.
 */
    printf("*** [%s;%d]: Steuerung: Externe Macro-Strings -D<MacroString>\n",
                __FILE__,__LINE__);

    printf("Externe Macro-String TEST1 oder TEST2 gesetzt ?\n\t");

    #define TEST1 1     /* !CRQ-230309:avoid errors */

    #if TEST1
        printf("ja:=TEST1.\n");
    #elif TEST2
        printf("ja:=TEST2.\n");
    #else
        #error  ...please define TEST1 or TEST2 /* c-error ! */
    #endif

/*  ------------------------------------------------------------------------ */
/*  Ablaufsteuerung::Interne MACRO-Strings  {#define, #undef, #ifndef}       */
/*  ------------------------------------------------------------------------ */
    printf("*** [%s;%d]: Steuerung:Interne Macro-Strings\n",__FILE__,__LINE__);

    #define NAME  "Willy"
            printf("\tmacro NAME1 = (%s)\n",NAME);
    #undef  NAME
    #ifndef NAME
            #define NAME    "Otto"
    #endif
    printf("\tmacro NAME2 = (%s)\n",NAME);


/*  ------------------------------------------------------------------------ */
/*  MACRO-statement {'#Line#'}                                               */
/*  ------------------------------------------------------------------------ */
    printf("*** [%s;%d]: Line\n",__FILE__,__LINE__);

    printf("a)  vars={__LINE__:'%d',__FILE__:'%s'}\n",__LINE__,__FILE__);
    printf("... use #line 4711 Macro-Test-File\n");
    #line   4711 "Macro-Test-File"
    printf("b)  vars={__LINE__:'%d', __FILE__:'%s'}\n",__LINE__,__FILE__);

/*  ######################################################################## */
    printf("--- EndOfFile:[%s] at LineNr:[%d] \n",__FILE__,__LINE__);

    return (p_iEc);
}


#ifndef __USE_TUTOR__MAIN
int main(int args, char *argv[]) {
    int     iEc = atoi(getenv("v_FWK_exitCode"));
    return  F06_macro(iEc);
}
#endif
