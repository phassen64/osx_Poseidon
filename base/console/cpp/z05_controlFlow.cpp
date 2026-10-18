//  ****************************************************************************
//  TUTORIAL:   C++     :   control flow
//  ****************************************************************************
//  !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß-------$

/*
    content:
        •   m:  conditions
        •   m:  if-elseif-else
        •   m:  if ternary
        •   m:  switch
        •   m:  while
        •   m:  do while
        •   m:  for
        •   s:  for.break
        •   s:  for.continue
        •   s:  for.goto
    keywords handled<9>:
        •   break
        •   continue
        •   do
        •   else
        •   goto
        •   for
        •   if
        •   switch
        •   while
    url:
        •   https://www.w3schools.com/cpp/cpp_while_loop.asp ...

 */

#include "Tutor.h"
using namespace std;

int F05_controlFlow(CTutor &m) {

//  =:= b:  declare
    int         i,j,n,x;
    int         iEc;
    string      S;
    char        z = m.E_COLOR_GRAY;
    const char* sHdr = "control";

//  =:= b:  header
    iEc =
    m.f_header(sHdr,__FILE__,__LINE__);

//
//  =:= b:  body
//

//  === m:  conditions

    m.f_menu("conditions",__LINE__);
    i = m.f_iRandom(5);
    j = m.f_iRandom(8);
    if (i > j)  { m.f_text(z,"i:(%d) > j:%d",i,j);  };
    if (i >= j) { m.f_text(z,"i:(%d) >= j:%d",i,j); };
    if (i == j) { m.f_text(z,"i:(%d) == j:%d",i,j); };
    if (i < j)  { m.f_text(z,"i:(%d)  < j:%d",i,j); };


//  === m:  if-elseif-else

    m.f_menu("if",__LINE__);

    i=23; j=0; x = m.f_iRandom(23,0);       // using Tutor random
    assert((x<=i)&&(x>=j));

    m.f_text(z,"iRnd.hour =: '%d'",x);
    if (x < 10) {
      S = "Good morning.";
    } else if (x < 20) {
      S = "Good day";
    } else {
      S = "Good evening.";
    }
    m.f_text(z,"GoodText(%d) =: '%s'",x,S.c_str());

//  === m:  if ternary

    m.f_menu("if-ternary",__LINE__);
    i=23; j=0; x = m.f_iRandom(23,0);       // using Tutor random
    assert((x<=i)&&(x>=j));
    S = (x < 18) ? "Good day." : "Good evening.";
    m.f_text(z,"GoodText2(%d) =: '%s'",x,S.c_str());

//  === m:  switch

    m.f_menu("switch",__LINE__);

    i = 7;
    x = m.f_iRandom(i);    assert((x<=i) && (x>=1));

    switch (x) {
        case 1  : S = "Monday";     break;
        case 2  : S = "Tuesday";    break;
        case 3  : S = "Wednesday";  break;
        case 4  : S = "Thursday";   break;
        case 5  : S = "Friday";     break;
        case 6  : S = "Saturday";   break;
        case 7  : S = "Sunday";     break;
        default : S = "NotFound X"; break;
    } ;
    m.f_text(z,"Weekday of (%d) =: '%s'",x,S.c_str());


//  === m:  while

    m.f_menu("while",__LINE__);

    m.f_subMenu("while1",__LINE__);
    i = 8; j = 3; x = m.f_iRandom(i,j);    assert((x<=i) && (x>=j));
    i = 0;
    m.f_print(z,"\twhile(%d<%d):",i,x);
    while (i < x) {
        m.f_print(z,"[%d]",i);
        i++;
    }
    m.f_echo(";");

    m.f_subMenu("while2:break",__LINE__);
    i = 8; j = 3; x = m.f_iRandom(i,j);    assert((x<=i) && (x>=j));
    i = 0;
    m.f_print(z,"\twhile(%d<%d):break(%d)::",i,x,j);
    while (i < x) {
        m.f_print(z,"[%d]",i);
        if (i == j) {
            break;
        }
        i++;
    }
    m.f_echo(";");

    m.f_subMenu("while3:continue",__LINE__);
    i = 8; j = 3; x = m.f_iRandom(i,j);    assert((x<=i) && (x>=j));
    i = 0;
    m.f_print(z,"\twhile(%d<%d):continue(%d)::",i,x,j);
    while (i < x) {
        n = i++;
        if (n == j) {
            continue;
        }
        m.f_print(z,"[%d]",n);
    }
    m.f_echo(";");

//  === m:  do while

    m.f_menu("do while",__LINE__);

    m.f_subMenu("do1",__LINE__);
    i = 8; j = 3; x = m.f_iRandom(i,j);    assert((x<=i) && (x>=j));
    i = 0;
    m.f_print(z,"\tdoWhile(%d<%d):",i,x);
    do  {
        m.f_print(z,"[%d]",i);
        i++;
    } while (i < x);
    m.f_echo(";");


//  === m:  for

    m.f_menu("for",__LINE__);

    m.f_subMenu("for0",__LINE__);
    i = 8; j = 3; x = m.f_iRandom(i,j);    assert((x<=i) && (x>=j));
    i = 0;
    m.f_print(z,"\tfor(%d<%d):",i,x);
    for(i=0; i < x; i++) {
        m.f_print(z,"[%d]",i);
    }
    m.f_echo(";");

//  === s:  for.break
    m.f_subMenu("for1:break",__LINE__);
    i = 8; j = 3; x = m.f_iRandom(i,j);    assert((x<=i) && (x>=j));
    i = 0;
    m.f_print(z,"\tfor(%d<%d):break(%d)::",i,x,j);
    for (i=0; i<x; i++ ) {
        m.f_print(z,"[%d]",i);
        if (i == j) {
            break;
        }
    }
    m.f_echo(";");

//  === s:  for.continue
    m.f_subMenu("for2:continue",__LINE__);
    i = 8; j = 3; x = m.f_iRandom(i,j);    assert((x<=i) && (x>=j));
    i = 0;
    m.f_print(z,"\tfor(%d<%d):continue(%d)::",i,x,j);
    for(i=0; i<x; i++) {
        if (i == j) {
            continue;
        }
        m.f_print(z,"[%d]",i);
    }
    m.f_echo(";");

//  === s:  for.goto
    m.f_subMenu("for3:goto",__LINE__);
    i = 10; j = 5; x = m.f_iRandom(i,j);    assert((x<=i) && (x>=j));
    j = i;
    i = 0;
    m.f_print(z,"\tfor(%d<%d):goto(%d)::",i,j,x);
    for(i=0; i<j; i++) {
        m.f_print(z,"[%d]",i);
        if (i == x) {
            goto L_goto;
        }
    }
L_goto: /* jump mark */
    m.f_echo(";");


//  =:= b:  footer
    m.f_menu("end",__LINE__);
    m.f_footer(sHdr,__FILE__,__LINE__);
    return(iEc);
};


#ifndef __USE_TUTOR__MAIN
int main(int p_iArgs, char *p_sArgv[]) {
    CTutor  m;
    if (p_iArgs >= 2) {
        m.f_mode_color(true);
    }
    return F05_controlFlow(m);
}
#endif
