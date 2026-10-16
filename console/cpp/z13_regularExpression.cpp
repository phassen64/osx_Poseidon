//  ****************************************************************************
//  TUTORIAL:   C++     :   Regular Expression (REGEX)
//  ****************************************************************************
//  !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß-------$
/*
    content:
        •   m:  regex::match
    url:
        •   https://cplusplus.com/reference/regex/
        •   https://www.softwaretestinghelp.com/regex-in-cpp/
*/


#include "Tutor.h"
using namespace std;

//  special include file for regular expressions
#ifdef __USE_TUTOR__STD_C11
    #include <regex>
#endif

int F__regex(CTutor &m) {

    int             iEc = m.f_iEc();
    const char*     sHdr =  "regex:match";
    char            z = m.E_COLOR_GRAY;
 //  =:= : define
    string          aS[5];  // array of strings
    string          STxt;   // tmp string to compare
    bool            bRex = false;
    string          SRex = "(\\+|-)?[[:digit:]]+";      // the RegEx

//  =:= : header
    m.f_chapter(sHdr, __FUNCTION__, __LINE__);

//  =:= m:  regex::match
    m.f_menu(sHdr, __LINE__);

//  =:= s:  create my REX object
    m.f_subMenu("regex",__LINE__);
#ifdef __USE_TUTOR__STD_C11
    regex           tRex(SRex);
#endif

//  =:= s:  create my to matches string array
    m.f_subMenu("create aS", __LINE__);
    aS[0] = string("123456");
    aS[1] = string("1g3456");
    aS[2] = string("e67");
    aS[3] = string("8232933");
    aS[4] = string("6666.234");

//  show
    m.f_text(z,"regex S:'%s'",SRex.c_str());

//  regMatch ans result
    m.f_subMenu("regMatch...",__LINE__);
    for(int i=0; i<5; i++) {
        STxt = aS[i] ;
        bRex = false;
#ifdef __USE_TUTOR__STD_C11
        if (regex_match ( STxt,tRex ) ) {
            bRex = true;
        }
#endif
        m.f_text(z,"REX[%i]<%s> \tmatch:<%d>",i, STxt.c_str(), bRex);
    }

    m.f_subMenu("finish", __LINE__);
    m.f_text(z,"iEc =: %d",iEc);
    return(iEc);
}


int F13_regular_expression(CTutor &m) {
    int             iRc,iEc;
    const char*     sHdr =  "RegularExpression";
    iEc = m.f_header(sHdr, __FILE__, __LINE__);
    iRc = F__regex(m);          if (iRc != iEc) { return iRc; }
    m.f_footer(sHdr, __FILE__, __LINE__);
    return(iEc);
};


#ifndef __USE_TUTOR__MAIN
int main(int p_iArgs, char *p_sArgv[]) {
    CTutor  m;
    if (p_iArgs >= 2) {
        m.f_mode_color(true);
    }
    return F13_regular_expression(m);
}
#endif
