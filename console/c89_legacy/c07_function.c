/*  ######################################################################## */
/*  07: Funktionen                                                           */
/*  ######################################################################## */
/*
    encoding: UTF-8
    !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿ
*/
/*  usage: DOS> run.exe [<float-ZAHL1> <int-ZAHL2>]
 *
*/
/*
 *  Inhalt:
 *      +   Proto Typpen
 *      +   Funktions-Teile {HEADER, ARGS, BODY, END}
 *      +   main Funktion
 *      +   normale Funktionen
 *          +   Prozeduren (void Funktionen)
 *      +   rekursive Funktionen
 *      +   Funktionen mit unbestimmter Parameter Anzahl
 *          +   lokale und globale Variablen
 *          +   static und externe Variablen
 *          + Speicherklasse: auto
 */

/*
 *  ***************************************************************************
 *  1) HEADER
 *  ***************************************************************************
 *  ===  KEYWORD:   void
 */

#ifndef __USE_TUTOR__MAIN
    #define INC__TUTOR_LIBRARY
#endif
#include "c00_include.h"
/*  #include    <stdio.h>
 *  #include    <stdlib.h>      * atof() and atoi()
 *  #include    <stdarg.h>      * varg
*/

/*
 *  ***************************************************************************
 *  2) PROTOTYPEN
 *  ***************************************************************************
 */

/*  Prototypen m?ssen in C++, jedoch nicht in C
 *  definiert werden.
 */
char simplePower1(
        float   base,       /* IN:  nur lesender Zugriff */
        int     exponent,   /* IN:  lesend */
        double * result     /* OUT: Ein- und Ausgabe */
                            /* RETURN-WERT:     char */
);
double simplePower2(
        double   base,       /* IN:  nur lesender Zugriff */
        int     exponent     /* IN:  lesend */
                             /* RETURN-WERT:     double */
);

/* Diese Funktion ist vom Type void - sie gibt keinen
 * Wert zur?ck.
 * In anderen Sprachen entspraeche sie einer Prozedur.
 */
void simplePower3(
        float   base,       /* IN:  nur lesender Zugriff */
        int     exponent,    /* IN:  lesend */
        double * result     /* OUT: Ein- und Ausgabe */
                             /* RETURN-WERT:     void */
);

unsigned int simpleFakultaet(
        unsigned int base   /* IN:  int ohne VZ */
       /* R?ckgabe ein char */
);

int f_varType (const char *buf, int id, ...);
/* !!! PROTO-TYP muss sein bei variabler Parameter-Anzahl ! */


double varAdd  (int sumop, ...);


#ifdef  USE__TUTOR_C2CPP
    int cpp_Functions(void);
#else
    #ifndef __cplusplus
        #define C_OLD_STYLE /* !CRQ-190826: not C++*/
    #endif
    /*
     * Der C++ Compiler beachtet auch CodeLines innnerhalb
     * von '#ifdef __cplusplus ... #endif'
     * Soll der C++ etwas ignorieren, muss ein eigenes
     * define gew?hlt werden.
     */
#endif

/*
 *  ***************************************************************************
 *  3) Die main() FUNKTION
 *  ***************************************************************************
 *  === !KEY:   return
 */
