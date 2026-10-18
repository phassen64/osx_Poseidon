//  ****************************************************************************
//  TUTORIAL:   C++     :   function
//  ****************************************************************************
//  !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß-------$
/*

    content functions... :  issues and menues

        === i:  starter
            •   m:  void
            •   m:  byValue

        === i:  argPTR vs argREF
            •   m:  byPointer
            •   m:  byReference

        === i:  argVAL vs argREF vs argSAFETY
            •   m:  concat.byValue
            •   m:  concat.byReference
            •   m:  concat.byReference & Safety

        === i:  global vs static
            •   m:  global
            •   m:  static

        === i:  recursion
            •   m:  Fibonnaci

        === i:  variable argument list
            •   m:  vAdd
            •   m:  vAverage
            •   m:  vprintf
            •   m:  vsprintf
            •   m:  vfprintf

        === i:  default parameter values
            •   m:  F_fDIV(fD,fQ=2)

        === i:  inline
            •   m:  inline F_iMAX()

        === i:  overload
            •   m:  i <= F_tOperator(i)
            •   m:  f <= F_tOperator(f)

        === i:  retPTR vs retREF
            •   m:  return PTR
            •   m:  return REF

        === i:  fctPTR vs fctREF
            •   m:  fctPTR
            •   m:  fctREF
        program:
            •   b:  header
            •   b:  footer

    keywords handled:
        •   inline
        •   return
        •   sizeof

    url:
        •   https://cplusplus.com/doc/tutorial/functions/
        •   https://de.wikipedia.org/wiki/Fibonacci-Folge
 */


#include "Tutor.h"
using namespace std;

#undef  C_BUFFER_SIZE
#define C_BUFFER_SIZE    512
#define C_TUTOR__MAX_LOOP_COUNTER 100

//  === i:  starter

void    F__void(CTutor &m,  char p_cVal, int p_iVal) {
    char    z = m.E_COLOR_GRAY;
    m.f_chapter("void", __FUNCTION__, __LINE__);
    m.f_puts(z,"\tparameter :: ( char:'%c' int:'%d' )",p_cVal,p_iVal);
}

int     F__byVal_add(CTutor &m, int p_i1, int p_i2) {
    char    z = m.E_COLOR_GRAY;
    int     iSum;
    m.f_chapter("byVal", __FUNCTION__ ,__LINE__);
    m.f_puts(z,"\tparameter :: ( i1:'%d' i2:'%d' )",p_i1,p_i2);
    iSum = p_i1 + p_i2;
    return iSum;
}

//  === i:  argPTR vs argREF

int     F__byPtr(CTutor &m, char* p_cVal, int* p_iVal) {
    char    z = m.E_COLOR_GRAY;
    m.f_chapter("byPtr",__FUNCTION__,__LINE__);
    m.f_puts(z,"\tparameter :: ( char*:'%p' int*:'%p' )",p_cVal,p_iVal);
    *p_cVal += 1;
    *p_iVal += 100;
    return __LINE__;
}

int     F__byRef(CTutor &m, char& p_cVal, int& p_iVal) {
    char    z = m.E_COLOR_GRAY;
    m.f_chapter("byRef",__FUNCTION__,__LINE__);
    m.f_puts(z,"\tparameter :: ( char:'%c' int:'%d' )",p_cVal,p_iVal);
    p_cVal += 1;
    p_iVal += 3;
    m.f_puts(z,"\tparameter :: ( char:'%c' int:'%d' )",p_cVal,p_iVal);
    return __LINE__;
}


//  === i:  argVAL vs argREF vs argSAFETY


