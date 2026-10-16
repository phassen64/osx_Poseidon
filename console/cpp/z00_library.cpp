/*  **************************************************************************
 *  Tutorial.CPP  :: "library                    ©[mATe64]      [2026-10-16]
 *  **************************************************************************

 *  encoding: UTF-8
    !$@€ƒ„…†‡‰Œ“”•—™αβγδεζηθ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑØÞ.äöüÄÖÜß.æîðñô÷ýþÿЖ.$

 *  content
    •   m:  F.header
    •   m:  F.menu

*  ************************************************************************* */

#include "i00_CPP_tutor.h"

//  ***************************************************************************
//  m:  F.header
//  ***************************************************************************

void f_lib_header(const char *cText, const char *cFile, int iLine) {
    f_lib_line('=');
    printf(">>> HDR:{%s} src:[%s,%d] dtm:[%s;%s]\n",
        cText,cFile,iLine,__DATE__,__TIME__);
    f_lib_line('=');
}


void f_lib_footer(const char *cText, const char *cFile, int iLine)
{
    printf("<<< FTR:{%s} src:[%s,%d] dtm:[%s;%s].\n",
        cText,cFile,iLine,__DATE__,__TIME__);
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

void f_lib_trace(const char *cText, const char *cFile, int iLine) {
    printf("&&& %s:[%s;%d]\n", cText, __FILE__, __LINE__);
}
void f_lib_menu(const char *cText, const char *cFile, int iLine) {
    printf("\n&&& menu:%s:[%s;%d]\n\n",cText,__FILE__,__LINE__);
}
void f_lib_show(const char *cText, const char *cFile, int iLine) {
    printf("\n\t&&& %s:[%s;%d]\n\n",cText,__FILE__,__LINE__);
}


void f_lib_info(const char *p_sFile, const char *p_sDate, const char *p_sTime)
{
    printf("### lib.Info by:[%s]...\n",p_sFile);

    printf("\t\t:?atDate\t:'%s'\n",p_sDate);
    printf("\t\t:?atTime\t:'%s'\n",p_sTime);

    printf("\t\t:?isC++\t:");
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
