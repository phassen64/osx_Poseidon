#ifndef __USE_TUTOR__MAIN
    #define INC__TUTOR_LIBRARY
#endif
#include "c00_include.h"
#include "c11_misc.h"

/*
    encoding: UTF-8
    !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿ
*/

#define F_CHK()   { \
    if ( iRc < 0) { \
        printf("?Code:%d at:[%d]",(iRc),(__LINE__)); return(iRc); } }


int F11_misc(int p_iEc)
{
    int             iRc = 123;
    TRecord X;

    F_MENU("miscTest");

    X.m_cVal = 'c';
    X.m_iVal = 987;
    X.m_eVal = e_green;


    printf("--- char: '%c'\n", X.m_cVal);
    printf("--- numb: '%d'\n", X.m_iVal);
    printf("--- eCol: '%d'\n", X.m_eVal);

    printf("\n\tRC.misc  =: <%d>\n", iRc); F_CHK();

    return __LINE__ ;
}


#ifndef __USE_TUTOR__MAIN
int main(int args, char *argv[])
{
    int     iEc = atoi(getenv("v_FWK_exitCode"));
    return(F11_misc(iEc));
}
#endif /* __USE_TUTOR__MAIN */


