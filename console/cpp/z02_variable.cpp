//  ****************************************************************************
//  TUTORIAL:   C++     :   variabe & dataType & array
//  ****************************************************************************
//  !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß-------$
/*
    content:
        •   C:  variable
            •   m:  definition
                •   s:  single
                •   s:  multiple
            •   m:  initialization
                •   s:  int i=x
                •   s:  int i(x)
                •   s:  int i{x}
            •   m:  typeDeduction: auto && decltype
                •   s:  auto
                •   s:  decltype

        •   C:  dataType
            •   m:  charTypes
                 •  s:  char
                 •  s:  char16_t
                 •  s:  char32_t
            •   m:  bool
            •   m:  NULL
                 •  s:  nullPointer
                 •  s:  nullValue
            •   m:  integer
                 •  s:  short,..
                 •  s:  longlong
                 •  s:  unsigned
            •    m: float & double
                 •  s:  float
                 •  s:  double
                 •  s:  long double
            •    m: string
                 •  s:  define
                 •  s:  add
                 •  s:  c++=>cString
                 •  s:  length
                 •  s:  access

        •   C:  varSize
            •   m:  sizeof(integer)
                •   s:  int8
                •   s:  uint16
                •   s:  int32
                •   s:  uint64
            •   m:  using bitmap
                •   s:  sizeof(bitmap)


    keywords handled<12+2>:
         •  auto
         •  bool
         •  char char16_t char32_t
         •  decltype
         •  double
         •  float
         •  int
         •  long
         •  nullptr
         •  string
         •  unsigned
         •  void

    url:
         •    https://cplusplus.com/doc/tutorial/variables/

 */

#include "Tutor.h"
using namespace std;


int F__define(CTutor &m) {
    // url:https://cplusplus.com/doc/tutorial/variables/
    int         iEc = m.f_iEc();
    char        z = m.E_COLOR_GRAY;
    const char*     sHdr = "variable";

//  =:= C:  variable
    m.f_chapter(sHdr,__FILE__,__LINE__,true);

//  =:= m:  definition
    m.f_menu("definition",__LINE__);

//  =:= s:  single
    m.f_subMenu("simple",__LINE__);
    int iRc=iEc;
    m.f_text(z,"iRc => %d",iRc);

//  =:= s:  multiple
    m.f_subMenu("multiple",__LINE__);
    int i,j,k;
    i = 5;
    j = 3;
    k = 6;
    m.f_text(z,"i:%d, j:%d, k:%d",i,j,k);

//  =:= m:  initialization

    m.f_menu("initialization",__LINE__);

//  =:= s:  int i=x
    m.f_subMenu("C-like~",__LINE__);
    int i1 = 1; m.f_text(z,"i1=x :%d",i1);
    string s1 = "This is a string1"; m.f_text(z,"s1=x :'%s'",s1.c_str());

//  =:= s:  int i(x)
    m.f_subMenu("Constructor~",__LINE__);
    int i2(2);  m.f_text(z,"i2(x) :%d",i2);
    string s2("This is a string2");  m.f_text(z,"s2(x) :'%s'",s2.c_str());

#ifdef __USE_TUTOR__STD_C11
//  =:= s:  int i{x}
    m.f_subMenu("uniform~",__LINE__);
    int i3{3}; m.f_text(z,"i3{x} :%d",i3);
    string s3{"This is a string3"};  m.f_text(z,"s3{x} :'%s'",s3.c_str());
#endif

//  =:= m:  typeDeduction: auto && decltype

    m.f_menu("typeDeduction",__LINE__);

//  =:= s:  auto
    m.f_subMenu("using:auto",__LINE__);
    int     iApple  = 7416;
    m.f_text(z,"iApple:%d",iApple);
#ifdef __USE_TUTOR__STD_C11
    auto    tApple  = iApple;
    m.f_text(z,"tApple:%d",tApple);     // like: int tApple = iApple
#endif

//  =:= s:  decltype
    m.f_subMenu("using:decltype",__LINE__);
    int         iOrange = 6732;
    m.f_text(z,"iOrange :%d",iOrange);
#ifdef __USE_TUTOR__STD_C11
    decltype(iOrange) tPeach;
    tPeach = 5522;
    m.f_text(z,"tPeach  :%d",tPeach);   // like: int tPeach = 5522
#endif

    return(iEc);
}


