//  ****************************************************************************
//  TUTORIAL:   C++     :   dummy
//  ****************************************************************************
//  !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß-------$
/*
    content:
        •   m:  DUMMY
    url:
        •   NONE
 */


#include "Tutor.h"

using namespace std;

int F00_dummy(CTutor &m) {
    int             iEc;
    const char*     sHdr =  "None";
    //  =:= b:  body
    m.f_header(sHdr, __FILE__, __LINE__);
    iEc = m.f_iEc();
    //  =:= m:  NONE
    m.f_menu("NONE", __LINE__);
    //  =:= b:  body
    m.f_footer(sHdr, __FILE__, __LINE__);
    return(iEc);
};


#ifndef __USE_TUTOR__MAIN
int main(int p_iArgs, char *p_sArgv[]) {
    CTutor  m;
    if (p_iArgs >= 2) {
        m.f_mode_color(true);
    }
    return F00_dummy(m);
}
#endif
