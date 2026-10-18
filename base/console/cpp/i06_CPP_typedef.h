/*  ****************************************************************************
 *  tutorial.C89  include:C.dataType        ©[mATe64]           [2026-10-14]
 *  ****************************************************************************
 *  encoding: UTF-8
    !$@€ƒ„…†‡‰¡“”•—Ÿ¢£¤¥¦§¨™©®×±«»♔♖♞♟°²³ƒµ¶·¹º¼½¾¿ÄÖÜäöüßæœžîðñôö÷αβγδεΦXΨ.Ω.*

 *  content:
    •   m:  C.typeDef

* ************************************************************************.$.*/

#ifndef __USE_TUTOR_CPP_H__typeDef
#define __USE_TUTOR_CPP_H__typeDef

//  ============================================================================
//  m: C.typeDef
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



#endif /* USE_TUTOR_CPP_H__typeDef */