/*  ########################################################################### */
/*  00:  Pragmas und MACRO-Funktionen                                           */
/*  ########################################################################### */
/*  Quelle f?r das Tutorial:
 *      1) mitp - 4.Auflage, Ulla Kirch-Print, Peter Prinz,
 *      2) C++ Lernen und professionell anwenden
 *      3) http://www.cplusplus.com
 */

/* 
    encoding: UTF-8
    !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿ
*/

#ifndef INC__TUTOR
#define INC__TUTOR

#ifdef  __cplusplus
    #define __C_ADVANCED    /* for c-files handled by a c++-Compiler */
#else
    #define __C_NATIVE
#endif

#if defined(_WIN32) || defined(_WIN64)
    #define OS_WINDOWS
        #ifndef _CRT_SECURE_NO_DEPRECATE
            #define _CRT_SECURE_NO_DEPRECATE  /*  warnings bei alten Fktn */
        #endif
        #if (defined(_MSC_VER))
            #pragma warning (default: 4001 4010 4115 4121 4201 4214 4209 4514)
            #pragma warning (disable: 4514)
            #pragma warning (disable: 4514)
            #pragma warning (disable: 28159) /* GetTickCount*/
        #endif /* MSCVER*/
#endif /* WIN32 || WIN64 */

#if (defined(_MSC_VER))
    #pragma warning( disable: 4267 )   /* sizet=>int */
    #pragma warning (disable: 4514)
    #pragma warning (disable: 4996)   /* fopen */
#endif /* MSCVER*/

#ifndef     I_STDLIB_H
            #define     I_STDLIB_H
            #include   <stdlib.h>       /* atof */
#endif

#ifndef     I_STDARG_H
            #define     I_STDARG_H
            #include   <stdarg.h>       /* varg */
#endif

#ifndef     I_TIME_H
            #define     I_TIME_H
            #include   <time.h>         /* time() */
#endif

#ifndef     I_CTYPE_H
            #define     I_CTYPE_H
            #include    <ctype.h>       /* Zeichen testen */
#endif

#ifndef     I_MATH_H
            #define     I_MATH_H
            #include    <math.h>        /* mathematische Fktn */
#endif

#ifndef     I_STDIO_H
            #define     I_STDIO_H
            #include   <stdio.h>        /* printf(), putchar(), fopen */
#endif

#ifndef     I_ASSERT_H
            #define     I_ASSERT_H
            #include   <assert.h>       /* assert() */
#endif

#ifndef     I_LIMTS_H
            #define     I_LIMITS_H
            #include   <limits.h>       /* CHAR_BIT */
#endif

#ifndef     I_FLOAT_H
            #define     I_FLOAT_H
            #include   <float.h>        /* */
#endif

#ifndef     I_SIGNAL_H
            #define     I_SIGNAL_H
            #include   <signal.h>       /* */
#endif

#ifndef     I_LOCALE_H
            #define     I_LOCALE_H
            #include   <locale.h>       /* */
#endif

#ifndef     I_STRING_H
            #define     I_STRING_H
            #include   <string.h>       /* strcpy */
#endif

#ifndef     I_SETJMP_H
            #define     I_SETJMP_H
            #include   <setjmp.h>
#endif

#ifndef     I_ERRNO_H
            #include    <errno.h>
#endif

#ifdef __USE_UNIX_FILE_HANDLING
    #include <fcntl.h>
    typedef int                         T_FILE;
    typedef int                         T_FILE_ACCESS;
    #define C_FILE_ACCESS_WRITE         O_WRONLY | O_CREAT | O_EXCL
    #define C_FILE_ACCESS_READ          O_RDONLY
    #define C_FILE_ACCESS_WRITE_BIN     C_FILE_ACCESS_WRITE  | O_BINARY
    #define C_FILE_ACCESS_READ_BIN      C_FILE_ACCESS_READ   | O_BINARY
    #define FILE_OPEN_ERR               -1
    #define FILE_CLOSE_OK               0
    #define fp2fh(fp)                   (T_FILE)((fp)->_file)
    #define fh2fd(fp)                   (int)fp
#else
    int read(int,void*,int);        /* #include <fcntl.h> */
    typedef FILE *                      T_FILE;
    typedef char *                      T_FILE_ACCESS;
    #define C_FILE_ACCESS_WRITE         "w+"
    #define C_FILE_ACCESS_READ          "r"
    #define C_FILE_ACCESS_WRITE_BIN     "wb+"
    #define C_FILE_ACCESS_READ_BIN      "rb"
    #define FILE_OPEN_ERR               0
    #define FILE_CLOSE_OK               0
    #define fp2fh(fp)                   (T_FILE)fp
    #define fh2fd(fp)                   ((fp)->_file)
#endif
#ifndef fileno
    #define fileno(__F) ((__F)->_file)   /* with strict ANSI warning */
#endif

/*
 *  ***************************************************************************
 *  PROGRAMM-Steuerung
 *  ***************************************************************************
 */

#define     TST_QUICKSORT_0         /* aktiv ohne '_0' */
#define     DBG_LIBRARY_0
#define     DECLARE                 /* for decl proto types */

/*
 *  ***************************************************************************
 *  CONSTANTs
 *  ***************************************************************************
 */

#define C_WORD_SIGN     0x8000
#define C_WORD_MAX      0xFFFF
#define C_DWORD_SIGN    0x80000000
#define C_E             2.71828182    /* 2.718281928459045 */
#define C_PI            3.14159265    /* 3.141592653589793 */

/*
 *  ***************************************************************************
 *  ESCAPE
 *  ***************************************************************************
 */

/*  ASCII code */
#define C_ASC_VTAB      '\xB'
#define C_ASC_BELL      '\x7'

