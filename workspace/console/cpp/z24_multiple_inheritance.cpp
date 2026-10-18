//  ****************************************************************************
//  TUTORIAL:   C++     :   multiple inheritance
//  ****************************************************************************
//  !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß-------$
/*
    chapter:
        •   C:  multiple
        •   C:  virtual baseClass   !CRQ-220916: NotRunningWith:MSC
        •   C:  overloading
    content:
        •   m:  m:  multipleInheritance
            •   s:  DateTime
            •   s:  only Date
            •   s:  only Time
            •   s:  randomFlag
        •   m:  virtual baseClass inheritance
            •   s:  inconclusive
            •   s:  single
            •   s:  uniq
        •   m:  overloading vs using
            •   s:  fMax<int>
            •   s:  fMax<float>
            •   s:  fMax<String>

    keyword:
        •   virtual
        •   using

    url:
        •   https://www.w3schools.com/CPP/cpp_inheritance_multiple.asp
 */


#include "Tutor.h"
using namespace std;


//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//  =:= C:  multiple inheritance
//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&


#include <iomanip>

class CDate
{
    protected:
        int     m_iDay, m_iMonth, m_iYear;

    public:
        int     m_iRnd;

        CDate(int T, int M, int Y) {
            m_iDay      =   T;
            m_iMonth    =   M;
            m_iYear     =   Y;
            m_iRnd  = 1 + rand() % 100;  //     1...100
        };

        virtual void f_output(string p_STxt="", bool p_bTab=false) {
            if (p_bTab) {
                cout    << "\t";
                if (!p_STxt.empty()) {
                    cout << p_STxt << " =:\t";
                }
            }
            cout    << setfill('0')
                    << setw(2);
            cout    << m_iDay << "."
                    << setw(2)
                    << m_iMonth << "."
                    << setw(4) << m_iYear;
        }
};


class CTime
{
    protected:
        int     m_iHour, m_iMinute, m_iSecond;

    public:
        int     m_iRnd;
        CTime(int H, int M, int S) {
            m_iHour     = H;
            m_iMinute   = M;
            m_iSecond   = S;
            m_iRnd      = 1 + rand() % 100;  //     1...100
        };
        virtual void f_output(string p_STxt="", bool p_bTab=false) {
            if (p_bTab) {
                cout    << "\t";
                if (!p_STxt.empty()) {
                    cout << p_STxt << " =:\t";
}
            }
            cout    << setfill('0')
                    << setw(2);
            cout    << m_iHour
                    << ":"
                    << setw(2)
                    << m_iMinute << ":"
                    << setw(2)
                    << m_iSecond;
        }
};


class CDateTime : public CDate, public CTime
{
    public:

        CDateTime(int D, int M, int Y, int h, int m, int s)
            :   CDate(D, M, Y),
                CTime(h, m, s)  {}

        virtual void f_output(string p_STxt="", bool p_bTab=false) {
            if (p_bTab) {
                cout    << "\t";
                if (!p_STxt.empty()) {
                    cout << p_STxt << " =:\t";
                }
            }
            CDate::f_output();
            cout << ",";
            CTime::f_output();
            cout << endl;
        }
};



int F__multiple(CTutor &m) {

    int             iEc     =   m.f_iEc();
    const char*     sHdr    =   "multipleInheritance";
    char            z       =   m.E_COLOR_GRAY;
    string          SRc;


//  =:= C:  multiple inheritance
    m.f_chapter(sHdr,__FILE__,__LINE__, true);

//  =:= m:  multipleInheritance
    m.f_menu(sHdr, __LINE__);

    m.f_text(z,"show");
    CDateTime xDTm(25, 10, 2017, 12, 3, 13);

//  =:= s:  DateTime
    m.f_subMenu("Date&&Time", __LINE__);
    xDTm.f_output("Date&Time",true);

//  =:= s:  only Date
    m.f_subMenu("Date only", __LINE__);
    xDTm.CDate::f_output("Date",true);
    cout << endl;

//  =:= s:  only Time
    m.f_subMenu("Time only", __LINE__);
    xDTm.CTime::f_output("Time",true);
    cout << endl;

//  =:= s:  randomFlag
    m.f_subMenu("show random flag", __LINE__);
//  m.f_text(z,"flag:<%d>",xDTm.m_iRnd);    //   ??? 'int CTime::m_iRnd' || 'int CDate::m_iRnd'
    m.f_text(z,"flag.time:<%d>",xDTm.CTime::m_iRnd);
    m.f_text(z,"flag.date:<%d>",xDTm.CDate::m_iRnd);

    m.f_subMenu("leave", __LINE__);
    return(iEc);

}

