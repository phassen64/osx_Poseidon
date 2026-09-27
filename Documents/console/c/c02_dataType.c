/*  ######################################################################## */
/*  02: Data Types, Variables, Constants, Eigene Funktionen                  */
/*  ######################################################################## */
/*
 *  Abk.: PP=PreProcessor,CPP=c++Style
 */
/*
    encoding: UTF-8
    !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿ
*/
/*
 *  variable components::
 *      memClass={'auto','extern','register','static'}
 *      varClass={NULL, 'const', 'volatile'}
 *      modifier={'unsigned','signed','short','long'}
 *      addrType={NULL,'*','&'}
 *      varType={'char','double','float','int'}
 *
 *  varDef::    [memClass][varClass][modifier][vartype][addrType] varName;
 *  Bsp:        extern const unsigned char * c;
 *
 * include of a file
*/

#ifndef __USE_TUTOR__MAIN
    #define INC__TUTOR_LIBRARY
#endif
#include "c00_include.h"    /* eigenes Header-File */

int F_mod_simpleDataType(void)
{

/*
 *  ***************************************************************************
 *  1)   Elementare Datentypen
 *  ***************************************************************************
 *  === !KEY:   char
 *  === !KEY:   int
 *  === !KEY:   float
 *  === !KEY:   double
 */

    F_MENU("simpleDataType");

    int             i=77;
    char            c='X';
    float           f=(float)-1.78;
    double          d=12345.6789;

    printf("\tchar            : '%c'  \n",c);
    printf("\tint             : '%d'  \n",i);     /* printf:: '%d' == '%i' */
    printf("\tfloat           : '%f'  \n",f);
    printf("\tdouble          : '%f'  \n",d);

    return __LINE__ ;
}


int F_mod_modificator(void)
{
/*
 *  ***************************************************************************
 *  2)   MODIFIKATOREN
 *  ***************************************************************************
 *  === !KEY:   long
 *  === !KEY:   short
 *  === !KEY:   signed
 *  === !KEY:   unsigned
 */

    F_MENU("dataType Modificator");

    /*
     * standard
     */

    long            l=-77891;           /* == long int */
    short           shI=-1234;            /* == short int */
    signed          siI=-1;         /* == signed int */
    unsigned        u=123456789;        /* == unsigned int */

    F_SHOW("long|short|signed|unsigned");

    printf("\tshort           : '%d'    \n",shI);
    printf("\tlong            : '%ld'   \n",l);
    printf("\tsigned          : '%d'    \n",siI);
    printf("\tunsigned        : '%d'    \n",u);

    /*
     * short/long kann auf 'int' oder
     * long auf 'double' angewandt werden.
     */
    short int       si=-12345;          /* short int == short */
    long int        li=-1234567;        /* long int == long */


    F_SHOW("long||short int");

    printf("\tshort int       : '%i'  \n",si);
    printf("\tlong long int   : '%ld' \n",li);
#ifdef _MSC_VER
    long double     ld=123456.678;
    printf("\tlong double     : '%Lf' \n",ld);   /*!CRQ-190826, CRQ-240309*/
#endif

    /* return -(__LINE__); */

    /*
     * signed/unsigned kann sowohl auf 'int' als auch auf 'char'
     * angewandt werden.
     * Da jedoch 'int' immer per default >signed< sind,
     * wird signed nur f?r char, unsigned f?r int und char eingesetzt.
     */

    F_SHOW("signed && unsigned");

    signed char     sc='B';
    unsigned char   uc='C';
    unsigned int    ui=256;

    printf("\tsigned char     : '%c'  \n",sc);
    printf("\tunsigned char   : '%c'  \n",uc);
    printf("\tunsigned int    : '%d'  \n",ui);


    F_SHOW("modificator 2 modificator");


    unsigned long         ul=1234567890;
    unsigned long int     uli=123456789;
    printf("\tunsigned long   : '%lu'  \n",ul);
    printf("\tunsigned long int  : '%lu'  \n",uli);

    return __LINE__ ;
}


