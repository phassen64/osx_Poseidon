//  ****************************************************************************
//  TUTORIAL:   C++     :   const
//  ****************************************************************************
//  !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß-------$
/*
    content:
        •   m:  literal         =>   long int i=123L
        •   m:  const typed     =>   const int Ci    123
        •   m:  const PreProc   =>   #define C_i     123
    url:
        •   https://cplusplus.com/doc/tutorial/constants/
    keyword handled:
        •   const
        •   <formatSpecifier> ...
*/

#include "Tutor.h"
using namespace std;


int F03_const(CTutor& m) {

    const char* sHdr = "const";
    int iEc =
        m.f_header(sHdr, __FILE__, __LINE__);
    char            z = m.E_COLOR_GRAY;
    char    c;
#ifdef __USE_TUTOR__STD_C11
    char16_t    c16;
    char32_t    c32;
#endif
    wchar_t     cwc;
    int         i;

//  =:= m:  literal
    m.f_menu("literal",__LINE__);

    m.f_subMenu("char",__LINE__);
    c='$';      m.f_text(z, "<c> =: '%c'", c);

    m.f_subMenu("char.prefix{u,U,L}",__LINE__);
    /*  NOTE:
        unlike type suffixes for integer literals,
        these prefixes are case sensitive:
        lowercase for char16_t and
        uppercase for char32_t and wchar_t.
    */
#ifdef __USE_TUTOR__STD_C11
    c16 = u'A';     m.f_text(z,"char  c16<u>    =: '%zu'",c16);
    c32 = U'A';     m.f_text(z,"char  c32<U>    =: '%zu'",c32);
#endif
    cwc = L'A';     m.f_text(z,"char  cwc<L>    =: '%c'",cwc);

    m.f_subMenu("int.prefixBase{0,x}",__LINE__);
    i=878;      m.f_text(z, "<i>(dec) = :%d<DEC> :%o<OCT> :%x<HEX>", i,i,i);
    i=07112;    m.f_text(z, "<i>(oct) = :%d<DEC> :%o<OCT> :%x<HEX>", i,i,i);
    i=0xA1b2;   m.f_text(z, "<i>(hex) = :%d<DEC> :%o<OCT> :%x<HEX>", i,i,i);

    m.f_subMenu("int.suffixIntType{u|U,l|L}",__LINE__);
    i                   =   0xA1B2C3D4;         // byteSize:4
    long int li         =   0xA1B2C3D4L;
    long long int lli   =   0xa1a2a3a4a5a6a7a8uL;
    unsigned u          =   0xA1B2C3D4u;
    unsigned int ui     =   0xA1B2C3D4U;
    unsigned long ul        =   0xa1a2a3a4lu;
    unsigned long int uli   =   0xa1a2a3a4lU;
    unsigned long long int ulli     =   0xa1a2a3a4a5a6a7a8uL;
    m.f_text(z, "<i>    =:  '%d'",  i);
    m.f_text(z, "<li>   =:  '%ld'", li);
    m.f_text(z, "<lli>  =:  '%llx => '%lld",lli,lli);
    m.f_text(z, "<u>    =:  '%lu'", u);
    m.f_text(z, "<ui>   =:  '%lu'", ui);
    m.f_text(z, "<ul>   =:  '%lu'", ul);
    m.f_text(z, "<uli>  =:  '%lu'", uli);
    m.f_text(z, "<ulli> =:  '%llx => '%llu''",ulli,ulli);

    m.f_subMenu("float.Number{e|E}",__LINE__);
#ifdef _MSC_VER
    double f;
#else
    float f;
#endif
    f = 3.14159;    m.f_text(z, "<float>        =:  '%f'",  f);
    f = 6.02e23;    m.f_text(z, "<float><e23>   =:  '%f'",  f);
    f = 1.6E-5;     m.f_text(z, "<float><E-5>   =:  '%f'",  f);

    m.f_subMenu("float.suffixType{f|U,l|L}",__LINE__);
    double d;
    long double ld;
    f   = 2.781f;   m.f_text(z, "<float><f>         =:  '%f'",  f);
    d   = 2.781L;   m.f_text(z, "<double><L>        =:  '%f'",  d);
    ld  = 2.781L;   m.f_text(z, "<longDouble><L>    =:  '%f'",  ld);
    ld  = 1.23f;    m.f_text(z, "<longDouble><f>    =:  '%f'",  ld);
    d   = 1.123F;   m.f_text(z, "<double><F>        =:  '%f'",  d);

    m.f_subMenu("other",__LINE__);
    bool bTrue  = true;
    bool bFalse = false;
#ifdef __USE_TUTOR__STD_C11
    int *p      = nullptr;
#else
    int *p      = 0;
#endif
    m.f_text(z, "<bTrue>    =: '%d'", bTrue);
    m.f_text(z, "<bFalse>   =: '%d'", bFalse);
    m.f_text(z, "<p>        =: '%p'", p);

//  =:= m:  const typed
    m.f_menu("typed const",__LINE__);
    const float C_fPi   =   (float)3.1415;
    const char  C_cAsterisk  = '*';
    m.f_text(z, "<const float C_fPi>        =: '%f'",   C_fPi);
    m.f_text(z, "<const char  C_cAsterisk> =: '%c'",    C_cAsterisk);

//  =:= m:  const preProc
    m.f_menu("preProcessor",__LINE__);
    #define C_PI         3.1415
    #define C_ASTERISK  '*'
    m.f_text(z, "<C_PI>         =: '%f'", C_PI);
    m.f_text(z, "<C_ASTERISK>   =: '%c'", C_ASTERISK);

    m.f_footer(sHdr, __FILE__, __LINE__);
    return iEc;
}

#ifndef __USE_TUTOR__MAIN
int main(int p_iArgs, char *p_sArgv[]) {
    CTutor  m;
    if (p_iArgs >= 2) {
        m.f_mode_color(true);
    }
    return F03_const(m);
}
#endif
