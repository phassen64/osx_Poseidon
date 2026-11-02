//  ****************************************************************************
//  TUTORIAL:   C++     :   classII : friend,...
//  ****************************************************************************
//  !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß-------$
/*
    content:
        •   C:  friend
        •   C:  copyConstructor
        •   C:  staticMember
        •   C:  nestedClass
        •   C:  mutable
        •   C:  explicit
    url:
        •   https://en.cppreference.com/w/cpp/language/friend
        •   https://en.cppreference.com/w/cpp/language/copy_constructor
        •   https://www.tutorialspoint.com/cplusplus/cpp_static_members.htm
        •   https://en.cppreference.com/w/cpp/language/nested_types
        •   https://en.cppreference.com/w/cpp/language/explicit
    keywords handled <4>:
        •   explicit
        •   friend
        •   mutable
        •   static
 */


#include "Tutor.h"
using namespace std;


//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//  !C:  friend
//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

class CPerson
{
    private:

        string m__sId;
        string m__sSurName;
        string m__sFirstName;
        double m__fAccountBalance;


    public:
         //     * constructor with initialization list
        CPerson(string p_sSurName, string p_sFirstName) :
                    m__sSurName(p_sSurName),
                    m__sFirstName(p_sFirstName) {
            m__sId = "ID:{" + m__sFirstName + "_" + m__sSurName + "}";
            m__fAccountBalance = 0.00;
        }
        void  f_payIn(double p_fMoney) {
            m__fAccountBalance += p_fMoney;
        }
        double f_getBalance() {
            return(m__fAccountBalance);
        }
        //  like a global function - not like a method
        friend double F_fGet_balanceOther(CPerson &p_tPerson) {
            return(p_tPerson.m__fAccountBalance * 0.9);
        }
};

#define     C_UNI__STUDENT_MAX  8
const int   C_iNumberOfStudents  =  C_UNI__STUDENT_MAX;

class CUni__student;
class CUni__teacher {
    private:
        int m__iNote[C_iNumberOfStudents];
    public:
        CUni__teacher() {
            for(int i=0, iRnd=0; i<C_iNumberOfStudents; i++) {
                iRnd = 1 + rand() % 10;     // 1...10
                m__iNote[i] = iRnd;
            }
        };
        int f_testResult(CUni__student &rS);
};

class CUni__student {
    friend int CUni__teacher::f_testResult(CUni__student &rS);
    private:
        int m__iIdx;                // 1..5
        int m__iMatriculation;      // 1001...9999

    public:
        CUni__student() {
            m__iIdx             = 0;
            m__iMatriculation   = 0;
        }
        void f_init(int p_iIdx, int p_iMat) {
            m__iIdx             = p_iIdx;
            m__iMatriculation   = p_iMat;
        }
        int f_get_sid() {
            return(m__iMatriculation);
        }
};

int CUni__teacher::f_testResult(CUni__student &rS) {
    return m__iNote[rS.m__iIdx];
};


class CFruit__apple;

class CFruit__banana {
    friend CFruit__apple; // the whole class is a friend
    private:
        int m__iNumber;
    public:
        CFruit__banana() : m__iNumber(3) {}
};

class CFruit__apple {
    private:
        int m__iNumber;
    public:
        CFruit__apple(int p_iNumber) : m__iNumber(p_iNumber) {}
        int f_multiply() {
            CFruit__banana  X;
            return (X.m__iNumber * m__iNumber);
        }
        int f_get_number() {
            return(m__iNumber);
        }
};


