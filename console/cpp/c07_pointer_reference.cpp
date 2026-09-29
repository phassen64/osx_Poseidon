//  ****************************************************************************
//  TUTORIAL:   C++     :   pointer vs reference
//  ****************************************************************************
//  !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß-------$

//  https://www.w3schools.com/cpp/cpp_pointers.asp
//  https://www.w3schools.com/cpp/cpp_references.asp
//  https://www.tutorialspoint.com/cplusplus/cpp_references.htm

/*
    content:
        •   m:  pointer
        •   m:  reference
 */

/*
    url: https://www.tutorialspoint.com/cplusplus/cpp_references.htm
    References vs Pointers
    References are often confused with pointers but
        three major differences between references and pointers are -
    •   You cannot have NULL references.
            You must always be able to assume that a reference is
            connected to a legitimate piece of storage.
    •   Once a reference is initialized to an object,
            it cannot be changed to refer to another object.
            Pointers can be pointed to another object at any time.
    •   A reference must be initialized when it is created.
            Pointers can be initialized at any time.
*/


#include "Tutor.h"
using namespace std;


int F__pointer(CTutor &m) {
/*
    A pointer,
    is a variable that stores the memory address as its value.
    A pointer variable points to a
        data type (like int or string) of the same type,
    and is created with the * operator.
    The address of the variable you're working with is assigned
        to the pointer.
 */

    int             iEc = m.f_iEc();
    char            cBuffer1[20] = "ABCDEFGHIJ$";
    char            cBuffer2[20] = "123567890";
    char            *pc1,
                    *pc2;
    char            z = m.E_COLOR_GRAY;
    const char*     sHdr = "pointer";

//  =:= b:  body
    m.f_chapter(sHdr,__FILE__,__LINE__,true);
    m.f_menu("pointer",__LINE__);

//  =:= m:  define
    m.f_subMenu("define",__LINE__);
    string      sFood   = "Pizza";
    string *    ptrFood = &sFood;   // pointer variable
    m.f_text(z,"sFood        := '%s'",sFood.c_str());
    m.f_text(z,"* ptrFood    := '%s'",(*ptrFood).c_str());
/*
    Use the & operator to store the memory address of
        the variable called food, and assign it to the pointer.
    Now, ptr holds the value of food's memory address.
*/

//  =:= m:  address
    m.f_subMenu("address",__LINE__);
    m.f_text(z,"addr(ptrFood)    := '%p'",ptrFood);

//  =:= m:  reDefine-PTR
    m.f_subMenu("reDefine",__LINE__);
    string      sFood2   = "HotDog";
    ptrFood  = &sFood2;
    m.f_text(z,"* ptrFood    := '%s'",(*ptrFood).c_str());

//  =:= m:  change-OBJECT
    m.f_subMenu("change",__LINE__);
    ptrFood = &sFood;
    sFood   = "FrenchFries";
    m.f_text(z,"* ptrFood    := '%s'",(*ptrFood).c_str());

//  =:= m:  using 2 buffers with 1 pointer
    m.f_subMenu("2 buffers",__LINE__);
    pc1 = &cBuffer1[0];
    m.f_text(z,"*pc1 \t =: '%s'",pc1);
    pc1 = &cBuffer2[0];
    m.f_text(z,"*pc1 \t =: '%s'",pc1);

//  =:= m:  arithmetic  - calc with pointers
    m.f_subMenu("2 pointers",__LINE__);
    pc1 = &cBuffer1[0];
    pc2 = pc1 + 5;
    m.f_text(z,"*pc1 \t =: '%s'",pc1);
    m.f_text(z,"*pc2 \t =: '%s'",pc2);

    return iEc;

}


int F__reference(CTutor &m) {
    int             iEc = m.f_iEc();
    char            z = m.E_COLOR_GRAY;
    const char*     sHdr = "reference";
/*
    A reference variable is a "reference" to an existing variable,
        and it is created with the & operator:
 */

//  =:= b:  body
    m.f_chapter(sHdr,__FILE__,__LINE__,true);
    m.f_menu("reference",__LINE__);

//  =:= m:  define
    m.f_subMenu("define",__LINE__);
    string      sFood       = "Pizza";
    string &    refFood = sFood;
    m.f_text(z,"sFood    := '%s'",sFood.c_str());
    m.f_text(z,"refFood  := '%s'",refFood.c_str());

//  =:= m:  address
    m.f_subMenu("address",__LINE__);
    m.f_text(z,"addr(refFood) := <NOT POSSIBLE>");

//  =:= m:  reDefine-REF
    m.f_subMenu("reDefine",__LINE__);
    string      sFood2      = "HotDog";
#if __USE_REF_ERROR
    string &    refFood = sFood2;
#else
    //  => error: redeclaration of 'std::__cxx11::string& refFood'
    m.f_text(z,"string &  refFood = sFood2 =>  <ERROR>");
#endif

//  =:= m:  change-OBJECT
    m.f_subMenu("change",__LINE__);
    sFood   = "Hamburger";
    m.f_text(z,"refFood  := '%s'",refFood.c_str());

    return iEc;
}


int F07_pointer_vs_reference(CTutor &m) {
    int             iEc ,
                    iRc;
    const char*     sHdr = "pointer_vs_reference";

//  =:= b:  header
    iEc = m.f_header(sHdr,__FILE__,__LINE__);

//  =:= M:  pointer
    iRc = F__pointer(m);
    if (iRc != iEc) {
        return iRc;
    }

//  =:= M:  reference
    iRc = F__reference(m);
    if (iRc != iEc) {
        return iRc;
    }

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
    return F07_pointer_vs_reference(m);
}
#endif