/*
 *  ***************************************************************************
 *  3)   Felder und Pointer
 *  ***************************************************************************
 *  === !OPR:   []
 *  === !OPR:   *
 *  === !OPR:   &
 */

int F_mod_pointer() {

    F_MENU("pointer");


    printf("\n\t&&& complex Array [%s;%d]\n\n", __FILE__,__LINE__);

    char          * Wochentag[]={"Mo","Di","Mi","Do","Fr","Sa","So"};
    int             matrix[3][4]={  {1,2,3,4},
                                    {11,22,33,44},
                                    {111,222,333,444},
                               };
    char            dumpBuffer[63];     /* for dump */


    printf("    ARRAY Wochentag[3]  : '%s'\n",Wochentag[3]);
    printf("    ARRAY Matrix[1][2]  : %d\n",matrix[1][2]);
    F_DUMP("Wochentag",Wochentag[0],sizeof(Wochentag));

    printf("\n\t&&& string constant[%s;%d]\n\n", __FILE__,__LINE__);

    int             i;
    char            str[]="ABCDEFGH";   /* STRING constant */
    char            charBuffer[32+1];   /* ARRAY of 32 chars +1 NULL == STRING */

    for(i=0; i<32; i++) {
        charBuffer[i] = 'a';
    }
    printf("\tstring        : '%s' \n",str);
    printf("\tcharBuffer    : '%s' \n",charBuffer);


    /* ===  Pointer */

    printf("\n\t&&& pointer[%s;%d]\n\n", __FILE__,__LINE__);

    char        c;
    char    *   ptr2char = &c;  /* ptr to char */
    char    *   ptr2str  = &(str[0]);  /* ptr to str */

    printf("    pointer_to_char : '%p' : *pc    : '%c' \n",ptr2char,*ptr2char);
    printf("    pointer_to_str  : '%p' : *pstr  : '%s' \n",ptr2str,ptr2str);
                /*
                 * ptr2str referenziert ohne auf ein str,
                 * da eigentlich nur ptr auf chars in C existieren.
                 */

    /* ===  dump */

    printf("\n\t&&& dumping[%s;%d]\n\n", __FILE__,__LINE__);


    /* ===  use my dump buffer function ! */
    memset(dumpBuffer,0,sizeof(dumpBuffer));
    for(i=0; i<(int)sizeof(dumpBuffer)-1; i++) {
        dumpBuffer[i]=0x40+i;
    };
    printf("dumpBuffer:'%s'\n",dumpBuffer);

    /*  === !FCT */
    F_DUMP("dumpBuffer",dumpBuffer,sizeof(dumpBuffer));

    return __LINE__;
}


/*
 *  ***************************************************************************
 *  4)   Groesse von Datentypen {OPERATOR: sizeof}
 *  ***************************************************************************
 *  === !KEY:   sizeof
 *  === !OPR:   sizeof
*/

