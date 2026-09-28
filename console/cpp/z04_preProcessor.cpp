//  ****************************************************************************
//  TUTORIAL:   C++     :   PreProcesssor
//  ****************************************************************************
//  !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß-------$

/*
    content:
        •   m:  #define
        •   m:  #if #else #elif #endif
        •   m:  #define #undef #ifndef defined()
        •   m:  #pragma
        •   m:  #error
        •   m:  #line
        •   m:  function F(x)

    keyw•rds related to PP<12>:
        •  include
        •  define
        •  if elif else endif
        •  defined ifndef undef
        •  line
        •  error
        •  pragma
        sum:12

    keywords related to PP C++23:
        •   elifdef     (C++23)
        •   elifndef    (C++23)
        •   warning     (C++23)
        sum:3


    url:
        https://cplusplus.com/doc/tutorial/preprocessor/

 */


#include "Tutor.h"
using namespace std;


int F04_preProcessor(CTutor &m) {
    const char*     sHdr = "PProcessor";
    int             iEc;
    bool            bVal;
    int             iVal;
    float           fVal;
    double          dVal;
    char            z = m.E_COLOR_GRAY;

//  =:= b:  body
    m.f_header(sHdr,__FILE__,__LINE__);
    iEc = m.f_iEc();        // get explicit

//  =:= m:  #define

    m.f_menu("#define",__LINE__);

    #define C_PP_i      123
    m.f_text(z,"C_PP_i   =: '%d'",C_PP_i);
    iVal = C_PP_i; // using PP variable
    m.f_text(z, "iVal     =: '%d'", iVal);

    #define C_PP_d  -99.123
    m.f_text(z, "C_PP_d   =: '%f'", C_PP_d);
    dVal = C_PP_d;
    m.f_text(z, "dVal     =: '%e'", dVal);

    #define C_PP_s      "Hello-IWasDefinedByC++PreProcessor"
    m.f_text(z,"C_PP_s   =: '%s'",C_PP_s);

    #define C_PP_b      true
    m.f_text(z,"C_PP_b   =: '%d'",C_PP_b);
    bVal =  C_PP_b; // using PP variable
    m.f_text(z,"bVal     =: '%d'",bVal);

//  =:= m:  #if #else #elif #endif"

    m.f_menu("#if #else #elif #endif",__LINE__);

    #if     C_PP_i == 1
        m.f_text(z,"C_PP_i  == 1");
    #elif   C_PP_i == 0
        m.f_text(z,"C_PP_i  == 0");
    #elif   C_PP_i > 100
        m.f_text(z,"C_PP_i  > 100");
    #else
        m.f_text(z,"C_PP_i  == any ");
    #endif

//  =:= m:  #define #undef #ifndef defined()

    m.f_menu("#define defined() #undef",__LINE__);

    m.f_subMenu("define",__LINE__);
    #define C_PP_x '!'
    m.f_text(z,"C_PP_x   =: '%c'",C_PP_x);

    m.f_subMenu("defined",__LINE__);
    #if defined (C_PP_x)
        m.f_text(z,"defined(C_PP_x) => yes");
    #else
        m.f_text(z,"defined(C_PP_x) => no!");
    #endif

    m.f_subMenu("undef",__LINE__);
    #undef C_PP_x

    #if defined (C_PP_x)
        m.f_text(z,"defined(C_PP_x) => yes");
    #else
        m.f_text(z,"defined(C_PP_x) => no!");
    #endif

    m.f_subMenu("ifndef",__LINE__);
    #ifndef C_PP_x
        m.f_text(z,"ifndef C_PP_x  == true");
    #endif

//  =:= m:  #pragma

    m.f_menu("#pragma", __LINE__);
    #ifdef _MSC_VER
        #pragma warning(suppress : 4305)    // truncation from 'double' to 'float'
    #endif
    m.f_text(z,"pragma used");

    #define C_PP_f  -1.234
    m.f_text(z, "C_PP_f   =: '%f'", C_PP_f);
    #ifdef _MSC_VER
        fVal =  (float)C_PP_f;  //  typecast needed - warning C4305 is not suppressed
    #else
        fVal = C_PP_f;
    #endif
    m.f_text(z, "fVal     =: '%g'", fVal);

//  =:= m:  #error

    m.f_menu("#error",__LINE__);

    #if !defined (__cplusplus)
        #error C++ compiler required.
    #else
        m.f_text(z,"Compiler is C++ => true");
    #endif

    //  =:= m:  function F(x)

    m.f_menu("function F(x)", __LINE__);

    //  =:= s:  F_MAX(x,y)

    m.f_subMenu("F_MAX(x,y)", __LINE__);
#ifndef F_MAX
    #define F_MAX(A,B) ((A) > (B) ? (A) : (B))
#endif
    #define C_PP_f1     5.6
    #define C_PP_f2     -1.2
    m.f_text(z, "C_PP_f1  =: '%f'", C_PP_f1);
    m.f_text(z, "C_PP_f2 =: '%f'", C_PP_f2);
    m.f_text(z, "MAX(f1,f2)  =: '%f'", F_MAX(C_PP_f1, C_PP_f2));

    //  =:= s:  F_CAT(x,y)

    m.f_subMenu("F_CONCATENATE(x,y)", __LINE__);

    #define C_PP_s1     "Harvey"
    #define C_PP_s2     " springt im Balkon"

    m.f_text(z, "C_PP_s1         =: '%s'", C_PP_s1);
    m.f_text(z, "C_PP_s2         =: '%s'", C_PP_s2);

#ifdef __USE_TUTOR__STD_C11

    #ifndef F_CAT
        #define F_CAT(A, B) { A##B }  // A ## B
    #endif

    dVal = F_CAT(1., 23);
    m.f_text(z, "f## =: '%f'", dVal);

    #ifdef _MSC_VER
        //  !CRQ:not in gnuPP
        iVal = F_CAT(-, 987); m.f_text(z, "i## =: '%i'", iVal);

        //  !CRQ:not in gnuPP
        const char* sHarvey = F_CAT("Harvey", "springt im Balkon");
        m.f_text(z, "s##  =: '%s'", sHarvey);
    #else
        #ifdef __USE_TUTOR__STD_C11
            iVal = F_CAT(12,34); m.f_text(z, "i## =: '%i'", iVal);
        #endif
    #endif

#endif  /* USE_TUTOR__STD_CPP_EXTENDED */

    //  =:= s:  F_SWAP(x,y)
    m.f_subMenu("F_SWAP(x,y)", __LINE__);

    union UByte {
        struct {
            unsigned int    b0 : 1;
            unsigned int    b1 : 1;
            unsigned int    b2 : 1;
            unsigned int    b3 : 1;
            unsigned int    b4 : 1;
            unsigned int    b5 : 1;
            unsigned int    b6 : 1;
            unsigned int    b7 : 1;
        } s;
        unsigned char   v;
    };

    #define F_SWAP(x)    ( (((x) & 0xF0) >> 4) | (((x) & 0x0F) << 4) )
    T_TUTOR__UINT8     y1,y2;
    y1 = 0xA1;
    y2 = F_SWAP(y1);
    m.f_text(z, "y1              =: '%x'",y1);
    m.f_text(z, "y2 = SWAP8(y1)  =: '%x'",y2);
    #undef F_SWAP

    #define F_SWAP(x)    (      (((x) & 0xFF00) >> 8)   \
                            |   (((x) & 0x00FF) << 8)   )
    T_TUTOR__UINT16    w1, w2;
    w1 = 0xB1B2;
    w2 = F_SWAP(w1);
    m.f_text(z, "w1              =: '%x'", w1);
    m.f_text(z, "w2 = SWAP16(w1)  =: '%x'", w2);
    #undef F_SWAP

    #define F_SWAP(x)    (      (((x) & 0xFF000000) >> 24)      \
                            |   (((x) & 0x00FF0000) >> 8)       \
                            |   (((x) & 0x0000FF00) << 8)       \
                            |   (((x) & 0x000000FF) << 24)      )
    T_TUTOR__UINT32   d1, d2;
    d1 = 0xC1C2C3C4;
    d2 = F_SWAP(d1);
    m.f_text(z, "d1               =: '%lx'", d1);
    m.f_text(z, "d2 = SWAP32(d1)  =: '%lx'", d2);
    #undef F_SWAP

    #define F_SWAP(x)    (      (((x) & 0xFF00000000000000) >> 56)      \
                            |   (((x) & 0x00FF000000000000) >> 40)      \
                            |   (((x) & 0x0000FF0000000000) >> 24)      \
                            |   (((x) & 0x000000FF00000000) >> 8)       \
                            |   (((x) & 0x00000000FF000000) << 8)       \
                            |   (((x) & 0x0000000000FF0000) << 24)      \
                            |   (((x) & 0x000000000000FF00) << 40)      \
                            |   (((x) & 0x00000000000000FF) << 56)      )
    T_TUTOR__UINT64   q1, q2;
    q1 = 0xd1d2d3d411223344;
    q2 = F_SWAP(q1);
    m.f_text(z, "q1              =: '%llx'", q1);
    m.f_text(z, "q2 = SWAP64(q1) =: '%llx'", q2);
    #undef F_SWAP

    //  =:= s:  SWAP(x,y) library
    m.f_subMenu("F_SWAP64(x,y) library", __LINE__);
    y1 = 0xe1;                  y2 = F_TUTOR__SWAP8(y1);
    w1 = 0xa1a2;                w2 = F_TUTOR__SWAP16(w1);
    d1 = 0xd1d2d3d4;            d2 = F_TUTOR__SWAP32(d1);
    q1 = 0xa1a2a3a4b1b2b3b4;    q2 = F_TUTOR__SWAP64(q1);
    m.f_text(z, "SWAP8(%x)       \t => '%x'",    y1, y2);
    m.f_text(z, "SWAP16(%x)      \t => '%x'",    w1, w2);
    m.f_text(z, "SWAP32(%lx)     \t => '%lx'",   d1, d2);
    m.f_text(z, "SWAP64(%llx)    \t => '%llx'",  q1, q2);

    //  =:= m:  #line vs __LINE__

    m.f_menu("#line", __LINE__);
    m.f_text(z, "Code is at LINE =: <%d>", __LINE__);

    #line 999123
    m.f_text(z, "Code is now at LINE =: <%d>", __LINE__);

    //  next line
    m.f_text(z, "Code next at LINE =: <%d>", __LINE__);


//  =:= b:  body
    m.f_footer(sHdr,__FILE__,__LINE__);
    return(iEc);
};


#ifndef __USE_TUTOR__MAIN
int main(int p_iArgs, char *p_sArgv[]) {
    CTutor  m;
    if (p_iArgs >= 2) {
        m.f_mode_color(true);
    }
    return F04_preProcessor(m);
}
#endif
