//  ****************************************************************************
//  TUTORIAL:   C++     :   struct vs union vs enum
//  ****************************************************************************
//  !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß-------$
/*
    content:
        •   m:  struct
            •   s:  struct.define
            •   s:  struct.access
            •   s:  struct.show
            •   s:  struct.copy
        •   m:  union
            •   s:  union.simple
            •   s:  union.byte <bitfield>
            •   s:  union.word
            •   s:  union.doubleWord
            •   s:  union.quadWord
            •   s:  check TutorLibrary
        •   m:  enum
            •   s:  enum.unscoped    ANSI-C
            •   s:  enum.scoped

    keywords:
        •   enum
        •   sizeof
        •   static_cast
        •   struct
        •   union
    url:
        •   https://www.w3schools.com/cpp/cpp_structs.asp
        •   https://www.tutorialspoint.com/cprogramming/c_unions.htm
        •   https://www.cpp-tutor.de/part1/enum.html

 */


#include "Tutor.h"
using namespace std;


int F__struct(CTutor &m) {
    const char*     sHdr = "struct";
    int             iEc = m.f_iEc();
    char            z = m.E_COLOR_GRAY;

//  =:= b:  body

//  =:= m:  struct
    m.f_chapter(sHdr,__FILE__,__LINE__,true);
    m.f_menu("struct",__LINE__);

//  =:= s:  struct.define
    m.f_subMenu("define",__LINE__);
    struct SCar {
        int     m_iId;
        string  m_sBrand;
        string  m_sModel;
        int     m_iYear;
    } tCar1, tCar2;     //  use 2 Variables
    struct SCar * pS;   //  pointer is of type of struct
#ifdef __BORLANDC__
/*  [bcc32c Error] :
 *  cannot pass object of non-trivial type 'struct SCar' through variadic method;
 *  call will abort at runtime
*/
#else
    m.f_text(z,"tCar1   := '%p'",&tCar1);
    m.f_text(z,"tCar2   := '%p'",&tCar2);
#endif

//  =:= s:  struct.access
    m.f_subMenu("access",__LINE__);
    pS  = &tCar1;
        pS->m_iId       = 1;
        pS->m_sBrand    = "BMW";
        pS->m_sModel    = "X5";
        pS->m_iYear     = 1999;
    pS  = &tCar2;
        pS->m_iId       = 2;
        pS->m_sBrand    = "Ford";
        pS->m_sModel    = "Mustang";
        pS->m_iYear     = 1968;

//  =:= s:  struct.show
    m.f_subMenu("show",__LINE__);
    pS  = &tCar1;
    m.f_text(z,"Car.ID    := '%d'",pS->m_iId);
    m.f_text(z,"Car.Brand := '%s'",pS->m_sBrand.c_str());
    m.f_text(z,"Car.Model := '%s'",pS->m_sModel.c_str());
    m.f_text(z,"Car.Year  := '%d'",pS->m_iYear);
    pS  = &tCar2;
    m.f_text(z,"Car.ID    := '%d'",pS->m_iId);
    m.f_text(z,"Car.Brand := '%s'",pS->m_sBrand.c_str());
    m.f_text(z,"Car.Model := '%s'",pS->m_sModel.c_str());
    m.f_text(z,"Car.Year  := '%d'",pS->m_iYear);

//  =:= s:  struct.copy
    m.f_subMenu("copy Car3:=Car1",__LINE__);
    struct SCar tCar3;
    tCar3   = tCar1;
    tCar3.m_iId = 3;
    pS      = &tCar3;
    m.f_text(z,"Car.ID    := '%d'",pS->m_iId);
    m.f_text(z,"Car.Brand := '%s'",pS->m_sBrand.c_str());
    m.f_text(z,"Car.Model := '%s'",pS->m_sModel.c_str());
    m.f_text(z,"Car.Year  := '%d'",pS->m_iYear);

    return iEc;
}

