//  ****************************************************************************
//  TUTORIAL:   C++     :   header file
//  ****************************************************************************
//  !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß-------$

#ifndef I__TUTOR__CPP_H
#define I__TUTOR__CPP_H

/*
    content:
        •   !m: compiler
        •   !m: include
        •   !m: define
        •   !m: typedef
        •   !m: macro
        •   !m: pragma
        •   !m: class coding

    url:
        •   https://www.w3schools.com/cpp/default.asp
        •   https://cplusplus.com/doc/tutorial/
        •   https://en.wikipedia.org/wiki/ANSI_escape_code

    callMe:
        $>  _cdc
        $>  g++ c03_dataType.cpp -ansi -std=c++11 -Wall -ggdb -DTUTOR -o run.exe'
        $>  .\run.exe x
*/

//  ============================================================================
//  !m: compiler version
//  ============================================================================

/*
    The flag __cplusplus must be enabled with option:
    /Zc:__cplusplus
    https://learn.microsoft.com/en-us/cpp/build/reference/zc-cplusplus?view=msvc-170
*/
#if __cplusplus >= 201103L
    #define __USE_TUTOR__STD_C11
#else
    #define __USE_TUTOR__STD_C00
#endif


//  ============================================================================
//  !m: include
//  ============================================================================

//  !url:   https://cplusplus.com/reference/cassert/assert/
//  !url:   https://en.cppreference.com/w/cpp/error/assert
#ifndef     I_ASSERT_H
            #define     I_ASSERT_H
            #include   <assert.h>       // assert()
#endif  //* STATUS:tested


//  !url:   https://cplusplus.com/reference/cctype/
#ifndef     I_CTYPE_H
            #define     I_CTYPE_H
//&         #include    <ctype.h>       * autoinclude : max()
#endif  //* STATUS:auto


//  !url:   https://cplusplus.com/reference/chrono/
#ifdef  __USE_TUTOR__STD_C11
#ifndef     I_CHRONO_H
            #define     I_CHRONO_H
            #include    <chrono>       // C11++ chronolog only
#endif  //* STATUS:done
#endif

//  !url:   https://cplusplus.com/reference/cstring/
#ifndef     I_CSTRING_H
            #define     I_CSTRING_H
            #include   <cstring>        // !CRQ-221003 * no autoinclude: strcpy,strlen
#endif  //* STATUS:auto

//  !url:   https://cplusplus.com/reference/cerrno/errno/
#ifndef     I_ERRNO_H
            #define     I_ERRNO_H
//&         #include    <errno.h>       * autoinclude: errno
#endif  //* STATUS:auto

//  !url:   https://cplusplus.com/reference/cfloat/
#ifndef     I_FLOAT_H
            #define     I_FLOAT_H
            #include   <float.h>
#endif


//  !url:   https://cplusplus.com/reference/iostream/
#ifndef     I_IOSTREAM_H
            #define     I_IOSTREAM_H
            #include    <iostream>      // cout...
#endif  //* STATUS:tested

//  !url:   https://www.w3schools.com/cpp/cpp_math.asp
//  https://stackoverflow.com/questions/26065359/m-pi-flagged-as-undeclared-identifier
//  https://docs.microsoft.com/de-de/cpp/c-runtime-library/math-constants?view=msvc-170

#ifndef     I_MATH_H
            #define     I_MATH_H
            #define __USE_TUTOR__MATH
                    #include    <cmath>        // sqrt...
            #ifndef C_TUTOR__PI
                #define C_TUTOR__E          2.71828182845904523536
                #define C_TUTOR__LOG2E      1.44269504088896340736
                #define C_TUTOR__LOG10E     0.434294481903251827651
                #define C_TUTOR__PI         3.14159265358979323846
                #define C_TUTOR__PI_2       1.57079632679489661923
                #define C_TUTOR__PI_4       0.785398163397448309616
                #define C_TUTOR__LN2        0.693147180559945309417
                #define C_TUTOR__LN10       2.30258509299404568402
                #define C_TUTOR__SQRT2      1.41421356237309504880
            #endif
#endif  //* STATUS:tested


//  !url:   https://cplusplus.com/reference/climits/
#ifndef     I_LIMTS_H
            #define     I_LIMITS_H
            #include   <climits>        // CHAR_BIT, INT_MIN,...
#endif  //* STATUS:open


//  !url:   https://en.wikipedia.org/wiki/Stdarg.h
#ifndef     I_STDARG_H
            #define     I_STDARG_H
            #include   <stdarg.h>       // varg
#endif  //* STATUS:open


//  !url:   https://www.tutorialspoint.com/c_standard_library/stdio_h.htm
#ifndef     I_STDIO_H
            #define     I_STDIO_H
//&         #include   <stdio.h>        * autoinclude: printf,putchar,fopen
#endif  //* STATUS:auto


//  !url:   https://cplusplus.com/reference/cstdlib/
#ifndef     I_STDLIB_H
            #define     I_STDLIB_H
//&         #include   <cstdlib>        * autoinclude: rand, atoi
#endif  //* STATUS:auto

//  !url:   https://cplusplus.com/reference/string/
//  !url:   https://cplusplus.com/forum/general/38801/  :: <cstring> vs <string>
#ifndef     I_STRING_H
            #define     I_STRING_H
            #include   <string>         // std::stoi
#endif  //* STATUS:tested


