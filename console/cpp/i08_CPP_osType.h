/*  ***************************************************************************
 *  Tutorial.C++  :: "include.osType"       ©[mATe64]       [2026-10-16]
 *  ***********************************************************************.$.*/
//  !$@€ƒ„…†‡‰¡“”•—Ÿ¢£¤¥¦§¨™©®×±«»♔♖♞♟°²³ƒµ¶·¹º¼½¾¿ÄÖÜäöüßæœžîðñôö÷αβγδεΦXΨ.Ω.*

//  content:
//      •   m:  osType
//      •   m:  pragma

#ifndef __USE_TUTOR_CPP_H__osType
#define __USE_TUTOR_CPP_H__osType

//  ============================================================================
//  m:  osType
//  ============================================================================

//
//  === : m: osType := OS-Windows
//

#if defined(_WIN32) || defined(_WIN64)
    #define I_WINDOWS_H
    #define C_TUTOR__OS_WINDOWS
    #include <Windows.h>
#else
    #include <unistd.h>
#endif /* WIN32 || WIN64 */

#endif /*USE_TUTOR_CPP__INCLUDE__compact*/


//  ============================================================================
//  m:  pragma
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
