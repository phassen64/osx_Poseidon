//  ****************************************************************************
//  TUTORIAL:   C++     :   print formatted <printf,colorMode>
//  ****************************************************************************
//  !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß-------$

/*
    content:
        •   m:  print colored
        •   m:  printf variable
        •   m:  cout Manipulator
    key:
        •   oct
        •   dec
        •   hex
    cout manipulator:
        •   setw (intx)
        •   setfill(int x)
        •   setprecision(int x)
    Streams:
        •   stringStream
            •   StringStream.input
            •   StringStream.output

    url:
        •   https://cplusplus.com/reference/cstdio/printf/
        •   https://en.wikipedia.org/wiki/ANSI_escape_code
 */


#include "Tutor.h"
using namespace std;

int F__print_color(CTutor &m) {
    int             iEc = m.f_iEc();
    const char*     sHdr = "print__colored";

//  =:= m:  print colored
    m.f_menu(sHdr,__LINE__);

    //  !PHA: puts(): const char* =>  char*
    m.f_subMenu("f.puts()",__LINE__);
    m.f_puts((char*)"\tdoRED",m.E_COLOR_RED);
    m.f_puts((char*)"\toREDBRHT",m.E_COLOR_RED_BRHT);

    //  !PHA: echo(): needs no char* - uses const char*
    m.f_subMenu("f.echo()",__LINE__);
    m.f_echo("\tdoGreen",m.E_COLOR_GREEN);

    //  !PHA: text(): needs no char* and uses TABs
    m.f_subMenu("f.text()",__LINE__);
    m.f_text("doGreenLGHT",m.E_COLOR_GREEN_BRHT);
    m.f_text("doBlue",m.E_COLOR_BLUE);
    m.f_text("doBlueBRHT",m.E_COLOR_BLUE_BRHT);
    m.f_text("doYellow",m.E_COLOR_YELLOW);
    m.f_text("doYellowBRHT",m.E_COLOR_YELLOW_BRHT);
    m.f_text("doCyan",m.E_COLOR_CYAN);
    m.f_text("doCyanBRHT",m.E_COLOR_CYAN_BRHT);
    m.f_text("doMagenta",m.E_COLOR_MAGENTA);
    m.f_text("doMagentaBRHT",m.E_COLOR_MAGENTA_BRHT);
    m.f_text("doGray",m.E_COLOR_GRAY);
    m.f_text("doWhite",m.E_COLOR_WHITE);

    m.f_info("endOfColor",__FILE__,__LINE__);
    m.f_text("doNone",m.E_COLOR_NONE);

//  =:= b:  footer
    m.f_subMenu("finish",__LINE__);
    return iEc;
};


int F__print_variable(CTutor &m) {
    int             iEc = m.f_iEc();
    const char*     sHdr = "print__variable";
    char            z   = m.E_COLOR_GRAY;
    char    s[80];
    int     i;

//  =:= m:  printf variable
    m.f_menu(sHdr,__LINE__);
    strcpy(s,"  Hello World ! ");

//  =:= s:  string
    m.f_subMenu("stringOutput",__LINE__);
    m.f_text(z,"string :'%s'",s);
    m.f_text(z,"string :'%8s'",s);
    m.f_text(z,"string<%%-10s> :'%-10s'",s);

//  =:= s:  integer
    m.f_subMenu("integer",__LINE__);
    i = 0x40;
    m.f_text(z,"integer<%%d> :'%d'",i);
    m.f_text(z,"integer<%%4d> :'%4d'",i);
    m.f_text(z,"integer<%%4.4d> :'%4.4d'",i);
    m.f_text(z,"integer<%%4.4x> :'%4.4x'",i);

//  =:= b:  footer
    m.f_subMenu("finish",__LINE__);
    return iEc;
}

#include  <iomanip>

