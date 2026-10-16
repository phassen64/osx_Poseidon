/*  ***************************************************************************
 *  tutorial.C89  :: "system"                   ©[mATe64]       [2026-10-13]
 *  ***************************************************************************
 *   encoding: UTF-8
 *   !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿ
*/

/*  --- Content:
 *  MATHEMATIC              : abs, ceil, div, pow, sin,...
 */


#include "i00_C89_tutor.h"

/*
 *  ***************************************************************************
 *  MATHEMATISCHE Funktionen <math.h>
 *  ***************************************************************************
 */

int F_mod_mathTest() {

    int         i;
    double      dBase,dExp;
    double      dFrac,dMant;
    double      dVal1,dVal2;
    double      dSum;
    int         iVal1,iVal2;
    int         iSum;
    long int    liVal1,liVal2;
    div_t       tDiv;
    ldiv_t      l_tDiv;

    printf("\n&&& menu : mathTest [%s;%d] \n\n",__FILE__,__LINE__);

    iVal1    =   -981;
    iSum    =   abs(iVal1);
    printf("\tabs()     :: FCT(%d) =: %d\n", iVal1,iSum);

    iVal1   =   13;
    iVal2   =   3;
    tDiv    =   div(iVal1,iVal2);
    printf("\tdiv(x,y)  :: FCT(%d,%d) =: (%d,%d)\n",
                                iVal1,iVal2,tDiv.quot,tDiv.rem);
    liVal1  =   1234567890;
    liVal2  =   91;
    l_tDiv  =   ldiv(liVal1,liVal2);
    printf("\tldiv(x,y) :: FCT(%ld,%ld) =: (%ld,%ld)\n",
                                liVal1,liVal2,l_tDiv.quot,l_tDiv.rem);

    dBase   =   -981.321;
    dFrac   =   modf(dBase,&dMant);
    printf("\tmodf()    :: FCT(%f,&d) == (%f,%f) = :%f\n", dBase,dBase,dMant,dFrac);

    dVal1   =   12.125;
    dSum    =   frexp(dVal1,&i);
    printf("\tfrexp()   :: FCT(%f,&i)    == (%f,%i) =: %f\n", dVal1,dVal1,i,dSum);

    dBase   =   -981.321;
    dSum   =   fabs(dBase);
    printf("\tfabs()    :: FCT(%f) =: (%f)\n", dBase,dSum);

/*  gcc has not ceil etc */
#if defined(__cplusplus) || defined (_MSC_VER_)
        printf("\tVERSION:C++ || MSVER'\n");
#else
        printf("\tVERSION:gcc\n");
        return __LINE__;
#endif

    dBase   =   -981.321;
    dSum    =   ceil(dBase);
    printf("\tceil()    :: FCT(%f) =: %f\n", dBase,dSum);

    dBase   =   981.321;
    dSum    =   ceil(dBase);
    printf("\tceil()    :: FCT(%f) =: %f\n", dBase,dSum);

    dBase   =   -981.321;
    dSum    =   floor(dBase);
    printf("\tfloor()   :: FCT(%f) =: %f\n", dBase,dSum);

    dBase   =   981.321;
    dSum    =   floor(dBase);
    printf("\tfloor()   :: FCT(%f) =: %f\n", dBase,dSum);


    dVal1   =   12.125;
    dVal2   =   3.425;
    dSum    =   fmod(dVal1,dVal2);
    printf("\tfmod()    :: FCT(%f,%f) =: %f\n", dVal1,dVal2,dSum);

    dBase   =   1.3;
    dExp    =   4.1;
    dSum    =   pow(dBase,dExp);
    printf("\tpow()     :: FCT(%f,%f) =: %f\n", dBase,dExp,dSum);

    dBase   =   100.10;
    dSum    =   log10(dBase);
    printf("\tlog10()   :: FCT(%f) =: %f\n", dBase,dSum);

    dBase   =   4.5;
    dSum    =   exp(dBase);
    printf("\texp()     :: FCT(%f) =: %f\n", dBase,dSum);

    dBase   =   100.10;
    dSum    =   log(dBase);
    printf("\tlog()     :: FCT(%f) =: %f\n", dBase,dSum);

    dBase   =   100.10;
    dSum    =   sqrt(dBase);
    printf("\tsqrt()    :: FCT(%f) =: %f\n", dBase,dSum);

    dBase   =   C_PI/2;
    dSum    =   sin(dBase);
    printf("\tsin()[RAD]    :: FCT(%f) =: %f\n", dBase,dSum);

    dBase   =   30;
    dSum    =   cos(dBase);
    printf("\tcos()[RAD]    :: FCT(%f) =: %f\n", dBase,dSum);

    dBase   =   30;
    dSum    =   tan(dBase);
    printf("\ttan()[RAD]    :: FCT(%f) =: %f\n", dBase,dSum);

    dBase   =   0.5;
    dSum    =   asin(dBase);
    printf("\tasin()[RAD]   :: FCT(%f) =: %f\n", dBase,dSum);

    dBase   =   0.5;
    dSum    =   acos(dBase);
    printf("\tacos()[RAD]   :: FCT(%f) =: %f\n", dBase,dSum);

    dBase   =   0.5;
    dSum    =   atan(dBase);
    printf("\tatan()[RAD]   :: FCT(%f) =: %f\n", dBase,dSum);

    dBase   =   C_E/2;
    dSum    =   sinh(dBase);    /* 0.5 * (e ** x - e ** -x) */
    printf("\tsinh()[RAD]   :: FCT(%f) =: %f\n", dBase,dSum);

    dBase   =   C_E/2;
    dSum    =   cosh(dBase);   /* 0.5 * (e ** x + e ** -x) */
    printf("\tcosh()[RAD]   :: FCT(%f) =: %f\n", dBase,dSum);

    dBase   =   C_E/2;
    dSum    =   tanh(dBase);
    printf("\ttanh()[RAD]   :: FCT(%f) =: %f\n", dBase,dSum);

    return __LINE__;
}

/*
 *  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
 *  m:body
 *  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
*/

#define F_CHK()   { \
    if ( iRc < 0) { \
        printf("?Code:%d at:[%d]",(iRc),(__LINE__)); return(iRc); } }

int F09_math(int p_iEc)
{
    int iRc;

    f_lib_header("math",__FILE__,__LINE__);

    /*  subfunction call */

    printf("\n\ts:call subfunction...\n");

    iRc = F_mod_mathTest();     printf("\n\tRC.mathTest         =: <%d>\n",iRc); F_CHK();


    f_lib_footer("math",__FILE__,__LINE__);
    return(p_iEc);

} /* main */



/*  ######################################################################## */
/*	main */
/*  ######################################################################## */

#ifndef __USE_TUTOR_C89__MAIN
#define __USE_TUTOR_C89__MAIN
int main(int args, char *argv[]) {
    int     iEc = atoi(getenv("v_FWK_exitStatus"));
    return  F09_math(iEc);
}
#endif
