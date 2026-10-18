//  ****************************************************************************
//  TUTORIAL:   C++     :   overloading C++ operator
//  ****************************************************************************
//  !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß-------$
/*
    file:
        •   F:  helper
        •   F:  main

    content:
        •   C:  basic
        •   C:  friendFunction
            •   m:  operator.friend.function
                •   s:  friend: +
                •   s:  friend: cout
                •   s:  friend: cin
        •   C:  method
            •   m:  operator.method
                •   s:  method: +=
                •   s:  method: -=
                •   s:  method: (-y)
                •   s:  method: (-x)
                •   s:  method: -(A,B)  * notOK
                •   s:  method: *=
                •   s:  method: /=
        •   C:  postfix & prefix
            •   m:  ++.operator.++
                •   s:  postfix : x++
                •   s:  postfix : x--
                •   s:  prefix  : ++x
                •   s:  prefix  : --x
        •   C:  autoCast
            •   m:  int+long+float
        •   C:  type: byConstructor
            •   m:  casting_byConstructor
                •   s:  float:  +=
        •   C:  type: byFunction
        •   C:  objectCopy
        •   C:  operator =: '()'
        •   C:  operator =: '->'
            •   m:  intelligent pointer
        •   C:  operator =: 'new' & 'delete'

    keyword:
        •   operator

    url:
        •   https://cplusplus.com/doc/tutorial/templates/
        •   https://en.cppreference.com/w/cpp/language/operators
        •   https://en.wikipedia.org/wiki/Fraction
        •   https://www.freemathhelp.com/numerator-denominator/

    NOT overloadablle operators... :
    url:
    https://www.tutorialspoint.com/operators-that-cannot-be-overloaded-in-cplusplus
        ?               conditional
        .               member-selection
        .*              member-selection with pointer to member
        ::              scope
        sizeof          object size information
        typeid          object type information
        static_cast     casting operator
        const_cast      const operator
*/


#include "Tutor.h"
using namespace std;

//  *
//  =:= F:  helper
//  *

//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//  =:= C:  basic
//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&


//  https://www.programiz.com/cpp-programming/operator-overloading


class CCounter {
    private:
        int m__iValue;
    public:
        //  Constructor to initialize count to 5
        CCounter() : m__iValue(5) {};

        //  Overload ++ when used as prefix
        void operator ++ () {
            ++m__iValue;
        }
        void f_outputCounter() {
            cout << "\tCounter: " << m__iValue << endl;
        }
};

int F___basic(CTutor &m) {
    int             iEc = m.f_iEc();
    const char*     sHdr =  "basics of operator overloading";
    char            z = m.E_COLOR_GRAY;
    m.f_menu(sHdr, __LINE__);
    m.f_chapter(sHdr, __FUNCTION__, __LINE__);

    m.f_subMenu("init", __LINE__);
    CCounter X;

    m.f_subMenu("call", __LINE__);
    // Call the "void operator ++ ()" function
    ++X;

    m.f_subMenu("output", __LINE__);
    X.f_outputCounter();

    m.f_subMenu("finish", __LINE__);
    m.f_text(z,"iEc =: %d",iEc);
    return(iEc);
};

//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//  =:= C:  friendFunction
//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

class CFraction /*Bruchrechnung*/
{
    private:
        int m__iNumerator/*Zaehler*/, m__iDenominator/*Nenner*/;
        int f__ggt(int a, int b);

    public:
        CFraction() : m__iNumerator(0), m__iDenominator(1) {}
        CFraction(int z, int n) : m__iNumerator(z), m__iDenominator(n) {}

        void f_output() {
                cout << "\t"
                << m__iNumerator << "/"
                << m__iDenominator << endl;
        };
        void f_Kuerzen();
        void f_init(int z, int n) {
            m__iNumerator   = z;
            m__iDenominator = n;
        };

        //  =:= m:  operator.friend.function
        //  =:= s:  friend: +
        //  =:= s:  friend: -
        //  =:= s:  friend: *
        //  =:= s:  friend: /
        friend CFraction operator+ (const CFraction &A, const CFraction &B);
        friend CFraction operator- (const CFraction &A, const CFraction &B);
        friend CFraction operator* (const CFraction &A, const CFraction &B);
        friend CFraction operator/ (const CFraction &A, const CFraction &B);