/*  C-chars */
#define C_LINEFEED      '\f'
#define C_TAB           '\t'
#define C_VTAB          '\v'
#define C_QUESTION_MARK '\?'
#define C_NEWLINE       '\n'
#define C_RETURN        '\r'
#define C_BACKSPACE     '\b'
#define C_NULL          '\0'

/*
 *  ***************************************************************************
 *  SYNONYMS
 *  ***************************************************************************
 */


#define C_CARD8             unsigned char
#define C_CARD16            unsigned short int
#define C_CARD32            unsigned long int


typedef char                    SIGN8;
typedef unsigned char           USIGN8;
typedef short int               SIGN16;
typedef unsigned short int      USIGN16;
typedef long int                SIGN32;
typedef unsigned long int       USIGN32;
typedef float                   FLOAT;
typedef double                  DOUBLE;
typedef unsigned char           T_BYTE;


#ifdef  OS_WINDOWS
    #ifdef _MSC_VER
        typedef signed   __int64     SIGN64;
        typedef unsigned __int64        USIGN64;
        typedef unsigned __int64    C_USIGN64;
        typedef long                C_SIGN64;
    #else
        /*  --- gnu has problems
         *  gnu ISO 90 shows warnings with
         *  '__int64' and 'long long'
        */
        typedef signed long long     SIGN64;
        typedef signed long long     LONGLONG   ;
        typedef unsigned long long   USIGN64;
    #endif
    #define C_CARD64            C_USIGN64
#else
    /* !CRQ-190826 */
    typedef long unsigned int       DWORD;
    typedef long int                LONG;
    typedef signed long long        SIGN64;
    typedef unsigned long long      USIGN64;
    typedef unsigned long long      LONGLONG;
    typedef union _LARGE_INTEGER
    {
        struct {    DWORD LowPart;    LONG HighPart;  };
        struct {    DWORD LowPart;    LONG HighPart;  } u;
        LONGLONG QuadPart;
    } LARGE_INTEGER,  *PLARGE_INTEGER;

#endif

/*
 *  ***************************************************************************
 *  MACRO Funktionen
 *  ***************************************************************************
 */

#define F_LOWBYTE(x)            (*(CARD16 *)&(x))
#define F_LOWWORD(x)            (*(CARD16 *)&(x))
#define F_SIGNED16(x)           (*(CARD16 *)&(x))     /* signed shift */
#define F_SIGNED32(x)           (*(CARD32 *)&(x))     /* signed shift 32 */
#define F_BYTE2WORD(x)          (*(CARD16 *)&(x))
#define F_BYTE2DWORD(x)         (*(CARD32 *)&(x))
#define F_STR(x)                ((char*)(&(x[0])))

#define F_MAX(a,b)              (((a) >= (b))    ? (a) : (b))
#define F_MIN(a,b)              (((a) <  (b))    ? (a) : (b))
#define F_ABS(a)                (((a) < 0 )     ? (-a) : (a))

#define F_BIN(a,b,c,d,e,f,g,h)  a*128+b*64*c*32+d*16+e*8+f*4+g*2+h
#define F_SQUARE(x)             ( (x) * (x) )

#define F_PASTE(front,back)     front ## back
#define FOREVER                 for(;;)

#define F_VPRINT_F(argList)     f_VFPRINTF  argList
#define F_VPRINT_S(argList)     f_VSPRINTF  argList
#define F_TIME()                f_getTimeStr(gTimeStr)

#define F_QSTR(x)               # x
#define F_CONCAT( a, b )        a ## b
#define F_XCONCAT(a,b)          F_CONCAT(a,b)
#define F_DUMP(idStr,mem,size)  f_dump(mem,size,__FILE__,__LINE__,idStr)

#if TESTEN
#define F_TRACE_V(arglist)      SYSEM_TRACE ((C_PFSP_TRACE_DEBUG,\
                                           "*** vTRACE:[%s,%d]:", \
                                          f_getFileName(__FILE__),__LINE__)); \
                                          pfsp_vPRINT arglist;
#endif


#define F_TRACE(x)  printf("&&& %s:[%s;%d]\n", x, __FILE__, __LINE__)
#define F_printf(x) printf x


#define F_HEADER(x) f_HEADER(x,__FILE__,__LINE__);
#define F_HEADER_LINE(x)   {                 \
    printf ("*** %s:[FILE=%s;LINE=%d]" \
            ":[DATE=%s;TIME=%s]\n", \
            x, \
            __FILE__,__LINE__, \
            __DATE__,__TIME__);  \
} /* printf over LINES */
/*  oslayer.h of KUKA */

#define F_MENU(x)   printf("\n&&& menu:%s:[%s;%d]\n\n",x,__FILE__,__LINE__)
#define F_SHOW(x)   printf("\n\t&&& %s:[%s;%d]\n\n",x,__FILE__,__LINE__)

#define     OFFSETOF(s,m)    ((size_t)&(((s *)0)->m))
#define     INTSIZEOF(n)     ( (sizeof(n) + sizeof(int) - 1) & ~(sizeof(int) - 1) )
#define     VASTART(ap,v)    ( ap = (VALIST)&v + INTSIZEOF(v) )
#define     VAARG(ap,t)      ( *(t *)((ap += INTSIZEOF(t)) - INTSIZEOF(t)) )
#define     VAEND(ap)        ( ap = (VALIST)0 )
#define     UNREFPARM(p)     {(p)=(p);}
#define     ENDOF(p)         ((p)+1)


#define F_SETWORD(ptr,  val)   ((*((USIGN16*)ptr)) = (USIGN16)(val))
#define F_SETDWORD(ptr, val)   ((*((USIGN32*)ptr)) = (USIGN32)(val))

