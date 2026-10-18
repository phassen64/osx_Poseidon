//  ****************************************************************************
//  TUTORIAL:   C++     :   Derived Class
//  ****************************************************************************
//  !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß-------$
/*
    chapter:
        •   F:  class
        •   F:  helper
        •   F:  main
    content:
        •   m:  derivedClass <dC> basic
            •   s:  bC:constructor
            •   s:  bC:destructor
        •   m:  derivationType <dT>
            •   s:  dT:public
            •   s:  dT:protected
            •   s:  dT:private
        •   m:  constructor && destructor of <dC>
            •   s:  dC:constructor
            •   s:  dC:destructor
        •   m:  access compabitlity if bC:=dC
            •   s:  show object<bC>
            •   s:  show pointer *p<bC>
            •   s:  show pointer *p<dC>
        •   m:  class hierarchy
        •   m:  this-pointer
            •   s:  this
        •   m:  virtual method
            •   s:  define virtual<bC>:base
            •   s:  define virtual<dC>:derived
        •   m:  virtual Destructor<vD>
            •   s:  define.vD
            •   s:  using.vD
    keyword:
        •   class
        •   delete
        •   new
        •   private protected public
        •   virtual
    url:
        •   https://www.w3schools.com/cpp/cpp_inheritance.asp
        •   https://cplusplus.com/doc/tutorial/inheritance/
        •   https://www.tutorialspoint.com/cplusplus/cpp_inheritance.htm
        •   https://en.cppreference.com/w/cpp/language/derived_class
 */


/*
    In C++, it is possible to inherit attributes and methods
        from one class to another.
    We group the "inheritance concept" into two categories:
        �   derived class (child)
                - the class that inherits from another class
        �   base class (parent)
                - the class being inherited from
*/


#include "Tutor.h"
using namespace std;


//  ############################################################################
//  =:= F:  class
//  ############################################################################

//  Base class
class CMammal
{
    private:
        string  v_sCls;
        int     v_iRegister;
    protected:
        int     o_iCounter;
    public:
        //* static classCounter outside
        static int s_iCounter;
        //* own publics
        string  u_sName;
        bool    u_bVegetarian;
        int     u_iBabyPerYear;
        int f_iCounter(bool p_bStatic=false) {
            if (p_bStatic) {
                return s_iCounter;
            } else {
                return o_iCounter;
            }
        }
        int f_iRegister() {
            return v_iRegister ;
        }
        //  =:= s:  define virtual<bC>
        virtual string f_SName()  { return u_sName; }
        //  =:= s:  bC:constructor
        CMammal()   {
            v_sCls          = "Mammal";
            v_iRegister     = -1;
            cout    << "\t &&& created"
                    << " :<"  << v_sCls << ">"
                    << " :[" << ++s_iCounter  << "]"
                    << endl;
            o_iCounter      = 0;
            v_iRegister = 1000 + rand() % 1000;
        }
        //  =:= s:  bC:destructor
        ~CMammal()  {
            cout    << "\t &&& destroy"
                    << " :<"  << v_sCls << ">"
                    << " :[" << s_iCounter--  << "]"
                    << endl;
        }
};
int CMammal::s_iCounter = 0;

//  =:= s:  dT:public
class CRabbit: public CMammal  {
    private:
        string  v_sCls;
    public:
        //* static classCounter outside
        static int s_iCounter;
        //* own
        int     m_iLegs;
        float   m_fJumpWidth;
        //  =:= s:  define virtual<dC>
        virtual string f_SName()  {
            string sRc;
            sRc = "My Name is: '" + u_sName + "' !";
            return sRc;
        }
        //  =:= s:  dC:constructor::rabbit
        CRabbit() {
            v_sCls  = "Rabbit";
            cout    << "\t &&& created"
                    << " :<"  << v_sCls << ">"
                    << " :[" << ++s_iCounter  << "]"
                    << endl;
            this->o_iCounter += 1;
        }
        //  =:= s:  dC:destructor::rabbit
        ~CRabbit()  {
            cout    << "\t &&& destroy"
                    << " :<"  << v_sCls << ">"
                    << " :[" << s_iCounter--  << "]"
                    << endl;
        }
};
int CRabbit::s_iCounter = 0;