int F__dataType(CTutor &m) {
    int         iEc = m.f_iEc();
    char        z = m.E_COLOR_GRAY;
    const char* sHdr = "dataTypes";

//  =:= C:  dataType
    m.f_chapter(sHdr,__FILE__,__LINE__,true);

//  =:= m:  charTypes
    m.f_menu("charTypes",__LINE__);

//  =:= s:  char
    m.f_subMenu("char8",__LINE__);
    char    c = '$';        m.f_text(z,"char  c     =: '%c'",c);

#ifdef __USE_TUTOR__STD_C11
//  =:= s:  char16_t
    m.f_subMenu("char16",__LINE__);
#ifdef _MSC_VER
#else
    char16_t  cw = u'�';    m.f_text(z,"char  cw<�>     =: '%zu'",cw);
#endif
    //  =:= s:  char32_t
    m.f_subMenu("char32",__LINE__);
    char32_t  cd = u'A';    m.f_text(z,"char  cd<'A'>   =: '%zu'",cd);
#endif

//  =:= m:  bool
    m.f_menu("bool",__LINE__);
    bool        b   = true;     m.f_text(z,"bool  b =: '%d'",b);

//  =:= m:  void
    m.f_menu("void",__LINE__);
    void        *vPtr=0;        m.f_text(z,"void  vPtr =: '%p'",vPtr);

//  =:= m:  NULL
    m.f_menu("NULL",__LINE__);

//  =:= s:  nullPointer
#ifdef __USE_TUTOR__STD_C11
    m.f_subMenu("nullPtr",__LINE__);
    decltype(nullptr)   p1=0;       m.f_text(z,"nullptr p =: '%p'",p1);
#endif

//  =:= s:  nullValue
    m.f_subMenu("nullVal",__LINE__);
    long long int   *p2 = NULL;     m.f_text(z,"*p := NULL  =: '%p'",p2);

//  =:= m:  integer

    m.f_menu("integer",__LINE__);

//  =:= s:  short,...
    m.f_subMenu("short",__LINE__);
    int         i    = INT_MAX;     m.f_text(z,"int   <i>.max <%%d>  =: '%d'",i);
        m.f_text(z,"int   <i>.max <%%i>  =: '%i'",i);
        m.f_text(z,"int   <i>.max <%%u>  =: '%u'",i);
    short       si   = SHRT_MAX;    m.f_text(z,"short <si>.max     =: '%d'",si);
    long int    li   = LONG_MAX;    m.f_text(z,"long int <li>.max  =: '%ld'",li);

//  =:= s:  longlong
    m.f_subMenu("long long",__LINE__);
    long long int lli;
    lli = LLONG_MAX;    m.f_text(z,"long long int <lli>.max =: '%lld'",lli);
    lli = LLONG_MIN;    m.f_text(z,"long long int <lli>.min =: '%lld'",lli);

//  =:= s:  unsigned
    m.f_subMenu("unsigned",__LINE__);
    unsigned int ui  = UINT_MAX;
        m.f_text(z,"unsigned int <ui>.MAX            =: '%u'",ui);
    unsigned long int uli  = ULONG_MAX; // !CRQ-220825:UINT_MAX==ULONG_MAX
        m.f_text(z,"unsigned long int  <uli>.MAX     =: '%lu'",uli);
    unsigned long long int  ulli = ULLONG_MAX;
            m.f_text(z,"unsigned long long int <ulli>  =:'%llu'",ulli);

//  =:= m:  float & double

    m.f_menu("float && double",__LINE__);

//  =:= s:  float
    m.f_subMenu("float",__LINE__);
    float  f;
    f = FLT_MAX;      m.f_text(z,"float f.max   =: '%f'",f);
    f = FLT_MIN;      m.f_text(z,"float f.min   =: '%f'",f);

//  =:= s:  double
    m.f_subMenu("double",__LINE__);
    double  d;

#ifdef __USE_ERROR_DBL_MAX
    d = DBL_MAX;      m.f_text(z,"double d.max =: '%f'",d);
#else
    d = FLT_MAX;      m.f_text(z,"double d.max  =: '%f'",d);
#endif
    d = DBL_MIN;      m.f_text(z,"double d.min  =: '%f'",d);

    m.f_text(z,"double d.max<%%e>   =: '%e'",d);
    m.f_text(z,"double d.max<%%E>   =: '%E'",d);
    m.f_text(z,"double d.max<%%g>   =: '%g'",d);
    m.f_text(z,"double d.max<%%G>   =: '%G'",d);

//  =:= s:  long double
    m.f_subMenu("long double",__LINE__);
    long double  D;

    D = C_TUTOR__PI;
    m.f_text(z,"long double D.PI <%%f>   =: '%f'",D);

//  =:= m:  string

//  https://techdifferences.com/difference-between-character-array-and-string.html

    m.f_menu("string",__LINE__);

//  =:= s:  define
    m.f_subMenu("define",__LINE__);
    string tString = "Hello - I'am a c++ string";
    cout << "\t<<< string1:'" << tString << "'" << endl;

//  =:= s:  add
    m.f_subMenu("add",__LINE__);
    string s1, s2;
    s1 = "I make you...";
    s2 = "crazy";
    tString = s1 + s2;
    cout << "\t<<< string2:'" << tString << "'" << endl;

    //  define Alpha
    tString     = "ABCDEFGH";

//  =:= s:  c++=>cString
    m.f_subMenu("c++=>cString",__LINE__);
    m.f_text(z,"tString =: '%s'",tString.c_str());

//  =:= s:  length
    m.f_subMenu("S.length",__LINE__);
    int iLen;
    iLen        = tString.length();
    m.f_text(z,"tString.length =: '%d'",iLen);

//  =:= s:  access
    m.f_subMenu("access S[i]",__LINE__);
    i = 2;
    c = tString[i];
    m.f_text(z,"tString[%d] =: '%c'",i,c);

//  =:= b:  footer
    return(iEc);
};


