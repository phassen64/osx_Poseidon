//  ****************************************************************************
//  TUTORIAL:   C++     :   array   C89<=>C++
//  ****************************************************************************
//  !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß-------$

/*
    content:

        •   C:  arrayC89
            •  m:  array:int
                •   s:  define array:int
                •   s:  universal initialization array:int
                •   s:  sizeOf array:int
                •   s:  access array:int
                •   s:  multi-dimension array:int
            •   m:  array:char
                •   s:  define array:char1 x[]={'a','b','c'}
                •   s:  define array:char2 x[]={"abc"}
                •   s:  define array:char3 *x[]={"A","B","C"}
            •   m:  array:string
                •   s:  define array:S
                •   s:  fixed s[x]
                •   s:  unfixed s[]

        •  C:  arrayC++
            •   m:  array:C89
            •   m:  array:C++

    url:
        •   https://cplusplus.com/doc/tutorial/arrays/


 */


#include "Tutor.h"
using namespace std;


int F__arrayC89(CTutor &m) {

    int         iEc = m.f_iEc();
    char        z = m.E_COLOR_GRAY;
    const char*     sHdr = "arrayC89";
    int             i,n,
                    iSize;
//  =:= b:  header

//  =:= C:  arrayC89
    m.f_chapter(sHdr,__FILE__,__LINE__,true);

//  =:= m:  array:int
    m.f_menu("array:int",__LINE__);

//  =:= s:  define array:int
    m.f_subMenu("define array:int",__LINE__);
    n = 5;
#if defined(_MSC_VER) || defined (__BORLANDC__)
    int   aiNum[5]  = {10, 20, 30, 40, 50};
#else
    int   aiNum[n]  = {10, 20, 30, 40, 50}; //  !MSC:Compiler Error C2131
#endif
    for(int i=0; i<n; i++) {
        m.f_text(z,"aiNum[%d]= %d",i,aiNum[i]);
    }

//  =:= s:  universal initialization array:int
    m.f_subMenu("universal initialization array:int",__LINE__);
    int   biNum1[]  = {1, 2, 3 };
#ifdef __USE_TUTOR__STD_C11
    int   biNum2[] {5, 6, 7 };  //  extended initializer lists
#else
    int   biNum2[] = {5, 6, 7 };
#endif
    for(int i=0; i<3; i++) {
        m.f_text(z,"std:biNum1[%d]={x} \t :%d",i,biNum1[i]);
    }
    for(int i=0; i<3; i++) {
        m.f_text(z,"uni:biNum2[%d]{x} \t :%d",i,biNum2[i]);
    }

//  =:= s:  sizeOf array:int
    m.f_subMenu("sizeOf array:int",__LINE__);
    iSize = sizeof(aiNum);      // 20 == 5*sizeof(int)
    n     = iSize / sizeof(int);// ==> n==5
    m.f_text(z,"sizeof(aiNum)    => %d",iSize);
    m.f_text(z,"nSize            => %d",n);

//  =:= s:  access array:int
    m.f_subMenu("change",__LINE__);
    aiNum[(int)n/2] = -123;
    n   = sizeof(aiNum) / sizeof(int);
    for(int i=0; i<n; i++) {
        m.f_text(z,"aiNum[%d]= %d",i,aiNum[i]);
    }

//  =:= s:  multi-dimension array:int
    m.f_subMenu("multi-dimension",__LINE__);
    int iDim[2][4][10];
    int iX=1,iY=3,iZ=5;
    iDim[iX][iY][iZ] = 123;
    m.f_text(z,"iDim[%d,%d,%d] =: %d",iX,iY,iZ,iDim[iX][iY][iZ]);

//  =:= m:  array:char

    m.f_menu("array:char",__LINE__);

//  =:= s:  define array:char1 x[]={'a','b','c'}
    const char acHallo1[] = { 'H', 'a', 'l', 'l', 'o', ' ',
                            'W', 'e', 'l', 't', '\0' };

//  =:= s:  define array:char2 x[]={"abc"}
    const char acHallo2[] = { "Hallo Welt" };
    m.f_text(z,"ac1  => %s",acHallo1);
    m.f_text(z,"ac2  => %s",acHallo2);

//  =:= s:  define array:char3 *x[]={"A","B","C"}
    const char * acWeekday[] = {"Mo","Di","Mi","Do","Fr","Sa","So"};
    for(int i=0; i<7; i++) {
        m.f_text(z,"acWeekDay[%d]= %s",i,acWeekday[i]);
    }

//  =:= m:  array:string

    m.f_menu("array:string",__LINE__);

//  =:= s:  define array:S
    n = 4; i = n-1;
#if defined(_MSC_VER) || defined (__BORLANDC__)
    string  asCar[4]    = {"Volvo", "BMW", "Ford", "Mazda"};
#else
    string  asCar[n] = { "Volvo", "BMW", "Ford", "Mazda" };
#endif
    m.f_text(z,"asCar[%d] => %s",i,asCar[i].c_str());

//  =:= s:  fixed s[x]
    m.f_subMenu("fixed S[x]",__LINE__);
    string asCar3[5] = {"Volvo", "BMW", "Ford"};
    iSize = sizeof(asCar3);
    m.f_text(z,"sizeof(asCar3).A => %d",iSize);
    // size of array is 5, even though it's only three elements inside it
    asCar3[3] = "Mazda";
    asCar3[4] = "Tesla";
    iSize = sizeof(asCar3);
    m.f_text(z,"sizeof(asCar3).B => %d",iSize); // noChange

//  =:= s:  unfixed[]
    m.f_subMenu("unfixed S[]",__LINE__);
    string asCar2[] = {"Volvo", "BMW", "Ford"};
    iSize = sizeof(asCar2);
    m.f_text(z,"sizeof(asCar2)    => %d",iSize);

//  =:= b:  footer
    return(iEc);
};

//  &&& F:  arrayC++ &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

int F__arrayCpp(CTutor &m) {
    int             iEc = m.f_iEc();
    char            z = m.E_COLOR_GRAY;
    const char*     sHdr = "arrayC++";

//  =:= C:  arrayC++
    m.f_chapter(sHdr,__FILE__,__LINE__,true);

//  =:= m:  array:C++
    m.f_menu("array:C89",__LINE__);
    int iA[3] = {10,20,30};
    for (int i=0; i<3; ++i) {
        m.f_text(z,"iA[%d] => %d",i,iA[i]);
    }

//  =:= m:  array:C++
    m.f_menu("array:C++ <t.b.d>",__LINE__);
#if 0
    #include <iostream>
    #include <array>
    std::array<int, 3> iB;
#else
    int iB[3] = {41,42,43};
#endif
    for (int i = 0; i < 3; ++i) {
        m.f_text(z, "iB[%d] => %d", i, iB[i]);
}
    return(iEc);
}


int F15_array(CTutor &m) {
    const char*     sHdr = "Array";
    int iEc, iRc;
    iEc = m.f_header(sHdr,__FILE__,__LINE__);
    iRc = F__arrayC89(m);       if (iRc != iEc) { return iRc; }
    iRc = F__arrayCpp(m);       if (iRc != iEc) { return iRc; }
    m.f_footer(sHdr,__FILE__,__LINE__);
    return(iEc);
}


#ifndef __USE_TUTOR__MAIN
int main(int p_iArgs, char *p_sArgv[]) {
    CTutor  m;
    if (p_iArgs >= 2) {
        m.f_mode_color(true);
    }
    return F15_array(m);
}
#endif