//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//  =:= C:  virtual baseClass
//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

/*
 *  issue: ??? How to inheritance attributes only 1x
 */

class CGeometry
{
    public:
        int     X, Y;           //  unique?
        string  m_sDescription;      //  unique?
};

class CLine : virtual public CGeometry
{
    public:
        int     m_iLength;
        int     m_iColor;   // doubled

};

class CRectangle : virtual public CGeometry
{
    public:
        float   m_fArea;
        int     m_iColor;   // doubled
};

class CArchitecture : public CLine, public CRectangle
{
    public:
        CArchitecture(string S) { m_sDescription = S; };
};


int F__virtual(CTutor &m) {

    int             iEc     =   m.f_iEc();
    const char*     sHdr    =   "virtual baseClass";
    char            z       =   m.E_COLOR_GRAY;
    string          SRc;

//  =:= C:  virtual baseClass
    m.f_chapter(sHdr, __FUNCTION__, __LINE__, true);

//  =:= m:  virtual baseClass inheritance
    m.f_menu(sHdr, __LINE__);
    CArchitecture   pA("ImportantDesign0815!");

//  =:= s:  inconclusive
    //* Diese Attribute sind NICHT eindeutig !
    //* Es gibt gleiche Namen in verschiedenen Elternklassen.
    //*     Es muss der KlassenOperator verwendet werden
    m.f_subMenu("inconclusive", __LINE__);
    pA.CLine::m_iColor  = 17;
    pA.CRectangle::m_iColor  = 28;
    m.f_text(z,"LINE.color:<%d>",pA.CLine::m_iColor);
    m.f_text(z,"Area.color:<%d>",pA.CRectangle::m_iColor);

//  =:= s:  single
    //* Diese Attribute sind eindeutig,
    //*     jedoch nur, weil sie in den Elternklassen nur einmal vorkommen.
    m.f_subMenu("single", __LINE__);
    pA.m_iLength        = 200;
    pA.m_fArea          = (float)53.5;
    m.f_text(z,"Width:<%d>",pA.m_iLength);
    m.f_text(z,"Area:<%f>", pA.m_fArea);

//  =:= s:  uniq
    m.f_subMenu("uniq", __LINE__);
    //* Uniq, weil mit virtual abgeleitet wurde
    //* define CLine using (X,Y)
    pA.CLine::X             = 10;
    pA.CLine::Y             = 400;
    //* using (X,Y) overwriting CLine ...
    pA.CRectangle::X        = 932;      // == CLine::X
    pA.CRectangle::Y        = 765;      // == CLine::Y
    m.f_text(z,"Descript:<%s>",pA.m_sDescription.c_str());
    m.f_text(z,"LINE(%d,%d)...<overwritten>", pA.CLine::X, pA.CLine::Y);
    m.f_text(z,"RECT(%d,%d)", pA.CRectangle::X, pA.CRectangle::Y);

//  =:= s:  leave
    m.f_subMenu("leave", __LINE__);
    return(iEc);

}


//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//  =:= C:  overloading     key:using
//  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&


/*
    !url: https://herdt.com/pages/

    Wenn Sie von einer Klasse A eine Klasse B ableiten,
        erben Sie in der Klasse B
    alle public- und protected-Methoden der Klasse A.
    Haben Sie in der Klasse A
        beispielsweise eine Methode Ausgabe mehrfach �berladen,
        der verschiedene
    Parameter �bergeben werden k�nnen,
        stehen der Klasse B auch alle diese
    �berladenen Methoden zur Verf�gung.
    Wird eine dieser Methoden in der Klasse B �berschrieben,
        werden alle Methoden, also auch die �berladenen Methoden,
        verdeckt.
    Um diese dennoch in der Klasse zu verwenden,
        k�nnen Sie Methoden f�r die Klasse wieder sichtbar machen.
    Setzen Sie dazu in der
        Klassendefinition vor den Methodennamen das Schl�sselwort
        "using"
    und schlie�en Sie die Zeile mit einem Semikolon ab.

*/