int F__formatted_cout(CTutor& m) {
    int             iEc = m.f_iEc();
    const char* sHdr = "cout Manipulator";
    char            z = m.E_COLOR_GRAY;
    int             i=0,x=0x40,
                        a=1234,b=5;
    double          f = C_TUTOR__PI;

//  =:= m:  cout Manipulator
    m.f_menu(sHdr, __LINE__);

//  =:= s:  integer
    m.f_subMenu("integer",__LINE__);
    m.f_text(z,"integer<%%d> :'%d'",x);
    cout << "\t" << ++i << ": " << "decimal:"      << dec << x << endl;
    cout << "\t" << ++i << ": " << "octal:"        << oct << x << endl;
    cout << "\t" << ++i << ": " << "hexadecimal:"  << hex << x << endl;

//  =:= s:  Ausgabebreite
    m.f_subMenu("setw",__LINE__);
    cout << "\t" << ++i << ": " << setw(8) << x << endl;
    cout << "\t" << ++i << ": " << setw(8) << a << endl;
    cout << "\t" << ++i << ": " << setw(8) << b << endl;

//  =:= s:  F�llzeichen
    m.f_subMenu("setfill && setw",__LINE__);
    cout << setfill('.');
    cout << "\t" << ++i << ": " << setw(8) << x << endl;
    cout << "\t" << ++i << ": " << setw(8) << a << endl;
    cout << "\t" << ++i << ": " << setw(8) << b << endl;

//  =:= s:  Anzahl der Nachkommazahlen mit Runden der letzten Ziffer
    m.f_subMenu("setprecision",__LINE__);
    cout << "\t" << ++i << ": " << setprecision(4) << f << endl; // 3.142

//  =:= b:  footer
    m.f_subMenu("finish", __LINE__);
    return iEc;
}


#include <sstream>

int F__stream_output(CTutor& m) {
    int    iEc = m.f_iEc();
    const char*     sHdr    = "stringStream";
    char            z       = m.E_COLOR_GRAY;

//  =:= m:  stringStream
    m.f_menu(sHdr, __LINE__);

//  =:= s:  StringStream.input
    m.f_subMenu("SS.input",__LINE__);
    char            cString[] = "100 1.23 ABC";
    int     i;
    double  d;
    char    s[20];
    istringstream   tStreamInp(cString);
    tStreamInp >> i >> d >> s;
    cout << "\t" << "iStream:<" << i << ":" << d << ":" << s << ">" << endl;

//  =:= s:  StringStream.output
    m.f_subMenu("SS.output",__LINE__);
    ostringstream   tStreamOut;
    tStreamOut << 1.23 * 2 << "abcde" << 100;
    #ifdef __USE_TUTOR__STD_C11
        string S { tStreamOut.str() };
    #else
        string S = tStreamOut.str();
    #endif
    cout << "\t" << "oStream:<" << S << ">" << endl;

//  =:= b:  footer
    m.f_text(z,"iEc :'%d'",iEc);
    m.f_subMenu("finish", __LINE__);
    return iEc;
}

//  ###########################################################################
//  F:  main
//  ###########################################################################


int F14_print_formatted(CTutor &m) {
    int             iRc,iEc;
    const char*     sHdr = "printFormatted";
//  =:= b:  body
    iEc = m.f_header(sHdr,__FILE__,__LINE__);
    m.f_menu("Color",__LINE__);
    iRc = F__print_color(m);        if (iRc != iEc) { return iRc; }
    iRc = F__print_variable(m);     if (iRc != iEc) { return iRc; }
    iRc = F__formatted_cout(m);     if (iRc != iEc) { return iRc; }
    iRc = F__stream_output(m);      if (iRc != iEc) { return iRc; }
    //  =:= b:  footer
    m.f_footer(sHdr, __FILE__, __LINE__);
    return(iEc);
};


#ifndef __USE_TUTOR__MAIN
int main(int p_iArgs, char *p_sArgv[]) {
    CTutor  m;
    if (p_iArgs >= 2) {
        m.f_mode_color(true);
    }
    return F14_print_formatted(m);
}
#endif