int F07_function(int p_iEc)
{
    char    cRetVal = '?';
    float   fBase=2.5;
    int     iExponent=9;
    int     i;
    int     day,month,year;
    int     iValue;
    double  dResult=-1.0;
#ifdef __C_NATIVE
    char    (*p_fct)(float bas, int exp, double *res);
    double  resFct;
    int (*p_printf) (const char*, ...);
    char    *zahl[]= {"1.34","-8.9"};
#endif

    printf("============================================================ \n");
    printf("[C07]:  Funktionen\n");
    printf("============================================================ \n");

    printf("--- compiled:\n");
    printf("DATE=(%s;%s)",__DATE__,__TIME__);
    printf("FILE:[%s]\n", __FILE__);
#ifdef  __cplusplus
    printf("### isC++:=YES\n");
#else
    printf("### isC++:=NO !\n");
#endif

    printf("... I use fBase=%f,iExp=%d\n",fBase,iExponent);

/*
 *  ***************************************************************************
 *  4) FUNKTIONEN mit Pointern
 *  ***************************************************************************
 */
    printf("*** [%s;%d]: power::Input Values \n",__FILE__,__LINE__);

    printf("cRetVal     : %c\n",cRetVal);
    printf("iBase       : %f\n",fBase);
    printf("fExponent   : %i\n",iExponent);
    printf("dResult     : %f\n",dResult);


/*
 *  Call function with ***!NAME:'PARAMETERS'
 */
    printf("*** [%s;%d]: power1::Output Values \n",__FILE__,__LINE__);
    cRetVal = simplePower1(
                    fBase,
                    iExponent,
                    & dResult);
    printf("cRetVal     : %c\n",cRetVal);
    printf("iBase       : %f **\n",fBase);
    printf("fExponent   : %i\n",iExponent);
    printf("dResult     : %f\n",dResult);

    printf("*** [%s;%d]: power2::Output Values \n",__FILE__,__LINE__);
    dResult = simplePower2(
                    fBase,
                    iExponent);
    printf("iBase       : %f **\n",fBase);
    printf("fExponent   : %i\n",iExponent);
    printf("dResult     : %f\n",dResult);

    printf("*** [%s;%d]: power3::Output Values \n",__FILE__,__LINE__);
    simplePower3(
                    fBase,
                    iExponent,
                    & dResult);
    printf("iBase       : %f **\n",fBase);
    printf("fExponent   : %i\n",iExponent);
    printf("dResult     : %f\n",dResult);

/*
 *  ***************************************************************************
 *  5) REKURSIVE FUNKTIONEN
 *  ***************************************************************************
 */

    iValue  = iExponent;
    iValue  = simpleFakultaet(iValue);

    printf("*** [%s;%d]: fak::Output Value (FAK) \n",__FILE__,__LINE__);

    printf("cRetVal     : %c\n",cRetVal);
    printf("iBase       : %d !\n",iExponent);
    printf("= dResult   : %d\n",iValue);


/*
 *  ***************************************************************************
 *  6) FUNKTIONEN mit VARIABLEN Datentypen
 *  ***************************************************************************
 */

    printf("*** [%s;%d]: f_varType \n",__FILE__,__LINE__);

    f_varType("*int",1,4711);
    f_varType("*chr",2, "Zwei",123456789L);
    f_varType("double",3,1.111,2.222,3.333);

/*
 *  ***************************************************************************
 *  7) FUNKTIONEN mit VARIABLER Argumentanzahl
 *  ***************************************************************************
 */

    printf("*** [%s;%d]: varAdd \n",__FILE__,__LINE__);

    dResult = varAdd(3,1.1,2.2,3.3);
    printf("sum:%f\n",dResult);

/*
 *  ***************************************************************************
 *  8) POINTER auf FUNKTIONEN
 *  ***************************************************************************
 */
    printf("*** [%s;%d]: fctPointer \n",__FILE__,__LINE__);

#ifndef __C_NATIVE
    char    (*p_fct)(float bas, int exp, double *res);
    double  resFct;
#endif
    p_fct      =  simplePower1;
    (*p_fct)(2.1F,8,&resFct);
    printf("fctPtr=simplePower::2.1 ** 8 = %f\n",resFct);

#ifndef __C_NATIVE
    int (*p_printf) (const char*, ...);
#endif
    p_printf    = printf;
    (*p_printf)("fctPtr=printf::Hallo Funktions-Pointer\n");

/*
 *  ***************************************************************************
 *  9) andere
 *  ***************************************************************************
 */

    printf("*** [%s;%d]: andere Fktn \n",__FILE__,__LINE__);

    year    = 2007;
    month   = 7;
    day     = 9;
    i       = f_DayOfYear(year,month,day);
    printf("1) DayOfYear(YEAR=%d;MONTH=%d;DAY=%d) =: %d\n",
            year,month,day,i);

    f_MonthDay(2007, i, &month, &day);
    printf("2) MonthDay(YEAR=2007,JDAY=%d) =: MONTH=%d DAY=%d\n",
            i,month,day);

    i = 0;
#ifndef __C_NATIVE
    const char *zahl[]= {"1.34","-8.9"};
#endif
    for(i=0; i<2; i++) {
        printf("ZAHL[%d]:%s\n",i,zahl[i]);
    }
#if TST_QUICKSORT
    f_quickSort(
        (void*) zahl,
        (int)   0,
        (int)   1,
        (int)(f_cmpDoubleStr((void*)zahl[0],(void*)zahl[1]))
    );
#endif


    printf("--- EndOfFile:[%s] at LineNr:[%d] \n",__FILE__,__LINE__);
    return p_iEc;
    /*
     * Der Return-Wert muss mit dem Type der Definition ?bereinstimmen -
     * also int main(...) sollte ein  'int' zur?ckgeben.
     */

} /* F++ */

/*  ######################################################################## */
/*  DEFINITION der eigenen Funktionen                                        */
/*  ######################################################################## */

