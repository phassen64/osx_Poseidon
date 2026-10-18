//  ****************************************************************************
//  TUTORIAL:   C++     :   C Library <basic>
//  ****************************************************************************
//  !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß-------$

//  https://cplusplus.com/doc/tutorial/
//  https://www.w3schools.com/cpp/cpp_math.asp

/*
    content:
        •   b:  header
            •   m:  i.iostream
            •   m:  i.string    C++
            •   m:  i.assert
            •   m:  i.limit
            •   m:  i.float
            •   m:  i.math
            •   m:  i.stdarg
            •   m:  i.stdlib
            •   m:  i.ctype
            •   m:  i.time
            •   m:  i.errno
        •   b:  footer
 */


#include "Tutor.h"

#undef  C_BUFFER_SIZE
#define C_BUFFER_SIZE    512

void f_test__time() {
    CTutor  m;
    int     iSec=3;

//
//  =:= m:i chrono  https://cplusplus.com/reference/chrono/
//
//  #ifdef  __USE_TUTOR__STD_C11
#if defined (__USE_TUTOR__STD_C11) && (_MSC_VER)

    //  check f_delay

    auto begin = std::chrono::high_resolution_clock::now();
    m.f_delay(iSec);
    auto end = std::chrono::high_resolution_clock::now();
    auto elapsed = std::chrono::duration_cast<std::chrono::nanoseconds>(end - begin);
    printf("\t::check f_delay(<%d>) => <%.3f> seconds.\n", iSec,elapsed.count() * 1e-9);

    //  check f_sleep
    begin = std::chrono::high_resolution_clock::now();
    m.f_sleep(iSec);
    end = std::chrono::high_resolution_clock::now();
    elapsed = std::chrono::duration_cast<std::chrono::nanoseconds>(end - begin);
    printf("\t::check f_sleep(<%d>) => <%.3f> seconds.\n", iSec,elapsed.count() * 1e-9);
#else
    printf("\t::no check f_sleep(<%d>)\n", iSec);
#endif

}


/* clock example: frequency of primes */

int frequency_of_primes (int n) {
  int i,j;
  int freq=n-1;
  for (i=2; i<=n; ++i) for (j=(int)std::sqrt(i);j>1;--j) if (i%j==0) {--freq; break;}
  return freq;
}

int f_test__clock() {
  clock_t t;
  int f;
  t = clock();
  printf ("Calculating...\n");
  f = frequency_of_primes (99999);
  printf ("The number of primes lower than 100,000 is: %d\n",f);
  t = clock() - t;
  printf ("It took me %d clocks (%f seconds).\n",(int)t,((float)t)/CLOCKS_PER_SEC);
  return 0;
}

//  https://cplusplus.com/reference/cstdarg/va_start/
void f_test__printFloats(int p_iNumber, ...) {
    double val;
    printf ("--- Printing floats:");
    va_list vl;
    va_start(vl,p_iNumber);
    for (int i=0; i<p_iNumber; i++)
    {
      val=va_arg(vl,double);
      printf (" [%.2f]",val);
    }
    va_end(vl);
    printf ("\n");
}