        //  =:= s:  friend: cout
        //  =:= s:  friend: cin
        friend ostream & operator<< (ostream &ostr, const CFraction &X);
        friend istream & operator>> (istream &istr, CFraction &X);

        //  =:= m:  operator.method
        CFraction operator+= (const CFraction &X);
        CFraction operator-= (const CFraction &X);
        CFraction operator-  ();
        CFraction operator-  (const CFraction &X);
#ifdef __USE_TUTOR__OPERATOR_MINUS_PARAMETER_TWO
        CFraction operator-  (const CFraction &A, const CFraction &B);
#endif
//*     CFraction operator+ (const CFraction &X);   => friend
//*     CFraction operator- (const CFraction &X);   => friend

        //  =:= s:  method: *=
        //  =:= s:  method: /=
        CFraction operator*= (const CFraction &X);
        CFraction operator/= (const CFraction &X);

        //  =:= m:  casting_byConstructor
        CFraction(int i);
        CFraction(double d);


};

//* groesste gemeinsame Teiler
int CFraction::f__ggt(int A, int B)  // rekursive Methode
{
    int iRc, rest, an, bn;
    A = abs(A);
    B = abs(B);
    an = A > B ? A : B;
    bn = A < B ? A : B;
    rest = an - bn;
    if((rest > 0) && (bn != 0))   // bn = 0 ergibt eine endlose Konstruktion
        iRc = f__ggt(bn, rest);
    else
        iRc = an;
    return iRc;
}

//* k�rzen
void CFraction::f_Kuerzen()
{
    int
    iDivider        = f__ggt(m__iNumerator, m__iDenominator);
    m__iNumerator       /=      iDivider;
    m__iDenominator     /=      iDivider;
}

//  =:= s:  friend: +    : X=A+B
//  y = (4�3) + (5�6) = (4*3*6 + 5*6*3) � (3*6);
CFraction operator+ (const CFraction &A, const CFraction &B)
{
    CFraction  X;
    X.m__iNumerator     =       A.m__iNumerator  * B.m__iDenominator
                            +   B.m__iNumerator  * A.m__iDenominator;
    X.m__iDenominator   = A.m__iDenominator * B.m__iDenominator;
    X.f_Kuerzen();
    return X;
}

//  =:= s:  friend: -
CFraction operator- (const CFraction &A, const CFraction &B)
{
    CFraction  X;
    X.m__iNumerator     =       A.m__iNumerator  * B.m__iDenominator
                            -   B.m__iNumerator  * A.m__iDenominator;
    X.m__iDenominator   = A.m__iDenominator * B.m__iDenominator;
    X.f_Kuerzen();
    return X;
}

//  =:= s:  friend: *
//  y = (4/3) * (5/6) = (4*5) � (6*3) = 20�18 = 10�9;
CFraction operator* (const CFraction &A, const CFraction &B)
{
    CFraction  X;
    X.m__iNumerator     =       A.m__iNumerator   * B.m__iNumerator;
    X.m__iDenominator   =       A.m__iDenominator * B.m__iDenominator;
    X.f_Kuerzen();
    return X;
}

//  =:= s:  friend: /
//  y = (4�3) / (5�6) = (4*6) � (3*5) =  24�15 = 8�5;
CFraction operator/ (const CFraction &A, const CFraction &B)
{
    CFraction  X(0,0);
    if (    (A.m__iNumerator   != 0) &&
            (B.m__iNumerator   != 0) &&
            (A.m__iDenominator != 0) &&
            (B.m__iDenominator != 0) )
    {
        X.m__iNumerator     =   A.m__iNumerator   * B.m__iDenominator;
        X.m__iDenominator   =   A.m__iDenominator * B.m__iNumerator;
        X.f_Kuerzen();
    }
    return X;
}


//  =:= s:  friend: cout
ostream& operator<< (ostream &ostr, const CFraction &X) {
    ostr << "{" << X.m__iNumerator  << "/"
                << X.m__iDenominator << "}";
    return ostr;
}

//  =:= s:  friend: cin
istream& operator>> (istream &istr, CFraction &X) {
    char c;
    istr >> X.m__iNumerator >> c >> X.m__iDenominator;
    return istr;
}


//  =*= m:  operator.friend.function

