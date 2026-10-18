//  ****************************************************************************
//  TUTORIAL:   C++     :   nameSpace
//  ****************************************************************************
//  !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß-------$
/*
    content:
        •   m:  operator:namespace
        •   m:  operator:using
    keyword:
        •   m:  namespace
        •   m:  using
    url:
        •   https://cplusplus.com/doc/oldtutorial/namespaces/
 */

/*
    url: https://herdt.com/pages/

    In ANSI C++ gibt es mit dem namespace-Konzept eine
        weitere Möglichkeit zur Vermeidung
    von Namenskonflikten.
    Alle Bezeichner werden in einen Gültigkeitsbereich verpackt,
        in dem eine Namensgleichheit nicht vorkommen darf,
        die aber aufgrund der Struktur leicht zu realisieren ist.
    Im jeweiligen Modul teilen Sie dann dem Compiler mit,
        welche Namensbereiche Sie nutzen wollen.
    Werden aus anderen Namensbereichen
        doch einzelne Funktionen oder Variablen benötigt,
    können Sie diese über den Bereichsnamen mit
        anschließendem Auflösungsoperator "::" aufrufen

    Das Schlüsselwort "using"
        Mithilfe der using-Anweisung können Sie Elemente aus Namensbereichen
        sichtbar machen.
    Ein Element,
        das auf diese Weise sichtbar gemacht wurde,
        kann ohne Angabe des Namensbereichs verwendet werden.
    Treten dabei Bezeichner mehrfach auf,
        müssen diese durch Angabe des
        Namensbereiches mit darauf folgendem Auflösungsoperator "::"
        eindeutig angegeben werden.

*/

#include "Tutor.h"
using namespace std;


namespace NS__Apple {
    int x;
    class ClassA {
        public:
        int x;
    };
}

namespace NS__Orange {
    int x;
    class ClassA {
        public:
        int x;
    };
}

int F30_namespace(CTutor& m) {
    int             iEc;
    const char*     sHdr = "NameSpace";
    char            z = m.E_COLOR_GRAY;

//  =:= b:  header
    iEc = m.f_header(sHdr, __FILE__, __LINE__);

//  =:= m:  operator:namespace
    m.f_menu("namespace",__LINE__);
    int x = 123;
    m.f_text(z,"x<global>       =:%d",x);
    NS__Apple::ClassA pA;
    NS__Orange::ClassA pB;
    pA.x = 576;
    pB.x = 781;
    m.f_text(z,"NS Apple::pA.x  =:%d",pA.x);
    m.f_text(z,"NS Orange::pB.x =:%d",pB.x);

//  =:= m:  operator:using
    m.f_menu("using",__LINE__);
    using namespace NS__Apple;
    ClassA pC;
    pC.x = 815;
    m.f_text(z,"Apple.pC.x      =:%d",pC.x);

//  =:= b:  footer
    m.f_footer(sHdr, __FILE__, __LINE__);
    return(iEc);
};


#ifndef __USE_TUTOR__MAIN
int main(int p_iArgs, char *p_sArgv[]) {
    CTutor      m;
    if (p_iArgs >= 2) {
        m.f_mode_color(true);
    }
    return F30_namespace(m);
}
#endif