string  F__sConactenate_byVal (CTutor &m,   string p_sA, string p_sB) {
    m.f_chapter("byVal",__FUNCTION__,__LINE__);
    return p_sA + " & " + p_sB + " !";
}
//  faster - only ref
string  F__sConactenate_byRef (CTutor &m,   string& p_sA, string& p_sB) {
    m.f_chapter("byRef",__FUNCTION__,__LINE__);
    return p_sA + " & " + p_sB + " !";
}
//  faster and saftey - ref but don't change caller variables
string  F__sConactenate_byRef_const (CTutor &m,
                                                    const string& p_sA,
                                                    const string& p_sB) {
    m.f_chapter("bySafety",__FUNCTION__,__LINE__);
    return p_sA + " & " + p_sB + " !";
}


//  === i:  global vs static

//  using a named global variable
/*  A global variable is declared even before the �main()� function in C++,
    and it is destroyed only once your program finishes its execution.
*/

int     g_iCounter = 0;
int     F__callMeCounter_global(CTutor &m) {
    if (g_iCounter == 0)  {
        m.f_chapter("global",__FUNCTION__,__LINE__);
    }
    return ( ++ g_iCounter  );
}

/*  url: https://www.geeksforgeeks.org/static-keyword-cpp/
    Static variables in a Function:
    When a variable is declared as static, space for
    it gets allocated for the lifetime of the program.
    Even if the function is
        called multiple times, space for the static variable is allocated only once
        and the value of variable in the previous call gets carried through the next
    function call.
    This is useful for implementing coroutines in C/C++ or any other
    application where previous state of function needs to be stored.
*/

/*
    The effect is equal as using global, but there is no global needed
 */
int     F__callMeCounter_static(CTutor &m) {
    static  int m_iCounter = 0;
    if (m_iCounter == 0)  {
        m.f_chapter("static",__FUNCTION__,__LINE__);
    }
    return ( ++ m_iCounter );
}

//  === i:  recursion

#define C_TUTOR__FIB_MAX   10

int     F__fib(CTutor &m, int n) {
    char        z = m.E_COLOR_GRAY;
    if (n == C_TUTOR__FIB_MAX)  {
        m.f_chapter("fibonnaci",__FUNCTION__,__LINE__);
        m.f_puts(z,"\tparameter :: ( int:'%d' )",n);
        m.f_iCounter(true);
    } else {
        m.f_iCounter();
    }
    #ifdef __USE_DEBUG
        static int  iCallCounter=0;
        m.f_puts(z,"\tFIB[%2.2d]( '%d' )",++iCallCounter, n);
    #endif
    if (n <= 0) return 0;
    if (n <= 2) return 1;
    return ( F__fib(m,n-1) + F__fib(m,n-2) );
}

//  === i:  variable argument list

/*  * Das Ende einer variablen Liste muss irgendwie bestimmbar sein
    * Hier ist es der erste Parameter, welche die gesamte Anzahl
    * der g�ltigen Argumente definiert
*/
int F__vAdd(CTutor &m, int p_iNumberOfValues, ...) {
    m.f_chapter("vAdd",__FUNCTION__,__LINE__);
    int iSum=0;
    va_list  tVaList;
    va_start(tVaList, p_iNumberOfValues);
    for(int i=0; i<p_iNumberOfValues; i++) {
        iSum += va_arg(tVaList, int);
    }
    va_end(tVaList);
    return iSum;
}

/*  * Hier soll das Ende durch den Wert 0.0
    * bestimmt werden.
*/
double F__vAvg(CTutor &m, double p_fValue, ...) {
    m.f_chapter("vAverage",__FUNCTION__,__LINE__);
    int     iNumberOfValues     = 1;        // first element in list
    double  fSum                = p_fValue; // sum := <value of first element>
    double  fVal;
    va_list  tVaList;
    va_start(tVaList, p_fValue);
    do {
        fVal    = va_arg(tVaList, double);
        if (fVal == 0) {
            break;
        }
        iNumberOfValues +=  1;
        if (iNumberOfValues > C_TUTOR__MAX_LOOP_COUNTER) {
            break;
        }
        fSum            +=  fVal;
    } while (true);
    va_end(tVaList);
    return ( fSum / iNumberOfValues);        // !PHA:typecast(int)=>double
}