int F___friend_function(CTutor &m) {
    int             iEc = m.f_iEc();
    const char*     sHdr =  "opOverloading by using :: friend-function";
    char            z = m.E_COLOR_GRAY;
    int             i = 0;
    m.f_menu(sHdr, __LINE__);
    m.f_chapter(sHdr, __FUNCTION__, __LINE__);
    m.f_subMenu("fraction calculation", __LINE__);

//  =:= m:  operator.friend.function
    CFraction X, A(1,4), B(2,4), C(3,5);
    X = A + B + C;      // 1/4 + 2/4 + 3/5 = 27/20
    X.f_output();

    //  =:= s:  cout
    m.f_subMenu("cout", __LINE__);
    cout    << "\t" << ++i << " : "
            << "A" << A << " + "
            << "B" << B << " + "
            << "C" << C << " + "
            << "\t =: "
            << (A + B + C) << endl;

//  =:= s:  friend: +
    A.f_init(1,3);
    B.f_init(2,5);
    cout    << "\t" << ++i << " : "
            << "A" << A << " + " << "B" << B << "\t =: "
            << (A + B) << endl;

//  =:= s:  friend: -
    A.f_init(4,7);
    B.f_init(3,4);
    cout    << "\t" << ++i << " : "
            << "A" << A << " - " << "B" << B << "\t =: "
            << (A - B) << endl;

//  =:= s:  friend: *
    A.f_init(4,3);
    B.f_init(5,6);
    cout    << "\t" << ++i << " : "
            << "A" << A << " * " << "B" << B << "\t =: "
            << (A * B) << endl;

//  =:= s:  friend: /
//  y = (4�3) / (5�6) = (4*6) � (3*5) =  24�15;
    A.f_init(4,3);
    B.f_init(5,6);
    cout    << "\t" << ++i << " : "
            << "A" << A << " / " << "B" << B << "\t =: "
            << (A / B) << endl;

    m.f_subMenu("finish", __LINE__);
    m.f_text(z,"iEc =: %d",iEc);
    return(iEc);
};

//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//  =:= C:  method
//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

//  =:= m:  operator.method

//  =:= s:  method: +=      ::  y += x
CFraction CFraction::operator+= (const CFraction &X)
{
    m__iNumerator =
            m__iNumerator   *   X.m__iDenominator +
            m__iDenominator *   X.m__iNumerator;
    m__iDenominator *= X.m__iDenominator;
    f_Kuerzen();
    return *this;
}

//  =:= s:  method: -=      ::  y -= x
CFraction CFraction::operator-= (const CFraction &X)
{
    m__iNumerator =
            m__iNumerator   * X.m__iDenominator -
            m__iDenominator * X.m__iNumerator;
    m__iDenominator *= X.m__iDenominator;
    f_Kuerzen();
    return *this;
}

//  =:= s:  method: (-y)    ::  y = -y
CFraction CFraction::operator- ()
{
    CFraction X;
    X.m__iNumerator     = -m__iNumerator;
    X.m__iDenominator   = m__iDenominator;
    X.f_Kuerzen();
    return X;
}

//  =:= s:  method: (-x)    ::  y = y-x (==:y-=x)
CFraction CFraction::operator- (const CFraction &A)
{
    CFraction R(0,0);
    int iNum, iDen;
    iNum  = m__iNumerator * A.m__iDenominator -
                m__iDenominator * A.m__iNumerator;
    iDen  = m__iDenominator * A.m__iDenominator;
    R.m__iNumerator     = iNum;
    R.m__iDenominator   = iDen;
    R.f_Kuerzen();
    return R;
}

//  =:= s:  method: -(A,B)  ::  y = a-b     *** NOT working
#ifdef __USE_TUTOR__OPERATOR_MINUS_PARAMETER_TWO
CFraction CFraction::operator- (const CFraction &A, const CFraction &B)
{
    CFraction R(0,0);
    int iNum, iDen;
    iNum  = m__iNumerator * A.m__iDenominator -
                m__iDenominator * A.m__iNumerator;
    iDen  = m__iDenominator * A.m__iDenominator;
    R.m__iNumerator     = iNum;
    R.m__iDenominator   = iDen;
    R.f_Kuerzen();
    return R;
}
#endif


//  =:= s:  method: *=
CFraction CFraction::operator*= (const CFraction &A)
{
    m__iNumerator   *= A.m__iNumerator;
    m__iDenominator *= A.m__iDenominator;
    f_Kuerzen();
    return *this;
}