int F_mod_sizeOf() {

    char            c='X';
    int             i=77;
    float           f=-1.78F;
    double          d=12345.6789;
    long            l=-77891;           /* == long int */
    short           shI=-1234;          /* == short int */
    signed          siI=-1;             /* == signed int */
    short int       si=-12345;          /* short int == short */
    unsigned        u=123456789;        /* == unsigned int */
    long int        li=-1234567;        /* long int == long */
    long double     ld=123456.678;
    signed char     sc='B';
    unsigned char   uc='C';
    unsigned int    ui=256;
    unsigned long         ul=1234567890;
    unsigned long int     uli=123456789;
    char            str[]="ABCDEFGH";   /* STRING constant */
    char          * ptr2char = &c;  /* ptr to char */
    char          * Wochentag[]={"Mo","Di","Mi","Do","Fr","Sa","So"};
    int             matrix[3][4]={  {1,2,3,4},
                                    {11,22,33,44},
                                    {111,222,333,444},
                               };

    F_MENU("dataType Size");

    i=sizeof(c);    F_printf(("\tsizeof(char)  :   %d;\n",i)); /*!CRQ*/
    i=sizeof(i);    printf("\tsizeof(int)         :   %d;\n",i);
    i=sizeof(f);    printf("\tsizeof(float)       :   %d;\n",i);
    i=sizeof(d);    printf("\tsizeof(double)      :   %d;\n",i);
    i=sizeof(l);    printf("\tsizeof(long)        :   %d;\n",i);
    i=sizeof(shI);  printf("\tsizeof(short)           : %d;\n",i);
    i=sizeof(si);   printf("\tsizeof(short int)   :   %d;\n",i);
    i=sizeof(li);   printf("\tsizeof(long int)    :   %d;\n",i);
    i=sizeof(ld);   printf("\tsizeof(long double) :   %d;\n",i);
    i=sizeof(siI);  printf("\tsizeof(signed)          : %d;\n",i);
    i=sizeof(sc);   printf("\tsizeof(signed char)     : %d;\n",i);
    i=sizeof(u);    printf("\tsizeof(unsigned)        : %d;\n",i);
    i=sizeof(uc);   printf("\tsizeof(unsigned char)   : %d;\n",i);
    i=sizeof(ui);   printf("\tsizeof(unsigned int)    : %d;\n",i);
    i=sizeof(ul);   printf("\tsizeof(unsigned long)   : %d;\n",i);
    i=sizeof(uli);  printf("\tsizeof(unsigned long int)   : %d;\n",i);
    i=sizeof(uli);  printf("\tsizeof(unsigned long int)   : %d;\n",i);

    F_SHOW("Groesse von Strings, Pointern und Arrays");

    i=sizeof(str);      printf("\tstring='%s'           : %d;\n",str,i);
    i=sizeof(ptr2char); printf("\tpointer_to_char='%c'   : %d;\n", *ptr2char,i);
    i=sizeof(Wochentag); printf("\tsizeof(ARRAY Wochentag) {char [7][2]} :  %d;\n",i);
    i=sizeof(matrix);   printf("\tsizeof(ARRAY Matrix){int [3][4]} :  %d;\n",i);

    return __LINE__;
}


/*
 *  ***************************************************************************
 *  5)   Konvertierungen von Zahlen   {FCT=printf()}
 *  ***************************************************************************
 */

int F_mod_converter() {

    int         i;
    short int   si;
    char        sBuffer[32+1];

    F_MENU("converter");

    i = 123;
    printf("\ti (decimal)     :   %d     \n",i);
    printf("\ti (octal)       :   %o     \n",i);
    printf("\ti (hexadecimal) :   %x     \n",i);
    printf("\ti (binaer)      :   %s     \n",
            f_printBits(i,sBuffer,8));

    si = -1;
    printf("\tsi  (fmt='d')   :   %d     \n",si);
    printf("\tsi  (fmt='u')   :   %u     \n",si);

    return __LINE__;
}


/*
 *  ***************************************************************************
 *  6)   CONST data values
 *  ***************************************************************************
 */

int F_mod_constValue() {


    int             i=77;
    float           f=-1.78F;
    double          d=12345.6789;
    unsigned char   uc='C';
    unsigned long         ul=1234567890;

    F_MENU("CONST data values");

    /*
     *  --- number postfix
     *      long double :   {'l','L'}
     *      unsigned    :   {'u','U'}
     *      float       :   {'f','F'} und mit '.'
     *      double      :   {'l','L'} und mit '.'
     *  --- prefix
     *      octalNumber :   with '0...'
     *      hexaNumber  :   with '0x...' or '0X...'
     *  --- special letters
     *      octal   bits:   '\ooo'  3-bit Value
     *      hex     bits:   '\xhh'  2-bit Value
    */

    F_SHOW("INTEGER constants");

    ul  = 27ul;
    printf("\tul1(27ul) :   %ld\n",ul);
    ul  = 077;
    printf("\tul2=(077)     :%ld\n",ul);
    ul  = 0x1234U;
    printf("\tul3=(0x1234U) :%ld\n",ul);

    F_SHOW("FLOAT and DOUBLE constants");

    f  = 27.1F;
    printf("\tf1=(27.1F)    :%f\n",f);
    d  = -1.8E-3;
    printf("\td=(-1.8E-3)   :%G\n",d);       /* G -> %f oder %e */
    d  = -4.3E-9;
    printf("\td=(-1.8E-3)   :%E\n",d);

    F_SHOW("CHARACTER constants");

    uc   = 'X';
    printf("\tuc:%c\n",uc);

    F_SHOW("decimal|octal|hex number");

    i  = 12345;
    printf("\t(dec):i=12345    :%i\n",i);
    i  = 012345;
    printf("\t(oct):i=012345   :%i\n",i);
    i   = 0x1000;
    printf("\t(hex):i=0x1000   :%i\n",i);

    F_SHOW("bits in octal|hex number");

    i  = '\123';
    printf("\t(oct):i='\\123'   :%i\n",i);
    i  = '\xAB';
    printf("\t(hex):i='\\xAB'   :%i\n",i);

    /*
      STR konstanten koennen nicht in C im Programm-Body
      zugewiesen werden.
    */

    F_SHOW("globale Konstanten");

    printf("\te     = %f\n",C_E);
    printf("\tpi    = %f\n",C_PI);

    return __LINE__;
}


