//  ****************************************************************************
//  TUTORIAL:   C++     :   memory <Dynamic memory management>
//  ****************************************************************************
//  !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß-------$
/*
    content:
        •   i:  dynamicMemory_c89
            •   m:  malloc
            •   m:  calloc
            •   m:  free
            •   m:  realloc
        •   i:  dynamicMemory_cPP
            •   m:  new && new[]
            •   m:  delete && delete[]
    keyword:
        •   delete
        •   free
        •   new
    url:
        •   https://cplusplus.com/reference/cstdlib/
        •   https://cplusplus.com/reference/cstdlib/malloc/
        •   https://cplusplus.com/reference/cstdlib/calloc/
        •   https://cplusplus.com/reference/cstdlib/realloc/
        •   https://cplusplus.com/doc/tutorial/dynamic/
 */

#include "Tutor.h"
using namespace std;


int F__dynamicMemory_c89(CTutor &m) {
    int         iEc = m.f_iEc();
    const char* sHdr = "memC89";
    char        z = m.E_COLOR_GRAY;
    void *      p;
    char *      pc;
    int  *      pi;
    int         iStart;
    int         iMemSize;

//  =:= i:  dynamicMemory_c89
    m.f_chapter(sHdr,__FILE__,__LINE__,true);

//  =:= m:  malloc
    m.f_menu("malloc",__LINE__);

    //  * random memsize
    iMemSize = 1 + m.f_iRandom(20); m.f_text(z,"iMemSize =:'%d'",iMemSize);
    iMemSize = 32; m.f_text(z, "iMemSize.now =:'%d'", iMemSize);

    //  * allocate memory
    p   = malloc(iMemSize);
    if (p == NULL) {
        m.f_text(z, "malloc  fails");
        return -(__LINE__);
    }
    m.f_text(z,"malloc('%d') => '%p'",iMemSize, p);

    //  * use it
    pc  = (char*)p; // save
    for (int i=0; i<iMemSize-1; i++, pc++) {
        *pc = 'A' + i;
    }
    *pc = 0;

    //  * show
    pc = (char*)p; // restore
    m.f_text(z, "result : '%s'", pc);

//  =:= m:  calloc
    m.f_menu("calloc",__LINE__);
    p   = calloc(iMemSize,sizeof(int));
    if (p == NULL) {
        m.f_text(z, "calloc  fails");
        return -(__LINE__);
    }
    m.f_text(z,"calloc('%d') => '%p'",iMemSize, p);

    //  * use it
#if (defined(_MSC_VER))
    #pragma warning( push )
    #pragma warning (disable: 4127)
#endif /* MSCVER*/
    pi  = (int*)p;
    if (sizeof(int) == 4) {
        iStart = 0x41424300;
    }
    else if (sizeof(int) == 2) {
        iStart = 0x2100;
    }
    else {
        iStart = 0x40;
    }
#if (defined(_MSC_VER))
    #pragma warning( pop )
#endif /* MSCVER*/
    for (int i=0; i<iMemSize; i++, pi++) {
        *pi = iStart + i;
    }
    pi = (int*)p; // restore


//  =:= m:  realloc
    m.f_menu("realloc",__LINE__);
    iMemSize *= 2;
    p = (int*)realloc(pi, iMemSize * sizeof(int));
    if (p == NULL) {
        m.f_text(z, "realloc  fails");
        return -(__LINE__);
    }
    m.f_text(z, "realloc('%d') => '%p'", iMemSize, p);

    //  save
    pi = (int*)p; // save

    //  * write something more
    for (int i = 0; i < iMemSize; i++, pi++) {
        *pi = iStart + i;
    }
    pi = (int*)p; // restore

//  =:= m:  free
    m.f_menu("free",__LINE__);
    m.f_text(z, "free('%p')",pc);
    m.f_text(z, "free('%p')",pi);
    free(pc);
    free(pi);

    return(iEc);
};


int F__dynamicMemory_cPP(CTutor &m) {
    int         iEc = m.f_iEc();
    const char* sHdr = "memC++";
    char        z = m.E_COLOR_GRAY;
    int         iMemSize;

//  =:= i:  dynamicMemory_cPP
    m.f_chapter(sHdr,__FILE__,__LINE__,true);

//  =:= m:  new && new[]
    m.f_menu("new",__LINE__);
    char    *pc;
    int     *pi;

    //  *   single char alloc
    m.f_subMenu("perform new char",__LINE__);
    pc = new char;

    //  *   access
    *pc = '$';
    m.f_text(z, "single char : '%p' => '%c'", pc, *pc);

    //  *   perform new - risk an exception
    m.f_subMenu("perform new int[iMemSize]",__LINE__);

    //  * random memsize
    iMemSize = 1 + m.f_iRandom(10);
    m.f_text(z, "iMemSize =:'%d'", iMemSize);

    //  * new
    pi = new int[iMemSize];
    m.f_text(z, "exception?");

    //  *   perform new - avoid an exception but get NULL
    m.f_subMenu("perform new(nothrow)",__LINE__);
    pi = new(nothrow) int[iMemSize];
    m.f_text(z, "nullptr?");
    #ifdef __USE_TUTOR__STD_C11
        assert(pi != nullptr);
    #else
        assert(pi != NULL);
    #endif

    //  *   access
    m.f_subMenu("write pi[i]:=x",__LINE__);
    for(int i =0, iAsc=0x40; i<iMemSize; i++) {
        pi[i] = iAsc++;
    }

    //  *   show
    m.f_subMenu("show",__LINE__);
    for(int i =0; i<iMemSize; i++) {
        m.f_text(z, "mem[%d] =:'%2.2x'", i, pi[i]);
    }

//  =:= m:  delete  && delete[]
    m.f_menu("delete",__LINE__);

    m.f_subMenu("delete pc",__LINE__);
    delete pc;

    m.f_subMenu("delete[] pi",__LINE__);
    delete[] pi;

    m.f_text(z, "run");

    return iEc;
}


int F17_memory(CTutor &m) {
    int             iEc ,
                    iRc;
    const char*     sHdr = "memory C89vsC++";

//  =:= b:  header
    iEc = m.f_header(sHdr,__FILE__,__LINE__);

//  =:= b:  dynamicMemory
    iRc = F__dynamicMemory_c89(m); if (iRc != iEc) { return iRc; }
    iRc = F__dynamicMemory_cPP(m); if (iRc != iEc) { return iRc; }

//  =:= b:  footer
    m.f_footer(sHdr,__FILE__,__LINE__);
    return(iEc);
};


#ifndef __USE_TUTOR__MAIN
int main(int p_iArgs, char *p_sArgv[]) {
    CTutor  m;
    if (p_iArgs >= 2) {
        m.f_mode_color(true);
    }
    return F17_memory(m);
}
#endif
