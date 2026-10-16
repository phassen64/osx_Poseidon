/*  ***************************************************************************
 *  Tutorial.C++  :: "include.osType"       ©[mATe64]       [2026-10-16]
 *  ***********************************************************************.$.*/
//  !$@€ƒ„…†‡‰¡“”•—Ÿ¢£¤¥¦§¨™©®×±«»♔♖♞♟°²³ƒµ¶·¹º¼½¾¿ÄÖÜäöüßæœžîðñôö÷αβγδεΦXΨ.Ω.*

#ifndef __USE_TUTOR_CPP_H__OSTYPE
#define __USE_TUTOR_CPP_H__OSTYPE

//  ============================================================================
//  !m: include
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