//  =:= s:  dT:public
class CDolphin: public CMammal  {
    private:
        string  v_sCls;
    public:
        //* static classCounter outside
        static int s_iCounter;
        //* own
        int     m_iFlowed;
        float   m_fDivingDepth;
        void    f_info() {
        }
        //  =:= s:  this
        CDolphin * f_getThis() {
            return this;
        }
        //  =:= s:  dC:constructor::dolphin
        CDolphin() {
            v_sCls  = "Dolphin";
            cout    << "\t &&& created"
                    << " :<"  << v_sCls << ">"
                    << " :[" << ++s_iCounter  << "]"
                    << endl;
            //  =:= s:  this
            this->o_iCounter += 1;
        }
        //  =:= s:  dC:destructor::dolphin
        ~CDolphin()  {
            cout    << "\t &&& destroy"
                    << " :<"  << v_sCls << ">"
                    << " :[" << s_iCounter--  << "]"
                    << endl;
        }
};
int CDolphin::s_iCounter = 0;


//  =:= s:  dT:proteced
class CDog: protected CMammal  {
    private:
        string  v_sCls;
    public:
        //* static classCounter outside
        static int s_iCounter;
        //* access to BaseClass public
        string  f_get_SName()   { return this->u_sName; }
        int     f_get_iBaby()   { return this->u_iBabyPerYear; }
        bool    f_get_bVega()   { return this->u_bVegetarian; }
        //* own publics
        int     m_iLegs;
        void f_setDog(string p_SName, int p_iBaby, int p_iLegs, bool p_bVega=false) {
            m_iLegs                 = p_iLegs;      // direct access
            this->u_sName           = p_SName;
            this->u_iBabyPerYear    = p_iBaby;
            this->u_bVegetarian     = p_bVega;
        }
        //  =:= s:  define virtual<dC>
        virtual string f_SName()  {
            string sRc;
            sRc = "My Name is:*** '" + u_sName + "' ***";
            return sRc;
        }
        //  =:= s:  dC:constructor::dog
        CDog() {
            v_sCls  = "Dog";
            cout    << "\t &&& created"
                    << " :<"  << v_sCls << ">"
                    << " :[" << ++s_iCounter  << "]"
                    << endl;
            this->o_iCounter += 1;
        }
        //  =:= s:  dC:destructor::dog
        ~CDog()  {
            cout    << "\t &&& destroy"
                    << " :<"  << v_sCls << ">"
                    << " :[" << s_iCounter--  << "]"
                    << endl;
        }
};
int CDog::s_iCounter = 0;


//  =:= s:  dT:private
class CCat: private CMammal  {
    private:
        string  v_sCls;
    public:
        //* static classCounter outside
        static int s_iCounter;
        //* access to BaseClass public
        string  f_get_SName()   { return this->u_sName; }
        int     f_get_iBaby()   { return this->u_iBabyPerYear; }
        bool    f_get_bVega()   { return this->u_bVegetarian; }
        //* own publics
        int     m_iLegs;
        void f_setCat(string p_SName, int p_iBaby, int p_iLegs, bool p_bVega=false) {
            m_iLegs                 = p_iLegs;      // direct access
            //  =:= s:  this
            this->u_sName           = p_SName;
            this->u_iBabyPerYear    = p_iBaby;
            this->u_bVegetarian     = p_bVega;
        }
        //  =:= s:  dC:constructor::cat
        CCat() {
            v_sCls  = "Cat";
            cout    << "\t &&& created"
                    << " :<"  << v_sCls << ">"
                    << " :[" << ++s_iCounter  << "]"
                    << endl;
            //  =:= s:  this
            this->o_iCounter += 1;
        }
        //  =:= s:  dC:destructor::cat
        ~CCat()  {
            cout    << "\t &&& destroy"
                    << " :<"  << v_sCls << ">"
                    << " :[" << s_iCounter--  << "]"
                    << endl;
        }
};
int CCat::s_iCounter = 0;


//  =:= s:  define.vD
class  CTestBase {
    public:
        int Z1;
        virtual  ~CTestBase() {
            cout << "\t &&& Destructor of::Base" << endl; }
};
class   CTestDerived : public CTestBase {
    public:
        int Z2;
        ~CTestDerived() {
            cout << "\t &&& Destructor of::Derived" << endl; }
};


//  ############################################################################
//  =:= F:  helper
//  ############################################################################


