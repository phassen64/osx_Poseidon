//  ****************************************************************************
//  TUTORIAL:   C++     :   template
//  ****************************************************************************
//  !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß-------$
/*
    issue:
        •   F:  template
        •   F:  helper
        •   F:  main

    content:
        •   m:  function template
            •   s:  fMax<int>
            •   s:  fMax<int&>
            •   s:  fMax<float&>
        •   m:  overloading
            •   s:  TMax<String> generic
            •   s:  FMax<string> overloads TMax<string>
        •   m:  nested
            •   s:  fSwap
            •   s:  fSwap.Nested
        •   m:  default argument
            •   s:  fAdd
        •   m:  class template
            •   s:  T.constructor
            •   s:  T.destructor
            •   s:  T.method
            •   s:  T.new
            •   s:  T.addMyValues
            •   s:  T.getMyValues

    url:
        •   https://cplusplus.com/doc/tutorial/templates/
        •   https://en.wikipedia.org/wiki/Template_(C%2B%2B)
        •   https://docs.microsoft.com/de-de/cpp/cpp/templates-cpp?view=msvc-170

    readme: https://herdt.com/pages/
        •   i:  Templates
            Werden auch "generische" oder "parametrisierte" Typen genannt.
            Sie sind nicht seit Beginn der Entwicklung der Sprache C++
                deren Bestandteil und werden deshalb
            zum Teil von älteren Compilern nicht unterstützt.
            In C++ werden Funktions- und Klassen-Templates zur Verfügung gestellt.
                Dabei beschreibt ein Template eine
                    nicht beschränkte Anzahl von Funktionen bzw. Klassen,
                    in denen Typen verwendet werden,
            die im Template >nicht< genauer beschrieben werden.

*/

#include "Tutor.h"
using namespace std;


//  ###########################################################################
//  F:  template
//  ###########################################################################

//* =:= m:  function template :1
template <typename T>
int F_max(T i1, T i2) {
    if (i1 > i2) {      //* !PHA:not for string
        return 1;
    } else if ( i1 < i2 ) {
        return -1;
    } else {
        return 0;
    }
}

//  =:= m:  overloading
//  fMax<String> : overwrite generic function for T=string
int F_max(string& S1, string& S2)
{
    int iRc = F_max(S1.length(),S2.length());
    return iRc;
}



//* =:= m:  nested
template<typename T> void F_swap(T& x, T& y) {
    T tmp = x;
    x     = y;
    y     = tmp;
}
template<typename T> int F_swap_nested(T& x, T& y) {
    F_swap(x,y);
    return F_max(x,y);
}

//* =:= m:  default argument
//* =:= s:  FAdd
#ifdef __USE_TUTOR__STD_C11
template<typename T=int> int F_add(T i, T j) {
    return i+j;
}
#endif


//* =:= m:  class template

//* =:= s:  T.class
template <class X> class TArray {
    private:
        int     m__iLen,
                m__iPos;
        X *     m__pData;
    public:
        //  constructor && destructor
        TArray(int p_iLen);
        ~TArray();
        //  methods
        void    f_add(X     p_xVal);
        X       f_get(int   p_iPos);
};

//* =:= s:  T.constructor
template <class X> TArray<X>::TArray(int p_iLen) {
    m__iPos   = 0;
    m__iLen   = p_iLen;
    m__pData  = new X[p_iLen];
}

//* =:= s:  T.desctructor
template <class X> TArray<X>::~TArray() {
    delete[] m__pData;
}

//* =:= s:  T.method:add
template <class X> void TArray<X>::f_add(X p_xVal)
{
    *(m__pData + m__iPos) = p_xVal;
    m__iPos++;
}

//* =:= s:  T.method:get
template <class X> X TArray<X>::f_get(int p_iPos) {
    return *(m__pData + p_iPos);
}


//  ###########################################################################
//  F:  helper
//  ###########################################################################

