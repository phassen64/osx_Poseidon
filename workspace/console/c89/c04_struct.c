/*  ***************************************************************************
 *  tutorial.C89  :: "struct"               ©[mATe64]           [2026-10-13]
 *  **************************************************************************/
/*
    encoding: UTF-8
    !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿ
*/

#include    "i00_C89_tutor.h"


int F04_struct(int p_iEc);

#ifndef __USE_TUTOR_C89__MAIN
#define __USE_TUTOR_C89__MAIN
int main(int args, char *argv[]) {
    int     iEc = atoi(getenv("v_FWK_exitStatus"));
    return  F04_struct(iEc);
}
#endif

int F04_struct(int p_iEc) {

    f_lib_header("structures",__FILE__,__LINE__);

    printf("--- compiled:");
    printf("iEc  :[%d]\n",p_iEc);
    printf("DATETIME=(%s;%s)",__DATE__,__TIME__);
    printf("FILE: =[%s]\n", __FILE__);

    #ifdef  __cplusplus
        printf("### isC++:=YES\n");
    #else
        printf("### isC++:=NO !\n");
    #endif

    typedef union u_REAL
    {
        USIGN32 m_dword;       /* 32-bit */
        float   m_float;

        struct  {
            int /* muss 'int' sein - nicht USIGN32 */       frc:23;
            int /* USIGN32 */       exp:8;
            int /* USIGN32 */       sgn:1;
        } m_real;

         struct  {
            int /* USIGN32 */      abs:31;         /* frc+exp */
            int /* USIGN32 */      sgn:1;
        } m_real_sgn;

    } T_REAL;

    T_REAL      r1;
    T_REAL      * p = &r1;

    r1.m_dword = 0xa1a2a3a4;

    printf("r1.dw:[%ld]\n", r1.m_dword);
    printf("r1.ptr:[%p]\n", p);

    f_lib_footer("structures",__FILE__,__LINE__);
    return p_iEc;
}

