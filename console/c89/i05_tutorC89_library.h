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


#define F_VPRINT_F(argList)     f_lib_vfprintf  argList
#define F_VPRINT_S(argList)     f_lib_vsprintf  argList
#define F_TIME()                f_lib_getTimeStr(gTimeStr)

#define F_DUMP(idStr,mem,size)  f_lib_dump(mem,size,__FILE__,__LINE__,idStr)

#if TESTEN
#define F_TRACE_V(arglist)      SYSEM_TRACE ((C_PFSP_TRACE_DEBUG,\
                                           "*** vTRACE:[%s,%d]:", \
                                          f_getFileName(__FILE__),__LINE__)); \
                                          pfsp_vPRINT arglist;
#endif


#define F_TRACE(x)  f_lib_trace(x, __FILE__, __LINE__)
#define F_printf(x) printf x


#define F_HEADER(x)     f_lib_header(x,__FILE__,__LINE__);
#define F_MENU(x)       f_lib_menu(x,__FILE__,__LINE__)
#define F_SHOW(x)       f_lib_show(x,__FILE__,__LINE__)

/*  ===========================================================================
 *  m:  F.prototype
 *  ======================================================================== */

void f_lib_header(const char *cText, const char *cFile, int iLine);
void f_lib_trace(const char *cText, const char *cFile, int iLine);
void f_lib_menu(const char *cText, const char *cFile, int iLine);
void f_lib_show(const char *cText, const char *cFile, int iLine);

int     f_lib_vfprintf(char *fname,char *format, ...);
int     f_lib_vsprintf(char *str, char *format, ...);
int     f_lib_dump(char* mem,int memSize,char* File,int Line,char* idStr);
char *  f_lib_print_Bit(int n, char *s, int fmtLen);
char *  f_lib_print_Byte(char *s, int n);
int     f_lib_get_Byte(void);
int     f_lib_copyFile(char *src, char *obj);
void    f_lib_puts_Bit(int n);
int     f_lib_swapBit(int x, int bitnr1, int bitnr2);
void    f_lib_swapAny(void* v[], int i, int j);

char*   f_lib_getTimeStr(char* cTimeStr);
int     f_lib_dayOfYear(int year, int month, int day);
void    f_lib_monthDay(int year, int yearday, int* pmonth, int* pday);

//  extern char gTimeStr[];


#endif /*__USE_TUTOR_C89__INCLUDE_MACRO */