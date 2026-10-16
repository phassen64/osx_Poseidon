/*  ***************************************************************************
 *  Tutorial.C++  :: "hello"            ©[mATe64]           [2026-10-16]
 *  ***********************************************************************.$.*/
//  !$@€ƒ„…†‡‰¡“”•—Ÿ¢£¤¥¦§¨™©®×±«»♔♖♞♟°²³ƒµ¶·¹º¼½¾¿ÄÖÜäöüßæœžîðñôö÷αβγδεΦXΨ.Ω.*

//  #include <stdio.h>
#include "i00_CPP_tutor.h"

int F01_hello(int p_iEc) {
    f_lib_header("Hello",__FILE__,__LINE__);
    printf("hello C++ World!\n");
    f_lib_footer("Hello");
    return(p_iEc);
}

int main() {
//  int  iEc = atoi(getenv("v_FWK_exitStatus"));
    int  iEc = 77;
    return F01_hello(iEc);
}

/*last line*/