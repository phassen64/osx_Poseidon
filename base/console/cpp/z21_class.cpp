//  ****************************************************************************
//  TUTORIAL:   C++     :   class
//  ****************************************************************************
//  !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß-------$
/*
    content:
        •   m:  fruit level:basic
            •   s:  global object
            •   s:  method info
            •   s:  method with input-parameter
            •   s:  method with output-parameter
            •   s:  method with default-value
        •   m:  geometry level:advanced
            •   s:  constructor
            •   s:  destructor
            •   s:  outlined method
            •   s:  static classMember~variable
            •   s:  static classMember~method
        •   m:  vehicle level:expert
            •   s:  object.PTR
            •   s:  object.REF
            •   s:  this
    remark:
        •   i:  member initialization variants
            •   i.functional    :   Circle c(r)
            •   i.assignment    :   Circle c=x
            •   i.uniform       :   Circle c {r}
            •   i.podLike       :   Circle c={r}
    keyword<4>:
        •   class
        •   static
        •   private
        •   public
    url:
        •   https://www.w3schools.com/cpp/cpp_functions.asp
        •   https://cplusplus.com/doc/tutorial/classes/
*/

/*
    =:= static  Static Function Members
        url:  https://www.tutorialspoint.com/cplusplus/cpp_static_members.htm
        By declaring a function member as static,
            •   you make it independent of any particular
                    object of the class.
        A static member function...
            •   can be called even if no objects of the class exist
                    and the static functions are accessed using only the class name
                    and the scope resolution operator ::.
            •   can only access static data member,
                    other static member functions and
                    any other functions from outside the class.
            •   have a class scope and they
                    do not have access to the this pointer of the class.
            •   could be used to determine whether some objects
                    of the class have been created or not.
*/

/*
    =:= this    Object Ptr
        Every object in C++ has access to its own address through
            an important pointer called "this" pointer.
        The "this" pointer is an implicit parameter to all member functions.
        Therefore, inside a member function,
            this may be used to refer to the invoking object.
*/


#include "Tutor.h"
// #include <iostream>
using namespace std;


//  === i:  fruit =============================================================

//  =:= m: public method and global object
class CApple {
    public:
        void f_info(void) {
            cout << "\tI am an apple." << endl;
        }
} Apple1; // global object Apple


//  =:= m: public method
class CBanana {
    public:
        void f_info(void) {
            cout << "\tI am a banana." << endl;
        }
};

//  =:= m: private member
class CCitron {
    private:
        #ifdef __USE_TUTOR__STD_C11
            string m__sColor = "yellow";
        #else
            string m__sColor;
        #endif
    public:
        #ifndef __USE_TUTOR__STD_C11
            CCitron() { m__sColor = "yellow"; }
        #endif
        void f_info(void) {
            cout    << "\tI am a citron and my color is :"
                    << m__sColor
                    << "!"
                    << endl;
        }
        void f_setColor(string p_sColor) {
            m__sColor = p_sColor;
        }
};


//  =:= m: return-value
class CDurian {
    private:
        #ifdef __USE_TUTOR__STD_C11
            string m__sColor    = "brown";
            int     m__iAge     = 10;
        #else
            string  m__sColor;
            int     m__iAge;
        #endif
    public:
        #ifndef __USE_TUTOR__STD_C11
            CDurian() { m__sColor = "brown"; m__iAge = 10; }
        #endif
        void f_info(void) {
            cout    << "\tI am a durian, come from malaysia and my color is :"
                    << m__sColor
                    << " and my Age is :"
                    << m__iAge
                    << "!"
                    << endl;
        }
        void f_setValue(string p_sColor, int p_iAge) {
            m__sColor = p_sColor;
            m__iAge   = p_iAge ;
        }
        int  f_iAge(){
            return m__iAge;
        }
};