#define F_GETWORD(ptr)         (*((USIGN16*)ptr))
#define F_GETDWORD(ptr)        (*((USIGN32*)ptr))
#define F_GETQWORD(ptr)        (*((USIGN64*)(ptr)))

#define F_MAKEWORD(hi, lo)     ((USIGN16 )(((USIGN8)(lo)) | ((USIGN16 )((USIGN8)(hi))) <<  8))
#define F_MAKEDWORD(hi, lo)    ((USIGN32)(((USIGN16)(lo)) | ((USIGN32)((USIGN16)(hi))) << 16))
#define F_MAKEQWORD(hi, lo)    ((USIGN64)(((USIGN32)(lo)) | ((USIGN64)((USIGN32)(hi))) << 32))

#define F_LODWORD(qw)          ((USIGN32)(qw))
#define F_HIDWORD(qw)          ((USIGN32)(((USIGN64)(qw) >> 32) & 0xFFFFFFFF))

#define F_LOWORD(dw)           ((USIGN16)(dw))
#define F_HIWORD(dw)           ((USIGN16)(((DWORD)(dw) >> 16) & 0xFFFF))

#define F_LOBYTE(w)            ((USIGN8)(w))
#define F_HIBYTE(w)            ((USIGN8)(((WORD)(w)   >>  8) &   0xFF))


/*
 *  ***************************************************************************
 *  TYPEDEF
 *  ***************************************************************************
 */

    typedef enum BOOL_enum_tag {
            E_FALSE = 0,
            E_TRUE  = 1
    } T_BOOL;

/*
 *  ***************************************************************************
 *  Function PROTOTYPEs
 *  ***************************************************************************
 */

int f_VFPRINTF(char *fname,char *format, ...);
int f_VSPRINTF(char *str, char *format, ...);
int f_dump(char* mem,size_t memSize,char* File,int Line,char* idStr);
char * f_printBits(int n, char *s, int fmtLen);
char * f_printBYTE(char *s, int n);
int f_getBits(void);
int f_copyFile(char *src, char *obj);
int f_DayOfYear(int year, int month, int day);
void f_putBits(int n);
int f_swapBits(int x, int bitnr1, int bitnr2);
char* f_getTimeStr(char* cTimeStr);
void f_anySwap(void* v[], int i, int j);
void f_MonthDay(int year, int yearday, int* pmonth, int* pday);
extern char gTimeStr[];

/*
 *  ###########################################################################
 *  CODE
 *  ###########################################################################
 */


/*  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
#ifdef  INC__TUTOR_LIBRARY
/*  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
/*
 *  Die Library kann unter Windows gut verwendet werden.
 *  D.h. sowohl winGnu als auch vc++ k�nnen den Code verwenden.
 */


/*
 *  ***************************************************************************
 *  Globale Variablen
 *  ***************************************************************************
 */

const   double  gC_E    = 2.71828182;    /* 2.718281928459045 */
const   double  gC_PI   = 3.14159265;    /* 3.141592653589793 */
const   int     gC_days_per_month[2][13] =
                {
                    {0,31,28,31,30,31,30,31,31,30,31,30,31},
                    {0,31,29,31,30,31,30,31,31,30,31,30,31}
                };

const   char  * gC_MonthName[] =
                {
                    "?MO",
                    "JAN","FEB","MAR","APR","MAY","JUN",
                    "JUL","AUG","SEP","OCT","NOV","DEC"
                };

const   char  * gC_WeekdayName[] =
                {
                    "?DY",
                    "MON","TUE","WED","THU","FRI","SAT","SUN"
                };

/* globale Variable */

char    gTimeStr[256];

/*  ======================================================================== */
int f_VFPRINTF(char *fname, char *format, ...)
/*  ======================================================================== */
{
    va_list     args;
    int         rc;
/*
 *  --- ERROR: C++ compiler
 *  va_start( args, format );
 *  FILE *F=fopen(fname, "a+");
 *  ERR: Der msC++-Compiler fordert, dass va_start() hinter den
 *  Vereinbarungen folgen muss.
 *  Da auch der msC++-PreProcessor dies fordert,
 *  kann man hier nicht #if _cplusplus ... #endif
 *  verwenden.
 */
    FILE *F=fopen(fname, "a+");
    va_start( args, format );

    assert(F != 0);
    rc = vfprintf( F, format, args );
    fclose(F);
    va_end (args);
    return(rc);
}

/*  ======================================================================== */
#ifdef __cplusplus
    int f_VSPRINTF(char *str, const char *format, ...)
#else
    int f_VSPRINTF(char *str, char *format, ...)
#endif
/*  ======================================================================== */
{
    va_list     args;
    int         rc;
    va_start( args, format );
    rc = vsprintf( str, format, args );
    va_end (args);
    return(rc);
}

/*  ======================================================================== */
int f_dump( char *          s_dataPtr,
            size_t          z_dataSize,
            char *          file,
            int             line,
            char *          idStr)