#ifndef     I_TIME_H
            #define     I_TIME_H
            #include   <time.h>         // autoinclude: time, localtime
#endif  //*  STATUS:tested


//
//  === : m: OS-Windows
//

#if defined(_WIN32) || defined(_WIN64)
    #define I_WINDOWS_H
    #define C_TUTOR__OS_WINDOWS
    #include <Windows.h>
#else
    #include <unistd.h>
#endif /* WIN32 || WIN64 */


//  ============================================================================
//  !m: define constants
//  ============================================================================


#define C_TUTOR__BUFFER_SIZE           512
#define C_TUTOR__BUFFER_SIZE__TIMER    80
#define C_TUTOR__LINE_SIZE             80
#define C_TUTOR__LINE_BUFFER_SIZE      2*C_TUTOR__LINE_SIZE

#ifndef C_TUTOR__PI
    #define C_TUTOR__PI         3.14159265F
#endif
#define C_TUTOR__INTMAX         214748364L

#define C_TUTOR__ESC_SIZE               10
#define C_TUTOR__TAB_STRING     "    "
#define C_TUTOR__TAB_SIZE               5

//  ============================================================================
//  !m: typedef
//  ============================================================================

typedef char                    T_TUTOR__INT8;
typedef short int               T_TUTOR__INT16;
typedef long int                T_TUTOR__INT32;

typedef unsigned char           T_TUTOR__UINT8;
typedef unsigned short int      T_TUTOR__UINT16;
typedef unsigned long int       T_TUTOR__UINT32;

#ifdef I_WINDOWS_H
    #ifdef _MSC_VER
        typedef signed   __int64            T_TUTOR__INT64;
        typedef unsigned __int64            T_TUTOR__UINT64;
    #else
        /*  --- gnu has problems
         *  gnu ISO 90 shows warnings with
         *  '__int64' and 'long long'
        */
        typedef signed long long            T_TUTOR__INT64;
        typedef unsigned long long          T_TUTOR__UINT64;
    #endif
#else
    typedef signed long long                T_TUTOR__INT64;
    typedef unsigned long long              T_TUTOR__UINT64;
#endif

//
//  === : m: dataType: BYTE,...
//

//  url:https://learn.microsoft.com/en-us/cpp/cpp/cpp-bit-fields?view=msvc-150
//  * C++-bitfields have at least 32 bits

typedef union __u_dword {
    struct _s_bit {
        unsigned int    b0 : 1;
        unsigned int    b1 : 1;
        unsigned int    b2 : 1;
        unsigned int    b3 : 1;
        unsigned int    b4 : 1;
        unsigned int    b5 : 1;
        unsigned int    b6 : 1;
        unsigned int    b7 : 1;
        unsigned int    b8 : 1;
        unsigned int    b9 : 1;
        unsigned int    b10 : 1;
        unsigned int    b11 : 1;
        unsigned int    b12 : 1;
        unsigned int    b13 : 1;
        unsigned int    b14 : 1;
        unsigned int    b15 : 1;
        unsigned int    b16 : 1;
        unsigned int    b17 : 1;
        unsigned int    b18 : 1;
        unsigned int    b19 : 1;
        unsigned int    b20 : 1;
        unsigned int    b21 : 1;
        unsigned int    b22 : 1;
        unsigned int    b23 : 1;
        unsigned int    b24 : 1;
        unsigned int    b25 : 1;
        unsigned int    b26 : 1;
        unsigned int    b27 : 1;
        unsigned int    b28 : 1;
        unsigned int    b29 : 1;
        unsigned int    b30 : 1;
        unsigned int    b31 : 1;
    } b;
    struct _s_byte {
        unsigned int    y0 : 8;
        unsigned int    y1 : 8;
        unsigned int    y2 : 8;
        unsigned int    y3 : 8;
    } y;
    struct _s_word {
        unsigned int    wL : 16;
        unsigned int    wH : 16;
    } w;
    T_TUTOR__UINT32  v;
} T_TUTOR__dword;


typedef union __u_qword {
    struct _sQword {
        T_TUTOR__dword  dL;
        T_TUTOR__dword  dH;
    } d;
    T_TUTOR__UINT64   v;
} T_TUTOR__qword;


//  ============================================================================
//  !m: macro
//  ============================================================================

#ifndef F_TUTOR__MAX
    #define F_TUTOR__MAX(a,b)   (((a) > (b)) ? (a) : (b))
#endif

#ifndef F_TUTOR__MIN
    #define F_TUTOR__MIN(a,b)   (((a) < (b)) ? (a) : (b))
#endif

#ifndef F_TUTOR__CAT
    #define F_TUTOR__CAT(A, B) { A##B }
#endif

//  swap(Byte)
#define F_TUTOR__SWAP8(x)   (   (((x) & 0xF0) >> 4) | (((x) & 0x0F) << 4) )

//  swap(Word)
#define F_TUTOR__SWAP16(x)  (   (((x) & 0xFF00) >> 8)   \
                            |   (((x) & 0x00FF) << 8)   )

//  swap(DWord)
#define F_TUTOR__SWAP32(x)  (   (((x) & 0xFF000000) >> 24)      \
                            |   (((x) & 0x00FF0000) >> 8)       \
                            |   (((x) & 0x0000FF00) << 8)       \
                            |   (((x) & 0x000000FF) << 24)      )