//  =:= m: default-value
class CEggplant {
    private:
        #ifdef __USE_TUTOR__STD_C11
            string  m__sColor = "Green";
        #else
            string  m__sColor;
        #endif
    public:
        #ifndef __USE_TUTOR__STD_C11
            CEggplant() { m__sColor = "Green"; }
        #endif
        void f_info(void) {
            cout    << "\tI am a eggplant and my color is :"
                    << m__sColor
                    << "!"
                    << endl;
        }
        void f_setValue(string p_sColor = "DarkPurple") {
            m__sColor = p_sColor;
        }

};


int F__fruit(CTutor &m) {
    int         iEc = m.f_iEc();
    const char* sHdr = "Fruit++";
    int         iAge;
    char        z = m.E_COLOR_GRAY;

    m.f_chapter(sHdr,__FILE__,__LINE__,true);

    //  =:= m:  fruit level:basic
    m.f_menu("introduction",__LINE__);

    //  =:= s:  global object
    m.f_subMenu("Apple",__LINE__);
    Apple1.f_info();

    //  =:= s:  method info
    m.f_subMenu("Banana",__LINE__);
    CBanana B;
    B.f_info();

    //  =:= s:  method with input-parameter
    m.f_subMenu("Citron",__LINE__);
    CCitron C;
    C.f_info();
    C.f_setColor("green");
    C.f_info();

    //  =:= s:  method with output-parameter
    m.f_subMenu("Durian",__LINE__);
    CDurian D;
    D.f_info();
    iAge = D.f_iAge();
    m.f_text(z,"Age  := '%d'",iAge);
    D.f_setValue("darkBrown",33);
    D.f_info();

    //  =:= s:  method with default-value
    m.f_subMenu("Eggplant",__LINE__);
    CEggplant E;
    E.f_info();
    E.f_setValue();
    E.f_info();

    return(iEc);
};


//  === i:  geometry ==========================================================


//  =:= s:  constructor
class CRectangle {
    private:
        int     m__iX;
        int     m__iY;
        string  m__sCls;
    public:
        /*
         *  name(Constructor) == name(Class)
         *  and no return value
         */
        CRectangle(int p_iX, int p_iY) {
            cout    << "\t&&& I<" << m__sCls << "> am created" << endl;
            m__sCls = "Rectangle";
            m__iX = p_iX;
            m__iY = p_iY;
        }
        void f_info(void) {
            cout    << "\t" << m__sCls << " DIM=("
                    << m__iX
                    << ","
                    << m__iY
                    << ")"
                    << endl;
        }
};


//  =:= s:  destructor
class CCircle {
    private:
        int     m__iR;
        string  m__sCls;

    public:
        // * constructor
        CCircle(int p_iR) {
            m__iR       = p_iR;
            m__sCls     = "Circle";
            #ifdef __USE_TUTOR__STD_C11
                string m_sCls_tmp  = typeid(*this).name();  // !PHA:notworks
            #endif
            cout    << "\t&&& I<" << m__sCls << "> am created" << endl;
        }
        /*
         *  name(Desctructor) == name(~Class)
         *  and no return value
         */
        ~CCircle() {
            cout    << "\t&&& I <" << "Circle" << "> am destroyed" << endl;
        }
        void f_info(void) {
            cout    << "\t" << m__sCls << " DIM=("
                    << m__iR
                    << ")"
                    << endl;
        }
};


//  =:= s:  outlined method
class CSquare {
    private:
        int     m__iX;
        string  m__sCls;
    public:
        CSquare(int p_iX) {
            m__sCls = "Square";
            m__iX   = p_iX;
            cout    << "\t&&& I <" << m__sCls << "> am created" << endl;
        }
        ~CSquare() {
            cout    << "\t&&& I <" << m__sCls << "> am destroyed"   << endl;
        }
        //  outlined methods has to be declared before it's usage
        void f_info(void);
        void f_set(int);
};

//  outlined method 'f_set'
void CSquare::f_set(int p_iX) {
    m__iX = p_iX;
}

//  outlined method 'f_info'
void CSquare::f_info(void) {
    cout    << "\t" << m__sCls << " DIM=("
            << m__iX
            << ")"
            << endl;
}


//  =:= s:  static classMember~variable::definition

class CElipse {

    private:
        int     m__iA;
        int     m__iB;
        float   m__fX;
        float   m__fY;
        string  m__sCls;