int F__union(CTutor &m) {
    const char*     sHdr = "union";
    int             iEc = m.f_iEc();
    char            z = m.E_COLOR_GRAY;

//  =:= b:  body
    m.f_chapter(sHdr,__FILE__,__LINE__,true);

//  =:= m:  union.simple
    m.f_menu("union",__LINE__);

//  =:= s:  simple
    m.f_subMenu("simple",__LINE__);

    union  _u_tag  {
        unsigned char   m_yByte;
        char            m_cBuffer[16];
    } u;

    //  clear
    memset(&u,0,sizeof(u));

    u.m_yByte = 0x21;
    m.f_text(z,"u.y  := '%X'",u.m_yByte);        //  0x21
    m.f_text(z,"u.y  := '%c'",u.m_yByte);        //   '!'

    //  overwrite yByte
    strcpy(u.m_cBuffer,"ABCDEFG");
    m.f_text(z,"u.cB := '%s'",u.m_cBuffer);

    m.f_text(z,"u.y  := '%X'",u.m_yByte);        //  0x41 = 'A'

//  =:= s:  union.byte <bitfield>
    m.f_subMenu("union:by",__LINE__);

    union UByte {
        struct {
            unsigned int    b0 : 1;
            unsigned int    b1 : 1;
            unsigned int    b2 : 1;
            unsigned int    b3 : 1;
            unsigned int    b4 : 1;
            unsigned int    b5 : 1;
            unsigned int    b6 : 1;
            unsigned int    b7 : 1;
        } s ;
        unsigned char   v;
    } ;

    UByte   by;

    by.v         = 0xA0;
    by.s.b0      = 1;
    m.f_text(z,"by := '%X'",by.v);

//  =:= s:  union.word

    m.f_subMenu("union:wd",__LINE__);

    union UWord {
        struct {
            UByte   LB;
            UByte   HB;
        } s;
        T_TUTOR__UINT16    v;
    };

    UWord wd;

    wd.v            = 0xA1A2;
    wd.s.LB.s.b0    = 1;
    m.f_text(z,"wd := '%X'",wd.v);

//  =:= s:  union.doubleWord (32bit)

    m.f_subMenu("union:dw",__LINE__);

    union UDword {
        struct {
            UWord   LW;
            UWord   HW;
        } s;
        T_TUTOR__UINT32    v;
    };

    UDword dw;

    dw.v    = 0xA1A2A3A4;
    m.f_text(z,"dw := '%lX'",dw.v);
    dw.s.LW.s.LB.s.b0       = 1;
    m.f_text(z,"dw := '%lX'",dw.v);

//  =:= s:  union.quadWord (64bit)

    m.f_subMenu("union:qw",__LINE__);

    union UQword {
        struct {
            UDword  LD;
            UDword  HD;
        } s;
        T_TUTOR__UINT64    v;
    };

    UQword qw;

    qw.v    = 0x12345678A1A2A3A4;
    m.f_text(z,"qw := '%llX'",qw.v);
    qw.s.LD.s.LW.s.LB.s.b0       = 1;
    m.f_text(z,"qw := '%llX'",qw.v);

//  =:= s:  check TutorLibrary

    m.f_subMenu("check :: TutorLibrary",__LINE__);

    T_TUTOR__dword d;
    d.v            = 0xB1B2B3B4;
    m.f_text(z, "d1 := '%lX'", d.v);
    d.w.wL = 0xa1a2;
    d.w.wH = 0xc1c2;
    m.f_text(z,"d2 := '%lX'",d.v);

    T_TUTOR__qword q;
    q.v             = 0xB1B2B3B4B5B6B7B8;
    q.d.dL.b.b20    = 1;         //  set a Byte bit
    m.f_text(z, "qX := '%llX'", q.v);


    return iEc;
}

/*
    An enumeration is a distinct type whose value is restricted to
    a range of values,
    which may include several explicitly named constants ("enumerators").
    The values of the constants are values of an integral
    type known as the underlying type of the enumeration.
*/