//  swap(QuadWord)
#define F_TUTOR__SWAP64(x) (    (((x) & 0xFF00000000000000) >> 56)      \
                            |   (((x) & 0x00FF000000000000) >> 40)      \
                            |   (((x) & 0x0000FF0000000000) >> 24)      \
                            |   (((x) & 0x000000FF00000000) >> 8)       \
                            |   (((x) & 0x00000000FF000000) << 8)       \
                            |   (((x) & 0x0000000000FF0000) << 24)      \
                            |   (((x) & 0x000000000000FF00) << 40)      )

//  ============================================================================
//  !m: pragma
//  ============================================================================


#ifdef _MSC_VER
    #pragma warning(disable : 4244)     // __int64 => int */
    #pragma warning(disable : 4267)     // size_t' to 'int'
    #pragma warning(disable : 4456)     // declaration of 'i' hides previous local declaration...
    #pragma warning(disable : 4996)     // unsafe sprintf, strcpy,...
    /*
        •   f:  getenv      => _dupenv_s
        •   f:  localtime   => localtime_s
        •   f:  strcpy      => strcpy_s
        •   f:  strcat      => strcat_s
        •   f:  sprintf     => sprintf_s
    */
#endif

#ifdef _MSC_VER
    #undef _CRT_SECURE_NO_WARNINGS
#endif


//  ============================================================================
//  !m: class coding
//  ============================================================================

class CBasic {

    private:

        int m__i_INT_MAX_bitNumber;

        int f_iBitCounter_max(int p_iBase = 10) {
            int n = INT_MAX;
            int iCounter = 0;
            while (n > 0) {
                iCounter += 1;
                n /= p_iBase;
            }
            return iCounter;        // Base2
        }

    protected:

        FILE * m_fp = stdout;

    public:

        char m_sBuffer[256];
        char m_sPath[256];

        #if defined(_WIN32) || defined(_WIN64)
            static const char m_cDirSeparator = '\\';
        #else
            static const char m_cDirSeparator = '/';
        #endif
        char m_sDirSeparator[2];

        CBasic() {
            m__i_INT_MAX_bitNumber = f_iBitCounter_max(2);
            m_sDirSeparator[0] = this->m_cDirSeparator;
            m_sDirSeparator[1] = 0;
        };

        //  !CRQ-241216:environment
        bool f_bIsOsWindows() {
            #if defined(_WIN32) || defined(_WIN64)
                return true;
            #else
                return false;
            #endif
        }

        //  !CRQ-241216:environment
        char *f_sJoinPath(char *sDir, char *sFnm) {
            char *s = &m_sPath[0];
            char c;
            //  init dirName
            strcpy(s,sDir);
            // handleSep
            c = s[strlen(s)-1];
            if (c != m_cDirSeparator) {
                strcat(s,this->m_sDirSeparator);
            }
            //  append FileName
            strcat(s,sFnm);
            return s;
        }

        //  !CRQ-241216:environment !CRQ-241226:ScratchByFwk
        char* f_sScratchDirectory() {
            const char* pc;
            char* s = &m_sBuffer[0];
            //  init my local mem
            memset(s, 0, sizeof(m_sBuffer));
            //  fetch environment   
            #if defined(_WIN32) || defined(_WIN64)
                const char * sEnvVar_usr = {"USERPROFILE"};
                const char * sEnvVar_scr = {"v_USR_scratch_relPath"};
                pc = getenv(sEnvVar_usr);
                strcpy(s, pc);
                pc = getenv(sEnvVar_scr);
                strcat(s, pc);
            #else
                char    sFnm[100];
                const char * sEnvVar = {"HOME"};
                pc = getenv(sEnvVar);
                strcpy(s, pc);
                strcpy(sFnm, "temp");
                s = this->f_sJoinPath(s, sFnm);
            #endif
            return s;
        }

        bool f_filePtr(FILE * p_fp) {
            m_fp = p_fp;
            return true;
        }

        #define C_S2I_SIZE 12
        int f_s2i(char *s, int p_iBase=10) {

            char    c;
            int     iVal, iSum=0;
            bool    bSign = false;
            int     iSize; // = m__i_INT_MAX_bitNumber;

            m__i_INT_MAX_bitNumber = f_iBitCounter_max(p_iBase);
            iSize = m__i_INT_MAX_bitNumber;
            if (iSize > C_S2I_SIZE) {
                iSize = C_S2I_SIZE;
            }

            for(int i=0; i< iSize; i++ ) {
               c  = *s ++;
               if (!isdigit(c)) {
                    if ((i==0) && (c == '-')) {
                        bSign = true;
                        continue;
                    } else {
                        break;
                    }
               }
               iSum *= p_iBase;
               iVal = atoi(&c);
               iSum += iVal;
            }
            if (bSign) {
                iSum = -iSum;
            }
            return iSum;
        }
};


class CTimer {

    private :

        double  m__fDiff;
        char    m__cTimerBuffer[C_TUTOR__BUFFER_SIZE__TIMER];
        #ifdef  __USE_TUTOR__STD_C11
            clock_t m__tClock = 1;
        #else
            unsigned int  m__tClock;
        #endif
        time_t  m__tTime_timer;

    protected :

        char * f_sTimePtr(time_t *p_tTime, const char *p_sFmt = "%Y-%B-%d | %H:%M:%S") {
            struct  tm *    pTimeInfo;
            char *          s = m__cTimerBuffer;
            pTimeInfo   = localtime (p_tTime);
            strftime(s,sizeof(m__cTimerBuffer),p_sFmt,pTimeInfo);
            return s;
        }