/*  ======================================================================== */
{
    #define         C_DUMP_MAX_LINE_SIZE        256
    #define         C_DUMP_LINE_SIZE            16
    #define         C_DUMP_DWORD_SEPERATOR      ';'
    #define         C_DUMP_CHAR_UNVISIBLE       '~'
    #define         C_DUMP_CHAR_LAST            '.'
    #define         C_HEX_ASC_SEPERATOR         "________"

    int             iLines;
    int             iCharsPerLine;
    int             i,iSize,n,lineNr=0;
    unsigned char   xByte;
    char            sHexDump[C_DUMP_MAX_LINE_SIZE * 2];
    char            sAscDump[C_DUMP_MAX_LINE_SIZE];
#if defined(_WIN32) || defined(_WIN64)
    int
        zA=sizeof(sAscDump)-2,   /*!CRQ-240515:RAD:char[] vs char* */
        zH=sizeof(sHexDump)-4;   /*!CRQ-240515:RAD:char[] vs char* */
#else
    char            sBuffer[1024];
#endif
    char            *sA=sAscDump,*sH=sHexDump;

    iSize=(int)z_dataSize; /*!CRQ-190826*/
    printf("*** dump[%s;%d;'%s']: ptr=<%p>;len=<%d> ***\n",
                 file,line,idStr,s_dataPtr,iSize);

    if (z_dataSize == 0) {
        return(0);
    };

    iLines              = (1 + ((int)z_dataSize-1) / C_DUMP_LINE_SIZE);
    /*  printf("Data            :%d\n",z_dataSize);
        printf("Lines           :%d\n",iLines);
       */
    for(lineNr=1,n=0; lineNr <= iLines; lineNr++)
    {
        printf("%2.2X::",lineNr);
        printf("%p::",&(s_dataPtr[n]));
        if (lineNr == iLines) {
            iCharsPerLine   = z_dataSize % C_DUMP_LINE_SIZE;
            if (iCharsPerLine == 0) {
                iCharsPerLine = C_DUMP_LINE_SIZE;
            };
        }
        else {
            iCharsPerLine  =  C_DUMP_LINE_SIZE;
        };
        memset(sHexDump,0,sizeof(sHexDump));
        memset(sAscDump,0,sizeof(sAscDump));
        for(i=0; i < C_DUMP_LINE_SIZE; i++)
        {
            if (i < iCharsPerLine)
            {   /* print data */
                xByte   =   s_dataPtr[n++];
                #if defined(_WIN32) || defined(_WIN64)
                    snprintf(sHexDump,zH,"%s%02hX",sA,xByte); /*!CRQ-240515:uShort */
                    isprint(xByte) ?
                        snprintf(sAscDump,zA,"%s%c",sA,xByte) :
                        snprintf(sAscDump,zA,"%s%c",sA,C_DUMP_CHAR_UNVISIBLE);
                #else
                    *sBuffer = 0;
                    sprintf(sBuffer,"%s%02hX",sHexDump,xByte);
                    strcpy(sHexDump,sBuffer);
                    *sBuffer = 0;
                    isprint(xByte) ?
                        sprintf(sBuffer,"%s%c",sAscDump,xByte) :
                        sprintf(sBuffer,"%s%c",sAscDump,C_DUMP_CHAR_UNVISIBLE);
                    strcpy(sAscDump,sBuffer);
                #endif
            }
            else
            {   /* print empty chars */
                #if defined(_WIN32) || defined(_WIN64)
                    snprintf(sHexDump,zH,"%s%c%c",sH,C_DUMP_CHAR_LAST,C_DUMP_CHAR_LAST);
                    snprintf(sAscDump,zA,"%s%c",sA,C_DUMP_CHAR_LAST);
                #else
                    sprintf(sHexDump,"%s%c%c",sH,C_DUMP_CHAR_LAST,C_DUMP_CHAR_LAST);
                    sprintf(sAscDump,"%s%c",sA,C_DUMP_CHAR_LAST);
                #endif
            }
            if ( ((i+1)%4 == 0) && ((i+1) !=  C_DUMP_LINE_SIZE) )
            {   /* print dword seperator */
                #if defined(_WIN32) || defined(_WIN64)
                    snprintf(sHexDump,zH,"%s%c",sH,C_DUMP_DWORD_SEPERATOR);
                    snprintf(sAscDump,zA,"%s%c",sA,C_DUMP_DWORD_SEPERATOR);
                #else
                    sprintf(sHexDump,"%s%c",sH,C_DUMP_DWORD_SEPERATOR);
                    sprintf(sAscDump,"%s%c",sA,C_DUMP_DWORD_SEPERATOR);
                #endif
            };
        };
        printf("%s%s%s\n",sHexDump,C_HEX_ASC_SEPERATOR,sAscDump);
    }
    printf("*** end of dump\n");
    return(n);
}

/* ************************************************************************* */
int f_LINE(const char cText)
/* ************************************************************************* */
{
#define C_DBG_LINE_SIZE 70
    int i;
    for(i=0; i < C_DBG_LINE_SIZE; i++) {
        printf("%c",cText);
    }
    printf("\n");
    return(0);
}

/* ************************************************************************* */
void f_COMPILER(void)
/* ************************************************************************* */
{
    printf("### isC++           :");
    #ifdef  __cplusplus
        printf("'YES'\n");
    #else
        printf("'NO!'\n");
    #endif

    printf("### isSTANDARD_C    :");
    #ifdef  __STDC__
        printf("'YES'\n");
    #else
        printf("'NO!'\n");
    #endif

    printf("### COMPILER        :");
    #if defined(_MSC_VER)
        printf("'_MSC_VER'\n");
    #elif defined(__GNUC__)
        printf("'__GNUC__'\n");
    #else
        printf("'??? UNKNOWN'\n");
    #endif
}

/* ************************************************************************* */
int f_HEADER(const char *cText, const char *cFile, int iLine)
/* ************************************************************************* */
{
    f_LINE('=');
    printf("HDR=\"%s\"  SRC=[%s,%d] DATE=[%s;%s]\n",
        cText,cFile,iLine,__DATE__,__TIME__);
    f_LINE('=');
    f_COMPILER();
   return(0);
}

#define C_MAX_BIN_BUFFER_SIZE  256