int F__friend(CTutor &m) {
    int             iEc = m.f_iEc();
    const char*     sHdr =  "friends";
//  double          dRc;
//  float           fRc;
    char            z = m.E_COLOR_GRAY;
    string          SRc;
    int             iSum, iRnd, iVal, iSid;
//  char            cBuffer[256];
//  char* s = cBuffer;

//  =:= b:  body
    m.f_menu(sHdr, __LINE__);
    m.f_chapter(sHdr, __FUNCTION__, __LINE__);

    //  * payIn
    m.f_subMenu("payIn", __LINE__);
    CPerson P1("Bond","James");
    P1.f_payIn(1000.0);
    CPerson P2("MoneyPenny","Eve");
    P2.f_payIn(325.99);

    //  * show-My-Balance - using object methods
    m.f_subMenu("showMy", __LINE__);
    m.f_text(z,"P1.myBalance =: <%f> $", P1.f_getBalance());
    m.f_text(z,"P2.myBalance =: <%f> $", P2.f_getBalance());

    //  * show-Other-Balance - no OBJECT is needed
    m.f_subMenu("showOther", __LINE__);
    m.f_text(z,"balance(P1) =: <%f> $", F_fGet_balanceOther(P1));
    m.f_text(z,"balance(P2) =: <%f> $", F_fGet_balanceOther(P2));

//  =:= m:  friend.Method
    m.f_menu("friend::method", __LINE__);
    CUni__teacher  xTeacher;

    CUni__student xStudent[C_iNumberOfStudents];
    for(int i=0; i<C_iNumberOfStudents; i++) {
        iRnd =  m.f_iRandom(9999,1001);
        xStudent[i].f_init(i,iRnd);
    }
    for(int i=0; i<C_iNumberOfStudents; i++) {
        iSid = xStudent[i].f_get_sid();
        iVal = xTeacher.f_testResult(xStudent[i]);
        m.f_text(z,"student[%d] with id:<%d> got note =: '%d'",i+1,iSid,iVal);
    }

//  =:= m:  friend.Class
    m.f_menu("friend::class", __LINE__);
    iRnd =  m.f_iRandom(20,10);
    CFruit__apple xApple(iRnd);
    m.f_text(z,"I have apples   =: <%d>",xApple.f_get_number());
    iSum = xApple.f_multiply();
    m.f_text(z,"SumOfFruits     =: <%d>",iSum);

//  =:= b:  end
    return(iEc);
};

//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//  !C:  copyConstructor
//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

//  url: https://www.geeksforgeeks.org/copy-constructor-in-cpp/

/*  A copy constructor is a member function that initializes an object
    using another object of the same class.
    A copy constructor has the following general function prototype::
        ClassName (const ClassName &old_obj);
    The copy constructor can be defined
        "explicitly" by the programmer.
    If the programmer does not define the copy constructor,
        the compiler does it for us.
    REM:
        const ClassName &Ref untouches the original
*/

class CPoint {
    private:
        int m__x, m__y;
    public:
        CPoint(int x, int y) {          //  normal-constructor
            m__x = x;
            m__y = y;
        }
        CPoint(const CPoint& p) {       //  copy-constructor<explicit>
            m__x = p.m__x;
            m__y = p.m__y;
        }
        int f_getX() { return m__x; }
        int f_getY() { return m__y; }
};


int F__copyConstructor(CTutor &m) {
    int             iEc     =   m.f_iEc();
    const char*     sHdr    =   "copyConstructor";
    char            z       = m.E_COLOR_GRAY;

//  =:= b:  body
    m.f_menu(sHdr, __LINE__);
    m.f_chapter(sHdr, __FUNCTION__, __LINE__);
    m.f_text(z,"iEc  =: <%d>",iEc);

    m.f_subMenu("create first point", __LINE__);
    CPoint P1(10, 15); // Normal constructor is called here

    m.f_subMenu("copy P2:=P1", __LINE__);
    CPoint P2 = P1;     // Copy constructor is called here

    m.f_subMenu("showSource", __LINE__);
    m.f_text(z,"p1.x  =: <%d>",P1.f_getX());
    m.f_text(z,"p1.y  =: <%d>",P1.f_getY());

    m.f_subMenu("showCopiedPoint", __LINE__);
    m.f_text(z,"p2.x  =: <%d>",P2.f_getX());
    m.f_text(z,"p2.y  =: <%d>",P2.f_getY());

    return(iEc);
}

//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//  !C:  staticMember
//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

