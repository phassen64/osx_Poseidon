/*  **************************************************************************
 *  Tutorial.CPP  :: "library                    ©[mATe64]      [2026-10-16]
 *  **************************************************************************

 *  encoding: UTF-8
    !$@€ƒ„…†‡‰Œ“”•—™αβγδεζηθ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑØÞ.äöüÄÖÜß.æîðñô÷ýþÿЖ.$

 *  content
    •   m:  F.env
    •   m:  F.header
    •   m:  F.menu

*  ************************************************************************* */

#include "i00_CPP_tutor.h"

//  ***************************************************************************
//  m:  F.env
//  ***************************************************************************

void f_lib_getEnv(int & p_iEc, char **p_sDir) {
    p_iEc   =   atoi(getenv("v_FWK_exitStatus"));
    *p_sDir =   getenv("v_FWK_dirScratch");
}

//  ***************************************************************************
//  m:  F.header
//  ***************************************************************************

void f_lib_header(const char *sText, int iLine, const char *sFile) {
    f_lib_line('=');
    printf(">>> HDR:{%s} src:[%s,%d] dtm:[%s;%s]\n",
        sText,sFile,iLine,__DATE__,__TIME__);
    f_lib_line('=');
}


void f_lib_footer(const char *sText, int iLine, const char *sFile)
{
    printf("<<< FTR:{%s} src:[%s,%d] dtm:[%s;%s].\n",
        sText,sFile,iLine,__DATE__,__TIME__);
}


//  ***************************************************************************
//  m:  F.menu
//  ***************************************************************************

void f_lib_line(const char cText)
{
    #define C_DBG_LINE_SIZE 70
    int i;
    for(i=0; i < C_DBG_LINE_SIZE; i++) {
        printf("%c",cText);
    }
    printf("\n");
}

void f_lib_trace(const char *sText, int iLine, const char *sFile) {
    printf("&&& %s:[%s;%d]\n", sText, __FILE__, __LINE__);
}
void f_lib_menu(const char *sText, int iLine, const char *sFile) {
    printf("\n&&& menu:%s:[%s;%d]\n\n",sText,__FILE__,__LINE__);
}
void f_lib_show(const char *sText, int iLine, const char *sFile) {
    printf("\n\t&&& %s:[%s;%d]\n\n",sText,__FILE__,__LINE__);
}


void f_lib_info(int p_iLine, const char *p_sFile,
                    const char *p_sDate, const char *p_sTime)
{
    printf("### lib.Info by:[%s;%d]...\n",p_sFile,p_iLine);

    printf("\t\t:?atDate\t:'%s'\n",p_sDate);
    printf("\t\t:?atTime\t:'%s'\n",p_sTime);

    printf("\t\t:?isC++\t\t:");
    #ifdef  __cplusplus
        printf("'YES'\n");
    #else
        printf("'NO!'\n");
    #endif

    printf("\t\t:?isSTANDARD_\t:");
    #ifdef  __STDC__
        printf("'YES'\n");
    #else
        printf("'NO!'\n");
    #endif

    printf("\t\t:?whichCompiler\t:");
    #if defined(_MSC_VER)
        printf("'_MSC_VER'\n");
    #elif defined(__BORLANDC__)
        printf("'__BORLANDC__'\n");
    #elif defined(__GNUC__)
        printf("'__GNUC__'\n");
    #else
        printf("'??? UNKNOWN'\n");
    #endif
}
