/*  ######################################################################## */
/*  03: Operatoren                                                           */
/*  ######################################################################## */
/*
 *  Diese Uebung ermoeglicht die Verwendung von Input-Parametern.
 *  usage: DOS> run.exe [<float1> <float2>][<x>]
 *              float1, float2 : io floats
 *              x : if set, IO is active
 *
*/
/*
    encoding: UTF-8
    !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿ
*/

#ifndef __USE_TUTOR__MAIN
    #define INC__TUTOR_LIBRARY
#endif
#include    "c00_include.h"

/*
 * Funktionen werden spaeter erl?utert.
 * pre-Definitonen von Funktionen (proto types)
*/
int F03_operator(int);

#ifndef __USE_TUTOR__MAIN
int main(int args, char *argv[]) {
    int     iEc = atoi(getenv("v_FWK_exitCode"));
    return  F03_operator(iEc);
}
#endif

int F03_operator(int p_iEc)
{
    int         x,y,z;
    double      u,v;
    int         i,i1,i2;
    int         isIoMode=0;
    double      d,d1=7.3,d2=-2.7;
    char  *     p_char;
    void  *     p_void;
    char        str[10]="ABCDEFGHI";
    char        s1[10],s2[10],s3[10];

    printf("============================================================ \n");
    printf("[C03]:  Operatoren\n");
    printf("============================================================ \n");

    printf("--- compiled:");
    printf("DATETIME=(%s;%s)",__DATE__,__TIME__);
    printf("FILE:[%s]\n", __FILE__);
#ifdef  __cplusplus
    printf("### isC++:=YES\n");
#else
    printf("### isC++:=NO !\n");
#endif


 /* EINGABE formatieren (char-> float/double) */
    i1 = (int)d1;
    printf("x=%f=%d;\n",d1,i1);

    i2  = (int)d2;
    printf("y=%f=%d;\n",d2,i2);

    printf("============================================================= \n");

/*
 *  return -__LINE__;
*/

/*
 *  ***************************************************************************
 *  1)   TYP-Umwandlungen von elementaren Datentypen { typecast }
 *  ***************************************************************************
 *  === !OPR:   (typecast)
 */

    printf("*** [%s;%d]: TYPECASTING\n",__FILE__,__LINE__);
    x   = i2;
    d = (double)x * d1;
    printf("\td = (double)x * d1 = %f; x=%d,d1=%f\n",d,x,d1);


/*
 *  ***************************************************************************
 *  2)   POINTER-OPERATOREN {INHALTS- und ADRESS-}    { *, & }
 *  ***************************************************************************
 *  === !OPR:   *
 *  === !OPR:   &
 *  === !KEY:   void
 */
    printf("*** [%s;%d]: POINTER Operatoren\n",   __FILE__,__LINE__);
    /*
        char  *     p;
        char        str[10]="ABCDEFGHI";
    */
    p_char   = & str[0];        /* &  :  Adress-Operator */
    p_char   = str;             /*       kurze Schreibweise bei Arrays */

    * p_char = 'z';             /* *  :  Pointer-Operator */


    /* p_char ist ein Ptr oder Zeiger auf die Variable 'str',
         die selbst ein Feld ist.
    */
    printf("\t str : %s\n",str);
    printf("\t p = &str[0] = str =  : %p\n",p_char);
    printf("\t * p : %s\n",p_char);
    printf("\t p[0]: %c\n",p_char[0]);
    printf("\t p[1]: %c\n",p_char[1]);
    printf("\t p[2]: %c\n",p_char[2]);

    p_char[1] = 'x';     /* ?ndern des Inhaltes von 'str' ?ber den Zeiger */
    printf("\t * p': %s\n",p_char);

    printf("*** [%s;%d]: POINTER Artihmetik )\n",
                        __FILE__,__LINE__);

    printf("\t &(p[3]-&(p[0]): %d\n",(int)(&p_char[3]-&p_char[0]));

    /*  Der De-Referenz-Operator '->'
     *  wird bei Strukturen ben?tigt.
     */

    printf("*** [%s;%d]: void POINTER\n",   __FILE__,__LINE__);
    /* void Pointer */
    p_void   = p_char;
    printf("\t p_char               : %p\n",p_char);
    printf("\t p_void (:=p_char)    : %p\n",p_void);


/*
 *  ***************************************************************************
 *  3)   ARITHMETISCHE OPERATOREN       {'+','-','*','/'}
 *  ***************************************************************************
 */

    printf("*** [%s;%d]: Arithmetische Operatoren und Modulo\n",
                        __FILE__,__LINE__);
    x = i1;
    y = i2;
    z = x + y;
    printf("\tz = x + y = (%d) + (%d) =: %d\n",x,y,z);
    z = x - y;
    printf("\tz = x - y = (%d) - (%d) =: %d\n",x,y,z);
    z = x * y;
    printf("\tz = x * y = (%d) * (%d) =: %d\n",x,y,z);
    if (y == 0) {
        printf("??? ERR:x/0, use y=2\n");
        y = 2;
    }
    d = d1 / d2;
    printf("\tz = x / y = (%f) / (%f) =: %f\n",d1,d2,d);



/*
 *  ***************************************************************************
 *  4) ARTIHMETISCHE Modulo OPERATOREN         {'/','%'}
 *  ***************************************************************************
 */

    printf("*** [%s;%d]: Modulo Operatoren und Modulo\n",
                        __FILE__,__LINE__);

    x = i1;
    y = i2;
    y = F_ABS(y);
    z = x / y;
    printf("\tz = x DIV y = %i / %i =: %d\n",x,y,z);

    y = F_ABS(y);
    z = x % y;
        /* ANM: F?r Zeichen '%' muss in printf als '%%' verwendet werden */
    printf("\tz = x MOD y = %i %% %i =: %i\n",x,y,z);

/*
 *  ***************************************************************************
 *  5) UNAERE Operatoren
 *  ***************************************************************************
 */
    d1  = +1.23;    /* + ZAHL */
    d2  = -9.876;   /* - ZAHL */

    printf("*** [%s;%d]: UNAERE Operatoren\n",__FILE__,__LINE__);

    printf("... [%s;%d]: a) Plus-Operator\n",__FILE__,__LINE__);
    d   = +(d1);
    printf("\td = +(%f) = %f\n",d1,d);

    printf("... [%s;%d]: b) Minus-Operator\n",__FILE__,__LINE__);
    d   = -(d1);
    printf("\td = -(%f) = %f\n",d1,d);

    printf("... [%s;%d]: c) Komma-Operator\n",__FILE__,__LINE__);
    x   = (i1=3, i2=5, i1 * i2);
    printf("\tx = (a=3,b=5,a*b) = %d\n",x);

/*
 *  ***************************************************************************
 *  6)   UNAERE INC/DEC OPERATOREN      {'x++','++x','x--','--x'}
 *  ***************************************************************************
 */

    printf("*** [%s;%d]: INKREMENT/DEKREMENT Operatoren\n",__FILE__,__LINE__);

    x = i1;
    y = i2;
    z = ++x + y;
    printf("\t++x:: z = ++x + y = ++(%d) + (%d) = %d; x=%d,y=%d\n",i1,i2,z,x,y);

    x = i1;
    y = i2;
    z = x++ + y;
    printf("\tx++:: z = x++ + y = (%d)++ + (%d) = %d; x=%d,y=%d\n",i1,i2,z,x,y);

    x = i1;
    y = i2;
    z = ++x + --y;
    printf("\t--x:: z = ++(%d) + --(%d) = %d; x=%d,y=%d\n",i1,i2,z,x,y);

    x = i1;
    y = i2;
    z = ++x + y--;
    printf("\tx--:: z = ++(%d) + (%d)-- = %d; x=%d,y=%d\n",i1,i2,z,x,y);


    u = d1;
    v = d2;
    d = ++u - v;
    printf("\t++x(float):: z = ++(%f) - (%f) = %f\n",d1,d2,d);


/*
 *  ***************************************************************************
 *  7)   VERGLEICHS OPERATOREN   ( ==, !=, >,<, >=, <= )
 *  ***************************************************************************
 */
    printf("*** [%s;%d]: Vergleichs Operatoren\n",__FILE__,__LINE__);

    x = i1;
    y = i2;

    z = (x == y);
    printf("\t(x == y)=:%d; x=%d,y=%d\n",z,x,y);          /* == */

    z = (x != y);
    printf("\t(x != y)=:%d; x=%d,y=%d\n",z,x,y);          /* == */

    z = (x > y);
    printf("\t(x > y)=:%d; x=%d,y=%d\n",z,x,y);           /* > */

    z = (x < y);
    printf("\t(x < y)=:%d; x=%d,y=%d\n",z,x,y);           /* < */

    z = (x >= y);
    printf("\t(x >= y)=:%d; x=%d,y=%d\n",z,x,y);          /* >= */

    z = (x <= y);
    printf("\t(x <= y)=:%d; x=%d,y=%d\n",z,x,y);          /* <= */


/*
 *  ***************************************************************************
 *  8)   BOOLSCHE OPERATOREN     ( ||, &&, ! )
 *  ***************************************************************************
 */
    printf("*** [%s;%d]: Boolsche Operatoren\n",__FILE__,__LINE__);


    /* &&  */
    x = i1;
    y = i2;
    z = ((x != 6) && (y == 3));
    printf("\t&&  :: ((x != 6) && (y == 3))=:%d; x=%d,y=%d\n",z,x,y);

    /* ||  */
    x = 7;
    z = ( x++ == 8 || x == 3 );
    printf("\t||  :: ( x++ == 8 || x == 3 ) = \n");
    printf("\t       ( (7)++ == 8 || (7) == 3 ) =:%d\n",z);

    /* !  */
    x = 7;
    z = ( !(x == 3) );
    printf("\t!   :: ( !((%d) == 3 ) =: %d\n",x,z);

    /* SCHWERE BOOLSCHE AUSDRUECKE */
    x = i1;
    z = ((!x) && (x>=3));
    printf("\t((!x) && (x>=3)=:%d; x=%d\n",z,x);

    printf("=== [%s;%d]: Gemischte Anweisungen\n",__FILE__,__LINE__);
    /* GEMISCHTER: ++,--,||,&& */

    x = 0;
    y = 0;
    z = 0;
    printf("\tx=y=z=0: ( ++x || ++y && ++z ) = \n");
    printf("\t\t==:( ++(%d) || ++(%d) && ++(%d) ) =: ",x,y,z);
#ifdef __MSC_VER
    #pragma warning (disable: 4514)
#else
    /* try to disable warning */
#endif
    i = ( ++x || (++y && ++z) );      /* compiler produces a warning1 ! */
    printf("\t%d; x=%d,y=%d,z=%d\n",i,x,y,z);

    x = 0;
    y = 0;
    z = 0;
    printf("\tx=y=z=0: ( ++x && ++y || ++z ) = \n");
    printf("\t\t==:( ++(%d) || ++(%d) && ++(%d) ) =: ",x,y,z);
    i = ( (++x && ++y) ||  ++z );     /* warning2 */
    printf("\t%d; x=%d,y=%d,z=%d\n",i,x,y,z);

    x = i1;
    y = i2;
    z = i1+i2;
    printf("\t( ++x || ++y && ++z ) = \n");
    printf("\t\t==:( ++(%d) || ++(%d) && ++(%d) ) = ",x,y,z);
    i = ( ++x || ( ++y && ++z ) );      /* warning3 */
    printf("\t%d; x=%d,y=%d,z=%d\n",i,x,y,z);

/*
 *  ***************************************************************************
 *  9)   BIT OPERATOREN             {'&','|','^','~','>>','<<'}
 *  ***************************************************************************
 */
    printf("*** [%s;%d]: Bit Operatoren\n",__FILE__,__LINE__);

    x = i1;
    y = i2;
    i = ( x & y );
    printf("\t%s & %s = %s\n",
        f_printBYTE(s1,x),f_printBYTE(s2,y),f_printBYTE(s3,i));

    x = 0x83;
    y = 0xcc;
    i = ( x | y );
    printf("\t%s | %s = %s\n",
        f_printBYTE(s1,x),f_printBYTE(s2,y),f_printBYTE(s3,i));

    x = i1;
    y = i2;
    i = ( x ^ y );
    printf("\t%s ^ %s = %s\n",
        f_printBYTE(s1,x),f_printBYTE(s2,y),f_printBYTE(s3,i));

    x = i1;
    i = ~( x );
    printf("\t~%s = %s\n",
        f_printBYTE(s1,x) ,f_printBYTE(s3,i));

    x = 0x3A;
    y = 3;
    i = x >> y ;
    printf("\t%s >> %d = %s\n",
        f_printBYTE(s1,x) , y, f_printBYTE(s3,i));

    x = 0x3A;
    y = 3;
    i = x << y ;
    printf("\t%s << %d = %s\n",
        f_printBYTE(s1,x) , y, f_printBYTE(s3,i));

/*
 *  ***************************************************************************
 *  10)   (compound) ASSIGNMENT OPERATOREN
 *      {'=','+=','-=','*=', '/=', '%=','>>=','<<=','&=','|=','^='}
 *  ***************************************************************************
 *  DEF:    OPERATOR::  a op= b   <==>    a = a op b
 *  BSP:    op='+'      a +=  b   <==>    a = a + b
 */


    printf("*** [%s;%d]: COMPOUND ASSIGNEMENTS\n",__FILE__,__LINE__);
    z = x = i1;
    y = i2;
    z += y;
    printf("01:\tx += y    :: (%d)+=(%d) =: x=%d; x=%d,y=%d\n",i1,i2,z,x,y);

    x = i1;
    y = i2;
    x -= y;
    printf("02:\tx -= y    :: %d -= %d =: x=%d\n",i1,i2,x);

    x = i1;
    y = i2;
    x *= y;
    printf("03:\tx *= y    :: %d *= %d =: x=%d\n",i1,i2,x);

    x = i1;
    y = i2;
    x /= y;
    printf("04:\tx /= y    :: %d /= %d =: x=%d\n",i1,i2,x);

    x = i1;
    y = i2;
    x %= y;
    printf("05:\tx %%= y    :: %d %%= %d =: x=%d\n",i1,i2,x);

    x = i1;
    x &= i2;
    printf("06:\t%s &= %s =: %s\n",
        f_printBYTE(s1,i1) ,f_printBYTE(s2,i2),f_printBYTE(s3,x));

    x = i1;
    x |= i2;
    printf("07:\t%s |= %s =: %s\n",
        f_printBYTE(s1,i1) ,f_printBYTE(s2,i2),f_printBYTE(s3,x));

    x = i1;
    x ^= i2;
    printf("08:\t%s ^= %s =: %s\n",
        f_printBYTE(s1,i1) ,f_printBYTE(s2,i2),f_printBYTE(s3,x));

    x = i1;
    x <<= 2;
    printf("09:\tx <<= 2   :: (%2.2d) <<= 2)   =: x=%d\n",i1,x);

    x = y = 65;
    x >>= 2;
    printf("10:\tx >>= 2   :: (%2.2d) >>= 2)   =: x=%d\n",y,x);


/*
 *  ***************************************************************************
 *  *)   Spezielle Funktionen
 *  ***************************************************************************
 */
    printf("*** [%s;%d]: Spezielle Bit Funktionen\n",__FILE__,__LINE__);

    z = 77; /* 77d = 4dh == 0100.1101 */
    x = i1;
    y = i2;
    (y > 0) ? (y) : (y = -y);
    z = f_swapBits(z,x,y);
    /* swap(0101.0101,7,2)=:1100.1001*/
    printf("\t( swap(%s,%d,%d) ) = (%s)\n",
        f_printBYTE(s1,77),x,y,f_printBYTE(s2,z));

    x = i1;
    printf("BITs(%d):",x);
    f_putBits(x);

    /*
     *  *** IO mit BIT-Operation    ****
     */

    if (isIoMode) {
        printf("Eine Bitzahl eingeben (nur 0|1):");
        x = f_getBits();
        printf("== int:%d\n",x);
    }

/*
 *  ***************************************************************************
 *  11) andere Operatoren
 *  ***************************************************************************
 */

    printf("*** [%s;%d]: return-Operator\n",__FILE__,__LINE__);
    printf("--- EndOfFile:%s at LineNr:%d \n",__FILE__,__LINE__);

    return p_iEc;


} /* endOfMain */