    public:

        CTimer() {
            memset(m__cTimerBuffer, 0, sizeof(m__cTimerBuffer));
        }

        void f_delay(int p_iSeconds) {
            const int C_LOOP_MAX = 1000*1000*41;   // 1 sec
            double fSum = 0;
            double fAdd = 1;
            for (int iSec=0; iSec < p_iSeconds; iSec++ ) {
                for (int i=0; i < C_LOOP_MAX; i++) {
                    fSum += fAdd;
                    fAdd /= 2.0;
                }
            }
        }

        void f_sleep(int p_iSeconds) {
            #ifdef I_WINDOWS_H
                int iMsec = p_iSeconds * 1000;
                Sleep(iMsec);
            #else
                sleep(p_iSeconds);     // !CRQ-221003:UpperCase
            #endif
        }

        int f_tick() {
            int iRc;
            #ifdef  __USE_TUTOR__STD_C11
                clock_t t = clock();
            #else
                int t = 4711;
            #endif
            iRc = t - m__tClock;
            m__tClock = t;
            return iRc;
        }

        float f_timer(bool p_bStart = false) {
            time_t  tTime;
            if (p_bStart) {
                time(&tTime);
                time(&m__tTime_timer);
            }
            else {
                time(&tTime);
            }
            return (float)(difftime(tTime, m__tTime_timer));
        }

        char * f_sTime(const char *p_sFmt = "%Y-%m-%d|%H:%M:%S") {
            time_t          tTime;
            time (&tTime);
            return f_sTimePtr(&tTime,p_sFmt);
        }

}; // ~CTimer


class CColor {

    public :
        enum __e_COLOR_CODE {
            E_COLOR_NONE        ,
            E_COLOR_BLACK       ,
            E_COLOR_RED          ,
            E_COLOR_RED_BRHT     ,
            E_COLOR_GREEN        ,
            E_COLOR_GREEN_BRHT   ,
            E_COLOR_YELLOW       ,
            E_COLOR_YELLOW_BRHT  ,
            E_COLOR_BLUE         ,
            E_COLOR_BLUE_BRHT    ,
            E_COLOR_MAGENTA      ,
            E_COLOR_MAGENTA_BRHT ,
            E_COLOR_CYAN         ,
            E_COLOR_CYAN_BRHT    ,
            E_COLOR_GRAY         ,
            E_COLOR_WHITE
        } E_COLOR_CODE;

};


class CPrint : public CBasic, public CColor, public CTimer {

    private:

#ifdef __USE_TUTOR__STD_C11
        const char * C_ESC_COLOR_BLACK        = "\u001b[30m";
        const char * C_ESC_COLOR_RED          = "\u001B[31m";
        const char * C_ESC_COLOR_RED_BRHT     = "\u001B[91m";
        const char * C_ESC_COLOR_GREEN        = "\u001B[32m";
        const char * C_ESC_COLOR_GREEN_BRHT   = "\u001B[92m";
        const char * C_ESC_COLOR_YELLOW       = "\u001B[33m";
        const char * C_ESC_COLOR_YELLOW_BRHT  = "\u001B[93m";
        const char * C_ESC_COLOR_BLUE         = "\u001B[34m";
        const char * C_ESC_COLOR_BLUE_BRHT    = "\u001B[94m";
        const char * C_ESC_COLOR_MAGENTA      = "\u001B[35m";
        const char * C_ESC_COLOR_MAGENTA_BRHT = "\u001B[95m";
        const char * C_ESC_COLOR_CYAN         = "\u001B[36m";
        const char * C_ESC_COLOR_CYAN_BRHT    = "\u001B[96m";
        const char * C_ESC_COLOR_GRAY         = "\u001B[37m";
        const char * C_ESC_COLOR_WHITE        = "\u001B[97m";
        const char * C_ESC_COLOR__RESET       = "\u001B[0m";
#else
        #define C_ESC_COLOR_BLACK               "\u001b[30m"
        #define C_ESC_COLOR_RED                 "\u001B[31m"
        #define C_ESC_COLOR_RED_BRHT            "\u001B[91m"
        #define C_ESC_COLOR_GREEN               "\u001B[32m"
        #define C_ESC_COLOR_GREEN_BRHT          "\u001B[92m"
        #define C_ESC_COLOR_YELLOW              "\u001B[33m"
        #define C_ESC_COLOR_YELLOW_BRHT         "\u001B[93m"
        #define C_ESC_COLOR_BLUE                "\u001B[34m"
        #define C_ESC_COLOR_BLUE_BRHT           "\u001B[94m"
        #define C_ESC_COLOR_MAGENTA             "\u001B[35m"
        #define C_ESC_COLOR_MAGENTA_BRHT        "\u001B[95m"
        #define C_ESC_COLOR_CYAN                "\u001B[36m"
        #define C_ESC_COLOR_CYAN_BRHT           "\u001B[96m"
        #define C_ESC_COLOR_GRAY                "\u001B[37m"
        #define C_ESC_COLOR_WHITE               "\u001B[97m"
        #define C_ESC_COLOR__RESET              "\u001B[0m"
#endif

    protected:

        bool m__bColor_enabled; // C11: = false;

