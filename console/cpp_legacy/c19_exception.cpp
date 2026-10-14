//  ****************************************************************************
//  TUTORIAL:   C++     :   exception
//  ****************************************************************************
//  !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß-------$
/*
    content:
        •   m:  try exception isKnown:=true
        •   m:  try exception isKnown:=false
        •   m:  overload excpetion class
    keyword:
        •   catch
        •   throw
        •   try
    url:
        •   https://www.w3schools.com/cpp/cpp_exceptions.asp
        •   https://cplusplus.com/doc/tutorial/exceptions
 */


#include "Tutor.h"
using namespace std;

int F19_exception(CTutor &m) {

//  =:= b:  declare
    int     i,x;
    int     iEc,
            iAge,
            iExc;
    bool    bRc;
    string  S;
    char    z = m.E_COLOR_GRAY;
    const char *sHdr = "EXCP!";

//  =:= b:  header
    m.f_header(sHdr,__FILE__,__LINE__);
    iEc = m.f_iEc();        // get explicit

//  =:= b:  body : build RANDOM input values

    i=20;   x = m.f_iRandom(i);
    assert(x<=i);
    m.f_text(z,"iAge =: '%d'",x);
    iAge = x;

    i=1000; x = m.f_iRandom(i);
    m.f_text(z,"iExc =: '%d'",x);
    iExc = x;

//  =:= m:  try exception isKnown:=true

    m.f_menu("throw<int>",__LINE__);

    try {
        bRc = false;
        if (iAge >= 18) {
            bRc = true;
            S   = "Access granted - you are old enough.";
        } else {
            bRc = false;
            S   = "Age younger than allowed";
            #if defined(__BORLANDC__) && defined(_DEBUG)
                i=0;
            #else
                throw iExc;
            #endif
        }
        cout << "\tStatus:" << S.c_str() << ";" << endl;
    }
    catch (int p_iExc) {        // iExc is known
        m.f_text("EXCEPTION1",m.E_COLOR_MAGENTA_BRHT);
        cout << "\tStatus:Access denied\n";
        cout << "\tReason:"     << S.c_str() << ";" << endl;
        cout << "\tValidx:"     << bRc      << ";" << endl;
        cout << "\tExcNum:["    << p_iExc   << "]" << endl;
    }

//  =:= m:  try exception isKnown:=false

    m.f_menu("throw<ANY>",__LINE__);

    try {
        if (iAge >= 18) {
            S   = "Access2 granted - you are old enough.";
        } else {
            #if defined(__BORLANDC__) && defined(_DEBUG)
                i=0;
            #else
                throw iExc;
            #endif
        }
        cout << "\tStatus2a:" << S.c_str() << ";" << endl;
    }
    catch (...) {        // iExc is unknown
        m.f_text("EXCEPTION2",m.E_COLOR_MAGENTA_BRHT);
        S   = "Status:Access denied - any reason.";
        cout << "\tStatus2b:" << S.c_str() << ";" << endl;
    }

//  =:= m:  overload excpetion class

    m.f_menu("MyExeption<const char*>",__LINE__);

    class CMyException: public exception {
        //  virtual function 'what' defined in class Exception
        virtual const char* what() const throw()
        {
            return "My exception happened"; // const char*
        }
    }   myException1;

    try {
        if (iAge >= 18) {
            S   = "Access3 granted - you are old enough.";
        } else {
            #if defined(__BORLANDC__) && defined(_DEBUG)
                i=__LINE__;
            #else
                throw myException1;
            #endif
        }
        cout << "\tStatus3a:" << S.c_str() << ";" << endl;
    }
    catch (exception& p_ccpExc) {        // iExc is known
        m.f_text("EXCEPTION3",m.E_COLOR_MAGENTA_BRHT);
        cout << "\tExcStr:["    << p_ccpExc.what()   << "]" << endl;
    }

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
    return F19_exception(m);
}
#endif
