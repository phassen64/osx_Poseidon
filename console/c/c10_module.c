/*  ###################################################################### */
/*  10: MODULE                                                             */
/*  ###################################################################### */
/*
    encoding: UTF-8
    !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿ
*/
/*
 *  Thema:
 *      +   HP und UP
 *      +   static, extern, auto, register
 *      +   gobal, local
 *  weiteres:
 *      +   Aufruf von anderen Modulen unter Windows (siehe ANMERKUNG)
 *  ANMERKUNG:
 *      --- Mit 'Modulen' sind andere obj-Files gemeint.
 *      Andere *.exe Files (==Applikationen) werden entweder
 *          a) mit system("file.exe") oder
 *          b) ?ber Sockets oder SharedMemory
 *      aufgerufen werden (hier: mehrere main()).
 *      Fall a) ist in gnu.pl realisiert und dient dem
 *      Aufruf des C-Compilers.
 *      --- Hier werden 'Module' betrachtet,
 *      die mit dem C-Linker zu einem File gebunden werden.
 *      Es existiert daher nur ein einziges main().
 *
 */
#ifndef __USE_TUTOR__MAIN
    #define INC__TUTOR_LIBRARY
#endif
#include "c00_include.h"

/*  global variable */
char         gStr[]="This is the global str.";

/*  global static variable */
static  char gstaticStr[80]="Hauptmodul";
             /* Der Name gstaticStr wird auch von anderen Modulen
                verwendet.
                Jedoch ist der Speicherplatz ein anderer.
              */

extern  int     cFct(int i);            /* module C         */
extern  int     c2cppFct(int i);        /* module C2C++     */
extern  int     cpp2cFct(int i);        /* module C++2C     */

/*
 *  Funktionen aus C++ files kann ich nicht aufrufen,
    wie geht das ?
 */



/*  ======================================================================== */
int local_fct(void)
/*  ======================================================================== */
{
    static  int i=0;
    i ++;
    printf("*** [%s;%d]::local_fkt:  i=<%d>\n",
                __FILE__,__LINE__,i);
    return(i);
}


/*  ======================================================================== */
int F10_module(int p_iEc)
/*  ======================================================================== */
{
/*  In C++ m?ssen Speicherklassen > v o r < dem CODE
 *  initialisiert werden.
 */
#ifdef  USE_EXTERN
    int         i,iSRC;
#endif

/*  c-keyword 'auto' invalid in c++ */
#ifndef __cplusplus
    auto
#endif
    int     a1 =0;

    register    int     reg1=4711;
    const       float   const1=-1.23F;
    volatile    float   vol1=5.9F;

    printf("============================================================ \n");
    printf("[C10]:  modules\n");
    printf("============================================================ \n");
    printf("--- compiled:");
    printf("DATETIME=(%s;%s)",__DATE__,__TIME__);
    printf("FILE: [%s]\n", __FILE__);
    printf("START:%s\n",F_TIME());

#ifdef  __cplusplus
    printf("### isC++:=YES\n");
#else
    printf("### isC++:=NO !\n");
#endif

/*
 *  ***************************************************************************
 *  Speicherklassen
 *  ***************************************************************************
 *  === !KEY:   auto
 *  === !KEY:   register
 *  === !KEY:   extern
 *  === !KEY:   volatile
 *  auto, register, extern, const, volatile, (static (s.u.))
 */
    printf("------------------------------------------------------------ \n");
    printf("*** [%s;%d]: mem class \n",__FILE__,__LINE__);
    printf("------------------------------------------------------------ \n");

    printf("---  auto\n");
    printf("auto int auto1: %d\n",a1);

    printf("---  register\n");
    printf("register int reg1: %d\n",reg1);

    printf("---  const\n");
    printf("const float const1= <%f>\n",const1);

    printf("---  volatile\n");
    printf("volatile float vol1= <%f>\n",vol1);

    printf("*** [%s;%d]: static.local \n",__FILE__,__LINE__);

/*
 *  ***************************************************************************
 *  Globale Variablen: { static.local, static.global, global }
 *  ***************************************************************************
 *  === !KEY:   static
 *  const, volatile, static.local, static.global
 */
    printf("------------------------------------------------------------ \n");
    printf("[%s;%d]: Module and static.global  \n",__FILE__,__LINE__);
    printf("------------------------------------------------------------ \n");

    printf("---  static.local\n");
    local_fct();    /* increments 'i' 3x times */
    local_fct();
    local_fct();

    printf("--- static.global   (MAIN)\n");
    printf("gStaticStr  = <%s>\n",gstaticStr);

    printf("--- global   (MAIN)\n");
    printf("gStr        = <%s>\n",gStr);           /* global var */

    /* Der Unterschied zwischen
            global   vars und
            static.global vars
       besteht nur in ihrem NameSpace.
       - Die globale Variable ist in allen Modulen mit dem
         gleichen Namen sichtbar.
       - Die static.global variable nur in dem aktuellen Modul.
    */

/*
 *  ***************************************************************************
 *  Module      C2C++
 *  ***************************************************************************
 *  call C10.exe with PP='USE_EXTERN'
 */
    printf("------------------------------------------------------------ \n");
    printf("[%s;%d]: c++ modules \n",__FILE__,__LINE__);
    printf("------------------------------------------------------------ \n");


    printf("MAIN: I check 'USE_EXTERN'... \n");
#ifdef  USE_EXTERN
    printf("... 'version compiled with USE_EXTERN'\n");
#else
    printf("!!! USE_EXTERN not defined - I can't call external modules.\n");
#endif

#ifdef  USE_EXTERN
    iSRC    = 11;
    printf("--- [%s;%d]: MAIN: START with :cFct(%d)\n",__FILE__,__LINE__,i);
    i       = cFct(iSRC);
    printf("MAIN: result of :cFct(%d)=:%d\n",iSRC,i);
#endif

#ifdef  USE_EXTERN
    iSRC = 22;
    i    = c2cppFct(iSRC);
    printf("MAIN: result of :c2c++Fct(%d)=:%d\n",iSRC,i);
#endif

#ifdef  USE_EXTERN
    /*
     *  LINK-ERR: undefined reference to c2cpp Fct
     */
    iSRC = 33;
    i = cpp2cFct(iSRC);
    printf("MAIN: result of :c++2cFct(%d)=:%d\n",iSRC,i);
#endif

    printf("--- EndOfFile:[%s] at LineNr:[%d] \n",__FILE__,__LINE__);
    return(p_iEc);
}


/*  ######################################################################## */
/*	main */
/*  ######################################################################## */

#ifndef __USE_TUTOR__MAIN
int main(int args, char *argv[]) {
    int     iEc = atoi(getenv("v_FWK_exitCode"));
    return  F10_module(iEc);
}
#endif