    public:

        //  *   using "static" is like "static" in functions
        //  *   initialization outside the class
        //  *   deprecated inside like: static int m_iObjectCounter = 0;
        static int g_iElipseCounter;

        //  *   local objectCounter
        int     m_iElipseCounter;   // mapped to each object

        CElipse(int p_iA, int p_iB, float p_fX, float p_fY) {
            m__sCls = "Elipse";
            m__iA   = p_iA; m__iB = p_iB;
            m__fX   = p_fX; m__fY = p_fY;
            cout    << "\t&&& I <" << m__sCls << "> am created with Index:["
                    << ++g_iElipseCounter
                    << "]"
                    << endl;
            m_iElipseCounter = g_iElipseCounter;    // save
        }
        ~CElipse() {
            cout    << "\t&&& I <" << m__sCls << ">" <<
                    "[" << m_iElipseCounter << "] am destroyed"  << endl;
        }
        void f_info(void) {
            cout    << "\t" << m__sCls << "[" << m_iElipseCounter << "]"
                    << " DIM=("
                    << m__iA << ","
                    << m__iB << ","
                    << m__fX << ","
                    << m__fY
                    << ")"
                    << endl;
        }

        //  =:= s:  static classMember~method::define
        static void f_show(void) {
            cout    << "\t&&& gObjectCounter =: <" << g_iElipseCounter << ">"
                    << endl;
        }

};


//  =:= s:  static classMember~variable::initialization
/*
 *  The static variable must be defined outside of the class.
 *  In earlier versions it could be inside.
 */
int CElipse::g_iElipseCounter = 0;


int F__geometry(CTutor &m) {
    int         iEc = m.f_iEc();
    const char* sHdr = "Geometry++";
    m.f_chapter(sHdr,__FILE__,__LINE__,true);

    //  =:= m:  geometry level:advanced
    m.f_menu("geometry",__LINE__);

    //  =:= s:  constructor
    m.f_subMenu("constructor",__LINE__);
    CRectangle R(5,2);  //  === :initialization i.functional
    R.f_info();

    //  =:= s:  destructor
    m.f_subMenu("destructor",__LINE__);
    CCircle C=10;       //  === :initialization i.assignment
    C.f_info();

    //  =:= s:  outlined method
    m.f_subMenu("outlined method",__LINE__);
    #ifdef __USE_TUTOR__STD_C11
        CSquare Q{ 7 };     //  === :initialization i.uniform
    #else
        CSquare Q = 7;
    #endif
    Q.f_info();
    Q.f_set(81);
    Q.f_info();

    //  =:= s:  static classMember~variable::menu
    m.f_subMenu("static classVariable",__LINE__);
    CElipse E1(5 ,3,(float)20.5,(float)40.1);   E1.f_info();
    CElipse E2(-7,9,(float)14.2,(float)89.3);   E2.f_info();
    #ifdef __USE_TUTOR__STD_C11
        CElipse E3 = { 21,4, (float)-8.9, (float)-33.6 };  E3.f_info();
    #endif

    //  =:= s:  static classMember~method::menu
    m.f_subMenu("static classMethod",__LINE__);
    CElipse::f_show();

    m.f_menu("geometry:end",__LINE__);
    //  objects will no be destroyed

    return(iEc);
};


//  === i:  vehicle  ==========================================================


class CVehicle {
    private:
        float   m__fX;
        float   m__fY;
        float   m__fZ;
        string  m__sCls;
        int     m__iVehicleCounter;
        float f__fVolume() {
            return (float) ( m__fX * m__fY * m__fZ);
        }
    public:
        static int g_iVehicleCounter;
        CVehicle(float p_fX, float p_fY, float p_fZ) {
            m__sCls = "Vehicle";
            m__fX = p_fX; m__fY = p_fY; m__fZ = p_fZ;
            cout    << "\t&&& I <" << m__sCls << "> am created with Index:["
                    << ++g_iVehicleCounter
                    << "]"
                    << endl;
            m__iVehicleCounter = g_iVehicleCounter;
        }
        ~CVehicle() {
            cout    << "\t&&& I <" << m__sCls << ">" <<
                    "[" << m__iVehicleCounter << "] am destroyed"  << endl;
        }
        void f_info(int p_iLine = __LINE__) {
            cout    << "\t" << m__sCls << "[" << m__iVehicleCounter << "]"
                    << " DIM=("
                    << m__fX << ","
                    << m__fY << ","
                    << m__fZ
                    << ") at::["
                    << p_iLine
                    << "]"
                    << endl;
        }

