/*  ****************************************************************************
 *  tutorial.C89  include.protoType           ©[mATe64]           [2026-10-14]
 *  ****************************************************************************
 *  encoding: UTF-8
    !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿ
*  ****************************************************************************/

#ifndef __USE_TUTOR_CPP__INCLUDE__PROTOTYPE
#define __USE_TUTOR_CPP__INCLUDE__PROTOTYPE

/*  ===========================================================================
 *  m:  F.prototype
 *  ======================================================================  */

/*      m:  menu                                                            */
void    f_lib_header(const char *sText, const char *sFile="?", int iLine=-1);
void    f_lib_trace(const char *sText,  const char *sFile="?", int iLine=-1);
void    f_lib_menu(const char *sText,   const char *sFile="?", int iLine=-1);
void    f_lib_show(const char *sText,   const char *sFile="?", int iLine=-1);
void    f_lib_footer(const char *cText, const char *cFile="?", int iLine=-1);

void    f_lib_info(const char *sFile,   const char *sDate, const char* sTime);
void    f_lib_line(const char cChar='=');

/*      m:  tools                                                           */
int     f_lib_vfprintf(char *fName,char *sFormat, ...);
int     f_lib_vsprintf(char *sVariable, char *sFormat, ...);
int     f_lib_dump(char* sMem,int iMemSize,char* sFile,int iLine,char* sId);
char *  f_lib_print_Bit(int n, char *s, int iFmtLen);

/*      m:  File                                                            */
int     f_lib_copyFile(char *src, char *obj);

/*      m:  Byte                                                            */
char *  f_lib_putByte(char *s, int n);
int     f_lib_getByte(void);

/*      m:  bits                                                            */
void    f_lib_puts_Bit(int n);
int     f_lib_swapBit(int x, int iBitNo1, int iBitNo2);
void    f_lib_swapAny(void* v[], int i, int j);
int     f_lib_getBits(void);

/*      m:  dateTime                                                        */
char*   f_lib_getTimeStr(char* sTimeString);
int     f_lib_dayOfYear(int iYear, int iMonth, int iDay);
void    f_lib_monthDay(int iYear, int iYearday, int* iPMonth, int* iPDay);


#endif /* USE_TUTOR_CPP__INCLUDE__PROTOTYPE */