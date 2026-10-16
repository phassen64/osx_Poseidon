/*  ***************************************************************************
 *  Tutorial.C++  :: "hello"            ©[mATe64]           [2026-10-16]
 *  ***********************************************************************.$.*/
//  !$@€ƒ„…†‡‰¡“”•—Ÿ¢£¤¥¦§¨™©®×±«»♔♖♞♟°²³ƒµ¶·¹º¼½¾¿ÄÖÜäöüßæœžîðñôö÷αβγδεΦXΨ.Ω.*

/*
    environment
        •   v_FWK_exitStatus
        •   v_FWK_dirScratch

    content:
        •   === hints

    keyword handled:
        •   cout
        •   printf
        •   return
    url:
        •   https://www.w3schools.com/cpp/
        •   https://cplusplus.com/doc/tutorial/

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

#include "Tutor.h"

int F01_hello(int p_iEc, char *p_sDirTmp) {

    f_lib_header("+",__LINE__,__FILE__);

    printf("hello C++ World!\n");

    f_lib_info( __LINE__, __FILE__, __DATE__, __TIME__);
    printf("### Ec:'%d'\n",p_iEc);
    printf("### MyScratchDirIs:'%s'\n",p_sDirTmp);

    f_lib_footer("-",__LINE__);
    return(p_iEc);
}

#ifndef __USE_TUTOR__MAIN
int main() {
    int     iEc;
    char  * psTmp=0;
    f_lib_getEnv(iEc,&psTmp);
    return F01_hello(iEc,psTmp);
}
#endif

/*last line*/