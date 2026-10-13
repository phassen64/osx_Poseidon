/*  **************************************************************************
 *  Tutorial.C89  :: "library                    ©[mATe64]      [2026-10-12]
 *  **************************************************************************

 *  encoding: UTF-8
    !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿ

*  ************************************************************************* */

#include "i00_tutorC89.h"

/*  ===========================================================================
 *  m:  V.globals
 *  ======================================================================== */

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
int f_lib_vfprintf(char *fname, char *format, ...)
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
    int f_lib_vsprintf(char *str, const char *format, ...)
#else
    int f_lib_vsprintf(char *str, char *format, ...)
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
int f_lib_dump( char *          s_dataPtr,
            int             z_dataSize,
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
int f_lib_line(const char cText)
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
void f_lib_compilerInfo(void)
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
void f_lib_header(const char *cText, const char *cFile, int iLine)
/* ************************************************************************* */
{
    f_lib_line('=');
    printf("HDR=\"%s\"  SRC=[%s,%d] DATE=[%s;%s]\n",
        cText,cFile,iLine,__DATE__,__TIME__);
    f_lib_line('=');
}

void f_lib_trace(const char *cText, const char *cFile, int iLine) {
    printf("&&& %s:[%s;%d]\n", cText, __FILE__, __LINE__);
}
void f_lib_menu(const char *cText, const char *cFile, int iLine) {
    printf("\n&&& menu:%s:[%s;%d]\n\n",cText,__FILE__,__LINE__);
}
void f_lib_show(const char *cText, const char *cFile, int iLine) {
    printf("\n\t&&& %s:[%s;%d]\n\n",cText,__FILE__,__LINE__);
}


#define C_MAX_BIN_BUFFER_SIZE  256

/* ************************************************************************* */
int f_lib_bin2asc(void *pSRC, void *pOBJ, int iBinSize)
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
int f_lib_asc2bin(void *pSRC, void *pOBJ, int iAscSize)
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
char * f_lib_putByte(char *s, int n)
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
int f_lib_getByte(void)
/*  ======================================================================== */
/*
 *  DESC:   Byte-Muster einlesen, eine Zahl ausgeben
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
char * f_lib_print_Bit(int n, char *s, int fmtLen)
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
void f_lib_puts_Bit(int n)
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
int f_lib_getBits(void)
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
int f_lib_swapBit( int x, int bitnr1, int bitnr2)
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
int f_lib_dayOfYear(int year, int month, int day)
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
void f_lib_monthDay(int year, int yearday, int *pmonth, int *pday)
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
void f_lib_swapAny(void *v[], int i, int j)
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
int f_lib_cmpDoubleStr(char *s1, char *s2)
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
void f_lib_quickSort(
        void *  v[],
        int     left,
        int     right,
        int     (*comp)(void *, void *)         /* any compare function */
    )
/*  ======================================================================== */
{
    int     i, last;
    void    f_lib_swapAny(void *v[], int, int);   /* proto-type inside a fct */
    if (left >= right)  {
        return;
    }
    f_lib_swapAny( v,left,((left+right)/2) );
    last = left;
    for (i=left+1;i<=right;i++)
    {
        if ((*comp)(v[i],v[left])<0)
        {
            f_lib_swapAny(v,++last, i);
        }
    }
    f_lib_swapAny(v,left,last);
    f_lib_quickSort(v,left,last-1,comp);
    f_lib_quickSort(v,last+1,right,comp);

}

/*  ======================================================================== */
int f_lib_copyFile(char *srcFile, char *objFile)
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
char * f_lib_getTimeStr(char *cTimeStr)
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
T_FILE f_lib_fileOpen(char *cFile, T_FILE_ACCESS mode) {
/* ========================================================================= */
   T_FILE fd;
   F_TRACE("zip_FileOpen");
#ifdef  __USE_UNIX_FILE_HANDLING
    #define RW_USER (0400 | 0200)  /* creation mode for open() */
    fd = open(cFile,mode,RW_USER);
#else
    printf(("*** zip_FileOpen\n"                \
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
int f_lib_fileWrite(T_FILE fd, const void* buffer, int len) {
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
int f_lib_fileRead(T_FILE fd, void* bufferPtr, int len) {
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
                printf(("\t strerror(ferror(fp)=<%d>) =: <%s>\n",
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
int f_lib_fileClose(T_FILE fd) {
 /* ========================================================================= */
   int rc;
    rc = fclose(fd);     /* rc !=0 */
    if (rc != 0) {
        F_TRACE("??? ERR: zip_FileClose");
    }
    return(rc);
}

/* ========================================================================= */
int f_lib_fileSeek(T_FILE fd,long int i_Offset, int i_Origin) {
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