/* ************************************************************************* */
int f_bin2asc(void *pSRC, void *pOBJ, int iBinSize)
/* ************************************************************************* */
/*
    IN :    binSRC      0xA2
    OUT:    ascOBJ      {0x41 0x32}="A2"
    IN :    binLen
*/
{
    T_BYTE  *binSRC=(T_BYTE*)pSRC;
    T_BYTE  *ascOBJ=(T_BYTE*)pOBJ;
    int     i;
    char    asc[2*C_MAX_BIN_BUFFER_SIZE];

    memset(asc,0,sizeof(asc));
    assert(iBinSize < C_MAX_BIN_BUFFER_SIZE);

    /* _P("SRC:%p;OBJ:%p;SIZE:%d\n",binSRC,hexOBJ,size); */
    for(i=0; i < iBinSize; i++,binSRC+=1,ascOBJ+=2)
    {
        sprintf(asc,"%2.2X",(int)*binSRC);
        *ascOBJ         = asc[0];
        *(ascOBJ+1)     = asc[1];
    };
    return(i);
}

/* ************************************************************************* */
int asc2bin(void *pSRC, void *pOBJ, int iAscSize)
/* ************************************************************************* */
/*
    IN :    hexSRC      {0x41 0x32}="A2"
    OUT:    binOBJ      0xA2
    IN :    hexLen
*/
{
    int     i;
    T_BYTE  *ascSRC=(T_BYTE*)pSRC;
    T_BYTE  *binOBJ=(T_BYTE*)pOBJ;
    char    asc[2*C_MAX_BIN_BUFFER_SIZE];
    char  * pc;
    int     iBase = 16;
    unsigned long int ul;

    memset(asc,0,sizeof(asc));
    assert((unsigned)iAscSize < sizeof(asc));
    assert(iAscSize % 2 == 0);

    for(i=0; i < iAscSize; i+=2,ascSRC+=2,binOBJ+=1)
    {
        asc[0]  = *ascSRC;
        asc[1]  = *(ascSRC+1);
        ul      = strtoul(asc,&pc,iBase);
        assert(errno != ERANGE);
        *binOBJ = (T_BYTE)ul;
    };
    return(i);
}

/*  ======================================================================== */
char * f_printBits(int n, char *s, int fmtLen)
/*  ======================================================================== */
{
    /*
     *      func:   Print bits
     *      -IN :   number
     *      +OUT:   char where to save bit string
     *      -IN :   size to print
     */
    int     i;
    int     l=sizeof(n)*8;
    char    c;
    char   * pc = s;
    if (fmtLen != 0) {
        if (fmtLen < l) {
            l = fmtLen;        /* use parameter, when OK */
        }
    }
    for(i=0; i < l; i++)
    {
        c = (char)(((n >> (l-i-1)) & 1) + '0');
        *pc++ = c;
    }
    *pc = '\0';
    return(s);
}

/*  ======================================================================== */
char * f_printBYTE(char *s, int n)
/*  ======================================================================== */
/*  DESC:   Byte ausgeben
 */
{
    int             i,j,nOk=0;
    int             lByteLen=8;
    unsigned char   c;
    char            *s1 = s;

    *s1 = '\0';
    nOk=1; /* leading '0' */
    for(i=lByteLen-1,j=0; i>=0; --i,j++)
    {
        c = (char)((n >> i) & 1) + '0';
        if (c != '0') {
            nOk = 1;
        }
        if (nOk) {
            *s = c;
            s++;
        }
    }
    *s = '\0';
    return (s1);
}


/*  ======================================================================== */
void f_putBits(int n)
/*  ======================================================================== */
/*  DESC:    Bit-Muster einer Zahl ausgeben.
 */
{
    int     i;
    int     l=sizeof(n)*8;
    unsigned char    c;
    printf("BITs(%d):",n);
    for(i=l-1; i>=0; --i)
    {
        c = (char)((n >> i) & 1) + '0';
        putchar(c);
        if (i%4 == 0 && i>0) {
            putchar('.');
        };
    }
    printf(";\n");
}


/*  ======================================================================== */
int f_getBits(void)
/*  ======================================================================== */
/*
 *  DESC:   Bit-Muster einlesen, eine Zahl ausgeben
*/
{
    int     i=0;
    unsigned char    c;
    while( ((c=(char)getchar()) == ' ') || (c == '\t') ) {};
    while( (c == '0') || (c == '1')  )
    {
        i = (i << 1) | (c - '0');
        c = (char)getchar();
    }
    return(i);
}


/*  ======================================================================== */
int f_swapBits( int x, int bitnr1, int bitnr2)
/*  ======================================================================== */
/*
 *  DESC:   in data x swap bitnr1 with bitnr2
*/
{

    int newx, mask1, mask2;
    int msb = 8 * sizeof(int) - 1;         /* Hoechste Bit-Nummer  */

    if( bitnr1 < 0 || bitnr1 > msb || bitnr2 < 0 || bitnr2 > msb)
       return x;              /* Zurueck, falls ungueltige Bit-Nr.  */

    mask1 = (1 << bitnr1);              /* 1 in die Position bitnr1  */
    mask2 = (1 << bitnr2);              /* 1 in die Position bitnr2  */

    newx = x & ~(mask1 | mask2);        /* Beide Bits loeschen */

    if( x & mask1 )  newx |= mask2;     /* Bits tauschen    */
    if( x & mask2 )  newx |= mask1;

    return( newx);
}

/*
 *  --- B.W.Kernighan & D.M.Ritchie functions, S.107
 */

/*  ======================================================================== */
int f_DayOfYear(int year, int month, int day)
/*  ======================================================================== */
/*
 *  IN:     year, month, day
 *  RETURN: julian day
 */
{

    int i, n, leap;

    leap = ( ((year %4 == 0) && (year%100 != 0)) || (year%400 == 0));
    for(i=1; i<month; i++) {
        n = gC_days_per_month[leap][i];
        day += n;
    }
    return day;
}