        //  =:= s:  this
        bool  f_bIsLarger(CVehicle p_tVehicle /*test object*/) {
            float   fMine   = this->f__fVolume();   /*my object*/
            float   fOther  = p_tVehicle.f__fVolume();
            if ( fMine >  fOther  ) {
                return true;
            } else {
                return false;
            }
        }
};
int CVehicle::g_iVehicleCounter = 0;


int F__vehicle(CTutor &m) {
    int         iEc = m.f_iEc();
    const char* sHdr = "Vehicle++";
    char        z = m.E_COLOR_GRAY;

    m.f_chapter(sHdr,__FILE__,__LINE__,true);

    //  =:= m:  vehicle level:expert
    m.f_menu("vehicle",__LINE__);

    //  =:= s:  initialization variants

    //  url:https://cplusplus.com/doc/tutorial/classes/
    m.f_subMenu("initialization variant:podLike",__LINE__);
    #ifdef __USE_TUTOR__STD_C11
        //  === :initialization i.podlike
        CVehicle V1 = { (float)2.1,(float)5.1,(float)0.8 };     V1.f_info();
        CVehicle V2 = { (float)2.4, (float)8.3, (float)2.1 } ;  V2.f_info();
    #else
        CVehicle V1 ( (float)2.1,(float)5.1,(float)0.8 );       V1.f_info();
        CVehicle V2 ( (float)2.4,(float)8.3,(float)2.1 );       V2.f_info();
    #endif

    //  =:= s:  object.PTR  :   ptr:obj = 1:2
    m.f_subMenu("ptr *Vehicle",__LINE__);
    CVehicle *pV;
    pV = &V1;           m.f_text(z,"p(&V1)  := '%p'",pV);
    pV->f_info(__LINE__);
    pV = &V2;           m.f_text(z,"p(&V2)  := '%p'",pV);
    pV->f_info(__LINE__);

    //  =:= s:  object.REF  :   ref:obj = 1:1
    m.f_subMenu("ref &Vehicle",__LINE__);
    CVehicle &rV1 = V1;
    CVehicle &rV2 = V2;
#ifndef __BORLANDC__
    m.f_text(z,"r(&V1) := '%p'",&rV1);
    m.f_text(z,"r(&V2) := '%p'",&rV2);
#else
    rV1.f_info(__LINE__);
    rV2.f_info(__LINE__);
#endif

    //  =:= s:  this
    m.f_subMenu("pointer this",__LINE__);
    bool    bIsLarger = false;
    bIsLarger = V2.f_bIsLarger(V1);
    m.f_text(z,"V2 isLarger V1  := '%d'",bIsLarger);

    m.f_menu("vehicle:end",__LINE__);
    //  objects will no be destroyed

    return(iEc);
}




//  === i:  main  =============================================================


int F21_class(CTutor &m) {
    int         iEc, iRc;
    const char* sHdr = "Class";
    iEc = m.f_header(sHdr,__FILE__,__LINE__);
    iRc = F__fruit(m);      if (iRc != iEc) { return iRc; }
    iRc = F__geometry(m);   if (iRc != iEc) { return iRc; }
    iRc = F__vehicle(m);    if (iRc != iEc) { return iRc; }
    m.f_footer(sHdr,__FILE__,__LINE__);
    return(iEc);
};


#ifndef __USE_TUTOR__MAIN
int main(int p_iArgs, char *p_sArgv[]) {
    CTutor      m;
    if (p_iArgs >= 2) {
        m.f_mode_color(true);
    }
    return F21_class(m);
}
#endif