class CBeginner
{
    public:

        //  fMax<int>
        int f_max(int &i1, int &i2)
        {
            if (i1 > i2) {
                return 1;
            } else {
                return 0;
            }
        }

        //  fMax<float>
        int f_max(float &f1, float &f2)
        {
            if (f1 > f2) {
                return 1;
            } else {
                return 0;
            }
        }

        //  fMax<String>
        int f_max(string &S1, string &S2)
        {
            if (S1.length() > S2.length()) {
                return 1;
            } else {
                return 0;
            }
        }

};

class CStudent : public CBeginner
{
    public:

        //  * overloading! : implementing a better fMax<int>
        int f_max(int &i1, int &i2)
        {
            if (i1 > i2) {
                return 1;
            } else if ( i1 < i2 ) {
                return -1;
            } else {
                return 0;
            }
        }

        //* t.b.d a better fMax<float> - please take the old one !
        using CBeginner::f_max;

        //* !PHA: Es geht auch OHNE 'using'

};


int F__overloading(CTutor &m) {
    int             iEc     =   m.f_iEc();
    const char*     sHdr    =   "overloading && virtual baseClass && using";
    char            z       =   m.E_COLOR_GRAY;
    string          SRc;

//  =:= C:  overloading
    m.f_chapter(sHdr, __FUNCTION__, __LINE__, true);

    CStudent        qS;
    int             iRc;
    int             i1,i2;
    float           f1,f2;

//  =:= m:  overloading vs using
    m.f_menu("using",__LINE__);

//  =:= s:  fMax<int>
    m.f_subMenu("fMax<int>",__LINE__);
    i1  = m.f_iRandom(5);
    i2  = m.f_iRandom(5);
    iRc = qS.f_max(i1,i2);
    m.f_text(z,"fMax<int>(%d,%d) =: %d",    i1,i2,iRc);

//  =:= s:  fMax<float>
    m.f_subMenu("fMax<float>",__LINE__);
    f1  = (float) ( m.f_iRandom(1000,100) / 3) ;
    f2  = (float) ( m.f_iRandom(500, 20)  / 7);
    iRc = qS.CBeginner::f_max(f1,f2);
    m.f_text(z,"fMax<float>(%f,%f) =: %d", f1,f2,iRc);

//  =:= s:  fMax<String>
    m.f_subMenu("fMax<String>",__LINE__);
    string      s1,s2;
    string      aS[] = {    "Harvey",
                            "Peter",
                            "Antonio",
                            "Tom",
                            "Vincenco",
                        };
    i1  =  m.f_iRandom(5)-1;
    i2  =  m.f_iRandom(5)-1;
    if (i2 == i1) {
        i1 = 0; i2 = 1;
    }
    s1  = aS[i1];
    s2  = aS[i2];
    iRc = qS.CBeginner::f_max(s1,s2);
    m.f_text(z,"fMax<string>('%s','%s') =: %d", s1.c_str(),s2.c_str(),iRc);

//  =:= s:  leave
    m.f_subMenu("leave", __LINE__);
    return(iEc);
}


//  ############################################################################
//  =:= F:  main
//  ############################################################################


int F24_multiple_inheritance(CTutor &m) {
    int             iEc,
                    iRc;
    const char*     sHdr =  "multiple-inheritance";
    iEc = m.f_header(sHdr, __FILE__, __LINE__);
    iRc = F__multiple(m);       if (iRc != iEc) { return iRc; }
#if defined(_MSC_VER)
    iRc = 1;
#elif defined(__BORLANDC__)
    iRc = 2;
#else
    iRc = F__virtual(m);        if (iRc != iEc) { return iRc; }   // !CRQ-220916
#endif
    iRc = F__overloading(m);    if (iRc != iEc) { return iRc; }
    m.f_footer(sHdr, __FILE__, __LINE__);
    return(iEc);
};


#ifndef __USE_TUTOR__MAIN
int main(int p_iArgs, char *p_sArgv[]) {
    CTutor  m;
    if (p_iArgs >= 2) {
        m.f_mode_color(true);
    }
    return F24_multiple_inheritance(m);
}
#endif