//  =:= s:  method: /=      :   y /= x
CFraction CFraction::operator/= (const CFraction &A)
{
    // y = (4/3) � (5/6) = 4*6 � 3*5 =  24 � 15 = 1.6
    if (m__iNumerator == 0) {
        m__iDenominator = 1;
    } else if ( m__iDenominator == 0 || A.m__iDenominator == 0 ) {
        m__iNumerator   = 0;
        m__iDenominator = 1;
    } else {
        m__iNumerator   *= A.m__iDenominator;
        m__iDenominator *= A.m__iNumerator;
    }
    f_Kuerzen();
    return *this;
}


//  =:= m:  operator.method

int F___method(CTutor &m) {
    int             iEc = m.f_iEc();
    const char*     sHdr =  "opOverloading by using :: method";
    char            z = m.E_COLOR_GRAY;
    int             i=0;

    m.f_menu(sHdr, __LINE__);
    m.f_chapter(sHdr, __FUNCTION__, __LINE__);
    m.f_text(z,"A:(4/3) B:(3/5)");

    CFraction X(0,0);
    CFraction Y(0,0);

//  =:= s:  method: +=  :: op: y+=x
    CFraction A(4,3);
    CFraction B(3,5);
    cout    << "\t" << ++i << " : "
            << "Y" << A << " += " << B << "\t =: "
            << (A += B) << endl;

//  =:= s:  method: -=  :: op: y-=x
    A.f_init(4,3);
    B.f_init(3,5);
    cout    << "\t" << ++i << " : "
            << "Y" << A << " -= " << B << "\t =: "
            << (A -= B) << endl;

//  =:= s:  method: *=  :: op: y*=x
    A.f_init(5,4);
    B.f_init(4,7);
    cout    << "\t" << ++i << " : "
            << "Y" << A << " *= " << B << "\t =: "
            << (A *= B) << endl;

//  =:= s:  method: /=  :: op: y/=x
    A.f_init(4,3);
    B.f_init(5,6);
    cout    << "\t" << ++i << " : "
            << "Y" << A << " /= " << B << "\t =: "
            << (A /= B) << endl;

//  =:= s:  method: (-y):: op: y=-y
    A.f_init(8,2);
    cout    << "\t" << ++i << " : "
            << "A" << A << " = " << "(-A)" << "\t =: "
            <<  (-A) << endl;

//  =:= s:  method: (-x):: op: y=y-x
    A.f_init(4,3);
    B.f_init(3,5);
    cout    << "\t" << ++i << " : "
            << "A" << A << " - " << "B" << B << "\t =: "
            << (A - B) << endl;

#ifdef __USE_TUTOR__OPERATOR_MINUS_PARAMETER_TWO
//  =:= s:  method: -(A,B)
    Y = A - B
    cout    << "\t" << ++i << " : "
            << "A" << A << " - " << "B" << B << "\t =: "
            << Y << endl;
#endif

    m.f_subMenu("finish", __LINE__);
    m.f_text(z,"iEc =: %d",iEc);
    return(iEc);
};


//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//  =:= C:  postfix & prefix
//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//  https://stackoverflow.com/questions/7740350/overloading-postfix-and-prefix-operators

class CDigit {
    private:
        int m__iDigit;
    public:
        CDigit(int n=0) {
            m__iDigit = n;
        }
        //  =:= m:  ++.operator.++
        //  =:= s:  postfix : x++
        //  =:= s:  postfix : x--
        CDigit&  operator++() { ++m__iDigit; return *this; }
        CDigit&  operator--() { --m__iDigit; return *this; }
        //  =:= m:  ++.operator
        //  =:= s:  prefix  : ++x
        CDigit   operator++(int) {
            CDigit X(m__iDigit);
            ++(*this);
            return X;
        }
        //  =:= s:  prefix  : --x
        CDigit   operator--(int) {
            CDigit X(m__iDigit);
            --(*this);
            return X;
        }
        int f_get() const { return m__iDigit; }
};

