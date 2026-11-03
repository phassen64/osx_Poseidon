/*  ***************************************************************************
 *  tutorial.C89  :: "dummy"                    ©[mATe64]       [2026-10-13]
 *  ***************************************************************************
 *   encoding: UTF-8
 *   !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿ
*/
#include "i00_C89_tutor.h"

int F19_dummy(int p_iEc) {
    return (p_iEc);
}

#ifndef __USE_TUTOR_C89__MAIN
#define __USE_TUTOR_C89__MAIN
int main(int args, char *argv[])
{
    int     iEc = atoi(getenv("v_FWK_exitStatus"));
    return(F19_dummy(iEc));
}
#endif


