//  ****************************************************************************
//  TUTORIAL:   C++     :   math
//  ****************************************************************************
//  !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß-------$
/*
    !URL :  https://www.w3schools.com/cpp/cpp_math.asp

    content :
        •   m:  absolute
        •   m:  arithmetic
        •   m:  integer
        •   m:  float
        •   m:  trigonometry

 */


#include "Tutor.h"
using namespace std;


int F10_math(CTutor &m) {

//  =:= b:  declare
    int     iEc;
    char    C = m.E_COLOR_GRAY;
    int     i,j;
    float   f, x, y, z;
#ifdef _MSC_VER
    #pragma warning(disable : 4244)     // conversion from 'float' to 'int'...
    #pragma warning(disable : 4305)     // truncation from 'double' to 'float'...
#endif

/*
    string  S;
    char    s[C_STR_BUFFER_SIZE];
*/
    const char* sHdr = "math!";

//  =:= b:  header
    m.f_header(sHdr,__FILE__,__LINE__);
    iEc = m.f_iEc();        // get explicit

//  =:= m:  absolute
    m.f_menu("abs",__LINE__);
    i = -45;
    j = abs(i);     m.f_text(C,"abs(%d)  => %d",i,j);
    x = -1.51;
    y = fabs(x);    m.f_text(C,"fabs(%f) => %f",x,y);

//  =:= m:  arithmetic
    m.f_menu("arithmetic",__LINE__);
    x = 2.5;
    y = 5.3;
    m.f_subMenu("x**y",__LINE__);
    f = pow(x,y);           m.f_text(C,"pow(%f,%f)   => %f",x,y,f);
    x = 1000; y = log10(x); m.f_text(C,"log10(%f)    => %f",x,y);
    //  e**x
    m.f_subMenu("e**x",__LINE__);
    x = 5; y = exp(x);      m.f_text(C,"exp(%f)      => %f",x,y);
    x = y; y = log(x);      m.f_text(C,"log(%f)    => %f",x,y);
    //  x**2
    m.f_subMenu("x**2",__LINE__);
    x = 2; y = sqrt(x);     m.f_text(C,"sqrt(%f)    => %f",x,y);
    x = 100; y = sqrt(x);   m.f_text(C,"sqrt(%f)    => %f",x,y);
#ifdef __USE_TUTOR__STD_C11
    x = 5; y = exp2(x);     m.f_text(C,"exp2(%f)    => %f",x,y);
    x = y; y = log2(x);     m.f_text(C,"log2(%f)    => %f",x,y);
#endif
    m.f_subMenu("x**3",__LINE__);
    x = 2; y = cbrt(x);     m.f_text(C,"cbrt(%f)    => %f",x,y);
    x = 1000; y = cbrt(x);  m.f_text(C,"cbrt(%f)    => %f",x,y);

//  =:= m:  integer
    m.f_menu("integer",__LINE__);
    x = 1.51;
    m.f_subMenu("{round,ceil,floor,trunc}(x)",__LINE__);
    j = round(x);   m.f_text(C,"round(%f) => %d",x,j);
    j = ceil(x);    m.f_text(C,"ceil(%f) => %d",x,j);
    j = floor(x);   m.f_text(C,"floor(%f) => %d",x,j);
    j = trunc(x);   m.f_text(C,"trunc(%f) => %d",x,j);
    m.f_subMenu("{round,ceil,floor,trunc}(-x)",__LINE__);
    j = round(-x);  m.f_text(C,"round(%f) => %d",-x,j);
    j = ceil(-x);   m.f_text(C,"ceil(%f) => %d",-x,j);
    j = floor(-x);  m.f_text(C,"floor(%f) => %d",-x,j);
    j = trunc(-x);  m.f_text(C,"trunc(%f) => %d",-x,j);

//  =:= m:  float
    m.f_menu("float",__LINE__);
    m.f_subMenu("max && min",__LINE__);
    x = 12.34;
    y = 56.78;
    z = fmax(x,y);   m.f_text(C,"fmax(%f,%f) => %f",x,y,z);
    z = fmin(x,y);   m.f_text(C,"fmin(%f,%f) => %f",x,y,z);
    z = fmax(x,-y);  m.f_text(C,"fmax(%f,%f) => %f",x,-y,z);
    z = fmin(-x,y);  m.f_text(C,"fmin(%f,%f) => %f",-x,y,z);
    m.f_subMenu("mod",__LINE__);
    x = 6.2;
    y = 2.2;
    z = fmod(x,y);   m.f_text(C,"fmod(%f,%f) => %f",x,y,z);
    m.f_subMenu("dim",__LINE__);
    x = 6.2;
    y = 2.2;
    z = fdim(x,y);   m.f_text(C,"fdim(%f,%f) => %f",x,y,z);
    z = fdim(x,-y);  m.f_text(C,"fdim(%f,%f) => %f",x,-y,z);
    z = fdim(-x,y);  m.f_text(C,"fdim(%f,%f) => %f",-x,y,z);
    z = fdim(y,x);   m.f_text(C,"fdim(%f,%f) => %f",y,x,z);

//  =:= m:  trigonometry
    m.f_menu("trigonometry",__LINE__);
    x = 30;
    y = sin(x);     m.f_text(C,"sin(%f)  => %f",x,y);
    y = cos(x);     m.f_text(C,"cos(%f)  => %f",x,y);
    y = tan(x);     m.f_text(C,"tan(%f)  => %f",x,y);
    y = asin(x);    m.f_text(C,"asin(%f) => %f",x,y);
    y = acos(x);    m.f_text(C,"acos(%f) => %f",x,y);
    y = atan(x);    m.f_text(C,"atan(%f) => %f",x,y);
    y = sinh(x);    m.f_text(C,"sinh(%f)  => %f",x,y);
    y = cosh(x);    m.f_text(C,"cosh(%f)  => %f",x,y);
    y = tanh(x);    m.f_text(C,"tanh(%f)  => %f",x,y);

//  =:= b:  footer
    m.f_footer(sHdr,__FILE__,__LINE__);
    return(iEc);
};


#ifndef __USE_TUTOR__MAIN
int main(int p_iArgs, char *p_sArgv[]) {
    CTutor  m;
    if (p_iArgs >= 2) {
        m.f_mode_color(true);
    }
    return F10_math(m);
}
#endif
