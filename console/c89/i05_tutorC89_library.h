/*  ****************************************************************************
 *  tutorial.C89  include.library               ©[mATe64]           [2026-10-12]
 *  ****************************************************************************
 *  encoding: UTF-8
    !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿ
*  ****************************************************************************/


#ifndef __USE_TUTOR_C89__INCLUDE_LIBRARY
#define __USE_TUTOR_C89__INCLUDE_LIBRARY

/*  ===========================================================================
 *  m:  F.macro
 *  ======================================================================== */


#define F_VPRINT_F(argList)     f_VFPRINTF  argList
#define F_VPRINT_S(argList)     f_VSPRINTF  argList
#define F_TIME()                f_getTimeStr(gTimeStr)

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


/*  ===========================================================================
 *  m:  F.prototype
 *  ======================================================================== */

int     f_VFPRINTF(char *fname,char *format, ...);
int     f_VSPRINTF(char *str, char *format, ...);
int     f_dump(char* mem,int memSize,char* File,int Line,char* idStr);
char *  f_printBits(int n, char *s, int fmtLen);
char *  f_printBYTE(char *s, int n);
int     f_getBits(void);
int     f_copyFile(char *src, char *obj);
int     f_DayOfYear(int year, int month, int day);
void    f_putBits(int n);
int     f_swapBits(int x, int bitnr1, int bitnr2);
char*   f_getTimeStr(char* cTimeStr);
void     f_anySwap(void* v[], int i, int j);
void    f_MonthDay(int year, int yearday, int* pmonth, int* pday);

//  extern char gTimeStr[];


#endif /*__USE_TUTOR_C89__INCLUDE_MACRO */