/*  ======================================================================== */
    char simplePower1(float base, int exponent, double * pResult)
                /* ***!NAME:'ARGUMENTS' of a function */
/*  ======================================================================== */
{
    double  sum=1;
    int     i;
    printf("<<< simplePower1[%d]: base=%f,exp=%i\n",
                __LINE__,base,exponent);

    if (exponent < 0) { exponent=-exponent;};

    for(i=0; i<exponent; i++) {
        sum *= base;
    }

    /* Zuweisungen
    */
    base        = -3;
    exponent    = -11;
    *pResult    = sum;    /* den Wert ?ndern */
    printf("<<< simplePower1[%d]: base=%f,exp=%i;res=%f\n",
                __LINE__,base,exponent,*pResult);
    return('A');
}


#ifdef  C_OLD_STYLE /* not for the C++-Compiler */
/*  ======================================================================== */
    double simplePower2(base, exponent)
           double   base;
           int      exponent;    /* *** ALTER C-Stil */
/*  ======================================================================== */
#else
/*  ======================================================================== */
    double simplePower2(double base, int exponent)
/*  ======================================================================== */
#endif
{
    double  sum=1;
    int     i;
    printf("<<< simplePower2 [%d]: base=%f,exp=%i\n",
                __LINE__,base,exponent);

    if (exponent < 0) { exponent=-exponent;};

    for(i=0; i<exponent; i++) {
        sum *= base;
    }

    /* Zuweisungen
    */
    base        = -3;
    exponent    = -11;
    return(sum);
}

/*  ======================================================================== */
    void simplePower3(float base, int exponent, double * pResult)
/*  ======================================================================== */
{
    double  sum=1;
    int     i;
    printf("<<< simplePower3[%d]: base=%f,exp=%i;res=%f\n",
                __LINE__,base,exponent,*pResult);

    if (exponent < 0) { exponent=-exponent;};

    for(i=0; i<exponent; i++) {
        sum *= base;
    }

    /* Zuweisungen
    */
    base        = -3;
    exponent    = -11;
    *pResult    = sum;    /* den Wert ?ndern */
    printf("<<< simplePower3[%d]: base=%f,exp=%i;res=%f\n",
                __LINE__,base,exponent,*pResult);
    return; /* kein Wert bei void Funktionen */
}

/*  ======================================================================== */
unsigned int simpleFakultaet(unsigned int base)
/*  ======================================================================== */
/*
 *  R E K U R S I V E FUNKTION
 */
{
    if (base <= 1)
        return 1;
    else
        return simpleFakultaet(base-1) * base;
}




/*  ======================================================================== */
int f_varType(const char *buf, int id, ...)
/*  ======================================================================== */
/*  Diese Funktion arbeitet mit verschiedenen
 *  Datentypen
 */
{
    va_list argv;

    va_start (argv, id);

    if (id == 1) {
      int       arg1;
      arg1 = va_arg (argv, int);
      printf("<<< vartype1(%s):ARG1='%d'\n",
            buf,arg1);
    }

    else if (id == 2) {
      char *    arg1;
      long      arg2;
      arg1 = va_arg (argv, char *);
      arg2 = va_arg (argv, long);
      printf("<<< vartype2(%s):ARG1='%s',ARG2='%ld'\n",
            buf,arg1,arg2);
    }
    else if (id == 3) {
      double    arg1,arg2,arg3;
      arg1 = va_arg (argv, double);
      arg2 = va_arg (argv, double);
      arg3 = va_arg (argv, double);
      printf("<<< vartype3(%s):ARG1='%f',ARG2='%f',ARG3='%f'\n",
            buf,arg1,arg2,arg3);
    }
    else {
      printf("<<< vartype?(%s):?\n",buf);
    }
    va_end (argv);

    return(1);
}


/*  ======================================================================== */
double varAdd(int num, ...)
/*  ======================================================================== */
/*  Diese Funktion addiert die Double-Werte
 */
{
    int         i;
    double      sum = 0;
    double      arg;
    va_list argv;
    va_start (argv, num);
    printf("Num=%d\n",num);
    for (i=0; i<num; i++) {
        arg = va_arg(argv, double);
        sum += arg;
        printf("arg:%f\n",arg);
    }
    va_end (argv);
    return(sum);
}

/*  ######################################################################## */

#ifndef __USE_TUTOR__MAIN
int main(int args, char *argv[]) {
    int     iEc = atoi(getenv("v_FWK_exitCode"));
    return  F07_function(iEc);
}
#endif
