//  ****************************************************************************
//  TUTORIAL:   C++     :   polymorphism
//  ****************************************************************************
//  !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß-------$
/*
    content:
        •   m:  polymorphism && pure virtual
        •   m:  virtual class
    url:
        •   https://cplusplus.com/doc/tutorial/polymorphism/
*/

/*
    url: https://herdt.com/pages/

=== i:  Polymorphismus (Vielgestaltigkeit)
        bedeutet,
            dass der Aufruf einer <Methode> desselben Namens
            �ber Objekte verschiedener Klassen auch
            unterschiedliche an das Objekt
                angepasste Resultate erzeugen kann.
        In C++ kann das beispielsweise durch den
                Einsatz von Zeigern vom Typ einer Basisklasse
                implementiert werden,
                die auf Objekte gerichtet sind,
        deren Klassen mit dem Attribut "public" von dieser abgeleitet wurden.
        Die Klasse Fahrzeug wird als Basisklasse implementiert.
        Davon werden die Klassen
            Auto und
            Motorboot
        abgeleitet.
        Die beiden Klassen besitzen jeweils den gleichen Methodennamen "fahren".
        Jedoch implementiert jede Klasse die Methode "fahren"
            ihren Anspr�chen entsprechend unterschiedlich.
        In diesem Zusammenhang gibt es f�r bestimmte Methoden oder
            Eigenschaften �Oberbegriffe�,
        die sich bisher in Basisklassen widergespiegelt haben.
        Bislang beinhalteten die Basisklassen
            die allen Unterklassen gemeinsamen Methoden und Eigenschaften.
        Im Folgenden soll das erweitert werden,
            sodass die Basisklasse eine Vorlage f�r alle Unterklassen darstellt,
        die diese Vorlage ihren Erfordernissen anpassen.
        Im Kapitel Mehrfachvererbung haben Sie die Polymorphie
            schon durch die virtuellen Methoden kennengelernt.
        Eine Klasse ist polymorph,
            wenn sie mindestens eine Methode besitzt (geerbt oder definiert),
            die "virtuell" ist.
        Im Folgenden wird dieses Konzept weiter ausgebaut....


=== i:  Rein virtuelle Methoden
            sind virtuelle Methoden,
            die als Vorlage f�r alle abgeleiteten Klassen dienen.
        In der Klasse, in der diese Methoden deklariert sind,
            werden sie allerdings >nicht< implementiert.
        Das hei�t,
            sie m�ssen in einer konkreten abgeleiteten Klasse implementiert
                    werden.
        Eine rein virtuelle Methode wird durch eine
            an die Methodendeklaration angeh�ngte
            Zeichenfolge "= 0"
        erzeugt oder
            �ber einen Konstruktor,
        der im private-Bereich der Klasse deklariert ist
            und somit das Erzeugen von Objekten dieser Klasse verhindert.

*/


#include "Tutor.h"
using namespace std;


// =:=  m:  polymorphism && pure virtual

class CNumber
{
    public:
        /* Syntax for pure virtual is
         *      virtual <dataType> f() = 0;
        */
        virtual void f_show() = 0;      // no {..}
};

class CInteger : public CNumber
{
    private:
        int m_iValue ;
    public:
        CInteger(int i) { m_iValue = i; };
        void f_show() {
            cout << "\tThe intNumber is: " << m_iValue  << endl;
        };
};

class CFloat : public CNumber
{
    private:
        double m_fValue;
    public:
        CFloat(double d) { m_fValue = d; };
        void f_show() {
            cout << "\tThe floatNumber is: " << m_fValue << endl;
        };
};


int F25_polymorphism(CTutor &m) {
    int             iEc;
    const char*     sHdr =  "polymorphism";

    //  =:= b:  body
    iEc = m.f_header(sHdr, __FILE__, __LINE__);

    //  =:= m:  polymorphism && pure virtual
    m.f_menu("polymorphism", __LINE__);

   //* Syntax
   /*
        class <Name> {
            virtual <type> Methodenname(<Parameterliste>) = 0;
        };
    */

    // =:=  m:  abstract baseClass
    m.f_menu("abstract baseClass", __LINE__);
    CFloat      fVal(3.1415);
    CInteger    iVal(120);
    fVal.f_show();
    iVal.f_show();

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
    return F25_polymorphism(m);
}
#endif