        void f__print(char *p_sString, int p_iColor, bool p_bNL) {

            bool    bColor = m__bColor_enabled;
            char    sColor[C_TUTOR__ESC_SIZE];

            switch(p_iColor) {
                case E_COLOR_RED            : strcpy(sColor,C_ESC_COLOR_RED) ;          break;
                case E_COLOR_RED_BRHT       : strcpy(sColor,C_ESC_COLOR_RED_BRHT) ;     break;
                case E_COLOR_GREEN          : strcpy(sColor,C_ESC_COLOR_GREEN) ;        break;
                case E_COLOR_GREEN_BRHT     : strcpy(sColor,C_ESC_COLOR_GREEN_BRHT) ;   break;
                case E_COLOR_BLUE           : strcpy(sColor,C_ESC_COLOR_BLUE) ;         break;
                case E_COLOR_BLUE_BRHT      : strcpy(sColor,C_ESC_COLOR_BLUE_BRHT) ;    break;
                case E_COLOR_YELLOW         : strcpy(sColor,C_ESC_COLOR_YELLOW) ;       break;
                case E_COLOR_YELLOW_BRHT    : strcpy(sColor,C_ESC_COLOR_YELLOW_BRHT) ;  break;
                case E_COLOR_CYAN           : strcpy(sColor,C_ESC_COLOR_CYAN) ;         break;
                case E_COLOR_CYAN_BRHT      : strcpy(sColor,C_ESC_COLOR_CYAN_BRHT) ;    break;
                case E_COLOR_MAGENTA        : strcpy(sColor,C_ESC_COLOR_MAGENTA) ;      break;
                case E_COLOR_MAGENTA_BRHT   : strcpy(sColor,C_ESC_COLOR_MAGENTA_BRHT) ; break;
                case E_COLOR_GRAY           : strcpy(sColor,C_ESC_COLOR_GRAY) ;         break;
                case E_COLOR_WHITE          : strcpy(sColor,C_ESC_COLOR_WHITE) ;        break;
                case E_COLOR_NONE           : break;
                default:
                    bColor = false;
            };

            if (bColor) {
                fprintf(m_fp,"%s%s%s",sColor,p_sString,C_ESC_COLOR__RESET);
            } else {
                fprintf(m_fp,"%s",p_sString);
            }
            if (p_bNL) {
                fprintf(m_fp,"\n");
            }
        }

        void f__puts(char *p_sString, int p_iColor) {
            f__print(p_sString,p_iColor,true);
        }

    public:
        CPrint() {
            m__bColor_enabled = false;
        }
};

class CVPrint  : public CPrint {
    public:
        char * f_sPrint(char *p_cBuffer, const char *p_sFmt, ...) {
            va_list  tVaList;
            va_start(tVaList, p_sFmt);
            vsprintf (p_cBuffer, p_sFmt, tVaList);
            va_end(tVaList);
            return p_cBuffer;
        }
};

class CTrace  : public CVPrint {
    private:
        char m__cTraceBuffer[C_TUTOR__LINE_BUFFER_SIZE];
    public:
        void f_trace(const char *p_sText, const char *p_sFile, int p_iLine)
        {
            char *s = m__cTraceBuffer;
            sprintf(s,"--- T:\"%s\"  [%s;%d]", p_sText, p_sFile, p_iLine);
            f__puts(s,E_COLOR_MAGENTA_BRHT);
        }
        void f_info(const char *p_sText, const char *p_sFile, int p_iLine)
        {
            char *s = m__cTraceBuffer;
            sprintf(s,"--- I:\"%s\"  [%s;%d]", p_sText, p_sFile, p_iLine);
            f__puts(s,E_COLOR_YELLOW_BRHT);
        }
        void f_error(const char *p_sText, const char *p_sFile, int p_iLine)
        {
            char *s = m__cTraceBuffer;
            int iEc     = errno;
            int cClr = E_COLOR_RED;
            if (iEc != 0) {
                cClr = E_COLOR_RED;
                strcpy(s, "??? E==");
                sprintf(s, "%s<%d>",s, iEc);
            }
            else {
                cClr = E_COLOR_YELLOW;
                strcpy(s, "!!! E==0");
            }
            sprintf(s,"%s:\"%s\" [%s;%d]",
                    s,p_sText, p_sFile, p_iLine);
            f__puts(s,cClr);
        }
        CTrace() {
            memset(m__cTraceBuffer, 0, sizeof(m__cTraceBuffer));
        }
};

class CMenu   : public CTrace {

    private:

        int     m__iChapCtr;
        int     m__iMenuCtr;
        int     m__iSubMenuCtr;
        int     m__iTextCtr;
        int     m__iLine;
        #if defined(_MSC_VER)
            bool m__bRc = false;
        #else
            bool m__bRc;
        #endif
        char            m__cMenuBuffer[C_TUTOR__LINE_BUFFER_SIZE];
        char            m__cLineBuffer[C_TUTOR__LINE_SIZE+0x20];
        char            m__sFileName[C_TUTOR__LINE_SIZE];
#ifdef __USE_TUTOR__STD_C11
        const char *    m__cTab = "    ";
#else
        char            m__cTab[C_TUTOR__TAB_SIZE];
#endif
        time_t          m__tTime_menu;