int F28_template(CTutor &m) {
    int             iEc;
    const char*     sHdr =  "Template";
    int             i,j,iRc;
    float           f1,f2;
    char            z = m.E_COLOR_GRAY;

//  =:= b:  body
    iEc = m.f_header(sHdr, __FILE__, __LINE__);

//  =:= m:  function template
    m.f_menu("function template", __LINE__);
    m.f_subMenu("fMax", __LINE__);

//  =:= s:  fMax<int>
    iRc = F_max<int>(1,2);
    m.f_text(z,"TMax <int>  (1|2)   =: %d",iRc);

//  =:= s:  fMax<int&>
    i   = m.f_iRandom();
    j   = m.f_iRandom();
    iRc = F_max<int&>(i,j);
    m.f_text(z,"TMax <int&> (%d|%d) =: %d", i,j,iRc);

//  =:= s:  fMax<int&>
    i   = m.f_iRandom();  // 1...10
    j   = m.f_iRandom();
    iRc = F_max<int&>(i,j);
    m.f_text(z,"TMax <int&> (%d|%d) =: %d", i,j,iRc);

//  =:= s:  fMax<float&>
    f1  = (float)i*1.4;
    f2  = (float)j*1.4;
    iRc = F_max<float&>(f1,f2);
    m.f_text(z,"TMax <float&>   (%f|%f) =: %d", f1,f2,iRc);

//  =:= m:  overloading

//  =:= s:  TMax<string> generic
    string s1 = "ABC";
    string s2 = "123456";
    iRc = F_max<string&>(s1,s2); // genericMethod  => wrong result
    m.f_text(z,"TMax <string&>  (%s|%s) =: %d", s1.c_str(),s2.c_str(),iRc);
//  =:= s:  FMax<string> overloads TMax<string>
    iRc = F_max(s1,s2);           // overloadedMethod => OK
    m.f_text(z,"FMax <string&>  (%s|%s) =: %d", s1.c_str(),s2.c_str(),iRc);


//  =:= m:  nested
    m.f_menu("nesting templates", __LINE__);

//  =:= s:  fSwap
    m.f_subMenu("fSwap", __LINE__);
    m.f_text(z,"i=%d  j=%d", i,j);
    F_swap<int>(i,j);
    m.f_text(z,"i=%d  j=%d", i,j);

//  =:= s:  fSwap.Nested
    m.f_subMenu("fSwap3", __LINE__);
    iRc = F_swap_nested<int>(i,j);
    m.f_text(z,"fNested(i=%d,j=%d) =: %d", i,j,iRc);

//  =:= m:  default argument
    m.f_menu("template with default arguments", __LINE__);

//  =:= s:  fAdd
    m.f_subMenu("fAdd", __LINE__);
#ifdef __USE_TUTOR__STD_C11
    iRc = F_add(i,j);
    m.f_text(z,"fAdd(%d,%d) =: %d", i,j,iRc);
#endif

//  =:= m:  class template

    m.f_menu("class template", __LINE__);

//  =:= s:  T.new
    m.f_subMenu("create", __LINE__);
    int n = 1+ m.f_iRandom();
    TArray<int>   aNumber(n);
    m.f_text(z,"Elements =: %d",n);

//  =:= s:  T.addMyValues
    m.f_subMenu("add", __LINE__);
    for (int i=0, iRnd=1; i<n; i++) {
        iRnd = m.f_iRandom(1000,100);
        aNumber.f_add(iRnd);
        m.f_text(z,"add[%d] =: %d",i,iRnd);
    }

//  =:= s:  T.getMyValues
    m.f_subMenu("fetch", __LINE__);
    i = m.f_iRandom(n,1);
    i-= 1;
    m.f_text(z,"field[%d] =: %d", i, aNumber.f_get(i));

//  =:= b:  body
    m.f_footer(sHdr, __FILE__, __LINE__);
    return(iEc);
};


//  ###########################################################################
//  F:  main
//  ###########################################################################

#ifndef __USE_TUTOR__MAIN
int main(int p_iArgs, char *p_sArgv[]) {
    CTutor  m;
    if (p_iArgs >= 2) {
        m.f_mode_color(true);
    }
    return F28_template(m);
}
#endif