/*
 *  ***************************************************************************
 *  7)  data type constants
 *  ***************************************************************************
 *  === !KEY:   const
 */

int F_mod_constDataType() {


    F_MENU("dataType-Constants");

    int     i = 4711;
    const   int ci = 7;

    /*
     * ci = 3;      ERROR
     */
    printf("\tconst int ci      = %d\n",ci);

    const   int * p_ci    = &ci;
    printf("\tconst int p_ci    = %d\n",*p_ci);

    p_ci = &i;      /* p points to var */
    printf("\tp_ci->i           = %d\n",*p_ci);

    return __LINE__;
/*  return -__LINE__;
*/
}


/*
 *  ***************************************************************************
 *  8)  Macro-Konstanten (PP-Konstanten)
 *  ***************************************************************************
 */

int F_mod_constMacro() {

    F_MENU("pp-Constant");

    /* PP-Konstante */
    #define KONSTANTER_WERT 1000
    printf("\tKonstanter Wert:%d\n",KONSTANTER_WERT);

    return __LINE__;
}


/*
 *  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
 *  m:body
 *  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
*/


#define F_CHK()   { \
    if ( iRc < 0) { \
        printf("?Code:%d at:[%d]",(iRc),(__LINE__)); return(iRc); } }


int F02_dataType(int p_iEc)
{
		int iRc = -1;

    printf("=== CTutor::dataType:{%d}\n",p_iEc);
    printf("\tcompiled:\n");
    printf("\tDATE=(%s;%s)\n",__DATE__,__TIME__);
    printf("\tFILE:[%s;%d]\n", __FILE__,__LINE__);

    /*  subfunction call */
    #ifdef  __cplusplus
        printf("\t### isC++:=YES\n");
    #else
        printf("\t### isC++:=NO !\n");
    #endif

    iRc = F_mod_simpleDataType();   printf("\n\tRC.simple  =: <%d>\n",iRc); F_CHK();
    iRc = F_mod_modificator();      printf("\n\tRC.modificator  =: <%d>\n",iRc); F_CHK();
    iRc = F_mod_pointer();          printf("\n\tRC.pointer      =: <%d>\n",iRc); F_CHK();
    iRc = F_mod_sizeOf();           printf("\n\tRC.sizeOf DT    =: <%d>\n",iRc); F_CHK();
    iRc = F_mod_converter();        printf("\n\tRC.converter    =: <%d>\n",iRc); F_CHK();
    iRc = F_mod_constValue();       printf("\n\tRC.constVAL     =: <%d>\n",iRc); F_CHK();
    iRc = F_mod_constDataType();    printf("\n\tRC.constDT      =: <%d>\n",iRc); F_CHK();
    iRc = F_mod_constMacro();       printf("\n\tRC.constMACRO   =: <%d>\n",iRc); F_CHK();

		return (p_iEc);
}



#ifndef __USE_TUTOR__MAIN
int main(int args, char *argv[])
{
    int     iEc = atoi(getenv("v_FWK_exitCode"));
    return(F02_dataType(iEc));
}
#endif /* __USE_TUTOR__MAIN */