int F09_cLib(CTutor &m) {

    int         i, j, n, x, iLen;
    const char* sHdr = "CLIB";
    char        s[C_BUFFER_SIZE];
    char        z = m.E_COLOR_GRAY;
    char        c,
                cRc;
    bool        bRc = false;
    float       fRc;
    double      dRc;
    int         iRc,
                iEc;
    long int    lRc;
    short int                   si;
    unsigned short int          usi;
    unsigned int                ui;
    long int                    li;
    unsigned long int           uli;
    long long int               lli;
    unsigned long long int      ulli;

    const char    * sAlpha_upper    = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    const char    * sAlpha_lower    = "abcdefghijklmnopqrstuvwxyz";
    const char    * sAlNum          = "abc1234XYZ";
    const char    * sNumDec         = "1A3.8210x2";
    const char    * sNumHex         = "1.3a7xA0cE";

//  =:= b:  header
    iEc = m.f_header(sHdr,__FILE__,__LINE__);

//  =:= x:  show more info
    m.f_status();

//  =:= m:  i.iostream  URL:https://cplusplus.com/reference/iostream/
    m.f_menu("iostream",__LINE__);
    using namespace std;

//
//  =:= m:  i.string    URL:https://cplusplus.com/reference/string/stoi/
//

//  *** check C++
    m.f_subMenu("string",__LINE__);

    memset(s,0, C_BUFFER_SIZE);
    strcpy(s,"-12345");
    #ifdef __USE_TUTOR__STD_C11
        i = std::stoi(s);
        printf("<<< stoi:=<%d>\n",i);
    #endif
    i = m.f_s2i(s);
    printf("<<< st2i:=<%d>\n",i);

//
//  =:= m:  i.assert    URL:https://cplusplus.com/reference/cerrno/errno/
//
    m.f_menu("assert",__LINE__);

    m.f_subMenu("ternary",__LINE__);
    i = 4;
    j = 2;
    bRc = (i > j) ? true : false;
    m.f_text(z,"(%d) > (%d)  =: '%d'",i,j,bRc);

    m.f_subMenu("assert itself",__LINE__);
    assert((i>=j)&&(i!=j));

//
//  =:= m:  i.limit     URL:https://cplusplus.com/reference/climits/
//
    m.f_menu("limit",__LINE__);

    i   = CHAR_BIT;     m.f_text(z,"CHAR_BIT    =:  '%d'",i);
    i   = CHAR_MAX;     m.f_text(z,"CHAR_MAX    =:  '%d'",i);
    i   = CHAR_MIN;     m.f_text(z,"CHAR_MIN    =:  '%d'",i);
    si  = SHRT_MAX;     m.f_text(z,"SHRT_MAX    =:  '%d'",si);
    si  = SHRT_MIN;     m.f_text(z,"SHRT_MIN    =:  '%d'",si);
    usi = USHRT_MAX;    m.f_text(z,"USHRT_MAX   =:  '%d'",usi);
    i   = INT_MAX;      m.f_text(z,"INT_MAX     =:  '%d'",i);
    i   = INT_MIN;      m.f_text(z,"INT_MIN     =:  '%d'",i);
    ui  = UINT_MAX;     m.f_text(z,"UINT_MAX    =:  '%u'",ui);
    li  = LONG_MAX;     m.f_text(z,"LONG_MAX    =:  '%ld'",li);
    li  = LONG_MIN;     m.f_text(z,"LONG_MIN    =:  '%ld'",li);
    uli = ULONG_MAX;    m.f_text(z,"ULONG_MAX   =:  '%lu'",uli);
    lli = LLONG_MAX;    m.f_text(z,"LLONG_MAX   =:  '%lld'",lli);
    lli = LLONG_MIN;    m.f_text(z,"LLONG_MIN   =:  '%lld'",lli);
    ulli = ULLONG_MAX;  m.f_text(z,"ULLONG_MAX  =:  '%llu'",ulli);

//  return -(__LINE__);

//
//  =:= m:  i.float     URL:https://cplusplus.com/reference/cfloat/
//
    m.f_menu("float",__LINE__);
    fRc = FLT_MAX;      m.f_text(z,"FLT_MAX     =:  '%f'",fRc);
    fRc = FLT_MIN;      m.f_text(z,"FLT_MIN     =:  '%f'",fRc);
    iRc = FLT_DIG;      m.f_text(z,"FLT_DIG     =:  '%d'",iRc);
    iRc = FLT_RADIX;    m.f_text(z,"FLT_RADIX   =:  '%d'",iRc);
#ifdef __USE_TUTOR__STD_C11
#ifndef __BORLANDC__
    iRc = DECIMAL_DIG;  m.f_text(z,"DECIMAL_DIG =:  '%d'",iRc);
#endif
#endif

//
//  =:=     i.math      URL:https://www.w3schools.com/cpp/cpp_math.asp
//
    m.f_menu("math",__LINE__);

    m.f_subMenu("max",__LINE__);
    i = 3; j = 5;
#ifndef __BORLANDC__
    x = max(i,j);       m.f_text(z,"math::max(%d,%d) =: '%d'",i,j,x);
#endif

    m.f_subMenu("sqrt",__LINE__);
    i = 64;
    dRc = sqrt(i);      m.f_text(z,"math::sqrt(%d) =: '%f'",i,dRc);

    m.f_subMenu("constants",__LINE__);
    dRc = C_TUTOR__PI;      m.f_text(z,"math::pi        =: '%f'",dRc);
    dRc = C_TUTOR__E;       m.f_text(z,"math::e         =: '%f'",dRc);
    dRc = C_TUTOR__SQRT2;   m.f_text(z,"math::sqrt(2)   =: '%f'",dRc);

//
//  =:= m:  i.stdarg    URL:https://en.wikipedia.org/wiki/Stdarg.h
//
    m.f_menu("stdarg",__LINE__);
    f_test__printFloats(3, 3.14159, 2.71828, 1.41421);

//
//  =:= m:  i.stdlib    URL:https://cplusplus.com/reference/cstdlib/
//
    m.f_menu("stdlib:rand",__LINE__);
    iRc = RAND_MAX;                 m.f_text(z,"RAND_MAX =: '%d'",iRc);
    srand ((unsigned int)time(NULL)); // init

    m.f_subMenu("using stdlib::rand()",__LINE__);   //
    int iRnd;
    iRnd = rand() % 100;            m.f_text(z,"iRnd =: '%d'",iRnd);  // iRnd=[0,..99]

    m.f_subMenu("using CTutor::f_iRandom(Max,Min)",__LINE__);
    i=3;  x = m.f_iRandom(i);           m.f_text(z,"iRnd(%d) =:'%d'",i,x);
    i=10; x = m.f_iRandom(i);           m.f_text(z,"iRnd(%d) =:'%d'",i,x);
    i=5; j=2; x = m.f_iRandom(i,j);     m.f_text(z,"iRnd(%d,%d) =:'%d'",i,j,x);
    assert((x<=i)&&(x>=j));
    i=100; j=30; x = m.f_iRandom(i,j);  m.f_text(z,"iRnd(%d,%d) =:'%d'",i,j,x);
    i=-5; j=-9; x = m.f_iRandom(i,j);   m.f_text(z,"iRnd(%d,%d) =:'%d'",i,j,x);
    assert((x<=i)&&(x>=j));

    m.f_subMenu("atoi",__LINE__);
    strcpy(s,"12345");      x = atoi(s); m.f_text(z,"atoi('%s') =: <%d>",s,x);
    strcpy(s,"-871");       x = atoi(s); m.f_text(z,"atoi('%s') =: <%d>",s,x);

    m.f_subMenu("atof",__LINE__);
    strcpy(s,"325236.34");  dRc = atof(s); m.f_text(z,"atof('%s') =: <%f>",s,dRc);
    strcpy(s,"-12.23");     dRc = atof(s); m.f_text(z,"atof('%s') =: <%f>",s,dRc);

    m.f_subMenu("atol",__LINE__);
    lRc = 0;
    strncpy(s,"12345",10);      //!CRQ-220909:throws sometimes exp
    lRc = atol(s); m.f_text(z,"atol('%s') =: <%f>",s,lRc);

#if defined(__GNUC__) || defined (_MSC_VER)
    m.f_subMenu("system",__LINE__);
    iRc  = -1;
    i = 20; j = 5; x = m.f_iRandom(i, j);  m.f_text(z, "iRnd.fib(%d,%d) =:'%d'", i, j, x);
#endif

//
//  =:= m:  i.ctype     URL:https://cplusplus.com/reference/cctype/
//

    m.f_menu("ctype",__LINE__);

    c   = sAlpha_upper[0];
    bRc = isalpha(c);       m.f_text(z,"isAlpha('%c') =:'%d'",c,bRc);
    bRc = isupper(c);       m.f_text(z,"isUpper('%c') =:'%d'",c,bRc);

    c   = sAlNum[0];
    bRc = isalnum(c);       m.f_text(z,"isAlnum('%c') =:'%d'",c,bRc);

    c   = sAlpha_upper[0];
    cRc = tolower(c);       m.f_text(z,"toLower('%c') =:'%c'",c,cRc);

    c   = sAlpha_lower[0];
    cRc = toupper(c);       m.f_text(z,"toUpper('%c') =:'%c'",c,cRc);

    m.f_subMenu("isdigit",__LINE__);

    iLen    = strlen(sNumDec);
    n       = F_TUTOR__MIN(iLen,8);
    for(i=0; i < n; i++) {
        c   = sNumDec[i];
        bRc = isdigit(c);   m.f_text(z,"isDigit[%d]('%c') =:'%d'",i,c,bRc);
    }

    m.f_subMenu("isxdigit",__LINE__);

    iLen    = strlen(sNumHex);
    n       = F_TUTOR__MIN(iLen,8);
    for(i=0; i < n; i++) {
        c   = sNumHex[i];
        bRc = isxdigit(c);  m.f_text(z,"isXDigit[%d]('%c') =:'%d'",i,c,bRc);
    }

//
//  =:= m:  i.time  https://cplusplus.com/reference/ctime/
//
    m.f_menu("time.h",__LINE__);

    //  s01: use sTime()
    m.f_subMenu("time1",__LINE__);
    m.f_text(z,"CurrentTime1 =: '%s'",m.f_sTime("%y%m%d_%H%M%S"));
    m.f_text(z,"CurrentTime2 =: '%s'",m.f_sTime("%Y%m%d_%H%M%S"));

    //  s02: use timer()
    m.f_subMenu("time2",__LINE__);
    fRc = m.f_timer(true);
    m.f_text("runTimer",m.E_COLOR_CYAN);
    m.f_sleep(2);
    fRc = m.f_timer(false);
    m.f_text(z,"timerResult =: '%.2f' seconds",fRc);

    //  s03: check delay() and sleep()
    m.f_subMenu("time3",__LINE__);
    f_test__time();

    //  s04: clock
    m.f_subMenu("clock",__LINE__);
    f_test__clock();

    //  s05: tick
    m.f_subMenu("tick",__LINE__);
    iRc = m.f_tick();
    m.f_sleep(1);
    iRc = m.f_tick();
    m.f_text(z,"iTickCounter:<%d>", iRc);
    m.f_show_runtime();

//
//  =:= m:  i.errno       https://cplusplus.com/reference/cerrno/errno/
//
    m.f_subMenu("errno",__LINE__);
    i = errno;  m.f_text(z,"errno =: '%d'",i);
    m.f_error("TestErrno",__FILE__,__LINE__);

    cout << "<<< endOfTest:[" << 77 << "];" << endl;

//  =:= b:  footer
    iEc = m.f_footer(sHdr,__FILE__,__LINE__);

    return iEc;
};

#ifndef __USE_TUTOR__MAIN
int main(int p_iArgs, char *p_sArgv[]) {
    CTutor  m;
    if (p_iArgs >= 2) {
        m.f_mode_color(true);
    }
    return F09_cLib(m);
}
#endif