        void f__print_line(const char cId) {
            char    sLine[C_TUTOR__LINE_SIZE + 1];
            char    *s = sLine;
            for(int i=0; i < C_TUTOR__LINE_SIZE; i++) {
                * s ++ = cId;
            }
            * s = 0;
            f__puts(sLine, E_COLOR_GREEN);
        }

        void f__show_compiler(void)
        {
            char *s = m__cMenuBuffer;

            sprintf(s,"... isC++           :");
            #ifdef  __cplusplus
                strcat(s,"'YES");
            #else
                strcat(s,"'NO!");
            #endif
            f__puts(s, E_COLOR_GREEN);

            sprintf(s,"... isC11 x         :");
            #ifdef  __USE_TUTOR__STD_C11
                strcat(s,"'STDCC11");
            #else
                strcat(s,"'STDANSI");
            #endif
            f__puts(s, E_COLOR_GREEN);

            sprintf(s,"... isSTANDARD_C %s:",m__cTab);
            #ifdef  __STDC__
                strcat(s,"'YES'");
            #else
                strcat(s,"'NO!");
            #endif
            f__puts(s, E_COLOR_GREEN);

            sprintf(s,"... isCompiler %s:",m__cTab);
            #if defined(_MSC_VER)
                strcat(s,"'_MSC_VER'");
            #elif defined(__GNUC__)
                strcat(s,"'__GNUC__'");
            #elif defined(__BORLANDC__)
                strcat(s,"'__BORLANDC__'");
            #else
                strcat(s,"'??? UNKNOWN'");
            #endif
            f__puts(s, E_COLOR_GREEN);

            //  compiler version    >> 201103
            sprintf(s,"... __cplusplus %s:%ld",m__cTab,__cplusplus);
            f__puts(s, E_COLOR_GREEN);

            sprintf(s,"... isWIN32/64 %s:",m__cTab);
            #if defined(_WIN32) || defined(_WIN64)
                strcat(s,"'__WIN64__'");
                #include <Windows.h>        // enables sleep
            #else
                strcat(s,"'__UNIX___'");
                #include <unistd.h>
            #endif /* WIN32 || WIN64 */
            f__puts(s, E_COLOR_GREEN);
        }

        void f__show_DTm(void) {
            char *s = m__cMenuBuffer;
            sprintf(s,"... DTm %s: [%s;%s]",m__cTab,__DATE__,__TIME__);
            f__puts(s, E_COLOR_GREEN);
        }

        void f__show_Ec(void) {
            char* s = m__cMenuBuffer;
            sprintf(s,"%sStatusEc =: <%s>",  m__cTab, m__sEc_status);
            f__puts(s, E_COLOR_CYAN);
        }

        bool f__fetchFileName(const char * p_sFile) {
            char    *   pc;
            char        c;
            memset(m__cBuffer, 0, sizeof(m__cBuffer));
            memset(m__sFileName, 0, sizeof(m__sFileName));
            strncpy(m__cBuffer, p_sFile, sizeof(m__cBuffer) - 1);
            #ifdef C_TUTOR__OS_WINDOWS
                    c = '\\';
            #else
                    c = '/';
            #endif
            pc = strrchr(m__cBuffer, c);
            if (pc != 0) {
                pc++;
                strncpy(m__sFileName, pc, sizeof(m__sFileName));
                return true;
            }
            else if (strlen(m__cBuffer) < sizeof(m__sFileName)) {
                strcpy(m__sFileName, p_sFile);
            }
            else {
                strcpy(m__sFileName, "__?AnyFile__");
            }
            return false;
        }

    protected:

        float   m__fStart,
                m__fStopp;
#ifdef  __USE_TUTOR__STD_C11
        int     m__iEc=12345;
#else
        int     m__iEc;
#endif
        char    m__sEc[40];
        char    m__sEc_status[C_TUTOR__LINE_SIZE];
        char    m__cBuffer[C_TUTOR__BUFFER_SIZE];