//  url:https://cplusplus.com/reference/cstdio/vprintf/?kw=vprintf
//  int vprintf ( const char * format, va_list arg );
void    F__vPrint(CTutor &m, const char *p_sFmt, ...) {
    m.f_chapter("vprintf",__FUNCTION__,__LINE__);
    va_list  tVaList;
    va_start(tVaList, p_sFmt);
    printf("\tvShow:: <");
    vprintf (p_sFmt, tVaList);
    printf(">\n");
    va_end(tVaList);
}

//  url: https://cplusplus.com/reference/cstdio/vsprintf/
//  int vsprintf (char * s, const char * format, va_list arg );
char *  F__vsPrint(CTutor &m, char *p_cBuffer, const char *p_sFmt, ...) {
    m.f_chapter("vsprintf",__FUNCTION__,__LINE__);
    va_list  tVaList;
    va_start(tVaList, p_sFmt);
    vsprintf (p_cBuffer, p_sFmt, tVaList);
    va_end(tVaList);
    return p_cBuffer;
}

//  url:https://cplusplus.com/reference/cstdio/vfprintf/
//  int vfprintf ( FILE * stream, const char * format, va_list arg );
void    F__vfPrint(CTutor &m, FILE *p_Fp, const char *p_sFmt, ...) {
    m.f_chapter("vfprintf",__FUNCTION__,__LINE__);
    va_list  tVaList;
    va_start(tVaList, p_sFmt);
    fprintf(p_Fp,"\tvfShow:: <");
    vfprintf (p_Fp, p_sFmt, tVaList);
    fprintf(p_Fp,">\n");
    va_end(tVaList);
}


//  === i:  default parameter values

float   F__fDivide(CTutor &m, float p_fDivisor , int p_fQuotient=2) {
    float   fRc;
    m.f_chapter("fDivide",__FUNCTION__,__LINE__);
    fRc   =   (float) ( p_fDivisor / p_fQuotient);
    return (fRc);
}


//  === i:  inline

/*
    Preceding a function declaration with the "inline" specifier
    informs the compiler that inline expansion is preferred
    over the usual function call mechanism for a specific function.
    his does not change at all the behavior of a function,
    but is merely used to suggest the compiler that the code
    generated by the function body shall be inserted at each
    point the function is called,
    instead of being invoked with a regular function call.
*/

//* like a PreProc function - but performed by the Compiler

inline int F__iMax_inline (CTutor &m, const int& p_ri, const int& p_rj) {
    m.f_chapter("iMax",__FUNCTION__,__LINE__);
    if (p_ri > p_rj ) {
        return 1;
    } else if (p_ri < p_rj) {
        return -1;
    } else {
        return 0;
    }
}


//  === i:  overload

int     F__tOperator(CTutor &m, int a, int b) {
    m.f_chapter("iOp",__FUNCTION__,__LINE__);
    return (a + b);
}
float   F__tOperator(CTutor &m, float a, float b) {
    m.f_chapter("fOp",__FUNCTION__,__LINE__);
    return (a * b);
}

//  === i:  retPTR vs retREF    : returnValue is Pointer||Reference

int     * F__ptr_iList_max(CTutor &m, int p_iArray[], int p_iSize) {
    int iMax    = 0;
    m.f_chapter("returnPTR",__FUNCTION__,__LINE__);
    for(int i=0; i<p_iSize; i++) {
        if ( p_iArray[i] > p_iArray[iMax] ) {
            iMax = i;
        }
    }
    return(&p_iArray[iMax]);
}

int     & F__ref_iList_max(CTutor &m, int p_iArray[], int p_iSize) {
    int iMax=0;
    m.f_chapter("returnREF",__FUNCTION__,__LINE__);
    for(int i=0; i<p_iSize; i++) {
        if ( p_iArray[i] > p_iArray[iMax] ) {
            iMax = i;
        }
    }
    return(p_iArray[iMax]);
}


