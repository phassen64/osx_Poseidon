/*  ***************************************************************************
 *  tutorial.C89  :: "dummy"                    ©[mATe64]       [2026-10-13]
 *  ***************************************************************************
    encoding: UTF-8
    !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿ
 */


/*  m:  I.include */
#include "i00_tutorC89.h"

/*  m:  F.tester */
int F03_dummy(int p_iEc) {
    F_HEADER("dummy03");
    f_lib_compilerInfo();
    return(p_iEc);
}

/*  m:  F.main */
#ifndef __USE_TUTOR_C89__MAIN
#define __USE_TUTOR_C89__MAIN
int main() {
    int     iEc = atoi(getenv("v_FWK_exitCode"));
    return  F03_dummy(iEc);
}
#endif