        void f__header(const char *p_sHdr, const char *p_sFile, int p_iLine, bool p_bHdr=false) {

            char * s        = m__cMenuBuffer;
            char * sLine    = m__cLineBuffer;
            char    sHdrId[C_TUTOR__LINE_SIZE];
            const   char *sEnv_exit = "v_FWK_exitCode";
            float   fTime;
            time_t  tTime;
            char    sEcOut[20];
            bool    bLineOut = false;

            //  === :s  init buffer
            *s = 0;
            *sLine = 0;

            //  === :s  fetchFileName  :out m__sFileName
            m__bRc = f__fetchFileName(p_sFile);

            //  === :s  HeaderID
            if (p_bHdr) {   // !CRQ-260630:change
                strcpy(sHdrId, "=== H:HDR:");  
            } else {
                strcpy(sHdrId, "=== F:FTR:");
            }
            strcat(sHdrId, "<");
            strcat(sHdrId,p_sHdr);
            strcat(sHdrId, ">");

            //  === :s  init counter
            if (p_bHdr) {
                m__iChapCtr = 0;
                m__iMenuCtr = 0;
                m__iSubMenuCtr = 0;
                m__iTextCtr = 0;
            }

            //  === :s  line
            if (p_iLine > 0) { m__iLine = p_iLine; }

            //  === :s  exitCode
            if (p_bHdr) {
                snprintf(m__sEc,sizeof(m__sEc),"%s",std::getenv(sEnv_exit));
                if (strcmp((const char*)m__sEc,"(null)") == 0) {
                    m__iEc = -__LINE__;
                } else {
                    try {
                        #ifdef __USE_TUTOR__STD_C11
                            m__iEc = std::stoi(m__sEc);
                        #else
                            m__iEc = f_s2i(m__sEc);
                        #endif
                        sprintf(m__sEc_status,"f__header.iEc:%d",m__iEc);
                    }
                    catch (const std::invalid_argument& ia) {
                        sprintf(m__sEc_status,
                            "%s => Invalid argument:%s",
                            sEnv_exit,ia.what());
                    }
                }
            } else {
//              strcpy(std::getenv(sEnv_exit),m__sEc);  // writeBack - error
            }
#ifdef __USE_DEBUG
            fprintf(m_fp,"Status:%s\n",m__sEc_status);
#endif
            //  === :s  output String temp
            sprintf(sLine,"[%s;%d]{%s}",
                m__sFileName,p_iLine,f_sTime("%y%m%d%H%M%S"));
            sprintf(sEcOut,"::[%d]", m__iEc);

            //  === :s  run timer
            if ( p_bHdr ) {
                time(&m__tTime_menu);
#ifdef __USE_DEBUG
                fprintf(m_fp,"--- HeaderTime =: '%s'\n",f_sTimePtr(&m__tTime_menu));
#endif
                strcpy(s,sLine);
                f_sleep(1);
            } else {
                time(&tTime);
#ifdef __USE_DEBUG
                printf("--- HeaderTime.old =: %s\n",f_sTimePtr(&m__tTime_menu));
                printf("--- FooterTime.new =: %s\n",f_sTimePtr(&tTime));
#endif
                fTime = (float)difftime(tTime,m__tTime_menu);
//              printf("**** getTime2:<%f>\n",fTime);
                sprintf(s,sLine,"%s elapsed:<%.1f> secs",sLine,fTime);
            }

            //  === :s  show
            if (bLineOut) {f__print_line('=');} ;
            f__print(sHdrId, E_COLOR_GREEN_BRHT,false);
            f__print(s, E_COLOR_GRAY, false);
            f__puts(sEcOut, E_COLOR_GREEN_BRHT);  // !CRQ-260630:color
            if (bLineOut) {f__print_line('=');} ;
        }

    public:

        CMenu() {
            m__fStart = 0.0;
            m__fStopp = 0.0;
            m__iChapCtr = 0;
            m__iMenuCtr = 0;
            m__iSubMenuCtr = 0;
            m__iTextCtr = 0;
            m__iLine = 0;

            memset(m__cBuffer, 0, sizeof(m__cBuffer));
            memset(m__cMenuBuffer, 0, sizeof(m__cMenuBuffer));
            memset(m__cLineBuffer, 0, sizeof(m__cLineBuffer));
            memset(m__sFileName, 0, sizeof(m__sFileName));
            memset(m__sEc, 0, sizeof(m__sEc));
            #ifndef __USE_TUTOR__STD_C11
                m__iEc=12345;
                strcpy(m__cTab,C_TUTOR__TAB_STRING);
            #endif
        }

        int f_header(const char *p_sText, const char *p_sFile, int p_iLine) {
            f__header(p_sText,p_sFile,p_iLine,true);
            return m__iEc;
        }

        int f_footer(const char *p_sText, const char *p_sFile, int p_iLine) {
            f__header(p_sText,p_sFile,p_iLine,false);
            return m__iEc;
        }

        int f_iEc() {
            return m__iEc;
        }

        void f_chapter(const char *p_sText, const char *p_sFile="?F",
                    int p_iLine=-1, bool p_bSep = false) {
            char *s = m__cMenuBuffer;
            char z  = E_COLOR_YELLOW_BRHT;
            char sSep[10];
            m__iChapCtr += 1;
            m__iMenuCtr = m__iSubMenuCtr = m__iTextCtr = 0;
            //  === :s  fetchFileName  :out m__sFileName
            m__bRc = f__fetchFileName(p_sFile);
            if (p_bSep) {
                strcpy(sSep,"--- C: ");
            } else {
                sprintf(sSep,"%sC: ",m__cTab);
                z  = E_COLOR_CYAN;

            }
            sprintf(s,"%s %s at:[%s;%d] <%d>", sSep,p_sText,m__sFileName,p_iLine,m__iChapCtr);
            f__puts(s,z);
        }

        void f_menu(const char *p_sText, int p_iLine=-1) {
            char *s = m__cMenuBuffer;
            m__iMenuCtr += 1;
            m__iSubMenuCtr = 0;
            m__iTextCtr = 0;
            if (p_iLine > 0) { m__iLine = p_iLine; }
            sprintf(s,"--- M:  %s at:[%d] <%d>", p_sText,p_iLine,m__iMenuCtr);
            f__puts(s,E_COLOR_GREEN_BRHT);
        }

        void f_subMenu(const char *p_sText, int p_iLine=-1) {
            char *s = m__cMenuBuffer;
            m__iSubMenuCtr += 1;
            m__iTextCtr = 0;
            if (p_iLine > 0) { m__iLine = p_iLine; }
            sprintf(s,"%sm:  %s at:[%d] <%d>", m__cTab, p_sText,p_iLine,m__iSubMenuCtr);
//          sprintf(s,"--- m: %s at:[%d] <%d>", p_sText,p_iLine,m__iSubMenuCtr);
            f__puts(s,E_COLOR_GREEN);
        }

