/*  ***************************************************************************
 *  Tutorial.C++  :: "hello"            ©[mATe64]           [2026-10-16]
 *  ***********************************************************************.$.*/
//  !$@€ƒ„…†‡‰¡“”•—Ÿ¢£¤¥¦§¨™©®×±«»♔♖♞♟°²³ƒµ¶·¹º¼½¾¿ÄÖÜäöüßæœžîðñôö÷αβγδεΦXΨ.Ω.*

//  #include <stdio.h>
#include "i00_CPP_tutor.h"


int F01_hello(int p_iEc, char *p_sDirTmp) {

    f_lib_header("+",__LINE__,__FILE__);

    printf("hello C++ World!\n");

    f_lib_info( __LINE__, __FILE__, __DATE__, __TIME__);
    printf("### Ec:'%d'\n",p_iEc);
    printf("### MyScratchDirIs:'%s'\n",p_sDirTmp);

    f_lib_footer("-",__LINE__);
    return(p_iEc);
}

int main() {
    int     iEc;
    char  * psTmp=0;
    f_lib_getEnv(iEc,&psTmp);

    return F01_hello(iEc,psTmp);
}

/*last line*/