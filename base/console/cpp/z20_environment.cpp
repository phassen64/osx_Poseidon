//  ****************************************************************************
//  TUTORIAL:   C++     :   environment
//  ****************************************************************************
//  !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß-------$

/*
    content:
        •   m:  getenv

    url:
        •   https://cplusplus.com/reference/cstdlib/getenv/
 */


#include "Tutor.h"
using namespace std;

bool F__isEnv(const char *s) {
    if (s == NULL) {
        return false;
    }
    else {
        return true;
    }
}

int F20_environment(CTutor &m) {

    const char*     sHdr = "env";
    const char *    pccKey;
    char *          pcVal;
    int             iEc;
    char            z = m.E_COLOR_GRAY;
    const char *    saEnv[] = {
        "TMP",
        "USERNAME",
        "USERPROFILE",
        "COMPUTERNAME",
        "v_FWK_mode_bClear",
        "v_FWK_mode_bVerbose",
        "v_FWK_exitStatus"
    };
    int         n = 7;

//  =:= b:  header
    iEc = m.f_header(sHdr,__FILE__,__LINE__);
    m.f_status();   // !CRQ-220928:checkStatus

//  =:= m:  getenv
    m.f_menu("getenv",__LINE__);

    for(int i=0; i<n;i++) {
        pccKey = saEnv[i];
        if (F__isEnv(pccKey)) {
            pcVal = getenv(pccKey);
            m.f_text(z,"ENV[%d]('%s') \t =>  '%s'",i,pccKey,pcVal);
        }
    }

//  =:= b:  footer
    m.f_footer(sHdr,__FILE__,__LINE__);
    return iEc;
};

#ifndef __USE_TUTOR__MAIN
int main(int p_iArgs, char *p_sArgv[]) {
    CTutor  m;
    if (p_iArgs >= 2) {
        m.f_mode_color(true);
    }
    return F20_environment(m);
}
#endif
