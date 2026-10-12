//  ########################################################################### 
//  10: MODULE: m_C++2C                                                  
//  ###########################################################################   
//  Im Gegensatz zum zur Quelle <FILE.c>,
//  soll dieses File immer als C++ file includiert werden.
//  RESULTAT:
//      Die main() Funktion aus c10.c kann die Funktion cpp2cFct() 
//      nicht aufgerufen, bzw. diese Funktion kann nicht gelinkt werden.
//  !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß

/*  --------------------------------------------------------------------------- 
 *      LINK-ERROR
 *  ---------------------------------------------------------------------------
 *  *** ERR := "Undefined reference to cppFct" ***
 *  --- Ursache f?r den link ERROR: 
 *  c++ Funktionen k?nnen NICHT von c aufgerufen werden,
 *  wenn kein 'extern C' verwendet wird.
*/

#define     V__cplusplus
#include    <iostream>      
using       namespace std;        
static  char gstaticStr[80]="m_C++2C"; 
//  #include    "c10_b.c"
extern "C" int hello_C_NATIVE(void);

extern "C" {
int cpp2cFct(int iVal)
{    
    printf("================================================== \n");
    printf("[C10_c.cpp]: <%s>\n",gstaticStr);  
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

//  --- real C++ code
    class CInt {
    private:
         int   m_i1;
         int   m_i2;
    public:
         CInt::CInt(int p1, int p2) {
            m_i1 = p1;
            m_i2 = p2;            
         };            
         int operation(int &val) {
            val = val + m_i1 * m_i2;
            return val;
         }
    };
    CInt    I1(4,5);
    
//  --- use other modules          
    printf("<<< input value :%d\n",iVal);
    printf("make C++Operation:%d\n",I1.operation(iVal));
    printf("call submodule...\n");    
    iVal = hello_C_NATIVE();
    printf(">>> output value:%d\n",iVal);
    printf("...end of module: <%s>\n",gstaticStr);
    return iVal;
};
} /* extern C */
