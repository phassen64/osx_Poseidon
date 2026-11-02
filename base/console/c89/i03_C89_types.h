/*  ****************************************************************************
 *  tutorial.C89  include.types                ©[mATe64]           [2026-10-12]
 *  ****************************************************************************

    encoding: UTF-8
    !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿ

    content:
        m:  C.whiteChar
        m:  C.math
        m:  C.synonyms
        m:  T.PrimitiveTypes
        m:  T.File
        m:  T.Data
        m:  F.macro

*  ****************************************************************************/


#ifndef __USE_TUTOR_C89__INCLUDE_TYPES
#define __USE_TUTOR_C89__INCLUDE_TYPES


/*  ===========================================================================
 *  m:  C.whiteChar
 *  ======================================================================== */

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

/*  ===========================================================================
 *  m:  C.math
 *  ======================================================================== */

#define C_E             2.71828182    /* 2.718281928459045 */
#define C_PI            3.14159265    /* 3.141592653589793 */

/*  ===========================================================================
 *  m:  C.synonyms
 *  ======================================================================== */

#define C_WORD_SIGN         0x8000
#define C_WORD_MAX          0xFFFF
#define C_DWORD_SIGN        0x80000000

#define C_CARD8             unsigned char
#define C_CARD16            unsigned short int
#define C_CARD32            unsigned long int

/*  ===========================================================================
 *  m:  T.PrimitiveTypes
 *  ======================================================================== */

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

/*  ===========================================================================
 *  m:  T.Data
 *  ======================================================================== */


typedef enum BOOL_enum_tag {
    E_FALSE = 0,
    E_TRUE  = 1
} T_BOOL;

/*  ===========================================================================
 *  m:  F.macro
 *  ======================================================================== */

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


#define F_QSTR(x)               # x
#define F_CONCAT( a, b )        a ## b
#define F_XCONCAT(a,b)          F_CONCAT(a,b)

#define F_OFFSETOF(s,m)    ((size_t)&(((s *)0)->m))
#define F_INTSIZEOF(n)     ( (sizeof(n) + sizeof(int) - 1) & ~(sizeof(int) - 1) )
#define F_VASTART(ap,v)    ( ap = (VALIST)&v + INTSIZEOF(v) )
#define F_VAARG(ap,t)      ( *(t *)((ap += INTSIZEOF(t)) - INTSIZEOF(t)) )
#define F_VAEND(ap)        ( ap = (VALIST)0 )
#define F_UNREFPARM(p)     {(p)=(p);}
#define F_ENDOF(p)         ((p)+1)


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


#endif /*__USE_TUTOR_C89__INCLUDE_TYPES */