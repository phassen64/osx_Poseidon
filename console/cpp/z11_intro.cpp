/*  ***************************************************************************
 *  Tutorial.C++  :: "intro"            ©[mATe64]           [2026-10-16]
 *  ***********************************************************************.$.*/
//  !$@€ƒ„…†‡‰¡“”•—Ÿ¢£¤¥¦§¨™©®×±«»♔♖♞♟°²³ƒµ¶·¹º¼½¾¿ÄÖÜäöüßæœžîðñôö÷αβγδεΦXΨ.Ω.*


//  * include for printf
#include "stdio.h"

//  * include for cout
#include <iostream>
using namespace std;

//  tutor
#include "i01_CPP_standard.h"

int F01_hello(CTutor &m) {

    bool    b;
    string  S;
    char    s[256], *pc=s;

    //  =:= top
    cout << ">>> hello C++ Tutorial " << endl;

    //  =:= environment
    cout << "\tENVIRONMENT:= { "
    #if defined(_MSC_VER)
        << "MSC"
    #elif defined(__GNUC__)
        << "GNU"
    #elif defined(__BORLANDC__)
        << "BORLAND"
    #else
        << "?ANY"
    #endif
    << " }"
    << endl;


    //  !CRQ-241216: isOs
    b = m.f_bIsOsWindows();
    cout << "\tbIsWindows:= {" << b  << "}" << endl;

    //  !CRQ-241216: get my Scratch
    pc = m.f_sScratchDirectory();
    cout << "\tsDirScratch1:= {" << pc  << "}" << endl;

    //  =:= compilerID
    cout    <<  "\tCOMPILER := {"
            <<   __cplusplus
            <<  "}"
            <<  endl;

    //  =:= compilerType
    S = "C++:";
    #if __cplusplus >= 201103L
        S += "201X";
    #else
        S += "199X";
    #endif
    printf("\tTYPE:= { %s }\n",S.c_str());


    //  =:= USAGE option
    S = "PreProcSymbol:{ ";
    #ifdef _MSC_VER
        #if __USE_TUTOR__STD_C11
            S += "yes";
        #else
            S += "none";
        #endif
    #endif
    S += " }";
    printf("\tUSAGE := <%s>\n",S.c_str());

    cout << "<<< ready." << endl;

    return 0;
}


#ifndef __USE_TUTOR__MAIN
int main(int p_iArgs, char *p_sArgv[]) {
    CTutor  m;
    return F01_hello(m);
}
#endif
