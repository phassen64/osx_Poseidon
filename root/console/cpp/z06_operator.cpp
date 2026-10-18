//  ****************************************************************************
//  TUTORIAL:   C++     :   operator
//  ****************************************************************************
//  !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß-------$

/*
    content:

        •   m:  arithmetic
        •   m:  arithmetic standard
        •   m:  pre- & postfix ++ --
        •   m:  arithmetic assignment
        •   m:  bit assignment
        •   m:  comparison
        •   m:  logical
        •   m:  const_cast

    keyword<2>:
        •   true
        •   false
 */


#include "Tutor.h"
using namespace std;

#undef  C_BUFFER_SIZE
#define C_BUFFER_SIZE    512


int F06_operator(CTutor &m) {

//  =:= b:  declare
    int     iEc;
    int     i,j,n,x;
    float   f,fi,fj;
    bool    bRc;
//  char    c;
    char    s[C_BUFFER_SIZE];
    char    z = m.E_COLOR_GRAY;
//  char    *pc;
    const char* sHdr = "Operator";
//
//  =:= b:  header
    m.f_header(sHdr,__FILE__,__LINE__);
    iEc = m.f_iEc();        // get explicit


//  =:= m:  arithmetic

    m.f_menu("arithmetic",__LINE__);

//  =:= m:  arithmetic standard

    i = m.f_iRandom(5);
    j = m.f_iRandom(10);

    sprintf(s,"standard i:%d, j:%d",i,j); m.f_subMenu(s,__LINE__);
    x = i + j; m.f_text(z,"\t i + j  =: %d",x);
    x = i - j; m.f_text(z,"\t i - j  =: %d",x);
    x = i * j; m.f_text(z,"\t i * j  =: %d",x);

    sprintf(s,"DIV && MOD i:%d, j:%d",i,j); m.f_subMenu(s,__LINE__);
    x = i / j; m.f_text(z,"\t i / j  =: %d",x);
    x = j / i; m.f_text(z,"\t j / i  =: %d",x);
    x = i % j; m.f_text(z,"\t i %% j =: %d",x);
    x = j % i; m.f_text(z,"\t j %% i =: %d",x);
    i = 5; j = 8;

    sprintf(s,"real division of f=i/j=(%d/%d)",i,j); m.f_subMenu(s,__LINE__);

    //  a) only integer division => f:=0.0
    m.f_echo("::: typecast: no or wrong",m.E_COLOR_CYAN);

#ifdef _MSC_VER
    #pragma warning(disable : 4244) /* 'int' to 'float', possible loss of data*/
#endif
    f = i / j;              m.f_text(z,"\t i / j            =: %f",f);
    f = (float)(i / j);     m.f_text(z,"\t (float)(i / j)   =: %f",f);

    //  b) correct type cast     => f:=0.625
    m.f_echo("::: typecast: correct",m.E_COLOR_CYAN);
    f = (float)i / j;       m.f_text(z,"\t (float)i / j     =: %f",f);
    f = i / (float)j;       m.f_text(z,"\t  i / (float)j    =: %f",f);

    //  c) using float type     => f:=0.625
    m.f_echo("::: typecast: NONE - using float",m.E_COLOR_CYAN);
    fi = i;
    fj = j;
    f  = fi / fj;           m.f_text(z,"\t  fi / fj      =: %f",f);

//  =:= m:  arithmetic assignment

    i = m.f_iRandom(5);
    j = m.f_iRandom(8);

    sprintf(s,"arithmetic.assignment : i:%d, j:%d",i,j); m.f_subMenu(s,__LINE__);

    x=i; x+=j; m.f_text(z,"\t x += j     :%d",x);
    x=i; x-=j; m.f_text(z,"\t x -= j     :%d",x);
    x=i; x*=j; m.f_text(z,"\t x *= j     :%d",x);
    x=i; x/=j; m.f_text(z,"\t x /= j     :%d",x);
    x=i; x%=j; m.f_text(z,"\t x %%= j    :%d",x);

//  =:= m:  pre- & postfix ++ --

    n = i = m.f_iRandom(10,3);
    sprintf(s,"prefix && postfix : i:%d",i); m.f_menu(s,__LINE__);

    i = n; x = i++ ; m.f_text(z,"\t x=i++  => x:%d i:%d",x,i);
    i = n; x = i-- ; m.f_text(z,"\t x=i--  => x:%d i:%d",x,i);
    i = n; x = ++i ; m.f_text(z,"\t x=++i  => x:%d i:%d",x,i);
    i = n; x = --i ; m.f_text(z,"\t x=--i  => x:%d i:%d",x,i);

//  =:= m:  bit assignment

    i=0xCC; j=0x63;
    sprintf(s,"bit-assignment : x=i=$%x, j=$%x",i,j); m.f_menu(s,__LINE__);

    x=i; x&=j;  m.f_text(z,"\t x &= j    :%x=>%s",x,m.f_sInt2Bin(x,true));
    x=i; x|=j;  m.f_text(z,"\t x |= j    :%x=>%s",x,m.f_sInt2Bin(x,true));
    x=i; x^=j;  m.f_text(z,"\t x ^= j    :%x=>%s",x,m.f_sInt2Bin(x,true));
    x=i; x>>=j; m.f_text(z,"\t x >>= j   :%x",x);
    x=i; x<<=j; m.f_text(z,"\t x <<= j   :%x",x);

//  =:= m:  comparison

    i = m.f_iRandom(6); j = m.f_iRandom(8);
    sprintf(s,"comparison \t i=%d,j=%d",i,j); m.f_menu(s,__LINE__);

    bRc = (i == j) ? true : false; m.f_text(z,"\t i==j :%d",bRc);
    bRc = (i != j) ? true : false; m.f_text(z,"\t i!=j :%d",bRc);
    bRc = (i <  j) ? true : false; m.f_text(z,"\t i< j :%d",bRc);
    bRc = (i >  j) ? true : false; m.f_text(z,"\t i> j :%d",bRc);
    bRc = (i <= j) ? true : false; m.f_text(z,"\t i<=j :%d",bRc);
    bRc = (i >= j) ? true : false; m.f_text(z,"\t i>=j :%d",bRc);

//  =:= m:  logical

    i = m.f_iRandom(10); j = m.f_iRandom(10); x = m.f_iRandom(10);
    sprintf(s,"logical \t i=%d,j=%d,x=%d",i,j,x); m.f_menu(s,__LINE__);

    bRc = (x < i &&  x < j) ? true : false;
        m.f_text(z,"\t x < i &&  x < j =:%d",bRc);
    bRc = (x < i ||  x < j) ? true : false;
        m.f_text(z,"\t x < i ||  x < j =:%d",bRc);
    bRc = (!(x < i ||  x < j)) ? true : false;
        m.f_text(z,"\t ! [ x < i ||  x < j ] =:%d",bRc);

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
    return F06_operator(m);
}
#endif