//  url: https://en.cppreference.com/w/cpp/language/static

class CPet {
    private:
        string  m__sCls;
    public:
        static int s_iNumber;
        CPet()  {
            #ifdef __USE_TUTOR__STD_C11
                m__sCls = typeid(*this).name();
            #else
                m__sCls = "CPetClass";
            #endif
            cout    << "\t &&& created<" << m__sCls << ">:[" << ++s_iNumber  << "]"
                    << endl;
        }
        ~CPet() {
            cout << "\t &&& destroy [" << s_iNumber--  << "]" << endl;
        }
};
int CPet::s_iNumber = 0;


int F__staticMember(CTutor& m) {
    int             iEc = m.f_iEc();
    const char* sHdr = "staticMember";
    char            z = m.E_COLOR_GRAY;

    //  =:= b:  body
    m.f_menu(sHdr, __LINE__);
    m.f_chapter(sHdr, __FUNCTION__, __LINE__);
    m.f_text(z, "iEc  =: <%d>", iEc);

    //  =:= b:  create an array of pets
    m.f_subMenu("create", __LINE__);
#ifdef _MSC_VER
#define C_PET_MAX   5
    CPet aPet[C_PET_MAX];
    m.f_text(z, "iNrPets  =: <%d>", C_PET_MAX);
#else
    int iNrOfPets = m.f_iRandom(10);
    CPet aPet[iNrOfPets];
    m.f_text(z, "iNrPets  =: <%d>", iNrOfPets);
#endif

    m.f_subMenu("finish", __LINE__);
    return(iEc);
}

//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//  !C:  nestedClass
//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

//  globals
int v__gX = 33,
    v__gY = 100;


class CEnclose
{
    private:
        int             m__iId;
        static int      s__iCtr;    // init outside
    public:
        int             m_iPub;
//      CEnclose(int iId) : m__iId(iId) {}
        int f_get() {
            return m__iId;
        }
        class CInner
        {
            private:
                int m__iVal;
            public:
                void f_assign(int i) {
                    m__iVal = i+1;  // inner private
                    s__iCtr = i+2;  // outer private static - no LNK error
                    ::v__gX = i+3;  // global x
                    v__gY   = i+4;  // global y direct
                }
                void f_pointer(CEnclose *p, int i) {
                    p->m_iPub = i+5;  // outer public
                    p->m__iId = i+6;  // outer private
                }
        } XInner;  // object
};
int CEnclose::s__iCtr = 0;

int F__nestedClass(CTutor &m) {
    int             iEc     =   m.f_iEc();
    const char*     sHdr    =   "nestedClass";
    char            z       = m.E_COLOR_GRAY;

//  =:= b:  body
    m.f_menu(sHdr, __LINE__);
    m.f_chapter(sHdr, __FUNCTION__, __LINE__);
    m.f_text(z,"iEc  =: <%d>",iEc);

//  =:= b:  create an array of pets
    m.f_subMenu("create", __LINE__);
#if 0
    CEnclose E1(1);
#endif
    CEnclose E1;
    E1.XInner.f_assign(10);
    E1.XInner.f_pointer(&E1,100);
    m.f_text(z,"Outer.iVal =: <%d>",E1.f_get());

    m.f_subMenu("finish", __LINE__);
    return(iEc);
}


//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//  !C:  mutable
//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&


class CImmortial {
    public:
        mutable int m_iVal;
        char        m_cVal;
        CImmortial(int p_iVal, char p_cVal) {
            m_iVal = p_iVal;
            m_cVal = p_cVal;
        }
};