int F__varSize(CTutor &m) {
    int         iEc = m.f_iEc();
    char        z = m.E_COLOR_GRAY;
    const char*     sHdr = "varSize";
    T_TUTOR__INT8       i8Tmp;
    T_TUTOR__UINT16     u16Tmp;
    T_TUTOR__INT32      i32Tmp;
    T_TUTOR__UINT64     u64Tmp;
    T_TUTOR__dword      tDw;    // special dword
    T_TUTOR__qword      tBmp;   // typed BitField
    int             iSize;
    bool    bBrk = false;

    //  =:= C:  varSize
    m.f_chapter(sHdr, __FILE__, __LINE__, true);

    //  =:= m:  sizeof(integer)
    m.f_menu("sizeof.integer", __LINE__);

    //  =:= s:  int8
    m.f_subMenu("int8", __LINE__);
    i8Tmp = 0x41;
    iSize = sizeof(i8Tmp);
    m.f_text(z, "sizeof(i8)=[%1.1x] =: '%d'", i8Tmp, iSize);
    assert(iSize == 1);

    //  =:= s:  uint16
    m.f_subMenu("uint16", __LINE__);
    u16Tmp = 0xb1b2;
    iSize = sizeof(u16Tmp);
    m.f_text(z, "sizeof(i32)=[%2.2x] =: '%d'", u16Tmp, iSize);
    assert(iSize == 2);

    //  =:= s:  int32
    m.f_subMenu("int32", __LINE__);
    i32Tmp = 0x21414243;
    iSize = sizeof(i32Tmp);
    m.f_text(z, "sizeof(i32)=[%4.4X] =: '%d'", i32Tmp, iSize);
    assert(iSize >= 4);

    //  =:= s:  uint64
    m.f_subMenu("uint64", __LINE__);
    u64Tmp = 0xa1a2a3a4a5a6a7a8;
    iSize = sizeof(u64Tmp);
    m.f_text(z, "sizeof(u64)=[%8llx] =: '%d'", u64Tmp, iSize);
    assert(iSize == 8);

    //  =:= m:  using bitmap
    m.f_menu("using bitmap", __LINE__);
    bBrk ^= true;

    //  =:= s:  sizeof(dword)
    m.f_subMenu("sizeof bitmap.dw", __LINE__);
    tDw.v       = 0xd1d2d3d4;
    tDw.w.wL    = 0xe1e2;
    iSize = sizeof(tDw); // 4
    m.f_text(z, "DW.wL* =: '%4.4X'", tDw.w.wL);
    m.f_text(z, "sizeof(tDW)=: '%d'", iSize);
    assert(iSize >= 4);

    //  =:= s:  sizeof(qword)
    m.f_subMenu("sizeof bitmap.qw", __LINE__);
    iSize = sizeof(tBmp); // 8!
    m.f_text(z, "sizeof(tQW)=: '%d'", iSize);
    assert(iSize >= 8);

    //  =:= s:  map.bit
    m.f_subMenu("bit", __LINE__);
    tBmp.v = 0x0;
    tBmp.d.dL.b.b0  = 0x1;
    tBmp.d.dL.b.b8  = 0x1;
    tBmp.d.dL.b.b24 = 0x1;
    tBmp.d.dL.b.b30 = 0x1;
    m.f_text(z, "tBmp.v =: '%4.4X'", tBmp.v);

    //  =:= s:  map.byte
    m.f_subMenu("byte", __LINE__);
    tBmp.v = 0x0;
    tBmp.d.dL.y.y0 = 0xA1;
    tBmp.d.dL.y.y1 = 0xB2;
    tBmp.d.dL.y.y2 = 0xC3;
    tBmp.d.dL.y.y3 = 0xD4;
    m.f_text(z, "DL.y* =: '%4.4X'", tBmp.v);

    //  =:= s:  map.word
    m.f_subMenu("word", __LINE__);
    tBmp.v = 0x0;
    tBmp.d.dL.w.wL = 0xa1a2;
    tBmp.d.dL.w.wH = 0xb2b3;
    tBmp.d.dH.w.wL = 0xc3c4;
    tBmp.d.dH.w.wH = 0xd5d6;
    m.f_text(z, "WL =: '%8.8llX'", tBmp.v);

    //  =:= s:  map.dword
    m.f_subMenu("dword", __LINE__);
    tBmp.v = 0x0;
    tBmp.v = 0xd1d2d3d4;
    m.f_text(z, "dw =: '%4.4X'", tBmp.v);

    //  =:= s:  map.qword
    m.f_subMenu("qword", __LINE__);
    tBmp.v = 0x0;
    tBmp.v = 0xd1d2d3d4e5e6e7e8;
    m.f_text(z, "qw =: '%8.8llX'", tBmp.v);

    //  =:= b:  footer
    return(iEc);
}


//  &&& F:  main &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

int F02_variable(CTutor &m) {
    const char*     sHdr = "Variables";
    int iEc, iRc;
    iEc = m.f_header(sHdr,__FILE__,__LINE__);
    m.f_status();   // !CRQ-220928:checkStatus
    iRc = F__define(m);     if (iRc != iEc) { return iRc; }
    iRc = F__dataType(m);   if (iRc != iEc) { return iRc; }
    iRc = F__varSize(m);    if (iRc != iEc) { return iRc; }
    m.f_footer(sHdr,__FILE__,__LINE__);
    return(iEc);
}

#ifndef __USE_TUTOR__MAIN
int main(int p_iArgs, char *p_sArgv[]) {
    CTutor  m;
    if (p_iArgs >= 2) {
        m.f_mode_color(true);
    }
    return F02_variable(m);
}
#endif
