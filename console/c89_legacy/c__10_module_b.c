/*  ########################################################################### */
/*  10: MODULE: m_C2C++                                                         */
/*  ########################################################################### */
/* !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß         */
/*
 *  Dieses C-File wird als C++ File ?bersetzt.
 *  Es kann von C aus aufgerufen werden, weil hier :
 *      >>> extern "C" {....}   <<<
 *  verwendet wird. 
 */
#include    "stdio.h"          
static  char gstaticStr[80]="m_C2C++"; 

/*
 * ===  C comment style
 */
#ifdef  __cplusplus
extern "C" {
#endif
//  === C++ comment style
//  C2C++ code
//  We can use immediate coding styles between C and C++
int c2cppFct(int iVal)
{    
    printf("================================================== \n");   
    printf("[C10_b.c]:    <%s>\n",gstaticStr);  
    printf("================================================== \n");
    printf("--- FILE:%s,DATE={%s-%s}\n",
            __FILE__,  
            __DATE__,   
            __TIME__);  
#ifdef  __cplusplus
    printf("### isC++:=YES\n");
#else
    printf("### isC++:=NO !\n");
#endif                  
    printf("<<< input value :%d\n",iVal);
    iVal=7788;
    printf(">>> output Value: %d\n",iVal);
    printf("... end of module: <%s>\n",gstaticStr);
    return (iVal);
}
   
#ifdef  __cplusplus
} /* extern "C" */
#endif