/*  ======================================================================== */
void f_MonthDay(int year, int yearday, int *pmonth, int *pday)
/*  ======================================================================== */
/*
 *  IN: year
 *  IN: yearday = julianian day
 *  OUT:pmonth  = pointer to month
 *  OUT:pday    = pointer to day
 */
{
    int i, leap;
    leap = (((year %4 == 0) && (year%100 != 0)) || (year%400 == 0));
    for(i=1; yearday > gC_days_per_month[leap][i]; i++) {
        yearday -= gC_days_per_month[leap][i];
    }
    *pmonth = i;
    *pday   = yearday;
}

/*  ======================================================================== */
void f_anySwap(void *v[], int i, int j)
/*  ======================================================================== */
/*
 *  DESC:   swap 2 pointers
 */
{
    void    *temp;
    temp    = v[i];
    v[i]    = v[j];
    v[j]    = temp;
}

/*  ======================================================================== */
int f_cmpDoubleStr(char *s1, char *s2)
/*  ======================================================================== */
/*
 *  DESC:   compare two double strings
 *  USE:    >fct("1.234","-56.78");
 *  RET:    -1: s1<s2
 *           0: s1==s2
 *          +1: s1>s2
 */
{
    double  d1,d2;
    d1  =   atof(s1);
    d2  =   atof(s2);
    if (d1 < d2) {
        return (-1);
    } else if (d1 > d2) {
        return (1);
    } else {
        return(0);
    };
}


/*  --- K&R S.85 */
/*
 *  funktion quicksort(links, rechts)
 *      falls rechts > links dann
 *          teiler := teile(links, rechts)
 *          quicksort(links, teiler-1)
 *          quicksort(teiler+1, rechts)
 *      ende
 *  ende
*/

/*  ======================================================================== */
void f_quickSort(
        void *  v[],
        int     left,
        int     right,
        int     (*comp)(void *, void *)         /* any compare function */
    )
/*  ======================================================================== */
{
    int     i, last;
    void    f_anySwap(void *v[], int, int);   /* proto-type inside a fct */
    if (left >= right)  {
        return;
    }
    f_anySwap( v,left,((left+right)/2) );
    last = left;
    for (i=left+1;i<=right;i++)
    {
        if ((*comp)(v[i],v[left])<0)
        {
            f_anySwap(v,++last, i);
        }
    }
    f_anySwap(v,left,last);
    f_quickSort(v,left,last-1,comp);
    f_quickSort(v,last+1,right,comp);

}

/*  ======================================================================== */
int f_copyFile(char *srcFile, char *objFile)
/*  ======================================================================== */
/*  fopen,fclose,feof,ferror,fgets,fputs,fflush
 */
{
    int     i,iErr;
    char    *pLine;
    char    sLine[256];
    FILE    *fpSRC      = fopen(srcFile,"rb");
    FILE    *fpOBJ      = fopen(objFile,"wb+");

    clearerr(fpSRC);
    clearerr(fpOBJ);
    for(i=0; !feof(fpSRC); i++) {
        pLine = fgets(sLine,sizeof(sLine),fpSRC);
        if (pLine != NULL) {
            fputs(pLine,fpOBJ);
        }
        iErr = fflush(fpOBJ); /* write without cache */
    }
    if ((iErr=ferror(fpSRC)) != 0) {
        printf("ferror(fpSRC) =: <%d>\n",iErr);
    }
    fclose(fpSRC);
    fclose(fpOBJ);
    return(i);
}


typedef void        TSignalFunction(int);
TSignalFunction *   f_signalFct(int sigNr, TSignalFunction *sigHandler);

#ifndef SIGUSR1
#define SIGUSR1 30
#endif
#ifndef SIGUSR2
#define SIGUSR2 31
#endif


/*  ======================================================================== */
void f_sigHandler(int sigNr)
/*  ======================================================================== */
{
    switch(sigNr) {
        case    SIGTERM:
                printf("sigHandler:Signal 'SIGTERM' get!\n");
                break;
        case    SIGUSR1:
                printf("sigHandler:Signal 'SIGUSR1' get!\n");
                break;
        case    SIGABRT:
                printf("sigHandler:Signal 'SIGABRT' get!\n");
                break;
#ifdef OS_UNIX
        case    SIGKILL:
                printf("sigHandler:Signal 'SIGKILL' get!\n");
                break;
        case    SIGCNCL:
                printf("sigHandler:Signal 'SIGCNCL' get!\n");
                break;
        case    SIGSTOP:
                printf("sigHandler:Signal 'SIGSTOP' get!\n");
                break;
#endif
        default:
                printf("sigHandler:Signal:<%d> is not supported!\n",sigNr);
                break;
    }
}
/* possible signals called in the targetShell or hostShell */
/* FILE:C:\Windriver\vxworks-6.1-target\usr\h\signal.h */
/*
 *  VXWORKS Signale
    #define SIGKILL 9       kill
    #define SIGBUS  10      bus error
    #define SIGTERM 15      software termination signal from kill
    #define SIGCNCL 16      pthreads cancellation signal
    #define SIGSTOP 17      sendable stop signal not from tty
    #define SIGTSTP 18      stop signal from tty
    #define SIGCONT 19      continue a stopped process
    #define SIGUSR1 30      user defined signal 1
    #define SIGUSR2 31      user defined signal 2
 *
 *  WINDOWS XP  Signale
    #define SIGINT      2   Interactive attention
    #define SIGILL      4   Illegal instruction
    #define SIGFPE      8   Floating point error
    #define SIGSEGV     11  Segmentation violation
    #define SIGTERM     15  Termination request
    #define SIGBREAK    21  Control-break
    #define SIGABRT     22  Abnormal termination (abort)
*/