//  === i:  fctPTR vs fctREF

int     F__iRandom__dummy() {
    int iRc = 4711;
//    m.f_chapter("randomMe",__FUNCTION__,__LINE__);
//    iRc = m.f_iRandom(100,1);
    return iRc;
}
int     F__iRandom(CTutor &m) {
    int iRc;
    m.f_chapter("randomMe",__FUNCTION__,__LINE__);
    iRc = m.f_iRandom(100,1);
    return iRc;
}


int F08_function(CTutor &m) {

//  =:= b:  declare
    int     iRc,
            iEc;
    char    cBuffer[C_BUFFER_SIZE];
    char    z = m.E_COLOR_GRAY;
    char    c,c1,c2;
    char    *pc;
    int     i,j,k,nLength;
    double  d, dRc;
    float   f,f1,f2,fRc;
    string  S1,S2, SRc;
    const char* sHdr = "func!";

//  =:= b:  header

    m.f_header(sHdr,__FILE__,__LINE__);
    iEc = m.f_iEc();        // get explicit

//  === i:  starter ===========================================================

//  =:= m:  void
    m.f_menu("void",__LINE__);
    c   = 'x';
    i   = 123;
    m.f_text(z,">>> inp: c:'%c', i:%d",c,i);
    F__void(m,c,i);
    m.f_text(z,"<<< out: c:'%c', i:%d",c,i);

//  =:= m:  byValue
    m.f_menu("byValue",__LINE__);
    i   = -456;
    j   = 342;
    m.f_text(z,">>> inp: i:'%d',j:'%d'",i,j);
    iRc = F__byVal_add(m,i,j);
    m.f_text(z,"<<< out: i=%d',j=%d; iRc=:%d",i,j,iRc);

//  === i:  argPTR vs argREF ==================================================

//  =:= m:  byPointer

    m.f_menu("byPointer",__LINE__);
    i = 876;
    c = c1 = c2 = '!';
    m.f_text(z,">>> inp: c='%c',i='%d'",c,i);

    m.f_subMenu("using pc=&c1 &i",__LINE__);
    c1 = 'x'; pc = &c1;
    iRc = F__byPtr(m,pc,&i);
    m.f_text(z,"<<< out: c:'%c',i:<%d> && iRc:<%d>",c1,i,iRc);

    m.f_subMenu("using pc=&c2 &i",__LINE__);
    c2 = 'y'; pc = &c2;
    iRc = F__byPtr(m,pc,&i);
    m.f_text(z,"<<< out: c:'%c',i:<%d> && iRc:<%d>",c2,i,iRc);

//  =:= m:  byReference
    m.f_menu("fByRef",__LINE__);
    c   = 'A';
    i   = -651;
    m.f_text(z,">>> inp: c='%c',i='%d'",c,i);
    iRc = F__byRef(m,c,i);
    m.f_text(z,"<<< out: c:'%c',i:<%d> && iRc:<%d>",c,i,iRc);


//  === i:  argVAL vs argREF vs argSAFETY  ====================================


//  =:= m:  byReference
    m.f_menu("VALvsREF ",__LINE__);

//  =:= m:  concat.byValue
    m.f_subMenu("concat.byVAL",__LINE__);
    S1 ="Vika";
    S2 ="Harvey";
    m.f_text(z,">>> inp: s1='%s', s2='%s'",S1.c_str(),S2.c_str());
    SRc = F__sConactenate_byVal(m,S1,S2);
    m.f_text(z,"<<< out: sRc=:'%s'",SRc.c_str());

//  =:= m:  concat.byReference
    S1 ="Touch";
    S2 ="Down";
    m.f_text(z,">>> inp: s1='%s', s2='%s'",S1.c_str(),S2.c_str());
    m.f_subMenu("concat.byREF",__LINE__);
    SRc = F__sConactenate_byRef(m,S1,S2);
    m.f_text(z,"<<< out: sRc=:'%s'",SRc.c_str());

//  =:= m:  concat.byReference & Safety
    S1 ="Chess";
    S2 ="Mate";
    m.f_text(z,">>> inp: s1='%s', s2='%s'",S1.c_str(),S2.c_str());
    m.f_subMenu("concat.byREF&SAFETY",__LINE__);
    SRc = F__sConactenate_byRef_const(m,S1,S2);
    m.f_text(z,"<<< out: sRc=:'%s'",SRc.c_str());


//  === i:  global vs static    ===============================================

//  =:= u:  CallMeCounter
    m.f_menu("global vs static",__LINE__);

//  =:= m:  global
    m.f_subMenu("global",__LINE__);
    for (int i = 0; i < 3; i++ ) {
        iRc = F__callMeCounter_global(m);
    }
    m.f_text(z,"<<< out: CallMeCounter_g =: <%d>",iRc);

//  =:= m:  static
    m.f_subMenu("static",__LINE__);
    for (int i = 0; i < 5; i++ ) {
        iRc = F__callMeCounter_static(m);
    }
    m.f_text(z, "<<< out: CallMeCounter_s =: <%d>", iRc);

//  === i:  recursion =========================================================

//  =:= m:  Fibonnaci()
    m.f_menu("fibonnaci",__LINE__);
    i = 10;
    m.f_text(z,"input:: i='%d'",i);
    iRc = F__fib(m,i); // fib(10)=:55
    int iCtr = m.f_iCounter();
    m.f_text(z, "<<< out: CallMeCounter_f. =: <%d>  && FIB.iRc", iCtr, iRc);

//  === i:  variable argument list ============================================

//  =:= u:  vArg {vprintf,vfprintf,vsprintf}
    m.f_menu("variable Arglist",__LINE__);

//  =:= m:  vAdd
    m.f_subMenu("vAdd",__LINE__);
    i = m.f_iRandom(60,40);
    j = m.f_iRandom(100,1);
    k = m.f_iRandom();
    iRc = F__vAdd(m, 3, i, j, k);
    m.f_text(z,"F_vAdd(%d,%d,%d) =: %d",i,j,k,iRc);

//  =:= m:  vAverage
    m.f_subMenu("vAverage",__LINE__);
    dRc = F__vAvg(m, 1.2, 2.3, 4.5, 0);
    m.f_text(z,"F_vAvg(1.2,2.3,4.5) =: %f",dRc);

//  =:= m:  vprintf
    m.f_subMenu("vprintf",__LINE__);
    i   = 1234;
    c   = 'x';
    d   = -12.3456;
    S1  = "Dracula";
    F__vPrint(m,"c:'%c',i:%d,f:%g,s:'%s'",c,i,d,S1.c_str());

//  =:= m:  vsprintf
    m.f_subMenu("vsprintf",__LINE__);
    S1  = "VanHelsing";
    pc = F__vsPrint(m,cBuffer,"c:'%c', i:%d f:%g s:'%s'",c,i,d,S1.c_str());
    m.f_text(pc);

//  =:= m:  vfprintf
    m.f_subMenu("vfprintf",__LINE__);
    FILE *fp = stdout;
    S1  = "TomCruise";
    F__vfPrint(m,fp,"c:'%c', i:%d f:%g s:'%s'",c,i,d,S1.c_str());

//  === i:  default parameter values===========================================

//  =:= m:  F_fDIV(fD,fQ=2)

    m.f_menu("default parameter",__LINE__);
    f = (float)C_TUTOR__PI;
    m.f_text(z,">>> inp: f='%f'",f);
    fRc = F__fDivide(m,f);
    m.f_text(z,"<<< out: fRc=:'%f'",fRc);


//  === i:  inline ============================================================

//  =:= m:  inline F_iMAX()

    m.f_menu("inline",__LINE__);

    i = m.f_iRandom(60,40);
    j = m.f_iRandom(100,1);
    m.f_subMenu("inline1",__LINE__);
    m.f_text(z,">>> inp: i='%d', j='%d'",i,j);
    iRc = F__iMax_inline(m,i,j);
    m.f_text(z,"<<< out: iRc=:'%d'",iRc);

    i = m.f_iRandom(60,40);
    j = m.f_iRandom(100,1);
    m.f_subMenu("inline2",__LINE__);
    m.f_text(z,">>> inp: i='%d', j='%d'",i,j);
    iRc = F__iMax_inline(m,i,j);
    m.f_text(z,"<<< out: iRc=:'%d'",iRc);

//  === i:  overload ==========================================================

    m.f_menu("overload",__LINE__);

//  =:= m:  i <= F_tOperator(i)
    m.f_subMenu("f_iOperator",__LINE__);
    i = m.f_iRandom(1000,1);
    j = m.f_iRandom(100,1);
    m.f_text(z,">>> inp: i1='%d',i2='%d'",i,j);
    iRc = F__tOperator(m,i,j);
    m.f_text(z,"<<< out: iRc=:'%i'",iRc);

//  =:= m:  f <= F_tOperator(f)
    m.f_subMenu("f_fOperator",__LINE__);
    f1 = (float)100.3;
    f2 = (float)5.7;
    m.f_text(z,">>> inp: f1='%f',f2='%f'",f1,f2);
    fRc = F__tOperator(m,f1,f2);
    m.f_text(z,"<<< out: fRc=:'%f'",fRc);

//  === i:  retPTR vs retREF ==================================================

//  =:= m:  function PTR
    m.f_menu("returnPTR<*> vs returnREF<&>",__LINE__);
    int iList[]     = { 12,165,4,3345,345,3434,34,87,11,100 };
    nLength         = sizeof(iList)/sizeof(int);

//  =:= m:  return PTR  (* F__iList_max )
    m.f_subMenu("* F_iListMax()",__LINE__);
    m.f_text(z,">>> inp: <%d>:{12,165,4,3345,345,3434,34,87,11,100}",nLength);
    int *pRc;
    pRc = F__ptr_iList_max(m, iList, nLength); assert(pRc != NULL);
    m.f_text(z,"<<< out: pRc='%p' => '%i'",pRc, *pRc);

//  =:= m:  return REF  (& F__iList_max )
    m.f_subMenu("& F_iListMax()",__LINE__);
    m.f_text(z,">>> inp: <%d>:{12,165,4,3345,345,3434,34,87,11,100}",nLength);
    iRc = F__ref_iList_max(m, iList, nLength);
    m.f_text(z,"<<< out: iRc=:'%i'",iRc);

//  === i:  fctPTR vs fctREF ==================================================

    m.f_menu("fctPTR<*> vs fctREF<&>",__LINE__);

//  =:= m:  fctPTR
    m.f_subMenu("fctPTR",__LINE__);
#ifdef __USE_TUTOR__STD_C11
    int (* pFctDummy)() { nullptr };
#else
    int (* pFctDummy)();
#endif
    pFctDummy                       = &F__iRandom__dummy;
    iRc     = (*pFctDummy)();
    m.f_text(z,"<<< out: *ptrDmy=:'%i'",iRc);
    int (*pFct)(CTutor &)           = &F__iRandom;
    iRc     = (*pFct)(m);
    m.f_text(z,"<<< out: *ptrRnd=:'%i'",iRc);


//  =:= m:  fctREF
    m.f_subMenu("fctREF",__LINE__);
    int (& rFctDummy)()             = F__iRandom__dummy;
    iRc     = rFctDummy();
    m.f_text(z,"<<< out: refDmy=:'%i'",iRc);
    int (& rFctRandom)(CTutor &)    = F__iRandom;
    iRc     = rFctRandom(m);
    m.f_text(z,"<<< out: refRnd=:'%i'",iRc);


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
    return F08_function(m);
}
#endif