int F___fix_PostPre(CTutor &m) {
    int             iEc = m.f_iEc();
    const char*     sHdr =  "op =: postfix & prefix";
    char            z = m.E_COLOR_GRAY;
    int             i;
    m.f_menu(sHdr, __LINE__);
    m.f_chapter(sHdr, __FUNCTION__, __LINE__);
    CDigit X(5);
    m.f_text(z,"X =: %d",X.f_get());
//  =:= m:  ++.operator.++
//  =:= s:  postfix : x++
    i = (X++).f_get();    m.f_text(z,"i:%d X++ =:%d",i,X.f_get());
    i = (X--).f_get();    m.f_text(z,"i:%d X-- =:%d",i,X.f_get());
//  =:= s:  prefix  : ++x
    i = (++X).f_get();    m.f_text(z,"i:%d ++X =:%d",i,X.f_get());
    i = (--X).f_get();    m.f_text(z,"i:%d --X =:%d",i,X.f_get());
    m.f_subMenu("finish", __LINE__);
    m.f_text(z,"iEc =: %d",iEc);
    return(iEc);
};

//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//  =:= C:  autoCast
//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

int F___autoCast(CTutor &m) {
    int             iEc = m.f_iEc();
    const char*     sHdr =  "autoCast";
    char            z = m.E_COLOR_GRAY;
    m.f_menu(sHdr, __LINE__);
    m.f_chapter(sHdr, __FUNCTION__, __LINE__);
    //  =:= m:  int+long+float
    int             i   = 10;
    long            l   = 3L;
    float           f   = -123.456f;
#ifdef _MSC_VER
    T_TUTOR__INT64  iL = 10;
    #pragma warning(disable : 26451)
    double          dRc = iL + l + f;
#else
    double          dRc = i + l + f;
#endif
    m.f_text(z,"<%d> + <%ld> + <%f> =: <%f>", i,l,f,dRc);
    m.f_text(z,"iEc =: %d",iEc);
    m.f_subMenu("finish", __LINE__);
    return(iEc);
};


//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//  =:= C:  type: byConstructor
//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

//  =:= m:  casting_byConstructor
CFraction::CFraction(int i) {
    m__iNumerator   = i;
    m__iDenominator = 1;
};
CFraction::CFraction(double d) {
    m__iDenominator = 1;
    while(floor(d) != 0) {
        m__iDenominator *= 10;
        d *= 10;
    }
    m__iNumerator = int(d);
    f_Kuerzen();
};

//  =:= C:  type: byConstructor
int F___type_byConstructor(CTutor &m) {
    int             iEc = m.f_iEc();
    const char*     sHdr =  "type_byConstructor";
    char            z = m.E_COLOR_GRAY;
    int             i=0;
    m.f_menu(sHdr, __LINE__);
    m.f_chapter(sHdr, __FUNCTION__, __LINE__);

//  =:= m:  casting_byConstructor
//  =:= s:  float:  +=
    m.f_subMenu("float +=", __LINE__);
    CFraction A((double)4.5,(double)3.2);
    CFraction B((double)1.5,(double)4.1);
    m.f_text(z,"A = 4.5 / 3.2");
    m.f_text(z,"B = 1.5 / 4.1");
    cout    << "\t" << ++i << " : "
            << "A" << A << " += " << "B" << B << "\t =: "
            << (A += B) << endl;

    m.f_subMenu("finish", __LINE__);
    m.f_text(z,"iEc =: %d",iEc);
    return(iEc);
};

//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//  =:= C:  type: byFunction
//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

int F___type_byFunction(CTutor &m) {
    int             iEc = m.f_iEc();
    const char*     sHdr =  "type_byFunction";
    char            z = m.E_COLOR_GRAY;
    m.f_menu(sHdr, __LINE__);
    m.f_chapter(sHdr, __FUNCTION__, __LINE__);
    m.f_subMenu("finish", __LINE__);
    m.f_text(z,"iEc =: %d",iEc);
    return(iEc);
};

//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//  =:= C:  objectCopy
//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

int F___copy_object(CTutor &m) {
    int             iEc = m.f_iEc();
    const char*     sHdr =  "objectCopy";
    char            z = m.E_COLOR_GRAY;
    m.f_menu(sHdr, __LINE__);
    m.f_chapter(sHdr, __FUNCTION__, __LINE__);
    m.f_subMenu("finish", __LINE__);
    m.f_text(z,"iEc =: %d",iEc);
    return(iEc);
};

//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//  =:= C:  operator =: '()'
//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

int F___op_bracket(CTutor &m) {
    int             iEc = m.f_iEc();
    const char*     sHdr =  "op=:()";
    char            z = m.E_COLOR_GRAY;
    m.f_menu(sHdr, __LINE__);
    m.f_chapter(sHdr, __FUNCTION__, __LINE__);
    m.f_subMenu("finish", __LINE__);
    m.f_text(z,"iEc =: %d",iEc);
    return(iEc);
};