#if 0
   if (signal(SIGTERM, sigHandler) == SIG_ERR) {
       printf("err sigH:SIGTERM\n");
   }
#endif

/*  ======================================================================== */
char * f_getTimeStr(char *cTimeStr)
/*  ======================================================================== */
/*  Diese Funktion nutzt <time.h> anstelle von os spezifischen
 *  Include-Dateien
 */
{
    time_t  secs;
    struct  tm  *   p_tmCurrentTime;
    /*  http://www.cplusplus.com/reference/clibrary/ctime/tm.html   */
    /*  tm_sec      seconds after the minute        0-61*           */
    /*  tm_min      minutes after the hour          0-59            */
    /*  tm_hour     hours since midnight            0-23            */
    /*  tm_mday     day of the month                1-31            */
    /*  tm_mon      months since January            0-11            */
    /*  tm_year     years since                     1900            */
    /*  tm_wday     days since Sunday               0-6             */
    /*  tm_yday     days since January 1            0-365           */
    /*  tm_isdst    Daylight Saving Time flag                       */


    time(&secs);
/* #define _CRT_SECURE_NO_DEPRECATE */      /* Sonst warnings bei alten Fktn */
    p_tmCurrentTime = localtime(&secs);
#if STRFTIME_NO
    sprintf(cTimeStr,"%2.2d.%2.2d.%4.4d;%2.2d:%2.2d:%2.2d",
                     p_tmCurrentTime->tm_mday,
                     p_tmCurrentTime->tm_mon+1,
                     p_tmCurrentTime->tm_year+1900,
                     p_tmCurrentTime->tm_hour,
                     p_tmCurrentTime->tm_min,
                     p_tmCurrentTime->tm_sec);
#else
    strftime(
        cTimeStr,40 /*not Known::sizeof(cTimeStr)*/,
        "%d.%m.%Y|%H:%M:%S",
        p_tmCurrentTime);
#endif
    return(cTimeStr);
}



/*  ************************************************************************ */
#if defined(_WIN32) || defined(_WIN64)
/*  ************************************************************************ */

#include <windows.h>
#ifdef _MSC_VER
    typedef USIGN64 TTicksize;
#else
    typedef USIGN64 TTicksize;
#endif 


/*  ======================================================================== */
TTicksize f_osGetTime(void)         /* return ticks=ms */
/*  ======================================================================== */
{
#ifdef _MSC_VER
    USIGN64         tTicks = GetTickCount64();     /* OS_WINDOWS_VISTA */
#else
    USIGN32         tTicks = GetTickCount();
#endif
    /*
     * DWORD WINAPI GetTickCount(void);
     * The return value is the number of milliseconds that have elapsed
     * since the system was started.
     */
    return(tTicks);
}


/*  ======================================================================== */
char* f_osGetTimeStr(void)         /* return ms */
/*  ======================================================================== */
{
    unsigned long    divisor = 0;
    unsigned int     uMsec,uSec,uMin,uHour,uDay;

    memset(gTimeStr,0,sizeof(gTimeStr));
    divisor = GetTickCount();
    uMsec      =  divisor % 1000;
    divisor   /=  1000;
    uSec       =  divisor % 60;
    divisor   /=  60;
    uMin       =  divisor % 60;
    divisor   /=  60;
    uHour      =  divisor % 24 ;
    divisor   /=  24;
    uDay       =  divisor;
    sprintf(gTimeStr,
         "[%d/%2.2d:%2.2d:%2.2d;%3.3d]",
         uDay,uHour,uMin,uSec,uMsec);
    return(gTimeStr);
}

static UINT64 qwOldPCount=0;

/*  ======================================================================== */
USIGN64 f_osGetRealtime__WINDOWS(void)      /* return nsecs */
/*  ======================================================================== */
{
/*
 *  --- The QueryPerformanceFrequency function retrieves the frequency
 *  of the high-resolution performance counter, if one exists.
 *  The frequency cannot change while the system is running.
 *  If the installed hardware supports a high-resolution performance
 *  counter, the return value is nonzero.
 *  If the function fails, the return value is zero.
 *  To get extended error information, call GetLastError.
 *  For example, if the installed hardware does not support
 *  a high-resolution performance counter, the function fails.
 *
 *
 *  --- QueryPerformanceCounter
 *  The QueryPerformanceCounter function retrieves the
 *  current value of the high-resolution performance counter.
 *  QueryPerformanceCounter stellt fest,
 *  wie viele Millisekunden seit dem letzten Systemstart
 *  vergangen sind.
 *  Anders als GetTickCount wird die bestm�gliche Aufl�sung
 *  in einem vorzeichenlosen 64-Bit Wert abgelegt.
 *
 *  Retrieves the number of milliseconds that have elapsed
 *  since the system was started, up to 49.7 days.
 *  DWORD WINAPI GetTickCount(void);
 *  --> more is GetTickCount64(void)
*/

    LARGE_INTEGER   liCurPerfCount;
    LARGE_INTEGER   liCurPerfFreq;
    UINT64          qwCurPerfCount;
    UINT64          qwCurPerfFreq;
    UINT64          qwFactor        = 0;
    UINT64          qwSystemTime    = 0;
    static UINT64   qwOldTime       = 0;
    QueryPerformanceFrequency(&liCurPerfFreq);
    QueryPerformanceCounter(&liCurPerfCount);
    qwCurPerfCount  = F_MAKEQWORD(liCurPerfCount.HighPart, liCurPerfCount.LowPart);
    qwCurPerfFreq   = F_MAKEQWORD(liCurPerfFreq.HighPart, liCurPerfFreq.LowPart);
    assert(qwOldPCount <= qwCurPerfCount);   /* timerOverflow */
    qwOldPCount = qwCurPerfCount;
    qwFactor = (F_MAKEQWORD(0,1000) * F_MAKEQWORD(0,1000) * F_MAKEQWORD(0,1000));
    qwFactor = (USIGN64)(qwFactor * F_MAKEQWORD(0,1000));
    qwFactor = (USIGN64)(qwFactor / qwCurPerfFreq);
    qwSystemTime = (USIGN64)(qwCurPerfCount * qwFactor);
    qwSystemTime = (USIGN64)(qwSystemTime / F_MAKEQWORD(0,1000));
    assert(qwOldTime < qwSystemTime);
    qwOldTime = qwSystemTime;
    return(qwSystemTime);
}

