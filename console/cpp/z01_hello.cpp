//  ****************************************************************************
//  TUTORIAL:   C++     :   hello
//  ****************************************************************************
/*
    content:
        •   === hints
    keyword handled:
        •   cout
        •   printf
        •   retur
    url:
        •   https://www.w3schools.com/cpp/
        •   https://cplusplus.com/doc/tutorial/
    Encoding of this file :
#   !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß-------$
        •   ANSI
            https://en.wikipedia.org/wiki/Windows-1252
            === Encoding chars :
    US Keyboard Symbols :
        `       grave, grave accent, backtick, back quote
        ~       tilde
        !       exclamation mark, exclamation point, bang
        @       at, at sign, at symbol
        #       pound, hash, number
        $       dollar(s)
        %       percent, percent sign, parts per 100
        ^       carat, hat, circumflex, exponent symbol
        &       and, ampersand
        *       asterisk
        (       open parenthesis, left parenthesis
        )       close parenthesis, right parenthesis
        ( )     parentheses, round brackets
        •       hyphen, minus, minus sign, dash
        _       underscore
        =       equals, equal sign
        +       addition, plus sign
        [ ]     brackets, square brackets
        [       open bracket
        ]       close bracket
        { }     braces, curly brackets
        {       open brace
        }       close brace
        \       backslash, backward slash
        |       vertical pipe, pipe
        ;       semicolon
        :       colon
        `'      apostrophe, prime, single quote
        •       quotation mark, double quotes
        ,       comma
        .       period, decimal, dot
        /       slash, forward slash
        <>      angle brackets
        <       less than
        >       greater than
        ?       question mark
*/

/*
 + callMe:
    $>_cdc
    $>g++ c01_hello.cpp -ansi -Wall -o c01_hello.exe'
    $>.\c01_hello.exe
    $>_ldr; _cpp .\c01_hello.cpp; .\run.exe
*/

//  * include for printf
#include "stdio.h"

//  * include for cout
#include <iostream>
using namespace std;

//  tutor
#include "Tutor.h"

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
    #if __USE_TUTOR__STD_C11
        S += "yes";
    #else
        S += "none";
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