//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//  =:= C:  operator =: '->'
//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

//  =:= m:  intelligent pointer
class CIntellipointer
{
    private:
        struct t__Element
        {
            char    m_sId[80];
            int     m_iNumber;
            t__Element(): m_iNumber(0) {
                    strcpy(m_sId, "nicht vorhanden");  }
            t__Element(char *s, int i): m_iNumber(i) {
                    strcpy(m_sId, s); }
        };
        t__Element *p__elem;
        int m__iRefs;

    public:
        CIntellipointer() : m__iRefs(0) {
            #ifdef __USE_TUTOR__STD_C11
                p__elem = nullptr;
            #else
                p__elem = NULL;
            #endif
        }
        CIntellipointer(char *s, int n): m__iRefs(1) {
                p__elem = new t__Element(s, n); }
        ~CIntellipointer() {
            if(m__iRefs) {
                delete p__elem;
            }
        }
        t__Element * operator ->()
        {
            if(!m__iRefs)
                p__elem = new t__Element, ++m__iRefs;
            return p__elem;
        }
};

int F___op_arrow(CTutor &m) {
    int             iEc = m.f_iEc();
    const char*     sHdr =  "op=:'->'";
    char            z = m.E_COLOR_GRAY;
    char            sA[20],sB[20];
    m.f_menu(sHdr, __LINE__);
    m.f_chapter(sHdr, __FUNCTION__, __LINE__);

    strcpy(sA,"aaaa");
    strcpy(sB,"bbbb");
//  =:= m:  intelligent pointer
    CIntellipointer a(sA, 1), b(sB, 2), c, d;
    cout << "\t" << a->m_sId << " " << a->m_iNumber << endl;
    cout << "\t" << b->m_sId << " " << b->m_iNumber << endl;
    cout << "\t" << c->m_sId << " " << c->m_iNumber << endl;
    cout << "\t" << d->m_sId << " " << d->m_iNumber << endl;

    m.f_subMenu("finish", __LINE__);
    m.f_text(z,"iEc =: %d",iEc);
    return(iEc);
};


//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//  =:= C:  operator =: 'new' & 'delete'
//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

int F___new_and_delete(CTutor &m) {
    int             iEc = m.f_iEc();
    const char*     sHdr =  "op=:new&delete";
    char            z = m.E_COLOR_GRAY;
    m.f_chapter(sHdr, __FUNCTION__, __LINE__);
    m.f_menu(sHdr, __LINE__);
    m.f_subMenu("finish", __LINE__);
    m.f_text(z,"iEc =: %d",iEc);
    return(iEc);
};


//  ############################################################################
//  =:= F:  main
//  ############################################################################

int F26_operator_overloading(CTutor &m) {

    int             iRc,iEc;
    const char*     sHdr =  "overload C++ operator";
    iEc = m.f_header(sHdr, __FILE__, __LINE__);

    iRc = F___basic(m);     if (iRc != iEc) { return iRc; }
    iRc = F___friend_function(m);     if (iRc != iEc) { return iRc; }
    iRc = F___method(m);            if (iRc != iEc) { return iRc; }
    iRc = F___fix_PostPre(m);       if (iRc != iEc) { return iRc; }
    iRc = F___autoCast(m);       if (iRc != iEc) { return iRc; }
    iRc = F___type_byConstructor(m);    if (iRc != iEc) { return iRc; }
    iRc = F___type_byFunction(m);       if (iRc != iEc) { return iRc; }
    iRc = F___copy_object(m);   if (iRc != iEc) { return iRc; }
    iRc = F___op_bracket(m);    if (iRc != iEc) { return iRc; }
    iRc = F___op_arrow(m);      if (iRc != iEc) { return iRc; }
#if 0
    iRc = F___new_and_delete(m);    if (iRc != iEc) { return iRc; }
#endif

    m.f_footer(sHdr, __FILE__, __LINE__);
    return(iEc);
};

#ifndef __USE_TUTOR__MAIN
int main(int p_iArgs, char *p_sArgv[]) {
    CTutor  m;
    if (p_iArgs >= 2) {
        m.f_mode_color(true);
    }
    return F26_operator_overloading(m);
}
#endif