int F__derivedClass(CTutor &m) {

    int             iEc=m.f_iEc();
    const char*     sHdr =  "Derived Class";
    char            z = m.E_COLOR_GRAY;
    string          SRc;

//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//  =:= m:  derivedClass <dC> basic
//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

//  derivationType==public

    m.f_menu(sHdr, __LINE__);

    //  init
    m.f_subMenu("init", __LINE__);
    CRabbit     R1;

    R1.u_sName = "Harvey";
    R1.m_iLegs = 4;
    R1.m_fJumpWidth = (float)7.32;
    R1.u_bVegetarian = true;
    R1.u_iBabyPerYear = 10;

//  =:= s:  dT:private
    m.f_subMenu("DT := public", __LINE__);
    CDolphin    H1;
    H1.u_sName = "Flipper";
    H1.m_iFlowed = 5;
    H1.m_fDivingDepth = (float)200.1;
    H1.u_bVegetarian = false;
    H1.u_iBabyPerYear = 2;

    m.f_subMenu("show rabbit", __LINE__);
    m.f_text(z,"R.name =: <%s>", R1.u_sName.c_str());
    m.f_text(z,"R.baby =: <%d>", R1.u_iBabyPerYear);
    m.f_text(z,"R.vega =: <%d>", R1.u_bVegetarian);
    m.f_text(z,"R.Legs =: <%d>", R1.m_iLegs);
    m.f_text(z,"R.Jump =: <%f>", R1.m_fJumpWidth);

    m.f_subMenu("show dolphin", __LINE__);
    m.f_text(z,"H.name =: <%s>", H1.u_sName.c_str());
    m.f_text(z,"H.baby =: <%d>", H1.u_iBabyPerYear);
    m.f_text(z,"H.vega =: <%d>", H1.u_bVegetarian);
    m.f_text(z,"H.flow =: <%d>", H1.m_iFlowed);
    m.f_text(z,"H.dive =: <%f>", H1.m_fDivingDepth);

    m.f_subMenu("show counter", __LINE__);
    m.f_subMenu("dT<public>:static classCounter", __LINE__);
    m.f_text(z,"H.counter<S> =: <%d>", H1.f_iCounter(true));
    m.f_text(z,"R.counter<S> =: <%d>", R1.f_iCounter(true));
    m.f_subMenu("dT<public>:proteced classCounter", __LINE__);
    m.f_text(z,"H.counter<o> =: <%d>", H1.f_iCounter());
    m.f_text(z,"R.counter<o> =: <%d>", R1.f_iCounter());

    m.f_subMenu("show regsiter", __LINE__);
    m.f_text(z,"R.register =: <%d>", R1.f_iRegister());
    m.f_text(z,"H.register =: <%d>", H1.f_iRegister());

//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//  =:= m:  derivationType <dT>     {public,proteced,private}
//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

/*
    !url: https://herdt.com/pages/
    Sie k�nnen durch eine Ableitung den Zugriffsschutz eines Attributes nicht
    verringern. Es ist beispielsweise nicht m�glich, eine in der Basisklasse als
    private oder protected deklarierte Methode durch eine public-Ableitung wieder
    mit dem Zugriffsattribut public zu versehen
*/

/*
    class CChild: <public> CBasic
    class CChild: <protected> CBasic
    class CChild: <private> CBasic
*/

    m.f_menu("derivation type <dT>", __LINE__);

//  =:= s:  dT:proteced
    m.f_subMenu("DT := protected", __LINE__);
    CDog        D1;
    D1.f_setDog("Lassie",3,4,false);
    m.f_text(z,"D.Name =: <%s>", D1.f_get_SName().c_str());
    m.f_text(z,"D.baby =: <%d>", D1.f_get_iBaby());
    m.f_text(z,"D.vega =: <%d>", D1.f_get_bVega());
    m.f_text(z,"D.leg  =: <%d>", D1.m_iLegs);   // OK!

//  =:= s:  dT:proteced
    m.f_subMenu("DT := private", __LINE__);
    CCat        C1;
    C1.f_setCat("Jerry",6,4,false);
    m.f_text(z,"C.leg  =: <%d>", C1.m_iLegs);
    m.f_text(z,"C.Name =: <%s>", C1.f_get_SName().c_str());
    m.f_text(z,"C.baby =: <%d>", C1.f_get_iBaby());
    m.f_text(z,"C.vega =: <%d>", C1.f_get_bVega());


//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//  =:= m:  constructor && destructor of <dC>
//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

    m.f_menu("constructor && destructor of <dC>", __LINE__);

/*
    !url: https://herdt.com/pages/
    Abgeleitete Klassen besitzen genauso wie Basisklassen
        Konstruktoren und Destruktoren.
    Grunds�tzlich wird f�r ein Objekt einer abgeleiteten Klasse
        immer zuerst der Konstruktor der Basisklasse abgearbeitet
        und danach der Konstruktor der abgeleiteten Klasse.
    Bei den Destruktoren ist die Reihenfolge umgekehrt.
    Der Destruktor der abgeleiteten Klasse wird vor dem
        Destruktor der Basisklasse ausgef�hrt.
    So kann in allen Methoden einer
        abgeleiteten Klasse,
        also auch den Konstruktoren und Destruktoren,
        immer davon ausgegangen werden,
        dass alle Eigenschaften der Basisklasse richtig initialisiert sind.
    Sie k�nnen den Standardkonstruktor und den
        Standarddestruktor der abgeleiteten Klasse erweitern.
*/


//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//  =:= m:  access compabitlity if bC:=dC
//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

/*
    !url: https://herdt.com/pages/
    Zuweisung von Objekten abgeleiteter Klassen Ein Objekt einer abgeleiteten Klasse
    kann einem Objekt einer Basisklasse zugewiesen werden.
    Die Ableitung muss daf�r
    mit dem Attribut public durchgef�hrt werden.
    Das entspricht der
        Betrachtungsweise, dass ein Objekt einer abgeleiteten Klasse
    als besondere Form
    der Basisklasse angesehen werden kann.
*/

    m.f_menu("access compabitlity", __LINE__);

//  =:= s:  define bC
    m.f_subMenu("define bC", __LINE__);
    CMammal M1;
    M1.u_sName          = "KingKong";
    M1.u_bVegetarian    = true;
    M1.u_iBabyPerYear   = 5;

//  =:= s:  show object<bC>
    m.f_subMenu("show tMammal", __LINE__);
    m.f_text(z,"M.name =: <%s>", M1.u_sName.c_str());
    m.f_text(z,"M.baby =: <%d>", M1.u_iBabyPerYear);
    m.f_text(z,"M.vega =: <%d>", M1.u_bVegetarian);

//  =:= s:  show pointer *p<bC>
    m.f_subMenu("show *pMammal", __LINE__);
    CMammal *pM = &M1;
    m.f_text(z,"*pM         =: <%p>", pM);
    m.f_text(z,"*pM->name   =: <%s>", pM->u_sName.c_str());
    m.f_text(z,"*pM->baby   =: <%d>", pM->u_iBabyPerYear);
    m.f_text(z,"*pM->vega   =: <%d>", pM->u_bVegetarian);

//  =:= s:  show pointer *p<dC>
    m.f_subMenu("show *pRabbit", __LINE__);
    CRabbit *pR = &R1;
    m.f_text(z,"*pR         =: <%p>", pR);
    m.f_text(z,"*pR->name   =: <%s>", pR->u_sName.c_str());
    m.f_text(z,"*pR->baby   =: <%d>", pR->u_iBabyPerYear);
    m.f_text(z,"*pR->vega   =: <%d>", pR->u_bVegetarian);

//  =:= s:  assign bC:=dC
    m.f_subMenu("assign bC:=dC", __LINE__);
    M1 = R1;
    m.f_text(z,"M.name =: <%s>", M1.u_sName.c_str());
    m.f_text(z,"M.baby =: <%d>", M1.u_iBabyPerYear);
    m.f_text(z,"M.vega =: <%d>", M1.u_bVegetarian);

//  ??? pointer pM is lost

//  =:= s:  *p->assign bC:=dC
    m.f_subMenu("result", __LINE__);
    m.f_text(z,"*pM         =: <%p>", pM);
    m.f_text(z,"*pM->name =: <%s>", pM->u_sName.c_str());
    m.f_text(z,"*pR->name =: <%s>", pR->u_sName.c_str());


//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//  =:= m:  class hierarchy
//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

    m.f_menu("class hierarchy", __LINE__);

/*
    !url: https://herdt.com/pages/
    Von einer Klasse k�nnen beliebig viele andere
        Klassen abgeleitet werden.
    Eine abgeleitete
    Klasse kann wiederum als Basisklasse zum
        Ableiten anderer Klassen verwendet werden.
    So k�nnen komplexe Klassenhierarchien aufgebaut
        werden.
*/

//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//  =:= m:  this-pointer
//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

    m.f_menu("this-pointer", __LINE__);

    //* define a pointer and use special member function
    CDolphin *pH;
    pH = H1.f_getThis();

    m.f_subMenu("getThis", __LINE__);
    m.f_text(z,"*pH         =: <%p>", pH);
    m.f_text(z,"*pH->name   =: <%s>", pH->u_sName.c_str());


//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//  =:= m:  virtual method
//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

/*
    !url: https://herdt.com/pages/

    === Funktionsweise
    Die Adressen der virtuellen Methoden stehen in einer Tabelle, die
    mit VMT (Virtual Method Table) bezeichnet wird. In dieser werden
    zur Laufzeit eines Programms die Anfangsadressen der zugeh�rigen
    aktuellen Methoden gespeichert.
    Obwohl alle Methoden (der Basisklasse als auch der abgeleiteten Klassen)
        bereits im Speicher
        vorhanden sind,
    werden sie erst durch den Eintrag der Anfangsadresse
    in die VFT an die Instanz gebunden.


    === Regeln fur virtuelle Methoden
    �   Eine in der Basisklasse virtuell definierte Methode
        ist automatisch in allen abgeleiteten Klassen virtuell.
    �   Eine abgeleitete Klasse muss nicht notwendigerweise
            alle in der Basisklasse vorhandenen
                virtuellen Methoden uberschreiben.
        Wird eine Methode nicht uberschrieben, wird die
            Methode der Basisklasse verwendet.
    �   Konstruktoren durfen nicht mit dem Attribut virtual definiert werden,
            da zur Kompilierungszeit bei den Anweisungen zur
                Erzeugung einer Instanz immer die Klasse durch die
            Klassenangabe feststeht.
    �   Destruktoren konnen virtuell definiert werden !
        Ist ein Destruktor in der Basisklasse virtuell
            definiert und wird z. B. der Operator
            delete uber einen Basisklassenzeiger aufgerufen,
        werden fur das konkrete Objekt einer abgeleiteten Klasse alle Destruktoren
            in der richtigen Reihenfolge abgearbeitet.
        Ist die Methode nicht als virtual definiert,
            wird das Objekt nicht korrekt freigegeben,
            da es als ein Objekt vom Typ der Basisklasse behandelt wird.

*/


    m.f_menu("virtual method", __LINE__);

    m.f_subMenu("show different virtual methods", __LINE__);
    string sName;

    m.f_subMenu("virtualMethod of dC", __LINE__);
    sName = R1.f_SName();
    m.f_text(z,"R.sName   =: <%s>", sName.c_str());
    sName = D1.f_SName();
    m.f_text(z,"D.sName   =: <%s>", sName.c_str());

    m.f_subMenu("virtualMethod of bC", __LINE__);
    sName = H1.f_SName();
    m.f_text(z,"H.sName   =: <%s>", sName.c_str());


//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//  =:= m:  virtual Destructor
//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

/*
    !url: https://herdt.com/pages/

    Im Gegensatz zu Konstruktoren k�nnen Destruktoren mit dem Attribut virtual
    deklariert werden.
    Dies kann besonders dann Bedeutung erlangen,
        wenn eine
        dynamische Speicherverwaltung implementiert wird,
        bei der Sie einen Speicherbereich �ber den Destruktor freigeben m�ssen,
            der �ber den Konstruktor
            einer abgeleiteten Klasse bereitgestellt wurde.
    Der Destruktor der Basisklasse
        kann dies nicht leisten,
        weil das Objekt der Basisklasse
        die angelegten Speicherbereiche
        der Objekte der abgeleiteten Klasse nicht kennt.

*/
    m.f_menu("virtual Destructor", __LINE__);

//  =:= s:  using.vD
    CTestBase *pTB;
    pTB     =   new CTestDerived;       //  using : dynamic memory
    delete pTB;                         //  free

//  =:= b:  body
    m.f_subMenu("leave", __LINE__);
    return(iEc);
}


//  ############################################################################
//  =:= F:  main
//  ############################################################################

int F23_derived_class(CTutor &m) {
    int             iEc ,
                    iRc;
    const char*     sHdr =  "Derived Class";
//  =:= b:  header
    iEc = m.f_header(sHdr,__FILE__,__LINE__);
//  =:= b:  derivedClass...
    iRc = F__derivedClass(m);     if (iRc != iEc) { return iRc; }
//  =:= b:  footer
    m.f_subMenu("footer", __LINE__);
    m.f_footer(sHdr,__FILE__,__LINE__);
    return(iEc);
};


#ifndef __USE_TUTOR__MAIN
int main(int p_iArgs, char *p_sArgv[]) {
    CTutor  m;
    if (p_iArgs >= 2) {
        m.f_mode_color(true);
    }
    return F23_derived_class(m);
}
#endif