int F__enum(CTutor &m) {

//  =:= b:  declare
    int         iEc = m.f_iEc();
    int         i,
                n;
    char        z = m.E_COLOR_GRAY;
    const char* sHdr = "enum";

//  =:= b:  intro
    m.f_chapter(sHdr,__FILE__,__LINE__,true);

//  =:= m:  enum

//  =:= s:  enum.unscoped
    m.f_menu("unscoped",__LINE__);

    m.f_subMenu("EColor",__LINE__);
    enum EColor { E_black, E_red, E_green, E_blue, E_white };
    EColor eColor = E_red;
    switch(eColor)
    {
        case E_red  : m.f_echo("\t color is: 'red'");   break;
        case E_green: m.f_echo("\t color is: 'green'"); break;
        case E_blue : m.f_echo("\t color is: 'blue'");  break;
        default:
            m.f_echo("\t color is: 'black' or 'white'");  break;
    }

    //  Show
    m.f_subMenu("EColor.n",__LINE__);
    n = static_cast<int>(eColor);
    m.f_text(z,"eColor = %d",n);

//  =:= s:  loop through - the enum without spaces
    m.f_subMenu("EColor.for",__LINE__);
    for (i=E_black; i<E_white; i++) {
        m.f_text(z,"EColor[%d] = %d",
            i,
            static_cast<EColor>(i) );
    }

    // size
    m.f_subMenu("EColor.size",__LINE__);
    n   = sizeof(EColor);
    m.f_text(z,"sizeof(EColor) = %d",n);

    /*  An term used for unimportant variables in programming
        when the programmer is too lazy to think of an actual name.
        The origin of such word is described in detail in RFC 3092.
    */

    enum EFoo {
            E_Foo_a,
            E_Foo_b,
            E_Foo_c = 10,
            E_Foo_d,
            E_Foo_e = 1,
            E_Foo_f,
            E_Foo_g = E_Foo_c + E_Foo_f
    };

    //  Show
    EFoo eFoo = E_Foo_g;
    m.f_subMenu("EFoo.n",__LINE__);
    n = static_cast<int>(eFoo);
    m.f_text(z,"eFoo = %d",n);

    //  show this enum
    m.f_subMenu("EFoo.x",__LINE__);
    m.f_text(z,"E_Foo_a = %d", E_Foo_a);
    m.f_text(z,"E_Foo_b = %d", E_Foo_b);
    m.f_text(z,"E_Foo_c = %d", E_Foo_c);
    m.f_text(z,"E_Foo_d = %d", E_Foo_d);
    m.f_text(z,"E_Foo_e = %d", E_Foo_e);
    m.f_text(z,"E_Foo_f = %d", E_Foo_f);
    m.f_text(z,"E_Foo_g = %d", E_Foo_g);

    m.f_subMenu("EFoo.size",__LINE__);
    n   = sizeof(EFoo);
    m.f_text(z,"sizeof(EFoo) = %d",n);

//  =:= s:  enum.scoped
    m.f_menu("scoped",__LINE__);
#ifdef __USE_TUTOR__STD_C11
    m.f_subMenu("CColor.def",__LINE__);
    enum class CColor { e_red, e_green = 20, e_blue };
    CColor rColor = CColor::e_blue;
    switch(rColor)
    {
        case CColor::e_red  : m.f_echo("\t ccolor='red'");   break;
        case CColor::e_green: m.f_echo("\t ccolor='green'"); break;
        case CColor::e_blue : m.f_echo("\t ccolor='blue'");  break;
    }

    // int n = r; // error: no implicit conversion from scoped enum to int
    m.f_subMenu("CColor.n",__LINE__);
    n = static_cast<int>(rColor); // OK, n = 21
    m.f_text(z,"rColor = %d",n);
#endif

//  =:= b:  footer
    return(iEc);

};


int F16_struct_union_enum(CTutor &m) {
    int             iEc,
                    iRc = -1;
    const char*     sHdr = "struct_&&_union_&&_enum";

//  =:= b:  header
    m.f_header(sHdr,__FILE__,__LINE__);
    iEc = m.f_iEc();        // get explicit
    m.f_status();

//  =:= C:  struct
    iRc = F__struct(m);
    if (iRc != iEc) {
        return iRc;
    }

//  =:= C:  union
    iRc = F__union(m);
    if (iRc != iEc) {
        return iRc;
    }

//  =:= C:  enum
    iRc = F__enum(m);
    if (iRc != iEc) {
        return iRc;
    }

//  =:= b:  footer
    m.f_footer(sHdr,__FILE__,__LINE__);
    return(iEc);
}


#ifndef __USE_TUTOR__MAIN
int main(int p_iArgs, char *p_sArgv[]) {
    CTutor  m;
    if (p_iArgs >= 2) {
        m.f_mode_color(true);
    }
    return F16_struct_union_enum(m);
}
#endif
