/*  ***************************************************************************
 *  Tutorial.C++  :: "include.compact"      ©[mATe64]       [2026-10-16]
 *  ***********************************************************************.$.*/
//  !$@€ƒ„…†‡‰¡“”•—Ÿ¢£¤¥¦§¨™©®×±«»♔♖♞♟°²³ƒµ¶·¹º¼½¾¿ÄÖÜäöüßæœžîðñôö÷αβγδεΦXΨ.Ω.*

#ifndef __USE_TUTOR_CPP_H__compact
#define __USE_TUTOR_CPP_H__compact

//  ============================================================================
//      m: include
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



#endif /*USE_TUTOR_CPP__INCLUDE__compact*/