int F__mutable(CTutor &m) {
    int             iEc     =   m.f_iEc();
    const char*     sHdr    =   "mutable";
    char            z       = m.E_COLOR_GRAY;

//  =:= b:  body
    m.f_menu(sHdr, __LINE__);
    m.f_chapter(sHdr, __FUNCTION__, __LINE__);
    m.f_text(z,"iEc  =: <%d>",iEc);

//  =:= b:  create an array of pets
    m.f_subMenu("create", __LINE__);
    const CImmortial CIm1(3,'!');
    m.f_text(z,"IM.cVal =: <%c>",CIm1.m_cVal);
    m.f_text(z,"IM.iVal =: <%d>",CIm1.m_iVal);

//  =:= b:  change
    m.f_subMenu("change", __LINE__);
#if 0
    CIm1.m_cVal = 'x';      //  ERROR - object is const
#endif
    CIm1.m_iVal = 4711;     //  acess possible
    m.f_text(z,"IM.iVal =: <%d>",CIm1.m_iVal);

    m.f_subMenu("finish", __LINE__);
    return(iEc);
}


//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//  !C:  explicit
//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&


class CFormX
{
    private:
        int i;
        char s;
    public:
        CFormX(int p){i = p; s = '#';}
        CFormX(char r, int p = 0){s = r; i = p;}
        void Ausgabe()
        {
            cout << "\tAusgabe von Objekten der Klasse FormX: " << endl;
            cout << "\t\ti = " << i << endl;
            cout << "\t\ts = " << s << endl;
            return;
        }
};

class CFormY
{
    private:
        int i;
        char s;
    public:
        explicit CFormY(int p){i = p; s = '#';}
        explicit CFormY(char r, int p = 0){s = r; i = p;}
        void Ausgabe()
        {
            cout << "\tAusgabe von Objekten der Klasse FormY: " << endl;
            cout << "\t\ti = " << i << endl;
            cout << "\t\ts = " << s << endl;
            return;
        }
};



int F__explicit(CTutor &m) {
    int             iEc     =   m.f_iEc();
    const char*     sHdr    =   "explicit";
    char            z       = m.E_COLOR_GRAY;

//  =:= b:  body
    m.f_menu(sHdr, __LINE__);
    m.f_chapter(sHdr, __FUNCTION__, __LINE__);
    m.f_text(z,"iEc  =: <%d>",iEc);

//  =:= b:  FormX
    m.f_subMenu("NoExplicit<Standard>", __LINE__);
    CFormX   a = 1;
    CFormX   b = CFormX(2);  // Zuweisung einer tempor�ren Instanz der Klasse X zu b
    CFormX   c(3);
    CFormX   d = 'D';
    CFormX   e = CFormX('E');
    CFormX   f('F');
    a.Ausgabe();
    b.Ausgabe();
    c.Ausgabe();
    d.Ausgabe();
    e.Ausgabe();
    f.Ausgabe();

//  =:= b:  FormY

    m.f_subMenu("using Explicit", __LINE__);

//  CFormY g = 1;           //  !Fehler!, nun nicht mehr m�glich
    CFormY h = CFormY(2);   //  Zuweisung der tempor�ren Instanz der Klasse Y zu h
    CFormY i(3);
//  CFormY j = 'J';         //  !Fehler!, nun nicht mehr m�glich
    CFormY k = CFormY('K');
    CFormY l('L');
//  g.Ausgabe();            // s.o.
    h.Ausgabe();
    i.Ausgabe();
//  j.Ausgabe();    // s.o
    k.Ausgabe();
    l.Ausgabe();


    m.f_subMenu("finish", __LINE__);
    return(iEc);
}


//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//  !C:  main
//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

int F22_friend(CTutor &m) {
    int             iEc ,
                    iRc;
    const char*     sHdr = "friends";

//  =:= b:  header
    iEc = m.f_header(sHdr,__FILE__,__LINE__);

//  =:= b:  friend...
    iRc = F__friend(m);             if (iRc != iEc) { return iRc; }
    iRc = F__copyConstructor(m);    if (iRc != iEc) { return iRc; }
    iRc = F__staticMember(m);       if (iRc != iEc) { return iRc; }
    iRc = F__nestedClass(m);        if (iRc != iEc) { return iRc; }
    iRc = F__mutable(m);            if (iRc != iEc) { return iRc; }
    iRc = F__explicit(m);           if (iRc != iEc) { return iRc; }

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
    return F22_friend(m);
}
#endif
