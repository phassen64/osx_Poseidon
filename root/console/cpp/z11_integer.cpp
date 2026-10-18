//  ****************************************************************************
//  TUTORIAL:   C++     :   integer
//  ****************************************************************************
//  !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß-------$
/*
    content:
        •   m:  range   :   INT_MAX,...,ULLONG_MAX
        •   m:  base    :   dec,hex,oct,bin
    keywords<4>:
        •   int
        •   long
        •   short
        •   unsigned
    url:
        •   https://cplusplus.com/doc/tutorial/variables/
        •   https://cplusplus.com/reference/ios/oct/
        •   https://cplusplus.com/reference/ios/dec/
        •   https://cplusplus.com/reference/ios/hex/
 */


#include "Tutor.h"
using namespace std;

#undef  C_BUFFER_SIZE
#define C_BUFFER_SIZE    512


void f_print_i(int p_iVal, CTutor &m, bool p_bUpCase=false) {
    int         i = p_iVal;
    char        z = m.E_COLOR_GRAY;
    m.f_text(z,"<i>.10   =:  '%d'"   ,i);
    if (p_bUpCase) {
        m.f_text(z,"<i>.16  =:  '%X' <%%X>"   ,i);
    } else {
        m.f_text(z,"<i>.16  =:  '%x'"   ,i);
    }
    m.f_text(z,"<i>.8    =:  '%o'"   ,i);
    m.f_text(z,"<i>.2    =:  '%s'" , m.f_sInt2Bin(i,true));
} // f~prinT_TUTOR__INT

void f_print_iL(long int p_ilVal, CTutor &m, bool p_bUpCase=false) {
    long int    i = p_ilVal;
    char        z = m.E_COLOR_GRAY;
    m.f_text(z,"<iL>.10  =:  '%ld'"  ,i);
    if (p_bUpCase) {
        m.f_text(z,"<iL>.16  =:  '%lX'"   ,i);
    } else {
        m.f_text(z,"<iL>.16  =:  '%lx'"   ,i);
    }
    m.f_text(z,"<iL>.8   =:  '%lo'"  ,i);
    m.f_text(z,"<iL>.2   =:  '%s'" , m.f_sInt2Bin(i,true));
} // f~print_iL


int F11_integer(CTutor &m) {

//  =:= b:  declare
    int             iEc;
    char            z = m.E_COLOR_GRAY;
    const char*     sHdr = "integer";
    bool            b = false;

//  =:= b:  header
    iEc =
    m.f_header(sHdr,__FILE__,__LINE__);

//  =:= b:  intro
    m.f_status();
    m.f_chapter(sHdr,__FILE__,__LINE__,true);

//
//  =:= m:  body
//


//  =:= m:  range

    m.f_menu("range",__LINE__);

    int                     i_max       =   INT_MAX,
                            i_min       =   INT_MIN;
    short                   iS_max      =   SHRT_MAX,
                            iS_min      =   SHRT_MIN;
    long int                iL_max      =   LONG_MAX,
                            iL_min      =   LONG_MIN;
    long long int           iLL_max     =   LONG_MAX,
                            iLL_min     =   LONG_MIN;
    unsigned int            iU_max      =   UINT_MAX;
    unsigned long int       iUL_max     =   ULONG_MAX;  //  ==UINT_MAX
    unsigned long long int  iULL_max    =   ULLONG_MAX;

    m.f_text(z,"int   <i>.max       =:  '%d'"   ,i_max);
    m.f_text(z,"int   <i>.min       =:  '%d'"   ,i_min);
    m.f_text(z,"short <iS>.max      =:  '%d'"   ,iS_max);
    m.f_text(z,"short <iS>.min      =:  '%d'"   ,iS_min);
    m.f_text(z,"long  <iL>.max      =:  '%ld'"  ,iL_max);
    m.f_text(z,"long  <iL>.min      =:  '%ld'"  ,iL_min);
    m.f_text(z,"long  <iLL>.max     =:  '%lld'" ,iLL_max);
    m.f_text(z,"long  <iLL>.min     =:  '%lld'" ,iLL_min);
    m.f_text(z,"unsigned <iU>.max   =:  '%u'"   ,iU_max);
    m.f_text(z,"unsigned <iUL>.max  =:  '%lu'"  ,iUL_max);
    m.f_text(z,"unsigned <iULL>.max =:  '%llu'" ,iULL_max);

//  =:= m:  base

    m.f_menu("base",__LINE__);

    //  standard
    int i;
    i = 1234;       m.f_subMenu("<i>.positive",__LINE__);   f_print_i(i,m,b);
    i = -5678;      m.f_subMenu("<i>.negative",__LINE__);   f_print_i(i,m,b);
    i = 0xABCDEF;   m.f_subMenu("<i>.hexnu",__LINE__);      f_print_i(i,m,b);
    i = 01274;      m.f_subMenu("<i>.octal",__LINE__);      f_print_i(i,m,b);

    //  special
    m.f_subMenu("<i>.max",__LINE__); f_print_i(i_max,m,true);
    m.f_subMenu("<i>.min",__LINE__); f_print_i(i_min,m,true);

    //  long
    long int iL;
    iL = 123456;        m.f_subMenu("<iL>.positive",__LINE__);  f_print_iL(iL,m,b);
    iL = -456789;       m.f_subMenu("<iL>.negative",__LINE__);  f_print_iL(iL,m,b);
    iL = 0x5abcdef3;    m.f_subMenu("<iL>.hexnu",__LINE__);     f_print_iL(iL,m,b);
    iL = 01234567;      m.f_subMenu("<iL>.octal",__LINE__);     f_print_iL(iL,m,b);

    //  special
    m.f_subMenu("<iL>.max",__LINE__); f_print_i(iL_max,m,true);
    m.f_subMenu("<iL>.min",__LINE__); f_print_i(iL_min,m,true);

//  =:= b:  footer
    m.f_menu("end",__LINE__);
    m.f_footer(sHdr,__FILE__,__LINE__);
    return(iEc);

};


#ifndef __USE_TUTOR__MAIN
int main(int p_iArgs, char *p_sArgv[]) {
    CTutor  m;
    if (p_iArgs >= 2) {
        m.f_mode_color(true);
    }
    return F11_integer(m);
}
#endif
