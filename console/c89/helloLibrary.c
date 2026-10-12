/*
    *   compile+link in 1 STEP
        $   gcc helloLibrary.c c00_library.c -o do.exe

    *   compile+link in 2 STEPs
        $   gcc -c helloLibrary.c -o src.obj
        $   gcc -c c00_library.c -o lib.obj
        $   gcc src.obj lib.obj -o run.exe
        $   ./run.exe
*/


#include "c00_tutorC89_2_advanced.h"

void f_lib_hello(void);

int main() {
    printf("hello,M Tester!\n");
    f_lib_hello();
    return 61;
}

/*last line*/