/*  ************************************************************************ */
#else      /* WINDOWS C++ INTERFACE */

USIGN64 f_osGetRealtime__POSIX(void)
{
/*    The <time.h> header declares the structure tm,
 *    which includes at least the following members:
 *    int    tm_sec   seconds [0,61]
 *    int    tm_min   minutes [0,59]
 *    int    tm_hour  hour [0,23]
 *    int    tm_mday  day of month [1,31]
 *    int    tm_mon   month of year [0,11]
 *    int    tm_year  years since 1900
 *    int    tm_wday  day of week [0,6] (Sunday = 0)
 *    int    tm_yday  day of year [0,365]
 *    int    tm_isdst daylight savings flag
 *    The <time.h> header declares the structure timespec,
 *    which has at least the following members:
 *    time_t  tv_sec    seconds
 *    long    tv_nsec   nanoseconds
*/

    USIGN64  retVal=0;
/*  *** not working
    struct timespec {
        int tv_sec;
        int tv_nsec;
    } tp;
    struct timespec tp;
    clock_gettime(CLOCK_REALTIME,&tp);
    retVal = (USIGN64)tp.tv_sec * (USIGN64)1000 * (USIGN64)1000 * (USIGN64)1000
                + (USIGN64)tp.tv_nsec;
*/
    return(retVal);
}

#endif  /* WINDOWS/POSIX*/

/*  ************************************************************************ */

/*  ######################################################################## */
/*  FILE handling     (UNIX-2-ANSI file handling conversion)                                                       */
/*  ######################################################################## */
/*  both file functions are
 *  supported by thismodules
 */

/* ========================================================================= */
T_FILE f_FileOpen(const char *cFile, T_FILE_ACCESS mode) {
/* ========================================================================= */
   T_FILE fd;
   F_TRACE("zip_FileOpen");
#ifdef  __USE_UNIX_FILE_HANDLING
    #define RW_USER (0400 | 0200)  /* creation mode for open() */
    fd = open(cFile,mode,RW_USER);
#else
    F_printf(("*** zip_FileOpen\n"                \
                "fileName           :   %s\n"       \
                "mode               :   %s\n",
                cFile,mode));
    fd = fopen(cFile,mode);
#endif
    if (fd == 0) {
        F_TRACE("??? ERR: zip_FileOpen");
    }
    return(fd);
}

/* ========================================================================= */
int f_FileWrite(T_FILE fd, const void* buffer, int len) {
 /* ========================================================================= */
   int n;

#ifdef  __USE_UNIX_FILE_HANDLING
    n = write(fd,buffer,len);
#else
    n = fwrite(buffer,len,1,fd);
    if (n == 1) {
        n = len;
    };
#endif
    if (n == 0) {
        F_TRACE("??? ERR: zip_FileWrite");
    }

   return(n);
}

/* ========================================================================= */
int f_FileRead(T_FILE fd, void* bufferPtr, int len) {
/* ========================================================================= */
/* returns data as long as possible
 * rc==0 if error or end of file
 */
    int         n;

#ifdef  __USE_UNIX_FILE_HANDLING
    n = read(fd,buffer,len);        /* in unix very simple */
#else
    /* now the same in ANSI */
    int         fPos;
    int         i;
    T_BYTE *    buffer=(T_BYTE*)bufferPtr;
    fPos    = ftell(fd);
    n       = fread(buffer,len,1,fd);
    if (n == 1) {
        n = len;
    }
    else {
        fseek(fd,fPos,SEEK_SET);
        for(n=0; n < len; n++)
        {
            *(T_BYTE*)buffer++ = fgetc(fd);
            i = ferror(fd);
            if (i==0) {
                i = feof(fd);
            }
            if (i!=0) {
                F_printf(("\t strerror(ferror(fp)=<%d>) =: <%s>\n",
                    i,strerror(i)));
                break;
            }
        }
    }
#endif  /* __USE_UNIX_FILE_HANDLING */
    if (n == 0) {
        F_TRACE("??? ERR: zip_FileRead");
    }
    return(n);
}

/* ========================================================================= */
int f_FileClose(T_FILE fd) {
 /* ========================================================================= */
   int rc;
#ifdef  __USE_UNIX_FILE_HANDLING
    rc = close(fd);
#else
    rc = fclose(fd);     /* rc !=0 */
#endif
    if (rc != 0) {
        F_TRACE("??? ERR: zip_FileClose");
    }
    return(rc);
}

/* ========================================================================= */
int f_FileSeek(T_FILE fd,long int i_Offset, int i_Origin) {
 /* ========================================================================= */

    int n;
    /* values_for_origin::
     * {    SEEK_SET,   # Beginning of file
     *      SEEK_CUR,   # Current position of the file pointer
     *      SEEK_END    # End of file
     * }
     */
#ifdef  __USE_UNIX_FILE_HANDLING
    n = lseek(fd, i_Offset, i_Origin);
#else
    n = fseek(fd, i_Offset, i_Origin);
#endif
    return(n);
}

#endif /* INC__TUTOR_LIBRARY */
#endif /* INC__TUTOR */