//  ****************************************************************************
//  TUTORIAL:   C++     :   casting
//  ****************************************************************************
//  !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß-------$
/*  url:
    https://www.geeksforgeeks.org/static_cast-in-c-type-casting-operators/?ref=lbp
    https://www.geeksforgeeks.org/const_cast-in-c-type-casting-operators/?ref=rp
    https://www.geeksforgeeks.org/reinterpret_cast-in-c-type-casting-operators/?ref=lbp
    https://learn.microsoft.com/de-de/cpp/cpp/dynamic-cast-operator?view=msvc-170
*/

/*
    content:
        •   m:  castingType :static
        •   m:  castingType :dynamic
            •   s:  down-casting
            •   s:  up-casting
        •   m:  castingType :const
            •   s:  non-constant class member
            •   s:  pass const-data to a non-const function
        •   m:  castingType :reInterpret

    keywords:
        •   static_cast
        •   const_cast
        •   dynamic_cast

    g++ :
        --help  :   help info
        -c      :   Compile and assemble, but do not link.

    Static Cast:
        This is the simplest type of cast which can be used.
        It is a compile time cast.
        It does things like implicit conversions between
        types (such as int to float, or pointer to void*),
        and it can also call explicit conversion functions (or implicit ones).


    Const Cast
        const_cast is used to cast away the constness of variables.
        Following are some interesting facts about const_cast.
            const_cast can be used to change

        1)  non-const class members inside a
            const member function.
            Consider the following code snippet.
            Inside const member function f_fun(), <this> is treated
            by the compiler as <const CStudent* const this>,
                i.e. <this> is a constant pointer to a constant object,
            thus compiler doesn't allow to
            change the data members through <this> pointer.
            const_cast changes the type
                of <this> pointer to <CStudent* const this>.

        2)  const_cast can be used to pass const data to a
            function that doesn't receive const.
            For example,
            in the following program F_Fun() receives a normal pointer,
            but a pointer to a const can be passed with the help of const_cast.

    Dynamic Cast:
        A cast is an operator that converts
            data from one type to another type.
        In C++, dynamic casting is mainly used for safe
            downcasting at run time.
        To work on dynamic_cast there must be one virtual
            function in the base class.
        A dynamic_cast works only polymorphic base class
            because it uses this information to decide safe downcasting.
        down-casting:
            Casting a base class pointer (or reference) to a
                derived class pointer (or reference) is known as downcasting.
        up-casting:
            Casting a derived class pointer (or reference) to
                a base class pointer (or reference) is known as upcasting.

    Reinterpret Cast:
        It is used to convert a pointer of some data
            type into a pointer of another data type,
            even if the data types before and after conversion are different.
        It does not check if the pointer type and
            data pointed by the pointer is same or not.

 */


#include "Tutor.h"
using namespace std;

#define __USE_TUTOR__CONST_CAST


//  =:= m:  castingType :const

class CStudent
{
    private:
    	int m_iRoll;
    public:
    	// constructor
    	CStudent(int iR):m_iRoll(iR) {}
    	// A const function that changes roll with the help of const_cast
        #ifdef __USE_TUTOR__CONST_CAST
    	    void f_fun() const {
   		        ( const_cast <CStudent*> (this) )->m_iRoll = 5;
   		    }
        #else
    	    void f_fun() {
                m_iRoll = 9;
    	    }
        #endif
    	int f_getRoll() { return m_iRoll; }
};
int F__Fun(int* ptr) {
    return (*ptr + 10);
}


//  =:= m:  castingType :dynamic

class CBase {
	void print()
	{
		cout << "Base" << endl;
	}
};
class CDerived : public CBase {
	void print() {
		cout << "Derived" << endl;
	}
};


//  ############################################################################
//  =:= F:  helper & main
//  ############################################################################


int F27_casting(CTutor &m) {
    int             iEc, iRc;
    const char*     sHdr =  "castingTypes";
    char            z = m.E_COLOR_GRAY;

    //  =:= b:  body
    iEc = m.f_header(sHdr, __FILE__, __LINE__);

//  =:= m:  castingType :static
    m.f_menu("static", __LINE__);
    float   f   = 3.5;
    iRc = f;                        // this is how you do in C
    cout << "\tA =: " << iRc << endl;
    iRc = static_cast<int>(f);      // and this how in C++
    cout << "\tB =: " << iRc << endl;

//  =:= m:  castingType :const
    m.f_menu("const", __LINE__);

    //  =:= s:  non-constant class member
    m.f_subMenu("non-constant class member", __LINE__);
	CStudent s(3);
	m.f_text(z,"Old roll number: %d",s.f_getRoll());
	s.f_fun();
	m.f_text(z,"New roll number: %d",s.f_getRoll());

    //  =:= s:  pass const-data to a non-const function
    m.f_subMenu("non-const function", __LINE__);
    const int   c_iVal  = 10;
    const int * p1      = &c_iVal;
    int *p2 = const_cast <int *>(p1);
    cout << "\t" << F__Fun(p2) << endl ;
	m.f_text(z,"p1    : %p", p1);
	m.f_text(z,"p2    : %p", p2);
	m.f_text(z,"Fun   : %d", F__Fun(p2));


//  =:= m:  castingType :dynamic
    m.f_menu("dynamic", __LINE__);

	CBase       xBase,      *pBase=&xBase ;
	CDerived    xDerived,   *pDerived=&xDerived;
	m.f_text(z,"pBase       : %p",pBase);
	m.f_text(z,"pDerived    : %p",pDerived);

//  =:= s:  up-casting
    m.f_subMenu("upCasting", __LINE__);
	CBase*   pB     =   dynamic_cast<CBase*>(pDerived);
	m.f_text(z,"pB := <BASE*>pD  : %p",pB);

//  =:= s:  down-casting
    m.f_subMenu("downCasting", __LINE__);
#ifdef __USE_TUTOR__STD_C11
    CDerived* pD=nullptr;
#else
    CDerived* pD=NULL;
#endif
	m.f_text(z,"pD := pD  : %d",pD);
	m.f_text(z,"pD := <DERIVED*>pB : &&& error");
#if 0
    CDerived* pD    =   dynamic_cast<CDerived*>(pBase);
    <<< error: cannot dynamic_cast 'pBase'...
#endif

//  =:= m:  castingType :reInterpret
    m.f_menu("reInterpret", __LINE__);

    int* pInteger   = new int(65);
	m.f_text(z,"pIntArray   : %p",pInteger);
	m.f_text(z,"*pIntArray  : %d",*pInteger);

    char* pChar     = reinterpret_cast<char*>(pInteger);
	m.f_text(z,"pChar       : %p",pChar);
	m.f_text(z,"*pChar      : %c",*pChar);

    //  =:= b:  body
    m.f_footer(sHdr, __FILE__, __LINE__);
    return(iEc);
};


#ifndef __USE_TUTOR__MAIN
int main(int p_iArgs, char *p_sArgv[]) {
    CTutor  m;
    if (p_iArgs >= 2) {
        m.f_mode_color(true);
    }
    return F27_casting(m);
}
#endif
