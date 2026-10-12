/*  ######################################################################## */
/*  10: MODULE: m_C                                                          */
/*  ######################################################################## */

#include "c00_include.h"
static  char    gstaticStr[80]="m_C"; 
extern  char    gStr[80];

int hello_C_NATIVE(void) {
    printf("*** Hello C native!\n");
    return(987);
}   

int cFct(int i)    
{      
    printf("================================================== \n");
    printf("[C10_a.c]:    <%s>\n",gstaticStr);  
    printf("================================================== \n");
    printf("--- FILE:%s,DATE={%s-%s}\n",
            __FILE__,  
            __DATE__,   
            __TIME__);        
    printf("--- [%s;%d]: START C_MODULE\n",__FILE__,__LINE__); 
    printf("Hello subFct \n");   /* eine Ausgabe eines Textes */
#ifdef  __cplusplus
    printf("### isC++:=YES\n");
#else
    printf("### isC++:=NO !\n");
#endif
    printf("--- static.global   (SubFct)\n");
    printf("### gStaticStr = <%s>\n",gstaticStr);
    printf("### gStr = <%s>\n",gStr);
    printf("<<< input  value:%d\n",i);
    i=123;
    printf(">>> output value:%d\n",i);
    printf("... end of module: <%s>\n",gstaticStr);
    return(i);
}