        void f_text(const char *p_sText, int p_iColor=E_COLOR_WHITE) {
            char *s = m__cBuffer;
            m__iTextCtr += 1;
            sprintf(s,"%st:  %s%s <%d>", m__cTab, p_sText, m__cTab, m__iTextCtr);
            f__puts(s,p_iColor);
        }

        //  overloading
        void f_text(int p_iColor, const char *p_sFmt,...) {
            char *s = m__cBuffer;
            char sText[C_TUTOR__LINE_BUFFER_SIZE];
            memset(sText, 0, sizeof(sText));
            va_list  tVaList;
            va_start(tVaList, p_sFmt);
            vsnprintf (sText, C_TUTOR__LINE_BUFFER_SIZE-2, p_sFmt, tVaList);
            va_end(tVaList);
            sText[C_TUTOR__LINE_BUFFER_SIZE - 1] = 0;
            m__iTextCtr += 1;
            sprintf(s,"%st:  %s%s <%d>",
                    m__cTab, sText, m__cTab, m__iTextCtr);
            f__puts(s,p_iColor);
        }

        void f_status() {
            f__show_DTm();
            f__show_compiler();
            f__show_Ec();
        }
};


class CTutor : public CMenu {

    private:
        int  m_iCounter;

    public:

//      constructor
        CTutor() {
            srand((unsigned int)time(NULL));
            m_iCounter = 0;
        }

        void f_mode_color(bool p_bColor) {
            if (p_bColor) {
                m__bColor_enabled = true;
            }
        }

//      wrapper.VAR
        void f_print(int p_iColor, const char *p_sFmt,...) {
            char* s = m__cBuffer;
            va_list  tVaList;
            va_start(tVaList, p_sFmt);
            vsprintf (s, p_sFmt, tVaList);
            va_end(tVaList);
            f__print(s, p_iColor, false);
        }
        void f_puts(int p_iColor, const char *p_sFmt,...) {
            char* s = m__cBuffer;
            va_list  tVaList;
            va_start(tVaList, p_sFmt);
            vsprintf (s, p_sFmt, tVaList);
            va_end(tVaList);
            f__print(s, p_iColor, true);
        }

//      wrapper.STD
        void f_print(char *p_sString, int p_iColor=E_COLOR_GRAY, bool p_bNL=false) {
            f__print(p_sString, p_iColor, p_bNL);
        }
        void f_puts(char *p_sString, int p_iColor=E_COLOR_GRAY) {
            f__print(p_sString, p_iColor, true);
        }

        void f_echo(const char* p_cString, int p_iColor = E_COLOR_GRAY) {
            char* s = m__cBuffer;
            strcpy(s, p_cString);
            f__print(s, p_iColor, true);
        }

        void f_show_runtime() {
            char* s = m__cBuffer;
            time_t  tTime;
            time(&tTime);
            sprintf(s, "--- i: runTime  =: %s", f_sTimePtr(&tTime));
            f_puts(s, E_COLOR_BLUE_BRHT);
        }

        int f_iCounter(bool p_bStart = false) {
            int iRc;
            if (p_bStart) {
                iRc = m_iCounter;
                m_iCounter  = 0;
            } else {
                m_iCounter += 1;
                iRc  = m_iCounter;

            }
            return iRc;
        }

        int f_iRandom(int p_iMax = 10, int p_iMin = 1) {

            int     iRnd,
                iMax = p_iMax,      // M = 5
                iMin = p_iMin;      // N = 2
            int     x = 1;

            if (p_iMin >= p_iMax) {
                iMin = 1;
            }

            x = iMax - iMin + 1;    //  5-2+1 => x=4 => 0...3 ; x = M-N+1 => M = N+x-1
            iRnd = rand() % x;      //  y = [0...x-1]
            iRnd += iMin;           //  y +=N => y=[N...N+x-1]=[N...M]
            return(iRnd);
        }

        char* f_sInt2Bin(int p_iValue, bool p_bBeauty = false) {

            char    c;
            char* s = m__cBuffer;
            char* pc;
            char    sDigit[64];
            int     i, j, n, x;

            x = n = p_iValue;
            pc = s;
            i = 0;
            memset(s, 0, sizeof(m__cBuffer));

            //  int => binString
            while (x > 0) {
                if (x % 2 == 0) {
                    *pc = '0';
                }
                else {
                    *pc = '1';
                }
                x /= 2;
                pc++;
                i += 1;
            }

            //  complete %8
            while (i++ % 8 != 0) {
                *pc++ = '0';
            }
            *pc = 0;

            //  reverse string
            j = strlen(s);
            memset(sDigit, 0, sizeof(sDigit));
            for (i = 0; j > 0; i++, j--) {
                sDigit[i] = s[j - 1];
            }
            sDigit[i] = 0;

            //  beauty
            memset(s, 0, sizeof(m__cBuffer));
            if (p_bBeauty) {
                j = strlen(sDigit) - 1;
                for (i = 0, pc = s; i <= j; i++) {
                    c = sDigit[i];
                    *pc++ = c;
                    if ((i != 0) && (i != j) && ((i + 1) % 4 == 0)) {
                        *pc++ = '.';
                    }
                }
                *pc++ = 0;
            }
            else {
                strcpy(s, sDigit);
            }
            return s;
        }

}; // CTutor

#endif  /* I__TUTOR__CPP_H */
